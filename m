From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: proposed MPD16 latency workaround
Date: Mon, 20 Sep 2010 09:23:41 +0200
Message-ID: <4C970BFD.3080006@ladisch.de>
References: <4C9154F4.8040304@foltman.com> <4C91DD19.5000005@ladisch.de>
	<4C921DA5.6080301@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 684C41037FF
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 09:22:49 +0200 (CEST)
In-Reply-To: <4C921DA5.6080301@foltman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Foltman <wdev@foltman.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Krzysztof Foltman wrote:
> On 16/09/10 10:02, Clemens Ladisch wrote:
>>> ii) the driver is switched into config mode by sending a special SysEx
>>> message to the output port (which is intercepted by the driver and used
>>> to set a flag). This is to prevent programs that open all the MIDI ports
>>> in the system (JACK daemon with ALSA MIDI driver, a2jmidid etc.) from
>>> starting unwanted communication with configuration endpoints.
>> 
>> This can be considered a bug in those programs.
> 
> Yes. Well, it's the case of what's right vs. what's convenient. I think
> the assumption that opening a MIDI port (sequencer or raw) won't cause
> disastrous results (like increased latency of some other port) is a fair
> assumption.

It is possible that an opened MIDI port uses resources that would be
needed by other devices.

>> Since this device uses a completely vendor-dependent protocol, your
>> changes result in a driver that uses practically none of the common
>> code for the MPD16.
> 
> Well, it _could_ be used for some other USB MIDI devices (the ones using
> bulk mode on input endpoints) to reduce data churn on USB ports when
> devices are physically connected but their MIDI ports are not used.
> Probably isn't worth it though: the power and bandwidth use of the
> unnecessary polling is probably minimal.

I'd estimate that the power usage is measurable on laptops.  Changing
the driver to submit URBs only when a port is open is one of those
changes that I want to do whenever I have time to do unimportant
changes.

>> I'll see if I can write it until Monday; you'll just have to test it
>> and remove my bugs.  :)
> 
> That would be great - if you have time for it. I definitely can take 
> care of testing/debugging in that case.

Well, it turned out bigger than I would have liked.

Compile-tested.  Handle with care.

> To clarify: in this solution, to enable control input, you need to send
> a fake sysex on control output.

I've changed it so that you can send anything to enable the input.

-- 
Regards,
Clemens


--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -45,6 +45,15 @@ config SND_USB_USX2Y
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-usb-usx2y.
 
+config SND_USB_MPD16
+	tristate "Akai MPD16 driver"
+	select SND_RAWMIDI
+	help
+	  Say Y here to include support for the Akai MPD16 MIDI controller.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-mpd16.
+
 config SND_USB_CAIAQ
 	tristate "Native Instruments USB audio devices"
 	select SND_HWDEP
--- a/sound/usb/misc/Makefile
+++ b/sound/usb/misc/Makefile
@@ -1,2 +1,4 @@
+snd-mpd16-objs := mpd16.o
 snd-ua101-objs := ua101.o
+obj-$(CONFIG_SND_USB_MPD16) += snd-mpd16.o
 obj-$(CONFIG_SND_USB_UA101) += snd-ua101.o
