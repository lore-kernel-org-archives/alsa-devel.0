From: Mario Kicherer <dev@kicherer.org>
Subject: [PATCH v3] MIDI driver for Behringer BCD2000 USB device
Date: Mon, 10 Feb 2014 23:34:28 +0100
Message-ID: <1392071668-10722-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id F3F64260851
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 23:34:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mario Kicherer <dev@kicherer.org>
List-Id: alsa-devel@alsa-project.org

This patch adds initial support for the Behringer BCD2000 USB DJ controller.
At the moment, only the MIDI part of the device is working, i.e. knobs,
buttons and LEDs.

I also plan to add support for the audio part, but I assume that this will
require more effort than the rather simple MIDI interface. Progress can be
tracked at https://github.com/anyc/snd-usb-bcd2000.

Changes since v2:
	- applied more changes from Daniel Mack and Clemens Ladisch

Changes since v1:
        - fixed the various code style issues, thanks to Daniel Mack and
          checkpatch.pl.

Signed-off-by: Mario Kicherer <dev@kicherer.org>
---
 sound/usb/Kconfig           |  13 ++
 sound/usb/Makefile          |   2 +-
 sound/usb/bcd2000/Makefile  |   3 +
 sound/usb/bcd2000/bcd2000.c | 484 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 501 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/bcd2000/Makefile
 create mode 100644 sound/usb/bcd2000/bcd2000.c

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index de9408b..145653a 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -146,5 +146,18 @@ config SND_USB_HIFACE
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-usb-hiface.
 
+config SND_BCD2000
+	tristate "Behringer BCD2000 MIDI driver"
+	select SND_RAWMIDI
+	help
+	  Say Y here to include MIDI support for the Behringer BCD2000 DJ
+	  controller.
+
+	  Audio support is still work-in-progress at
+	  https://github.com/anyc/snd-usb-bcd2000
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-bcd2000.
+
 endif	# SND_USB
 
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index abe668f..2b92f0d 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -23,4 +23,4 @@ obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
 obj-$(CONFIG_SND_USB_US122L) += snd-usbmidi-lib.o
 
-obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/
+obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/
diff --git a/sound/usb/bcd2000/Makefile b/sound/usb/bcd2000/Makefile
new file mode 100644
index 0000000..f09ccc0
--- /dev/null
+++ b/sound/usb/bcd2000/Makefile
@@ -0,0 +1,3 @@
+snd-bcd2000-y := bcd2000.o
+
+obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
\ No newline at end of file
diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
new file mode 100644
index 0000000..7a24611
--- /dev/null
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -0,0 +1,484 @@
+/*
+ * Behringer BCD2000 driver
+ *
+ *   Copyright (C) 2014 Mario Kicherer (dev@kicherer.org)
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/usb/audio.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/rawmidi.h>
+
+#define DEVICE_NAME "Behringer BCD2000"
+#define DEVICE_SHORTNAME "bcd2000"
+
+#define PREFIX DEVICE_SHORTNAME ": "
+#define BUFSIZE 64
+
+static struct usb_device_id id_table[] = {
+	{ USB_DEVICE(0x1397, 0x00bd) },
+	{ },
+};
+
+static unsigned char device_cmd_prefix[] = {0x03, 0x00};
+
+static unsigned char bcd2000_init_sequence[] = {
+	0x07, 0x00, 0x00, 0x00, 0x78, 0x48, 0x1c, 0x81,
+	0xc4, 0x00, 0x00, 0x00, 0x5e, 0x53, 0x4a, 0xf7,
+	0x18, 0xfa, 0x11, 0xff, 0x6c, 0xf3, 0x90, 0xff,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+	0x18, 0xfa, 0x11, 0xff, 0x14, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xf2, 0x34, 0x4a, 0xf7,
+	0x18, 0xfa, 0x11, 0xff};
+
+struct bcd2000 {
+	struct usb_device *dev;
+	struct snd_card *card;
+	struct usb_interface *intf;
+	int card_index;
+
+	int midi_out_active;
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_substream *midi_receive_substream;
+	struct snd_rawmidi_substream *midi_out_substream;
+
+	unsigned char midi_in_buf[BUFSIZE];
+	unsigned char midi_out_buf[BUFSIZE];
+
+	struct urb *midi_out_urb;
+	struct urb *midi_in_urb;
+
+	struct usb_anchor anchor;
+};
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+
+static DEFINE_MUTEX(devices_mutex);
+static unsigned int devices_used;
+static struct usb_driver bcd2000_driver;
+
+#ifdef CONFIG_SND_DEBUG
+static void bcd2000_dump_buffer(const char *prefix, const char *buf, int len)
+{
+	print_hex_dump(KERN_DEBUG, prefix,
+			DUMP_PREFIX_NONE, 16, 1,
+			buf, len, false);
+}
+#else
+static void bcd2000_dump_buffer(const char *prefix, const char *buf, int len) {}
+#endif
+
+static int bcd2000_midi_input_open(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static int bcd2000_midi_input_close(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+/* register midi substream */
+static void bcd2000_midi_input_trigger(struct snd_rawmidi_substream *substream,
+						int up)
+{
+	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+	bcd2k->midi_receive_substream = up ? substream : NULL;
+}
+
+static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
+					const unsigned char *buf, int len)
+{
+	unsigned char length, tocopy;
+
+	if (!bcd2k->midi_receive_substream)
+		return;
+
+	bcd2000_dump_buffer(PREFIX "received from device: ", buf, len);
+
+	if (len < 2)
+		return;
+
+	/*
+	 * Packet structure: mm nn oo (pp)
+	 *	mm: payload length
+	 *	nn: MIDI command or note
+	 *	oo: note or velocity
+	 *	pp: velocity
+	 */
+
+	length = buf[0];
+
+	/* ignore packets without payload */
+	if (length == 0)
+		return;
+
+	tocopy = min(length, (unsigned char) (len-1));
+
+	bcd2000_dump_buffer(PREFIX "sending to userspace: ",
+					&buf[1], tocopy);
+
+	snd_rawmidi_receive(bcd2k->midi_receive_substream,
+					&buf[1], tocopy);
+}
+
+static void bcd2000_midi_send(struct bcd2000 *bcd2k,
+				struct snd_rawmidi_substream *substream)
+{
+	int len, ret;
+
+	BUILD_BUG_ON(sizeof(device_cmd_prefix) >= BUFSIZE);
+	/* copy the "set LED" command bytes */
+	memcpy(bcd2k->midi_out_buf, device_cmd_prefix,
+		sizeof(device_cmd_prefix));
+
+	/*
+	 * get MIDI packet and leave space for command prefix
+	 * and payload length
+	 */
+	len = snd_rawmidi_transmit(substream,
+				bcd2k->midi_out_buf + 3, BUFSIZE - 3);
+
+	if (len < 0)
+		snd_printk("%s: snd_rawmidi_transmit error %d\n",
+				__func__, len);
+
+	if (len <= 0)
+		return;
+
+	/* set payload length */
+	bcd2k->midi_out_buf[2] = len;
+	bcd2k->midi_out_urb->transfer_buffer_length = BUFSIZE;
+
+	bcd2000_dump_buffer(PREFIX "sending to device: ",
+			bcd2k->midi_out_buf, len+3);
+
+	/* send packet to the BCD2000 */
+	ret = usb_submit_urb(bcd2k->midi_out_urb, GFP_ATOMIC);
+	if (ret < 0)
+		dev_err(&bcd2k->dev->dev, PREFIX
+			"%s (%p): usb_submit_urb() failed, ret=%d, len=%d\n",
+			__func__, substream, ret, len);
+	else
+		bcd2k->midi_out_active = 1;
+}
+
+static int bcd2000_midi_output_open(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
+{
+	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+
+	if (bcd2k->midi_out_active) {
+		usb_kill_urb(bcd2k->midi_out_urb);
+		bcd2k->midi_out_active = 0;
+	}
+
+	return 0;
+}
+
+/* register midi substream */
+static void bcd2000_midi_output_trigger(struct snd_rawmidi_substream *substream,
+						int up)
+{
+	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+
+	if (up) {
+		bcd2k->midi_out_substream = substream;
+		/* check if there is data userspace wants to send */
+		if (!bcd2k->midi_out_active)
+			bcd2000_midi_send(bcd2k, substream);
+	} else {
+		bcd2k->midi_out_substream = NULL;
+	}
+}
+
+static void bcd2000_output_complete(struct urb *urb)
+{
+	struct bcd2000 *bcd2k = urb->context;
+	struct snd_rawmidi_substream *midi_out_substream;
+
+	bcd2k->midi_out_active = 0;
+
+	if (urb->status != 0)
+		dev_err(&urb->dev->dev,
+			PREFIX "output urb->status: %d\n", urb->status);
+
+	midi_out_substream = ACCESS_ONCE(bcd2k->midi_out_substream);
+	if (!midi_out_substream)
+		return;
+
+	/* check if there is more data userspace wants to send */
+	bcd2000_midi_send(bcd2k, midi_out_substream);
+}
+
+static void bcd2000_input_complete(struct urb *urb)
+{
+	int ret;
+	struct device *dev = &urb->dev->dev;
+	struct bcd2000 *bcd2k = urb->context;
+
+	if (urb->status) {
+		dev_warn(dev, PREFIX "input urb->status: %i\n", urb->status);
+		return;
+	}
+
+	if (!bcd2k)
+		return;
+
+	if (urb->actual_length > 0)
+		bcd2000_midi_handle_input(bcd2k, urb->transfer_buffer,
+					urb->actual_length);
+
+	/* acknowledge received packet */
+	ret = usb_submit_urb(bcd2k->midi_in_urb, GFP_ATOMIC);
+	if (ret < 0)
+		dev_err(dev, "unable to submit urb. OOM!?\n");
+}
+
+static struct snd_rawmidi_ops bcd2000_midi_output = {
+	.open =    bcd2000_midi_output_open,
+	.close =   bcd2000_midi_output_close,
+	.trigger = bcd2000_midi_output_trigger,
+};
+
+static struct snd_rawmidi_ops bcd2000_midi_input = {
+	.open =    bcd2000_midi_input_open,
+	.close =   bcd2000_midi_input_close,
+	.trigger = bcd2000_midi_input_trigger,
+};
+
+static void bcd2000_init_device(struct bcd2000 *bcd2k)
+{
+	int ret;
+
+	init_usb_anchor(&bcd2k->anchor);
+	usb_anchor_urb(bcd2k->midi_out_urb, &bcd2k->anchor);
+	usb_anchor_urb(bcd2k->midi_in_urb, &bcd2k->anchor);
+
+	/* copy init sequence into buffer */
+	memcpy(bcd2k->midi_out_buf, bcd2000_init_sequence, 52);
+	bcd2k->midi_out_urb->transfer_buffer_length = 52;
+
+	/* submit sequence */
+	ret = usb_submit_urb(bcd2k->midi_out_urb, GFP_KERNEL);
+	if (ret < 0)
+		dev_err(&bcd2k->dev->dev, PREFIX
+			"%s: usb_submit_urb() out failed, ret=%d: ",
+			__func__, ret);
+	else
+		bcd2k->midi_out_active = 1;
+
+	/* send empty packet to enable button and controller events */
+	ret = usb_submit_urb(bcd2k->midi_in_urb, GFP_KERNEL);
+	if (ret < 0)
+		dev_err(&bcd2k->dev->dev, PREFIX
+			"%s: usb_submit_urb() in failed, ret=%d: ",
+			__func__, ret);
+
+	/* ensure initialization is finished */
+	usb_wait_anchor_empty_timeout(&bcd2k->anchor, 1000);
+}
+
+static int bcd2000_init_midi(struct bcd2000 *bcd2k)
+{
+	int ret;
+	struct snd_rawmidi *rmidi;
+
+	ret = snd_rawmidi_new(bcd2k->card, bcd2k->card->shortname, 0,
+					1, /* output */
+					1, /* input */
+					&rmidi);
+
+	if (ret < 0)
+		return;
+
+	strlcpy(rmidi->name, bcd2k->card->shortname, sizeof(rmidi->name));
+
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_DUPLEX;
+	rmidi->private_data = bcd2k;
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+					&bcd2000_midi_output);
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+					&bcd2000_midi_input);
+
+	bcd2k->rmidi = rmidi;
+
+	bcd2k->midi_in_urb = usb_alloc_urb(0, GFP_KERNEL);
+	bcd2k->midi_out_urb = usb_alloc_urb(0, GFP_KERNEL);
+
+	if (!bcd2k->midi_in_urb || !bcd2k->midi_out_urb) {
+		snd_printk(KERN_ERR PREFIX "usb_alloc_urb failed\n");
+		return -ENOMEM;
+	}
+
+	usb_fill_int_urb(bcd2k->midi_in_urb, bcd2k->dev,
+				usb_rcvintpipe(bcd2k->dev, 0x81),
+				bcd2k->midi_in_buf, BUFSIZE,
+				bcd2000_input_complete, bcd2k, 1);
+
+	usb_fill_int_urb(bcd2k->midi_out_urb, bcd2k->dev,
+				usb_sndintpipe(bcd2k->dev, 0x1),
+				bcd2k->midi_out_buf, BUFSIZE,
+				bcd2000_output_complete, bcd2k, 1);
+
+	bcd2000_init_device(bcd2k);
+
+	return 0;
+}
+
+static void bcd2000_free_usb_related_resources(struct bcd2000 *bcd2k,
+						struct usb_interface *interface)
+{
+	/* usb_kill_urb not necessary, urb is aborted automatically */
+
+	usb_free_urb(bcd2k->midi_out_urb);
+	usb_free_urb(bcd2k->midi_in_urb);
+
+	if (bcd2k->intf) {
+		usb_set_intfdata(bcd2k->intf, NULL);
+		bcd2k->intf = NULL;
+	}
+}
+
+static int bcd2000_probe(struct usb_interface *interface,
+				const struct usb_device_id *usb_id)
+{
+	struct snd_card *card;
+	struct bcd2000 *bcd2k;
+	unsigned int card_index;
+	char usb_path[32];
+	int err;
+
+	mutex_lock(&devices_mutex);
+
+	for (card_index = 0; card_index < SNDRV_CARDS; ++card_index)
+		if (enable[card_index] && !(devices_used & (1 << card_index)))
+			break;
+
+	if (card_index >= SNDRV_CARDS) {
+		mutex_unlock(&devices_mutex);
+		return -ENOENT;
+	}
+
+	err = snd_card_create(index[card_index], id[card_index], THIS_MODULE,
+					sizeof(*bcd2k), &card);
+	if (err < 0) {
+		mutex_unlock(&devices_mutex);
+		return err;
+	}
+
+	bcd2k = card->private_data;
+	bcd2k->dev = interface_to_usbdev(interface);
+	bcd2k->card = card;
+	bcd2k->card_index = card_index;
+	bcd2k->intf = interface;
+
+	snd_card_set_dev(card, &interface->dev);
+
+	strcpy(card->driver, DEVICE_NAME);
+	strcpy(card->shortname, DEVICE_SHORTNAME);
+	usb_make_path(bcd2k->dev, usb_path, sizeof(usb_path));
+	snprintf(bcd2k->card->longname, sizeof(bcd2k->card->longname),
+			DEVICE_NAME ", at %s",
+			usb_path);
+
+	dev_info(&bcd2k->dev->dev, PREFIX "%s", bcd2k->card->longname);
+
+	err = bcd2000_init_midi(bcd2k);
+	if (err < 0)
+		goto probe_error;
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto probe_error;
+
+	usb_set_intfdata(interface, bcd2k);
+	devices_used |= 1 << card_index;
+
+	mutex_unlock(&devices_mutex);
+	return 0;
+
+probe_error:
+	dev_info(&bcd2k->dev->dev, PREFIX "error during probing");
+	bcd2000_free_usb_related_resources(bcd2k, interface);
+	snd_card_free(card);
+	mutex_unlock(&devices_mutex);
+	return err;
+}
+
+static void bcd2000_disconnect(struct usb_interface *interface)
+{
+	struct bcd2000 *bcd2k = usb_get_intfdata(interface);
+
+	if (!bcd2k)
+		return;
+
+	mutex_lock(&devices_mutex);
+
+	/* make sure that userspace cannot create new requests */
+	snd_card_disconnect(bcd2k->card);
+
+	bcd2000_free_usb_related_resources(bcd2k, interface);
+
+	devices_used &= ~(1 << bcd2k->card_index);
+
+	snd_card_free_when_closed(bcd2k->card);
+
+	mutex_unlock(&devices_mutex);
+}
+
+static struct usb_driver bcd2000_driver = {
+	.name =	DEVICE_SHORTNAME,
+	.probe =	bcd2000_probe,
+	.disconnect =	bcd2000_disconnect,
+	.id_table =	id_table,
+};
+
+static int __init bcd2000_init(void)
+{
+	int retval = 0;
+
+	retval = usb_register(&bcd2000_driver);
+	if (retval)
+		snd_printk(KERN_INFO "usb_register failed. Error: %d", retval);
+	return retval;
+}
+
+static void __exit bcd2000_exit(void)
+{
+	usb_deregister(&bcd2000_driver);
+}
+
+module_init(bcd2000_init);
+module_exit(bcd2000_exit);
+
+MODULE_DEVICE_TABLE(usb, id_table);
+MODULE_AUTHOR("Mario Kicherer, dev@kicherer.org");
+MODULE_DESCRIPTION("Behringer BCD2000 driver");
+MODULE_LICENSE("GPL");
-- 
1.8.3.2