--- /dev/null
+++ b/sound/usb/misc/mpd16.c
@@ -0,0 +1,672 @@
+/*
+ * Akai MPD16 driver
+ * Copyright Clemens Ladisch <clemens@ladisch.de>
+ * Copyright Krzysztof Foltman <wdev@foltman.com>
+ *
+ *
+ * This driver is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/rawmidi.h>
+#include <sound/asequencer.h>
+
+MODULE_DESCRIPTION("Akai MPD16 driver");
+MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_AUTHOR("Krzysztof Foltman <wdev@foltman.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_SUPPORTED_DEVICE("{{Akai,MPD16}}");
+
+/*
+ * AKAI MPD16 protocol:
+ *
+ * For control port (endpoint 1):
+ * ==============================
+ * One or more chunks consisting of first byte of (0x10 | msg_len) and then a
+ * SysEx message (msg_len=9 bytes long).
+ *
+ * For data port (endpoint 2):
+ * ===========================
+ * One or more chunks consisting of first byte of (0x20 | msg_len) and then a
+ * MIDI message (msg_len bytes long)
+ *
+ * Messages sent: Active Sense, Note On, Poly Pressure, Control Change.
+ */
+
+#define CONTROL_OUT_EP	1
+#define CONTROL_IN_EP	1
+#define MIDI_IN_EP	2
+
+#define MAX_AKAI_SYSEX_LEN	9
+
+struct mpd16 {
+	struct usb_device *dev;
+
+	spinlock_t lock;
+	struct mutex mutex;
+
+	struct snd_rawmidi_substream *control_output;
+	struct snd_rawmidi_substream *control_input;
+	struct snd_rawmidi_substream *midi_input;
+
+	struct urb *control_output_urb;
+	struct urb *control_input_urb;
+	struct urb *midi_input_urbs[2];
+
+	unsigned int control_output_packet_size;
+
+	bool control_output_was_triggered;
+	bool control_input_open;
+	bool control_input_allowed;
+	bool disconnected;
+};
+
+static struct usb_device_id id_table[] = {
+	{ USB_DEVICE(0x09e8, 0x0062) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, id_table);
+
+static const char *usb_error_string(int err)
+{
+	switch (err) {
+	case -ENODEV:
+		return "no device";
+	case -ENOENT:
+		return "endpoint not enabled";
+	case -EPIPE:
+		return "endpoint stalled";
+	case -ENOSPC:
+		return "not enough bandwidth";
+	case -ESHUTDOWN:
+		return "device disabled";
+	case -EHOSTUNREACH:
+		return "device suspended";
+	case -EINVAL:
+	case -EAGAIN:
+	case -EFBIG:
+	case -EMSGSIZE:
+		return "internal error";
+	default:
+		return "unknown error";
+	}
+}
+
+static void do_control_output(struct mpd16 *mpd16)
+{
+	struct urb *urb;
+	u8 *msg;
+	unsigned int buf_end, count, pos, end;
+	int err;
+
+	if (!mpd16->control_output)
+		return;
+
+	urb = mpd16->control_output_urb;
+	msg = urb->transfer_buffer + urb->transfer_buffer_length;
+	buf_end = mpd16->control_output_packet_size - MAX_AKAI_SYSEX_LEN - 1;
+
+	/* only try adding more data when there's space for at least 1 SysEx */
+	while (urb->transfer_buffer_length < buf_end) {
+		count = snd_rawmidi_transmit_peek(mpd16->control_output,
+						  msg + 1, MAX_AKAI_SYSEX_LEN);
+
+		/* try to skip non-SysEx data */
+		for (pos = 0; pos < count && msg[pos + 1] != 0xf0; pos++)
+			;
+		if (pos > 0) {
+			snd_rawmidi_transmit_ack(mpd16->control_output, pos);
+			continue;
+		}
+
+		/* look for the end of the SysEx data */
+		for (end = 1; end < count && msg[end + 1] < 0x80; end++)
+			;
+		/* next command started before the end of current one */
+		if (end < count && msg[end + 1] != 0xf7) {
+			/* it's incomplete - drop it */
+			snd_rawmidi_transmit_ack(mpd16->control_output, end);
+			continue;
+		}
+
+		/* SysEx complete */
+		if (end < count && msg[end + 1] == 0xf7) {
+			/* queue it, ack it, and get the next one */
+			count = end + 1;
+			msg[0] = 0x10 | count;
+			snd_rawmidi_transmit_ack(mpd16->control_output, count);
+			urb->transfer_buffer_length += 1 + count;
+			msg += 1 + count;
+			continue;
+		}
+
+		/* less than 9 bytes and no end byte - wait for more */
+		if (count < MAX_AKAI_SYSEX_LEN) {
+			mpd16->control_output = NULL;
+			return;
+		}
+
+		/* 9 bytes and no end marker in sight - malformed, skip it */
+		snd_rawmidi_transmit_ack(mpd16->control_output, count);
+	}
+
+	if (urb->transfer_buffer_length) {
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0)
+			dev_err(&mpd16->dev->dev, "cannot send data (%d): %s\n",
+				err, usb_error_string(err));
+	}
+}
+
+static bool fatal_error_status(struct urb *urb)
+{
+	return urb->status == -ENOENT ||	/* killed */
+	       urb->status == -ENODEV ||	/* device removed */
+	       urb->status == -ECONNRESET ||	/* unlinked */
+	       urb->status == -ESHUTDOWN;	/* device disabled */
+}
+
+static void control_output_complete(struct urb *urb)
+{
+	struct mpd16 *mpd16 = urb->context;
+	unsigned long flags;
+
+	if (unlikely(fatal_error_status(urb)))
+		return;
+
+	mpd16->control_output_urb->transfer_buffer_length = 0;
+
+	spin_lock_irqsave(&mpd16->lock, flags);
+	do_control_output(mpd16);
+	spin_unlock_irqrestore(&mpd16->lock, flags);
+}
+
+static void parse_input(const u8 *buffer, unsigned int length,
+			struct snd_rawmidi_substream *subs, unsigned int port)
+{
+	unsigned int pos = 0, received_port, msg_len;
+
+	while (pos < length) {
+		received_port = buffer[pos] >> 4;
+		msg_len = buffer[pos] & 0x0f;
+		pos++;
+		if (pos + msg_len <= length && received_port == port)
+			snd_rawmidi_receive(subs, &buffer[pos], msg_len);
+		pos += msg_len;
+	}
+}
+
+static void input_urb_complete(struct urb *urb, unsigned int port)
+{
+	struct mpd16 *mpd16 = urb->context;
+	unsigned long flags;
+	struct snd_rawmidi_substream *subs;
+	int err;
+
+	if (unlikely(fatal_error_status(urb)))
+		return;
+
+	spin_lock_irqsave(&mpd16->lock, flags);
+
+	switch (port) {
+	case 1:
+		subs = mpd16->control_input;
+		break;
+	case 2:
+		subs = mpd16->midi_input;
+		break;
+	default:
+		subs = NULL;
+		break;
+	}
+
+	if (subs) {
+		if (urb->status == 0)
+			parse_input(urb->transfer_buffer, urb->actual_length,
+				    subs, port);
+
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0)
+			dev_err(&mpd16->dev->dev, "cannot submit URB (%d): %s\n",
+				err, usb_error_string(err));
+	}
+
+	spin_unlock_irqrestore(&mpd16->lock, flags);
+}
+
+static void control_input_complete(struct urb *urb)
+{
+	input_urb_complete(urb, 1);
+}
+
+static void midi_input_complete(struct urb *urb)
+{
+	input_urb_complete(urb, 2);
+}
+
+static struct urb *alloc_urb(struct mpd16 *mpd16, unsigned int pipe,
+			     void (*complete)(struct urb *))
+{
+	unsigned int packet_size;
+	struct urb *urb;
+
+	packet_size = usb_maxpacket(mpd16->dev, pipe, usb_pipeout(pipe));
+	if (!packet_size) {
+		dev_err(&mpd16->dev->dev, "endpoint %u(%c) not found\n",
+			usb_pipeendpoint(pipe), usb_pipeout(pipe) ? 'O' : 'I');
+		return NULL;
+	}
+	if (packet_size < MAX_AKAI_SYSEX_LEN + 1) {
+		dev_err(&mpd16->dev->dev, "packet size too small\n");
+		return NULL;
+	}
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return NULL;
+
+	urb->transfer_buffer =
+		usb_alloc_coherent(mpd16->dev, packet_size,
+				   GFP_KERNEL, &urb->transfer_dma);
+	if (!urb->transfer_buffer) {
+		usb_free_urb(urb);
+		return NULL;
+	}
+
+	urb->dev = mpd16->dev;
+	urb->pipe = pipe;
+	urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
+	urb->transfer_buffer_length = packet_size;
+	urb->context = mpd16;
+	urb->complete = complete;
+
+	return urb;
+}
+
+static void kill_and_free_urb(struct mpd16 *mpd16, struct urb **urb)
+{
+	if (*urb) {
+		usb_kill_urb(*urb);
+		usb_free_coherent(mpd16->dev,
+				  (*urb)->transfer_buffer_length,
+				  (*urb)->transfer_buffer,
+				  (*urb)->transfer_dma);
+		usb_free_urb(*urb);
+		*urb = NULL;
+	}
+}
+
+static int control_output_open(struct snd_rawmidi_substream *subs)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+
+	mutex_lock(&mpd16->mutex);
+
+	if (mpd16->disconnected) {
+		mutex_unlock(&mpd16->mutex);
+		return -ENODEV;
+	}
+
+	mpd16->control_output_urb =
+		alloc_urb(mpd16, usb_sndbulkpipe(mpd16->dev, CONTROL_OUT_EP),
+			  control_output_complete);
+	if (!mpd16->control_output_urb) {
+		mutex_unlock(&mpd16->mutex);
+		return -ENOMEM;
+	}
+
+	mpd16->control_output_packet_size =
+			mpd16->control_output_urb->transfer_buffer_length;
+	mpd16->control_output_urb->transfer_buffer_length = 0;
+
+	mutex_unlock(&mpd16->mutex);
+
+	return 0;
+}
+
+static int control_output_close(struct snd_rawmidi_substream *subs)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+
+	mutex_lock(&mpd16->mutex);
+	kill_and_free_urb(mpd16, &mpd16->control_output_urb);
+	mutex_unlock(&mpd16->mutex);
+
+	mpd16->control_output_was_triggered = false;
+
+	return 0;
+}
+
+static void submit_control_input_urb(struct mpd16 *mpd16)
+{
+	int err;
+
+	err = usb_submit_urb(mpd16->control_input_urb, GFP_ATOMIC);
+	if (err < 0)
+		dev_err(&mpd16->dev->dev, "cannot submit URB (%d): %s\n",
+			err, usb_error_string(err));
+}
+
+static void control_output_trigger(struct snd_rawmidi_substream *subs, int up)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpd16->lock, flags);
+
+	if (up) {
+		if (!mpd16->control_output && !mpd16->disconnected) {
+			mpd16->control_output = subs;
+			mpd16->control_output_was_triggered = true;
+
+			if (mpd16->control_input_open &&
+			    !mpd16->control_input_allowed) {
+				mpd16->control_input_allowed = true;
+				submit_control_input_urb(mpd16);
+			}
+
+			do_control_output(mpd16);
+		}
+	} else {
+		mpd16->control_output = NULL;
+	}
+
+	spin_unlock_irqrestore(&mpd16->lock, flags);
+}
+
+static int control_input_open(struct snd_rawmidi_substream *subs)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+
+	mutex_unlock(&mpd16->mutex);
+
+	if (mpd16->disconnected) {
+		mutex_unlock(&mpd16->mutex);
+		return -ENODEV;
+	}
+
+	mpd16->control_input_urb =
+		alloc_urb(mpd16, usb_rcvbulkpipe(mpd16->dev, CONTROL_IN_EP),
+			  control_input_complete);
+	if (!mpd16->control_input_urb) {
+		mutex_unlock(&mpd16->mutex);
+		return -ENOMEM;
+	}
+	mpd16->control_input_urb->transfer_flags |= URB_NO_FSBR;
+	mpd16->control_input_open = true;
+
+	if (mpd16->control_output_was_triggered) {
+		mpd16->control_input_allowed = true;
+		submit_control_input_urb(mpd16);
+	}
+
+	mutex_unlock(&mpd16->mutex);
+
+	return 0;
+}
+
+static int control_input_close(struct snd_rawmidi_substream *subs)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+
+	mutex_lock(&mpd16->mutex);
+	kill_and_free_urb(mpd16, &mpd16->control_input_urb);
+	mutex_unlock(&mpd16->mutex);
+
+	mpd16->control_input_open = false;
+	mpd16->control_input_allowed = false;
+
+	return 0;
+}
+
+static void control_input_trigger(struct snd_rawmidi_substream *subs, int up)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpd16->lock, flags);
+	mpd16->control_input = up ? subs : NULL;
+	spin_unlock_irqrestore(&mpd16->lock, flags);
+}
+
+static int midi_input_open(struct snd_rawmidi_substream *subs)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+	unsigned int i;
+	int err;
+
+	mutex_lock(&mpd16->mutex);
+
+	if (mpd16->disconnected) {
+		mutex_unlock(&mpd16->mutex);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mpd16->midi_input_urbs); ++i) {
+		mpd16->midi_input_urbs[i] =
+			alloc_urb(mpd16,
+				  usb_rcvbulkpipe(mpd16->dev, MIDI_IN_EP),
+				  midi_input_complete);
+		if (!mpd16->midi_input_urbs[i]) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mpd16->midi_input_urbs); ++i) {
+		err = usb_submit_urb(mpd16->midi_input_urbs[i], GFP_KERNEL);
+		if (err < 0) {
+			dev_err(&mpd16->dev->dev, "cannot submit URB (%d): %s\n",
+				err, usb_error_string(err));
+			goto error;
+		}
+	}
+
+	mutex_unlock(&mpd16->mutex);
+
+	return 0;
+
+error:
+	while (i > 0) {
+		--i;
+		kill_and_free_urb(mpd16, &mpd16->midi_input_urbs[i]);
+	}
+
+	mutex_unlock(&mpd16->mutex);
+
+	return err;
+}
+
+static int midi_input_close(struct snd_rawmidi_substream *subs)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+	unsigned int i;
+
+	mutex_lock(&mpd16->mutex);
+	for (i = 0; i < ARRAY_SIZE(mpd16->midi_input_urbs); ++i)
+		kill_and_free_urb(mpd16, &mpd16->midi_input_urbs[i]);
+	mutex_unlock(&mpd16->mutex);
+
+	return 0;
+}
+
+static void midi_input_trigger(struct snd_rawmidi_substream *subs, int up)
+{
+	struct mpd16 *mpd16 = subs->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpd16->lock, flags);
+	mpd16->midi_input = up ? subs : NULL;
+	spin_unlock_irqrestore(&mpd16->lock, flags);
+}
+
+static struct snd_rawmidi_ops control_output_ops = {
+	.open    = control_output_open,
+	.close   = control_output_close,
+	.trigger = control_output_trigger,
+};
+
+static struct snd_rawmidi_ops control_input_ops = {
+	.open    = control_input_open,
+	.close   = control_input_close,
+	.trigger = control_input_trigger,
+};
+
+static struct snd_rawmidi_ops midi_input_ops = {
+	.open    = midi_input_open,
+	.close   = midi_input_close,
+	.trigger = midi_input_trigger,
+};
+
+static void get_port_info(struct snd_rawmidi *rmidi, int number,
+			  struct snd_seq_port_info *seq_port_info)
+{
+	seq_port_info->type = SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
+			      SNDRV_SEQ_PORT_TYPE_HARDWARE;
+}
+
+static struct snd_rawmidi_global_ops global_ops = {
+	.get_port_info = get_port_info,
+};
+
+static void mpd16_free(struct snd_card *card)
+{
+	struct mpd16 *mpd16 = card->private_data;
+
+	mutex_destroy(&mpd16->mutex);
+}
+
+static int probe(struct usb_interface *interface,
+		 const struct usb_device_id *usb_id)
+{
+	struct snd_card *card;
+	struct mpd16 *mpd16;
+	struct snd_rawmidi *rmidi;
+	char usb_path[32];
+	int err;
+
+	if (interface->altsetting->desc.bInterfaceNumber != 0)
+		return -ENODEV;
+
+	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*mpd16), &card);
+	if (err < 0)
+		return err;
+	card->private_free = mpd16_free;
+	mpd16 = card->private_data;
+	mpd16->dev = interface_to_usbdev(interface);
+
+	spin_lock_init(&mpd16->lock);
+	mutex_init(&mpd16->mutex);
+
+	snd_card_set_dev(card, &interface->dev);
+
+	strcpy(card->driver, "MPD16");
+	strcpy(card->shortname, "MPD16");
+	usb_make_path(mpd16->dev, usb_path, sizeof(usb_path));
+	snprintf(card->longname, sizeof(card->longname),
+		 "AKAI MPD16 at %s", usb_path);
+
+	err = snd_rawmidi_new(card, "MPD16 Control", 0, 1, 1, &rmidi);
+	if (err < 0)
+		goto probe_error;
+	strcpy(rmidi->name, "MPD16 Control");
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_OUTPUT |
+			    SNDRV_RAWMIDI_INFO_INPUT |
+			    SNDRV_RAWMIDI_INFO_DUPLEX;
+	rmidi->ops = &global_ops;
+	rmidi->private_data = mpd16;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+			    &control_output_ops);
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &control_input_ops);
+
+	err = snd_rawmidi_new(card, "MPD16 MIDI", 1, 0, 1, &rmidi);
+	if (err < 0)
+		goto probe_error;
+	strcpy(rmidi->name, "MPD16 MIDI");
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT;
+	rmidi->ops = &global_ops;
+	rmidi->private_data = mpd16;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &midi_input_ops);
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto probe_error;
+
+	usb_set_intfdata(interface, card);
+
+	return 0;
+
+probe_error:
+	snd_card_free(card);
+	return err;
+}
+
+static void disconnect(struct usb_interface *interface)
+{
+	struct snd_card *card = usb_get_intfdata(interface);
+	struct mpd16 *mpd16;
+	unsigned int i;
+
+	if (!card)
+		return;
+	mpd16 = card->private_data;
+
+	/* make sure that userspace cannot create new requests */
+	snd_card_disconnect(card);
+
+	/* make sure that there are no pending USB requests */
+	mutex_lock(&mpd16->mutex);
+	spin_lock_irq(&mpd16->lock);
+	mpd16->disconnected = true;
+	mpd16->control_output = NULL;
+	mpd16->control_input = NULL;
+	mpd16->midi_input = NULL;
+	spin_unlock_irq(&mpd16->lock);
+	kill_and_free_urb(mpd16, &mpd16->control_output_urb);
+	kill_and_free_urb(mpd16, &mpd16->control_input_urb);
+	for (i = 0; i < ARRAY_SIZE(mpd16->midi_input_urbs); ++i)
+		kill_and_free_urb(mpd16, &mpd16->midi_input_urbs[i]);
+	mutex_unlock(&mpd16->mutex);
+
+	snd_card_free_when_closed(card);
+}
+
+static struct usb_driver driver = {
+	.name       = "snd-mpd16",
+	.id_table   = id_table,
+	.probe      = probe,
+	.disconnect = disconnect,
+#if 0
+	.suspend    = suspend,
+	.resume     = resume,
+#endif
+};
+
+static int __init alsa_card_mpd16_init(void)
+{
+	return usb_register(&driver);
+}
+
+static void __exit alsa_card_mpd16_exit(void)
+{
+	usb_deregister(&driver);
+}
+
+module_init(alsa_card_mpd16_init);
+module_exit(alsa_card_mpd16_exit);
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -645,105 +645,6 @@ static struct usb_protocol_ops snd_usbmi
 };
 
 /*
- * AKAI MPD16 protocol:
- *
- * For control port (endpoint 1):
- * ==============================
- * One or more chunks consisting of first byte of (0x10 | msg_len) and then a
- * SysEx message (msg_len=9 bytes long).
- *
- * For data port (endpoint 2):
- * ===========================
- * One or more chunks consisting of first byte of (0x20 | msg_len) and then a
- * MIDI message (msg_len bytes long)
- *
- * Messages sent: Active Sense, Note On, Poly Pressure, Control Change.
- */
-static void snd_usbmidi_akai_input(struct snd_usb_midi_in_endpoint *ep,
-				   uint8_t *buffer, int buffer_length)
-{
-	unsigned int pos = 0;
-	unsigned int len = (unsigned int)buffer_length;
-	while (pos < len) {
-		unsigned int port = (buffer[pos] >> 4) - 1;
-		unsigned int msg_len = buffer[pos] & 0x0f;
-		pos++;
-		if (pos + msg_len <= len && port < 2)
-			snd_usbmidi_input_data(ep, 0, &buffer[pos], msg_len);
-		pos += msg_len;
-	}
-}
-
-#define MAX_AKAI_SYSEX_LEN 9
-
-static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
-				    struct urb *urb)
-{
-	uint8_t *msg;
-	int pos, end, count, buf_end;
-	uint8_t tmp[MAX_AKAI_SYSEX_LEN];
-	struct snd_rawmidi_substream *substream = ep->ports[0].substream;
-
-	if (!ep->ports[0].active)
-		return;
-
-	msg = urb->transfer_buffer + urb->transfer_buffer_length;
-	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
-
-	/* only try adding more data when there's space for at least 1 SysEx */
-	while (urb->transfer_buffer_length < buf_end) {
-		count = snd_rawmidi_transmit_peek(substream,
-						  tmp, MAX_AKAI_SYSEX_LEN);
-		if (!count) {
-			ep->ports[0].active = 0;
-			return;
-		}
-		/* try to skip non-SysEx data */
-		for (pos = 0; pos < count && tmp[pos] != 0xF0; pos++)
-			;
-
-		if (pos > 0) {
-			snd_rawmidi_transmit_ack(substream, pos);
-			continue;
-		}
-
-		/* look for the start or end marker */
-		for (end = 1; end < count && tmp[end] < 0xF0; end++)
-			;
-
-		/* next SysEx started before the end of current one */
-		if (end < count && tmp[end] == 0xF0) {
-			/* it's incomplete - drop it */
-			snd_rawmidi_transmit_ack(substream, end);
-			continue;
-		}
-		/* SysEx complete */
-		if (end < count && tmp[end] == 0xF7) {
-			/* queue it, ack it, and get the next one */
-			count = end + 1;
-			msg[0] = 0x10 | count;
-			memcpy(&msg[1], tmp, count);
-			snd_rawmidi_transmit_ack(substream, count);
-			urb->transfer_buffer_length += count + 1;
-			msg += count + 1;
-			continue;
-		}
-		/* less than 9 bytes and no end byte - wait for more */
-		if (count < MAX_AKAI_SYSEX_LEN) {
-			ep->ports[0].active = 0;
-			return;
-		}
-		/* 9 bytes and no end marker in sight - malformed, skip it */
-		snd_rawmidi_transmit_ack(substream, count);
-	}
-}
-
-static struct usb_protocol_ops snd_usbmidi_akai_ops = {
-	.input = snd_usbmidi_akai_input,
-	.output = snd_usbmidi_akai_output,
-};
-
-/*
  * Novation USB MIDI protocol: number of data bytes is in the first byte
  * (when receiving) (+1!) or in the second byte (when sending); data begins
  * at the third byte.
@@ -1533,11 +1434,6 @@ static struct port_info {
 	EXTERNAL_PORT(0x086a, 0x0001, 8, "%s Broadcast"),
 	EXTERNAL_PORT(0x086a, 0x0002, 8, "%s Broadcast"),
 	EXTERNAL_PORT(0x086a, 0x0003, 4, "%s Broadcast"),
-	/* Akai MPD16 */
-	CONTROL_PORT(0x09e8, 0x0062, 0, "%s Control"),
-	PORT_INFO(0x09e8, 0x0062, 1, "%s MIDI", 0,
-		SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
-		SNDRV_SEQ_PORT_TYPE_HARDWARE),
 	/* Access Music Virus TI */
 	EXTERNAL_PORT(0x133e, 0x0815, 0, "%s MIDI"),
 	PORT_INFO(0x133e, 0x0815, 1, "%s Synth", 0,
@@ -2139,12 +2035,6 @@ int snd_usbmidi_create(struct snd_card *
 		umidi->usb_protocol_ops = &snd_usbmidi_cme_ops;
 		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
-	case QUIRK_MIDI_AKAI:
-		umidi->usb_protocol_ops = &snd_usbmidi_akai_ops;
-		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
-		/* endpoint 1 is input-only */
-		endpoints[1].out_cables = 0;
-		break;
 	default:
 		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 		err = -ENXIO;
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2120,17 +2120,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
-/* AKAI devices */
-{
-	USB_DEVICE(0x09e8, 0x0062),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.vendor_name = "AKAI",
-		.product_name = "MPD16",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_AKAI,
-	}
-},
-
 /* TerraTec devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0012),
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -290,7 +290,6 @@ int snd_usb_create_quirk(struct snd_usb_
 		[QUIRK_MIDI_FASTLANE] = create_any_midi_quirk,
 		[QUIRK_MIDI_EMAGIC] = create_any_midi_quirk,
 		[QUIRK_MIDI_CME] = create_any_midi_quirk,
-		[QUIRK_MIDI_AKAI] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -73,7 +73,6 @@ enum quirk_type {
 	QUIRK_MIDI_FASTLANE,
 	QUIRK_MIDI_EMAGIC,
 	QUIRK_MIDI_CME,
-	QUIRK_MIDI_AKAI,
 	QUIRK_MIDI_US122L,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
