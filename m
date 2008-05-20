From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] TASCAM US-122L Module
Date: Tue, 20 May 2008 11:31:12 +0200
Message-ID: <200805201131.12316.fzu@wemgehoertderstaat.de>
References: <200803161956.42461.fzu@wemgehoertderstaat.de>
	<s5hbq32ba47.wl%tiwai@suse.de>
	<200805201129.39484.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by alsa0.perex.cz (Postfix) with ESMTP id E9F902485F
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 12:14:16 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so2222843fka.0
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 03:14:16 -0700 (PDT)
In-Reply-To: <200805201129.39484.fzu@wemgehoertderstaat.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Establishes standard raw midi and custom pcm i/o.
Pcm is transmitted using mmaped memory, userspace accesses urb dma-memory.
ALSA pcm in userspace can be done using the usb_stream alsa-plugin.
Ehci-hcd note:	Module doesn't care for iso number of packets being a multiple
		of 8 so at least for vanilla kernels <= 2.6.26 it only works
		when the device is attached to an USB1.1 port.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>

---

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 9351b8a..9426f42 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -63,5 +63,16 @@ config SND_USB_CAIAQ_INPUT
 	   * Native Instruments Kore Controller 2
 	   * Native Instruments Audio Kontrol 1
 
+config SND_USB_US122L
+	tristate "Tascam US-122L USB driver"
+	depends on SND && USB && X86 && EXPERIMENTAL
+	select SND_RAWMIDI
+	help
+	  Say Y here to include support for Tascam US-122L USB Audio/MIDI
+	  interfaces.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-usb-us122l.
+
 endmenu
 
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index aa252ef..abb288b 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -8,5 +8,6 @@ snd-usb-lib-objs := usbmidi.o
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o snd-usb-lib.o
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usb-lib.o
+obj-$(CONFIG_SND_USB_US122L) += snd-usb-lib.o
 
 obj-$(CONFIG_SND) += usx2y/ caiaq/
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 7cf18c3..140ba36 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -156,6 +156,7 @@ enum quirk_type {
 	QUIRK_MIDI_RAW,
 	QUIRK_MIDI_EMAGIC,
 	QUIRK_MIDI_CME,
+	QUIRK_MIDI_US122L,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UA700_UA25,
diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
index 6676a17..c0c7770 100644
--- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -669,6 +669,42 @@ static struct usb_protocol_ops snd_usbmidi_raw_ops = {
 	.output = snd_usbmidi_raw_output,
 };
 
+static void snd_usbmidi_us122l_input(struct snd_usb_midi_in_endpoint *ep,
+				     uint8_t *buffer, int buffer_length)
+{
+	if (buffer_length != 9)
+		return;
+	buffer_length = 8;
+	while (buffer_length && buffer[buffer_length - 1] == 0xFD)
+		buffer_length--;
+	if (buffer_length)
+		snd_usbmidi_input_data(ep, 0, buffer, buffer_length);
+}
+
+static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep)
+{
+	int count;
+
+	if (!ep->ports[0].active)
+		return;
+	count = ep->urb->dev->speed == USB_SPEED_HIGH ? 1 : 2;
+	count = snd_rawmidi_transmit(ep->ports[0].substream,
+				     ep->urb->transfer_buffer,
+				     count);
+	if (count < 1) {
+		ep->ports[0].active = 0;
+		return;
+	}
+
+	memset(ep->urb->transfer_buffer + count, 0xFD, 9 - count);
+	ep->urb->transfer_buffer_length = count;
+}
+
+static struct usb_protocol_ops snd_usbmidi_122l_ops = {
+	.input = snd_usbmidi_us122l_input,
+	.output = snd_usbmidi_us122l_output,
+};
+
 /*
  * Emagic USB MIDI protocol: raw MIDI with "F5 xx" port switching.
  */
@@ -1714,6 +1750,9 @@ int snd_usb_create_midi_interface(struct snd_usb_audio* chip,
 			umidi->usb_protocol_ops =
 				&snd_usbmidi_maudio_broken_running_status_ops;
 		break;
+	case QUIRK_MIDI_US122L:
+		umidi->usb_protocol_ops = &snd_usbmidi_122l_ops;
+		/* fall through */
 	case QUIRK_MIDI_FIXED_ENDPOINT:
 		memcpy(&endpoints[0], quirk->data,
 		       sizeof(struct snd_usb_midi_endpoint_info));
diff --git a/sound/usb/usx2y/Makefile b/sound/usb/usx2y/Makefile
index 9ac22bc..7489330 100644
--- a/sound/usb/usx2y/Makefile
+++ b/sound/usb/usx2y/Makefile
@@ -1,3 +1,5 @@
 snd-usb-usx2y-objs := usbusx2y.o usX2Yhwdep.o usx2yhwdeppcm.o
+snd-usb-us122l-objs := us122l.o
 
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usb-usx2y.o
+obj-$(CONFIG_SND_USB_US122L) += snd-usb-us122l.o
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
new file mode 100644
index 0000000..b441fe2
--- /dev/null
+++ b/sound/usb/usx2y/us122l.c
@@ -0,0 +1,692 @@
+/*
+ * Copyright (C) 2007, 2008 Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <sound/core.h>
+#include <sound/hwdep.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#define MODNAME "US122L"
+#include "usb_stream.c"
+#include "../usbaudio.h"
+#include "us122l.h"
+
+MODULE_AUTHOR("Karsten Wiese <fzu@wemgehoertderstaat.de>");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.5");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-max */
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* Id for this card */
+							/* Enable this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for "NAME_ALLCAPS".");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for "NAME_ALLCAPS".");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable "NAME_ALLCAPS".");
+
+static int snd_us122l_card_used[SNDRV_CARDS];
+
+
+static int us122l_create_usbmidi(struct snd_card *card)
+{
+	static struct snd_usb_midi_endpoint_info quirk_data = {
+		.out_ep = 4,
+		.in_ep = 3,
+		.out_cables =	0x001,
+		.in_cables =	0x001
+	};
+	static struct snd_usb_audio_quirk quirk = {
+		.vendor_name =	"US122L",
+		.product_name =	NAME_ALLCAPS,
+		.ifnum = 	1,
+		.type = QUIRK_MIDI_US122L,
+		.data = &quirk_data
+	};
+	struct usb_device *dev = US122L(card)->chip.dev;
+	struct usb_interface *iface = usb_ifnum_to_if(dev, 1);
+
+	return snd_usb_create_midi_interface(&US122L(card)->chip,
+					     iface, &quirk);
+}
+
+/*
+ * Wrapper for usb_control_msg().
+ * Allocates a temp buffer to prevent dmaing from/to the stack.
+ */
+static int us122l_ctl_msg(struct usb_device *dev, unsigned int pipe,
+			  __u8 request, __u8 requesttype,
+			  __u16 value, __u16 index, void *data,
+			  __u16 size, int timeout)
+{
+	int err;
+	void *buf = NULL;
+
+	if (size > 0) {
+		buf = kmemdup(data, size, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+	}
+	err = usb_control_msg(dev, pipe, request, requesttype,
+			      value, index, buf, size, timeout);
+	if (size > 0) {
+		memcpy(data, buf, size);
+		kfree(buf);
+	}
+	return err;
+}
+
+static void pt_info_set(struct usb_device *dev, u8 v)
+{
+	int ret;
+
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			      'I',
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      v, 0, NULL, 0, 1000);
+	snd_printdd(KERN_DEBUG "%i\n", ret);
+}
+
+static void usb_stream_hwdep_vm_open(struct vm_area_struct *area)
+{
+	struct us122l *us122l = area->vm_private_data;
+	atomic_inc(&us122l->mmap_count);
+	snd_printdd(KERN_DEBUG "%i\n", atomic_read(&us122l->mmap_count));
+}
+
+static int usb_stream_hwdep_vm_fault(struct vm_area_struct *area,
+				     struct vm_fault *vmf)
+{
+	unsigned long offset;
+	struct page *page;
+	void *vaddr;
+	struct us122l *us122l = area->vm_private_data;
+	struct usb_stream *s;
+	int vm_f = VM_FAULT_SIGBUS;
+
+	mutex_lock(&us122l->mutex);
+	s = us122l->sk.s;
+	if (!s)
+		goto out;
+
+	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset < PAGE_ALIGN(s->read_size))
+		vaddr = (char *)s + offset;
+	else {
+		offset -= PAGE_ALIGN(s->read_size);
+		if (offset >= PAGE_ALIGN(s->write_size))
+			goto out;
+
+		vaddr = us122l->sk.write_page + offset;
+	}
+	page = virt_to_page(vaddr);
+
+	get_page(page);
+	mutex_unlock(&us122l->mutex);
+
+	vmf->page = page;
+	vm_f = 0;
+out:
+	return vm_f;
+}
+
+static void usb_stream_hwdep_vm_close(struct vm_area_struct *area)
+{
+	struct us122l *us122l = area->vm_private_data;
+	atomic_dec(&us122l->mmap_count);
+	snd_printdd(KERN_DEBUG "%i\n", atomic_read(&us122l->mmap_count));
+}
+
+static struct vm_operations_struct usb_stream_hwdep_vm_ops = {
+	.open = usb_stream_hwdep_vm_open,
+	.fault = usb_stream_hwdep_vm_fault,
+	.close = usb_stream_hwdep_vm_close,
+};
+
+
+static int usb_stream_hwdep_open(struct snd_hwdep *hw, struct file *file)
+{
+	struct us122l	*us122l = hw->private_data;
+	struct usb_interface *iface;
+	snd_printdd(KERN_DEBUG "%p %p\n", hw, file);
+	if (hw->used >= 2)
+		return -EBUSY;
+
+	if (!us122l->first)
+		us122l->first = file;
+	iface = usb_ifnum_to_if(us122l->chip.dev, 1);
+	usb_autopm_get_interface(iface);
+	return 0;
+}
+
+static int usb_stream_hwdep_release(struct snd_hwdep *hw, struct file *file)
+{
+	struct us122l	*us122l = hw->private_data;
+	struct usb_interface *iface = usb_ifnum_to_if(us122l->chip.dev, 1);
+	snd_printdd(KERN_DEBUG "%p %p\n", hw, file);
+	usb_autopm_put_interface(iface);
+	if (us122l->first == file)
+		us122l->first = NULL;
+	mutex_lock(&us122l->mutex);
+	if (us122l->master == file)
+		us122l->master = us122l->slave;
+
+	us122l->slave = NULL;
+	mutex_unlock(&us122l->mutex);
+	return 0;
+}
+
+static int usb_stream_hwdep_mmap(struct snd_hwdep *hw,
+				 struct file *filp, struct vm_area_struct *area)
+{
+	unsigned long	size = area->vm_end - area->vm_start;
+	struct us122l	*us122l = hw->private_data;
+	unsigned long offset;
+	struct usb_stream *s;
+	int err = 0;
+	bool read;
+
+	offset = area->vm_pgoff << PAGE_SHIFT;
+	mutex_lock(&us122l->mutex);
+	s = us122l->sk.s;
+	read = offset < s->read_size;
+	if (read && area->vm_flags & VM_WRITE) {
+		err = -EPERM;
+		goto out;
+	}
+	snd_printdd(KERN_DEBUG "%lu %u\n", size,
+		    read ? s->read_size : s->write_size);
+	/* if userspace tries to mmap beyond end of our buffer, fail */
+	if (size > PAGE_ALIGN(read ? s->read_size : s->write_size)) {
+		snd_printk(KERN_WARNING "%lu > %u\n", size,
+			   read ? s->read_size : s->write_size);
+		err = -EINVAL;
+		goto out;
+	}
+
+	area->vm_ops = &usb_stream_hwdep_vm_ops;
+	area->vm_flags |= VM_RESERVED;
+	area->vm_private_data = us122l;
+	atomic_inc(&us122l->mmap_count);
+out:
+	mutex_unlock(&us122l->mutex);
+	return err;
+}
+
+static unsigned int usb_stream_hwdep_poll(struct snd_hwdep *hw,
+					  struct file *file, poll_table *wait)
+{
+	struct us122l	*us122l = hw->private_data;
+	struct usb_stream *s = us122l->sk.s;
+	unsigned	*polled;
+	unsigned int	mask;
+
+	poll_wait(file, &us122l->sk.sleep, wait);
+
+	switch (s->state) {
+	case usb_stream_ready:
+		if (us122l->first == file)
+			polled = &s->periods_polled;
+		else
+			polled = &us122l->second_periods_polled;
+		if (*polled != s->periods_done) {
+			*polled = s->periods_done;
+			mask = POLLIN | POLLOUT | POLLWRNORM;
+			break;
+		}
+		/* Fall through */
+		mask = 0;
+		break;
+	default:
+		mask = POLLIN | POLLOUT | POLLWRNORM | POLLERR;
+		break;
+	}
+	return mask;
+}
+
+static void us122l_stop(struct us122l *us122l)
+{
+	struct list_head *p;
+	list_for_each(p, &us122l->chip.midi_list)
+		snd_usbmidi_input_stop(p);
+
+	usb_stream_stop(&us122l->sk);
+	usb_stream_free(&us122l->sk);
+}
+
+static int us122l_set_sample_rate(struct usb_device *dev, int rate)
+{
+	unsigned int ep = 0x81;
+	unsigned char data[3];
+	int err;
+
+	data[0] = rate;
+	data[1] = rate >> 8;
+	data[2] = rate >> 16;
+	err = us122l_ctl_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR,
+			     USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
+			     SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000);
+	if (err < 0)
+		snd_printk(KERN_ERR "%d: cannot set freq %d to ep 0x%x\n",
+			   dev->devnum, rate, ep);
+	return err;
+}
+
+static bool us122l_start(struct us122l *us122l,
+			 unsigned rate, unsigned period_frames)
+{
+	struct list_head *p;
+	int err;
+	unsigned use_packsize = 0;
+	bool success = false;
+
+	if (us122l->chip.dev->speed == USB_SPEED_HIGH) {
+		/* The us-122l's descriptor defaults to iso max_packsize 78,
+		   which isn't needed for samplerates <= 48000.
+		   Lets save some memory:
+		*/
+		switch (rate) {
+		case 44100:
+			use_packsize = 36;
+			break;
+		case 48000:
+			use_packsize = 42;
+			break;
+		case 88200:
+			use_packsize = 72;
+			break;
+		}
+	}
+	if (!usb_stream_new(&us122l->sk, us122l->chip.dev, 1, 2,
+			    rate, use_packsize, period_frames, 6))
+		goto out;
+
+	err = us122l_set_sample_rate(us122l->chip.dev, rate);
+	if (err < 0) {
+		us122l_stop(us122l);
+		snd_printk(KERN_ERR "us122l_set_sample_rate error \n");
+		goto out;
+	}
+	err = usb_stream_start(&us122l->sk);
+	if (err < 0) {
+		us122l_stop(us122l);
+		snd_printk(KERN_ERR "us122l_start error %i \n", err);
+		goto out;
+	}
+	list_for_each(p, &us122l->chip.midi_list)
+		snd_usbmidi_input_start(p);
+	success = true;
+out:
+	return success;
+}
+
+static int usb_stream_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
+				  unsigned cmd, unsigned long arg)
+{
+	struct usb_stream_config *cfg;
+	struct us122l *us122l = hw->private_data;
+	unsigned min_period_frames;
+	int err = 0;
+	bool high_speed;
+
+	if (cmd != SNDRV_USB_STREAM_IOCTL_SET_PARAMS)
+		return -ENOTTY;
+
+	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	if (copy_from_user(cfg, (void *)arg, sizeof(*cfg))) {
+		err = -EFAULT;
+		goto free;
+	}
+	if (cfg->version != USB_STREAM_INTERFACE_VERSION) {
+		err = -ENXIO;
+		goto free;
+	}
+	high_speed = us122l->chip.dev->speed == USB_SPEED_HIGH;
+	if ((cfg->sample_rate != 44100 && cfg->sample_rate != 48000  &&
+	     (!high_speed ||
+	      (cfg->sample_rate != 88200 && cfg->sample_rate != 96000))) ||
+	    cfg->frame_size != 6 ||
+	    cfg->period_frames > 0x3000) {
+		err = -EINVAL;
+		goto free;
+	}
+	switch (cfg->sample_rate) {
+	case 44100:
+		min_period_frames = 48;
+		break;
+	case 48000:
+		min_period_frames = 52;
+		break;
+	default:
+		min_period_frames = 104;
+		break;
+	}
+	if (!high_speed)
+		min_period_frames <<= 1;
+	if (cfg->period_frames < min_period_frames) {
+		err = -EINVAL;
+		goto free;
+	}
+
+	snd_power_wait(hw->card, SNDRV_CTL_POWER_D0);
+
+	mutex_lock(&us122l->mutex);
+	if (!us122l->master)
+		us122l->master = file;
+	else if (us122l->master != file) {
+		if (memcmp(cfg, &us122l->sk.s->cfg, sizeof(*cfg))) {
+			err = -EIO;
+			goto unlock;
+		}
+		us122l->slave = file;
+	}
+	if (!us122l->sk.s ||
+	    memcmp(cfg, &us122l->sk.s->cfg, sizeof(*cfg)) ||
+	    us122l->sk.s->state == usb_stream_xrun) {
+		us122l_stop(us122l);
+		if (!us122l_start(us122l, cfg->sample_rate, cfg->period_frames))
+			err = -EIO;
+		else
+			err = 1;
+	}
+unlock:
+	mutex_unlock(&us122l->mutex);
+free:
+	kfree(cfg);
+	return err;
+}
+
+#define SND_USB_STREAM_ID "USB STREAM"
+static int usb_stream_hwdep_new(struct snd_card *card)
+{
+	int err;
+	struct snd_hwdep *hw;
+	struct usb_device *dev = US122L(card)->chip.dev;
+
+	err = snd_hwdep_new(card, SND_USB_STREAM_ID, 0, &hw);
+	if (err < 0)
+		return err;
+
+	hw->iface = SNDRV_HWDEP_IFACE_USB_STREAM;
+	hw->private_data = US122L(card);
+	hw->ops.open = usb_stream_hwdep_open;
+	hw->ops.release = usb_stream_hwdep_release;
+	hw->ops.ioctl = usb_stream_hwdep_ioctl;
+	hw->ops.ioctl_compat = usb_stream_hwdep_ioctl;
+	hw->ops.mmap = usb_stream_hwdep_mmap;
+	hw->ops.poll = usb_stream_hwdep_poll;
+
+	sprintf(hw->name, "/proc/bus/usb/%03d/%03d/hwdeppcm",
+		dev->bus->busnum, dev->devnum);
+	return 0;
+}
+
+
+static bool us122l_create_card(struct snd_card *card)
+{
+	int err;
+	struct us122l *us122l = US122L(card);
+
+	err = usb_set_interface(us122l->chip.dev, 1, 1);
+	if (err) {
+		snd_printk(KERN_ERR "usb_set_interface error \n");
+		return false;
+	}
+
+	pt_info_set(us122l->chip.dev, 0x11);
+	pt_info_set(us122l->chip.dev, 0x10);
+
+	if (!us122l_start(us122l, 44100, 256))
+		return false;
+
+	err = us122l_create_usbmidi(card);
+	if (err < 0) {
+		snd_printk(KERN_ERR "us122l_create_usbmidi error %i \n", err);
+		us122l_stop(us122l);
+		return false;
+	}
+	err = usb_stream_hwdep_new(card);
+	if (err < 0) {
+/* release the midi resources */
+		struct list_head *p;
+		list_for_each(p, &us122l->chip.midi_list)
+			snd_usbmidi_disconnect(p);
+
+		us122l_stop(us122l);
+		return false;
+	}
+	return true;
+}
+
+static struct snd_card *usx2y_create_card(struct usb_device *device)
+{
+	int		dev;
+	struct snd_card *card;
+	for (dev = 0; dev < SNDRV_CARDS; ++dev)
+		if (enable[dev] && !snd_us122l_card_used[dev])
+			break;
+	if (dev >= SNDRV_CARDS)
+		return NULL;
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
+			    sizeof(struct us122l));
+	if (!card)
+		return NULL;
+	snd_us122l_card_used[US122L(card)->chip.index = dev] = 1;
+
+	US122L(card)->chip.dev = device;
+	US122L(card)->chip.card = card;
+	mutex_init(&US122L(card)->mutex);
+	init_waitqueue_head(&US122L(card)->sk.sleep);
+	INIT_LIST_HEAD(&US122L(card)->chip.midi_list);
+	strcpy(card->driver, "USB "NAME_ALLCAPS"");
+	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
+	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
+		card->shortname,
+		le16_to_cpu(device->descriptor.idVendor),
+		le16_to_cpu(device->descriptor.idProduct),
+		0,
+		US122L(card)->chip.dev->bus->busnum,
+		US122L(card)->chip.dev->devnum
+		);
+	snd_card_set_dev(card, &device->dev);
+	return card;
+}
+
+static void *us122l_usb_probe(struct usb_interface *intf,
+			      const struct usb_device_id *device_id)
+{
+	struct usb_device *device = interface_to_usbdev(intf);
+	struct snd_card *card = usx2y_create_card(device);
+
+	if (!card)
+		return NULL;
+
+	if (!us122l_create_card(card) ||
+	    snd_card_register(card) < 0) {
+		snd_card_free(card);
+		return NULL;
+	}
+
+	usb_get_dev(device);
+	return card;
+}
+
+static int snd_us122l_probe(struct usb_interface *intf,
+			    const struct usb_device_id *id)
+{
+	struct snd_card *card;
+	snd_printdd(KERN_DEBUG"%p:%i\n",
+		    intf, intf->cur_altsetting->desc.bInterfaceNumber);
+	if (intf->cur_altsetting->desc.bInterfaceNumber != 1)
+		return 0;
+
+	card = us122l_usb_probe(usb_get_intf(intf), id);
+
+	if (card) {
+		usb_set_intfdata(intf, card);
+		return 0;
+	}
+
+	usb_put_intf(intf);
+	return -EIO;
+}
+
+static void snd_us122l_disconnect(struct usb_interface *intf)
+{
+	struct snd_card *card;
+	struct us122l *us122l;
+	struct list_head *p;
+
+	card = usb_get_intfdata(intf);
+	if (!card)
+		return;
+
+	snd_card_disconnect(card);
+
+	us122l = US122L(card);
+	mutex_lock(&us122l->mutex);
+	us122l_stop(us122l);
+	mutex_unlock(&us122l->mutex);
+	us122l->chip.shutdown = 1;
+
+/* release the midi resources */
+	list_for_each(p, &us122l->chip.midi_list) {
+		snd_usbmidi_disconnect(p);
+	}
+
+	usb_put_intf(intf);
+	usb_put_dev(US122L(card)->chip.dev);
+
+	while (atomic_read(&us122l->mmap_count))
+		msleep(500);
+
+	snd_card_free(card);
+}
+
+static int snd_us122l_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct snd_card *card;
+	struct us122l *us122l;
+	struct list_head *p;
+
+	card = dev_get_drvdata(&intf->dev);
+	if (!card)
+		return 0;
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+
+	us122l = US122L(card);
+	if (!us122l)
+		return 0;
+
+	list_for_each(p, &us122l->chip.midi_list)
+		snd_usbmidi_input_stop(p);
+
+	mutex_lock(&us122l->mutex);
+	usb_stream_stop(&us122l->sk);
+	mutex_unlock(&us122l->mutex);
+
+	return 0;
+}
+
+static int snd_us122l_resume(struct usb_interface *intf)
+{
+	struct snd_card *card;
+	struct us122l *us122l;
+	struct list_head *p;
+	int err;
+
+	card = dev_get_drvdata(&intf->dev);
+	if (!card)
+		return 0;
+
+	us122l = US122L(card);
+	if (!us122l)
+		return 0;
+
+	mutex_lock(&us122l->mutex);
+	/* needed, doesn't restart without: */
+	err = usb_set_interface(us122l->chip.dev, 1, 1);
+	if (err) {
+		snd_printk(KERN_ERR "usb_set_interface error \n");
+		goto unlock;
+	}
+
+	pt_info_set(us122l->chip.dev, 0x11);
+	pt_info_set(us122l->chip.dev, 0x10);
+
+	err = us122l_set_sample_rate(us122l->chip.dev,
+				     us122l->sk.s->cfg.sample_rate);
+	if (err < 0) {
+		snd_printk(KERN_ERR "us122l_set_sample_rate error \n");
+		goto unlock;
+	}
+	err = usb_stream_start(&us122l->sk);
+	if (err)
+		goto unlock;
+
+	list_for_each(p, &us122l->chip.midi_list)
+		snd_usbmidi_input_start(p);
+unlock:
+	mutex_unlock(&us122l->mutex);
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	return err;
+}
+
+static struct usb_device_id snd_us122l_usb_id_table[] = {
+	{
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	0x0644,
+		.idProduct =	USB_ID_US122L
+	},
+/*  	{ */		/* US-144 maybe works when @USB1.1. Untested. */
+/* 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE, */
+/* 		.idVendor =	0x0644, */
+/* 		.idProduct =	USB_ID_US144 */
+/* 	}, */
+	{ /* terminator */ }
+};
+
+MODULE_DEVICE_TABLE(usb, snd_us122l_usb_id_table);
+static struct usb_driver snd_us122l_usb_driver = {
+	.name =		"snd-usb-us122l",
+	.probe =	snd_us122l_probe,
+	.disconnect =	snd_us122l_disconnect,
+	.suspend =	snd_us122l_suspend,
+	.resume =	snd_us122l_resume,
+	.reset_resume =	snd_us122l_resume,
+	.id_table =	snd_us122l_usb_id_table,
+	.supports_autosuspend = 1
+};
+
+
+static int __init snd_us122l_module_init(void)
+{
+	return usb_register(&snd_us122l_usb_driver);
+}
+
+static void __exit snd_us122l_module_exit(void)
+{
+	usb_deregister(&snd_us122l_usb_driver);
+}
+
+module_init(snd_us122l_module_init)
+module_exit(snd_us122l_module_exit)
diff --git a/sound/usb/usx2y/us122l.h b/sound/usb/usx2y/us122l.h
new file mode 100644
index 0000000..3d10c4b
--- /dev/null
+++ b/sound/usb/usx2y/us122l.h
@@ -0,0 +1,27 @@
+#ifndef US122L_H
+#define US122L_H
+
+
+struct us122l {
+	struct snd_usb_audio 	chip;
+	int			stride;
+	struct usb_stream_kernel sk;
+
+	struct mutex		mutex;
+	struct file		*first;
+	unsigned		second_periods_polled;
+	struct file		*master;
+	struct file		*slave;
+
+	atomic_t		mmap_count;
+};
+
+
+#define US122L(c) ((struct us122l *)(c)->private_data)
+
+#define NAME_ALLCAPS "US-122L"
+
+#define USB_ID_US122L 0x800E
+#define USB_ID_US144 0x800F
+
+#endif
diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
new file mode 100644
index 0000000..1c8b67f
--- /dev/null
+++ b/sound/usb/usx2y/usb_stream.c
@@ -0,0 +1,699 @@
+/*
+ * Copyright (C) 2007, 2008 Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/usb.h>
+
+#include "usb_stream.h"
+
+
+/*                             setup                                  */
+
+static unsigned usb_stream_next_packet_size(struct usb_stream_kernel *sk)
+{
+	struct usb_stream *s = sk->s;
+	sk->out_phase_peeked = (sk->out_phase & 0xffff) + sk->freqn;
+	return (sk->out_phase_peeked >> 16) * s->cfg.frame_size;
+}
+
+static void playback_prep_freqn(struct usb_stream_kernel *sk, struct urb *urb)
+{
+	struct usb_stream *s = sk->s;
+	unsigned l = 0;
+	int pack;
+
+	urb->iso_frame_desc[0].offset = 0;
+	urb->iso_frame_desc[0].length =	usb_stream_next_packet_size(sk);
+	sk->out_phase = sk->out_phase_peeked;
+	urb->transfer_buffer_length = urb->iso_frame_desc[0].length;
+
+	for (pack = 1; pack < sk->n_o_ps; pack++) {
+		l = usb_stream_next_packet_size(sk);
+		if (s->idle_outsize + urb->transfer_buffer_length + l >
+		    s->period_size)
+			goto check;
+
+		sk->out_phase = sk->out_phase_peeked;
+		urb->iso_frame_desc[pack].offset = urb->transfer_buffer_length;
+		urb->iso_frame_desc[pack].length = l;
+		urb->transfer_buffer_length += l;
+	}
+	snd_printdd(KERN_DEBUG "%i\n", urb->transfer_buffer_length);
+
+check:
+	urb->number_of_packets = pack;
+	s->idle_outsize += urb->transfer_buffer_length - s->period_size;
+	snd_printdd(KERN_DEBUG "idle=%i ul=%i ps=%i\n", s->idle_outsize,
+		    urb->transfer_buffer_length, s->period_size);
+}
+
+static void init_pipe_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
+			   struct urb **urbs, char *transfer,
+			   struct usb_device *dev, int pipe)
+{
+	int u, p;
+	int maxpacket = use_packsize ?
+		use_packsize : usb_maxpacket(dev, pipe, usb_pipeout(pipe));
+	int transfer_length = maxpacket * sk->n_o_ps;
+
+	for (u = 0; u < USB_STREAM_NURBS;
+	     ++u, transfer += transfer_length) {
+		struct urb *urb = urbs[u];
+		struct usb_iso_packet_descriptor *desc;
+		urb->transfer_flags = URB_ISO_ASAP;
+		urb->transfer_buffer = transfer;
+		urb->dev = dev;
+		urb->pipe = pipe;
+		urb->number_of_packets = sk->n_o_ps;
+		urb->context = sk;
+		urb->interval = 1;
+		if (usb_pipeout(pipe))
+			continue;
+
+		urb->transfer_buffer_length = transfer_length;
+		desc = urb->iso_frame_desc;
+		desc->offset = 0;
+		desc->length = maxpacket;
+		for (p = 1; p < sk->n_o_ps; ++p) {
+			desc[p].offset = desc[p - 1].offset + maxpacket;
+			desc[p].length = maxpacket;
+		}
+	}
+}
+
+static void init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
+		      struct usb_device *dev, int in_pipe, int out_pipe)
+{
+	struct usb_stream	*s = sk->s;
+	char			*indata = (char *)s + sizeof(*s) +
+					sizeof(struct usb_stream_packet) *
+					s->inpackets;
+	int			u;
+
+	for (u = 0; u < USB_STREAM_NURBS; ++u) {
+		sk->inurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
+		sk->outurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
+	}
+
+	init_pipe_urbs(sk, use_packsize, sk->inurb, indata, dev, in_pipe);
+	init_pipe_urbs(sk, use_packsize, sk->outurb, sk->write_page, dev,
+		       out_pipe);
+}
+
+
+/*
+ * convert a sampling rate into our full speed format (fs/1000 in Q16.16)
+ * this will overflow at approx 524 kHz
+ */
+static inline unsigned get_usb_full_speed_rate(unsigned rate)
+{
+	return ((rate << 13) + 62) / 125;
+}
+
+/*
+ * convert a sampling rate into USB high speed format (fs/8000 in Q16.16)
+ * this will overflow at approx 4 MHz
+ */
+static inline unsigned get_usb_high_speed_rate(unsigned rate)
+{
+	return ((rate << 10) + 62) / 125;
+}
+
+void usb_stream_free(struct usb_stream_kernel *sk)
+{
+	struct usb_stream *s;
+	unsigned u;
+
+	for (u = 0; u < USB_STREAM_NURBS; ++u) {
+		usb_free_urb(sk->inurb[u]);
+		sk->inurb[u] = NULL;
+		usb_free_urb(sk->outurb[u]);
+		sk->outurb[u] = NULL;
+	}
+
+	s = sk->s;
+	if (!s)
+		return;
+
+	free_pages((unsigned long)sk->write_page, get_order(s->write_size));
+	sk->write_page = NULL;
+	free_pages((unsigned long)s, get_order(s->read_size));
+	sk->s = NULL;
+}
+
+struct usb_stream *usb_stream_new(struct usb_stream_kernel *sk,
+				  struct usb_device *dev,
+				  unsigned in_endpoint, unsigned out_endpoint,
+				  unsigned sample_rate, unsigned use_packsize,
+				  unsigned period_frames, unsigned frame_size)
+{
+	int packets, max_packsize;
+	int in_pipe, out_pipe;
+	int read_size = sizeof(struct usb_stream);
+	int write_size;
+	int usb_frames = dev->speed == USB_SPEED_HIGH ? 8000 : 1000;
+	int pg;
+
+	in_pipe = usb_rcvisocpipe(dev, in_endpoint);
+	out_pipe = usb_sndisocpipe(dev, out_endpoint);
+
+	max_packsize = use_packsize ?
+		use_packsize : usb_maxpacket(dev, in_pipe, 0);
+
+	/*
+		t_period = period_frames / sample_rate
+		iso_packs = t_period / t_iso_frame
+			= (period_frames / sample_rate) * (1 / t_iso_frame)
+	*/
+
+	packets = period_frames * usb_frames / sample_rate + 1;
+
+	if (dev->speed == USB_SPEED_HIGH)
+		packets = (packets + 7) & ~7;
+
+	read_size += packets * USB_STREAM_URBDEPTH *
+		(max_packsize + sizeof(struct usb_stream_packet));
+
+	max_packsize = usb_maxpacket(dev, out_pipe, 1);
+	write_size = max_packsize * packets * USB_STREAM_URBDEPTH;
+
+	if (read_size >= 256*PAGE_SIZE || write_size >= 256*PAGE_SIZE) {
+		snd_printk(KERN_WARNING "a size exceeds 128*PAGE_SIZE\n");
+		goto out;
+	}
+
+	pg = get_order(read_size);
+	sk->s = (void *) __get_free_pages(GFP_KERNEL|__GFP_COMP|__GFP_ZERO, pg);
+	if (!sk->s) {
+		snd_printk(KERN_WARNING "couldn't __get_free_pages()\n");
+		goto out;
+	}
+	sk->s->cfg.version = USB_STREAM_INTERFACE_VERSION;
+
+	sk->s->read_size = read_size;
+
+	sk->s->cfg.sample_rate = sample_rate;
+	sk->s->cfg.frame_size = frame_size;
+	sk->n_o_ps = packets;
+	sk->s->inpackets = packets * USB_STREAM_URBDEPTH;
+	sk->s->cfg.period_frames = period_frames;
+	sk->s->period_size = frame_size * period_frames;
+
+	sk->s->write_size = write_size;
+	pg = get_order(write_size);
+
+	sk->write_page =
+		(void *)__get_free_pages(GFP_KERNEL|__GFP_COMP|__GFP_ZERO, pg);
+	if (!sk->write_page) {
+		snd_printk(KERN_WARNING "couldn't __get_free_pages()\n");
+		usb_stream_free(sk);
+		return NULL;
+	}
+
+	/* calculate the frequency in 16.16 format */
+	if (dev->speed == USB_SPEED_FULL)
+		sk->freqn = get_usb_full_speed_rate(sample_rate);
+	else
+		sk->freqn = get_usb_high_speed_rate(sample_rate);
+
+	init_urbs(sk, use_packsize, dev, in_pipe, out_pipe);
+	sk->s->state = usb_stream_stopped;
+out:
+	return sk->s;
+}
+
+
+/*                             start                                  */
+
+static bool balance_check(struct usb_stream_kernel *sk, struct urb *urb)
+{
+	bool r;
+	if (unlikely(urb->status)) {
+		if (urb->status != -ESHUTDOWN && urb->status != -ENOENT)
+			snd_printk(KERN_WARNING "status=%i\n", urb->status);
+		sk->iso_frame_balance = 0x7FFFFFFF;
+		return false;
+	}
+	r = sk->iso_frame_balance == 0;
+	if (!r)
+		sk->i_urb = urb;
+	return r;
+}
+
+static bool balance_playback(struct usb_stream_kernel *sk, struct urb *urb)
+{
+	sk->iso_frame_balance += urb->number_of_packets;
+	return balance_check(sk, urb);
+}
+
+static bool balance_capture(struct usb_stream_kernel *sk, struct urb *urb)
+{
+	sk->iso_frame_balance -= urb->number_of_packets;
+	return balance_check(sk, urb);
+}
+
+static void subs_set_complete(struct urb **urbs, void (*complete)(struct urb *))
+{
+	int u;
+
+	for (u = 0; u < USB_STREAM_NURBS; u++) {
+		struct urb *urb = urbs[u];
+		urb->complete = complete;
+	}
+}
+
+int usb_stream_prepare_playback(struct usb_stream_kernel *sk, struct urb *inurb)
+{
+	struct usb_stream *s = sk->s;
+	struct urb *io;
+	struct usb_iso_packet_descriptor *id, *od;
+	int p, l = 0;
+
+	io = sk->idle_outurb;
+	od = io->iso_frame_desc;
+	io->transfer_buffer_length = 0;
+
+	for (p = 0; s->sync_packet < 0; ++p, ++s->sync_packet) {
+		struct urb *ii = sk->completed_inurb;
+		id = ii->iso_frame_desc +
+			ii->number_of_packets + s->sync_packet;
+		l = id->actual_length;
+
+		od[p].length = l;
+		od[p].offset = io->transfer_buffer_length;
+		io->transfer_buffer_length += l;
+	}
+
+	for (;
+	     s->sync_packet < inurb->number_of_packets && p < sk->n_o_ps;
+	     ++p, ++s->sync_packet) {
+		l = inurb->iso_frame_desc[s->sync_packet].actual_length;
+
+		if (s->idle_outsize + io->transfer_buffer_length + l >
+		    s->period_size)
+			goto check_ok;
+
+		od[p].length = l;
+		od[p].offset = io->transfer_buffer_length;
+		io->transfer_buffer_length += l;
+	}
+
+check_ok:
+	s->sync_packet -= inurb->number_of_packets;
+	if (s->sync_packet < -2 || s->sync_packet > 0) {
+		snd_printk(KERN_WARNING "invalid sync_packet = %i;"
+			   " p=%i nop=%i %i %x %x %x > %x\n",
+			   s->sync_packet, p, inurb->number_of_packets,
+			   s->idle_outsize + io->transfer_buffer_length + l,
+			   s->idle_outsize, io->transfer_buffer_length,  l,
+			   s->period_size);
+		return -1;
+	}
+	if (io->transfer_buffer_length % s->cfg.frame_size) {
+		snd_printk(KERN_WARNING"invalid outsize = %i\n",
+			   io->transfer_buffer_length);
+		return -1;
+	}
+	s->idle_outsize += io->transfer_buffer_length - s->period_size;
+	io->number_of_packets = p;
+	if (s->idle_outsize > 0) {
+		snd_printk(KERN_WARNING "idle=%i\n", s->idle_outsize);
+		return -1;
+	}
+	return 0;
+}
+
+static void prepare_inurb(int number_of_packets, struct urb *iu)
+{
+	struct usb_iso_packet_descriptor *id;
+	int p;
+
+	iu->number_of_packets = number_of_packets;
+	id = iu->iso_frame_desc;
+	id->offset = 0;
+	for (p = 0; p < iu->number_of_packets - 1; ++p)
+		id[p + 1].offset = id[p].offset + id[p].length;
+
+	iu->transfer_buffer_length =
+		id[0].length * iu->number_of_packets;
+}
+
+static int submit_urbs(struct usb_stream_kernel *sk,
+		       struct urb *inurb, struct urb *outurb)
+{
+	int err;
+	prepare_inurb(sk->idle_outurb->number_of_packets, sk->idle_inurb);
+	err = usb_submit_urb(sk->idle_inurb, GFP_ATOMIC);
+	if (err < 0) {
+		snd_printk(KERN_ERR "%i\n", err);
+		return err;
+	}
+	sk->idle_inurb = sk->completed_inurb;
+	sk->completed_inurb = inurb;
+	err = usb_submit_urb(sk->idle_outurb, GFP_ATOMIC);
+	if (err < 0) {
+		snd_printk(KERN_ERR "%i\n", err);
+		return err;
+	}
+	sk->idle_outurb = sk->completed_outurb;
+	sk->completed_outurb = outurb;
+	return 0;
+}
+
+static void stream_idle(struct usb_stream_kernel *sk,
+			struct urb *inurb, struct urb *outurb)
+{
+	struct usb_stream *s = sk->s;
+	int l, p;
+	int insize = s->idle_insize;
+	int urb_size = 0;
+
+	s->inpacket_split = s->next_inpacket_split;
+	s->inpacket_split_at = s->next_inpacket_split_at;
+	s->next_inpacket_split = -1;
+	s->next_inpacket_split_at = 0;
+
+	for (p = 0; p < inurb->number_of_packets; ++p) {
+		struct usb_iso_packet_descriptor *id = inurb->iso_frame_desc;
+		l = id[p].actual_length;
+		if (unlikely(l == 0 || id[p].status)) {
+			snd_printk(KERN_WARNING "underrun, status=%u\n",
+				   id[p].status);
+			goto err_out;
+		}
+		s->inpacket_head++;
+		s->inpacket_head %= s->inpackets;
+		if (s->inpacket_split == -1)
+			s->inpacket_split = s->inpacket_head;
+
+		s->inpacket[s->inpacket_head].offset =
+			id[p].offset + (inurb->transfer_buffer - (void *)s);
+		s->inpacket[s->inpacket_head].length = l;
+		if (insize + l > s->period_size &&
+		    s->next_inpacket_split == -1) {
+			s->next_inpacket_split = s->inpacket_head;
+			s->next_inpacket_split_at = s->period_size - insize;
+		}
+		insize += l;
+		urb_size += l;
+	}
+	s->idle_insize += urb_size - s->period_size;
+	if (s->idle_insize < 0) {
+		snd_printk(KERN_WARNING "%i\n",
+			   (s->idle_insize)/(int)s->cfg.frame_size);
+		goto err_out;
+	}
+	s->insize_done += urb_size;
+
+	l = s->idle_outsize;
+	s->outpacket[0].offset = (sk->idle_outurb->transfer_buffer -
+				  sk->write_page) - l;
+
+	if (usb_stream_prepare_playback(sk, inurb) < 0)
+		goto err_out;
+
+	s->outpacket[0].length = sk->idle_outurb->transfer_buffer_length + l;
+	s->outpacket[1].offset = sk->completed_outurb->transfer_buffer -
+		sk->write_page;
+
+	if (submit_urbs(sk, inurb, outurb) < 0)
+		goto err_out;
+
+	s->periods_done++;
+	wake_up_all(&sk->sleep);
+	return;
+err_out:
+	s->state = usb_stream_xrun;
+	wake_up_all(&sk->sleep);
+}
+
+static void i_capture_idle(struct urb *urb)
+{
+	struct usb_stream_kernel *sk = urb->context;
+	if (balance_capture(sk, urb))
+		stream_idle(sk, urb, sk->i_urb);
+}
+
+static void i_playback_idle(struct urb *urb)
+{
+	struct usb_stream_kernel *sk = urb->context;
+	if (balance_playback(sk, urb))
+		stream_idle(sk, sk->i_urb, urb);
+}
+
+static void stream_start(struct usb_stream_kernel *sk,
+			 struct urb *inurb, struct urb *outurb)
+{
+	struct usb_stream *s = sk->s;
+	if (s->state >= usb_stream_sync1) {
+		int l, p, max_diff, max_diff_0;
+		int urb_size = 0;
+		unsigned frames_per_packet, min_frames = 0;
+		frames_per_packet = (s->period_size - s->idle_insize);
+		frames_per_packet <<= 8;
+		frames_per_packet /=
+			s->cfg.frame_size * inurb->number_of_packets;
+		frames_per_packet++;
+
+		max_diff_0 = s->cfg.frame_size;
+		if (s->cfg.period_frames >= 256)
+			max_diff_0 <<= 1;
+		if (s->cfg.period_frames >= 1024)
+			max_diff_0 <<= 1;
+		max_diff = max_diff_0;
+		for (p = 0; p < inurb->number_of_packets; ++p) {
+			int diff;
+			l = inurb->iso_frame_desc[p].actual_length;
+			urb_size += l;
+
+			min_frames += frames_per_packet;
+			diff = urb_size -
+				(min_frames >> 8) * s->cfg.frame_size;
+			if (diff < max_diff) {
+				snd_printdd(KERN_DEBUG "%i %i %i %i\n",
+					    s->insize_done,
+					    urb_size / (int)s->cfg.frame_size,
+					    inurb->number_of_packets, diff);
+				max_diff = diff;
+			}
+		}
+		s->idle_insize -= max_diff - max_diff_0;
+		s->idle_insize += urb_size - s->period_size;
+		if (s->idle_insize < 0) {
+			snd_printk("%i %i %i\n",
+				   s->idle_insize, urb_size, s->period_size);
+			return;
+		} else if (s->idle_insize == 0) {
+			s->next_inpacket_split =
+				(s->inpacket_head + 1) % s->inpackets;
+			s->next_inpacket_split_at = 0;
+		} else {
+			unsigned split = s->inpacket_head;
+			l = s->idle_insize;
+			while (l > s->inpacket[split].length) {
+				l -= s->inpacket[split].length;
+				if (split == 0)
+					split = s->inpackets - 1;
+				else
+					split--;
+			}
+			s->next_inpacket_split = split;
+			s->next_inpacket_split_at =
+				s->inpacket[split].length - l;
+		}
+
+		s->insize_done += urb_size;
+
+		if (usb_stream_prepare_playback(sk, inurb) < 0)
+			return;
+
+	} else
+		playback_prep_freqn(sk, sk->idle_outurb);
+
+	if (submit_urbs(sk, inurb, outurb) < 0)
+		return;
+
+	if (s->state == usb_stream_sync1 && s->insize_done > 360000) {
+		/* just guesswork                            ^^^^^^ */
+		s->state = usb_stream_ready;
+		subs_set_complete(sk->inurb, i_capture_idle);
+		subs_set_complete(sk->outurb, i_playback_idle);
+	}
+}
+
+static void i_capture_start(struct urb *urb)
+{
+	struct usb_iso_packet_descriptor *id = urb->iso_frame_desc;
+	struct usb_stream_kernel *sk = urb->context;
+	struct usb_stream *s = sk->s;
+	int p;
+	int empty = 0;
+
+	if (urb->status) {
+		snd_printk(KERN_WARNING "status=%i\n", urb->status);
+		return;
+	}
+
+	for (p = 0; p < urb->number_of_packets; ++p) {
+		int l = id[p].actual_length;
+		if (l < s->cfg.frame_size) {
+			++empty;
+			if (s->state >= usb_stream_sync0) {
+				snd_printk(KERN_WARNING "%i\n", l);
+				return;
+			}
+		}
+		s->inpacket_head++;
+		s->inpacket_head %= s->inpackets;
+		s->inpacket[s->inpacket_head].offset =
+			id[p].offset + (urb->transfer_buffer - (void *)s);
+		s->inpacket[s->inpacket_head].length = l;
+	}
+#ifdef SHOW_EMPTY
+	if (empty) {
+		printk(KERN_DEBUG"%s:%i: %i", __func__, __LINE__,
+		       urb->iso_frame_desc[0].actual_length);
+		for (pack = 1; pack < urb->number_of_packets; ++pack) {
+			int l = urb->iso_frame_desc[pack].actual_length;
+			printk(" %i", l);
+		}
+		printk("\n");
+	}
+#endif
+	if (!empty && s->state < usb_stream_sync1)
+		++s->state;
+
+	if (balance_capture(sk, urb))
+		stream_start(sk, urb, sk->i_urb);
+}
+
+static void i_playback_start(struct urb *urb)
+{
+	struct usb_stream_kernel *sk = urb->context;
+	if (balance_playback(sk, urb))
+		stream_start(sk, sk->i_urb, urb);
+}
+
+int usb_stream_start(struct usb_stream_kernel *sk)
+{
+	struct usb_stream *s = sk->s;
+	int frame = 0, iters = 0;
+	int u, err;
+	int try = 0;
+
+	if (s->state != usb_stream_stopped)
+		return -EAGAIN;
+
+	subs_set_complete(sk->inurb, i_capture_start);
+	subs_set_complete(sk->outurb, i_playback_start);
+	memset(sk->write_page, 0, s->write_size);
+dotry:
+	s->insize_done = 0;
+	s->idle_insize = 0;
+	s->idle_outsize = 0;
+	s->sync_packet = -1;
+	s->inpacket_head = -1;
+	sk->iso_frame_balance = 0;
+	++try;
+	for (u = 0; u < 2; u++) {
+		struct urb *inurb = sk->inurb[u];
+		struct urb *outurb = sk->outurb[u];
+		playback_prep_freqn(sk, outurb);
+		inurb->number_of_packets = outurb->number_of_packets;
+		inurb->transfer_buffer_length =
+			inurb->number_of_packets *
+			inurb->iso_frame_desc[0].length;
+		preempt_disable();
+		if (u == 0) {
+			int now;
+			struct usb_device *dev = inurb->dev;
+			frame = usb_get_current_frame_number(dev);
+			do {
+				now = usb_get_current_frame_number(dev);
+				++iters;
+			} while (now > -1 && now == frame);
+		}
+		err = usb_submit_urb(inurb, GFP_ATOMIC);
+		if (err < 0) {
+			preempt_enable();
+			snd_printk(KERN_ERR"usb_submit_urb(sk->inurb[%i])"
+				   " returned %i\n", u, err);
+			return err;
+		}
+		err = usb_submit_urb(outurb, GFP_ATOMIC);
+		if (err < 0) {
+			preempt_enable();
+			snd_printk(KERN_ERR"usb_submit_urb(sk->outurb[%i])"
+				   " returned %i\n", u, err);
+			return err;
+		}
+		preempt_enable();
+		if (inurb->start_frame != outurb->start_frame) {
+			snd_printd(KERN_DEBUG
+				   "u[%i] start_frames differ in:%u out:%u\n",
+				   u, inurb->start_frame, outurb->start_frame);
+			goto check_retry;
+		}
+	}
+	snd_printdd(KERN_DEBUG "%i %i\n", frame, iters);
+	try = 0;
+check_retry:
+	if (try) {
+		usb_stream_stop(sk);
+		if (try < 5) {
+			msleep(1500);
+			snd_printd(KERN_DEBUG "goto dotry;\n");
+			goto dotry;
+		}
+		snd_printk(KERN_WARNING"couldn't start"
+			   " all urbs on the same start_frame.\n");
+		return -EFAULT;
+	}
+
+	sk->idle_inurb = sk->inurb[USB_STREAM_NURBS - 2];
+	sk->idle_outurb = sk->outurb[USB_STREAM_NURBS - 2];
+	sk->completed_inurb = sk->inurb[USB_STREAM_NURBS - 1];
+	sk->completed_outurb = sk->outurb[USB_STREAM_NURBS - 1];
+
+/* wait, check */
+	{
+		int wait_ms = 3000;
+		while (s->state != usb_stream_ready && wait_ms > 0) {
+			snd_printdd(KERN_DEBUG "%i\n", s->state);
+			msleep(200);
+			wait_ms -= 200;
+		}
+	}
+
+	return s->state == usb_stream_ready ? 0 : -EFAULT;
+}
+
+
+/*                             stop                                   */
+
+void usb_stream_stop(struct usb_stream_kernel *sk)
+{
+	int u;
+	if (!sk->s)
+		return;
+	for (u = 0; u < USB_STREAM_NURBS; ++u) {
+		usb_kill_urb(sk->inurb[u]);
+		usb_kill_urb(sk->outurb[u]);
+	}
+	sk->s->state = usb_stream_stopped;
+	msleep(400);
+}
diff --git a/sound/usb/usx2y/usb_stream.h b/sound/usb/usx2y/usb_stream.h
new file mode 100644
index 0000000..4dd74ab
--- /dev/null
+++ b/sound/usb/usx2y/usb_stream.h
@@ -0,0 +1,112 @@
+/*
+ * Copyright (C) 2007, 2008 Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define USB_STREAM_INTERFACE_VERSION 2
+
+#define SNDRV_USB_STREAM_IOCTL_SET_PARAMS \
+	_IOW('H', 0x90, struct usb_stream_config)
+
+struct usb_stream_packet {
+	unsigned offset;
+	unsigned length;
+};
+
+
+struct usb_stream_config {
+	unsigned version;
+	unsigned sample_rate;
+	unsigned period_frames;
+	unsigned frame_size;
+};
+
+struct usb_stream {
+	struct usb_stream_config cfg;
+	unsigned read_size;
+	unsigned write_size;
+
+	int period_size;
+
+	unsigned state;
+
+	int idle_insize;
+	int idle_outsize;
+	int sync_packet;
+	unsigned insize_done;
+	unsigned periods_done;
+	unsigned periods_polled;
+
+	struct usb_stream_packet outpacket[2];
+	unsigned		 inpackets;
+	unsigned		 inpacket_head;
+	unsigned		 inpacket_split;
+	unsigned		 inpacket_split_at;
+	unsigned		 next_inpacket_split;
+	unsigned		 next_inpacket_split_at;
+	struct usb_stream_packet inpacket[0];
+};
+
+enum usb_stream_state {
+	usb_stream_invalid,
+	usb_stream_stopped,
+	usb_stream_sync0,
+	usb_stream_sync1,
+	usb_stream_ready,
+	usb_stream_running,
+	usb_stream_xrun,
+};
+
+#if __KERNEL__
+
+#define USB_STREAM_NURBS 4
+#define USB_STREAM_URBDEPTH 4
+
+struct usb_stream_kernel {
+	struct usb_stream *s;
+
+	void *write_page;
+
+	unsigned n_o_ps;
+
+	struct urb *inurb[USB_STREAM_NURBS];
+	struct urb *idle_inurb;
+	struct urb *completed_inurb;
+	struct urb *outurb[USB_STREAM_NURBS];
+	struct urb *idle_outurb;
+	struct urb *completed_outurb;
+	struct urb *i_urb;
+
+	int iso_frame_balance;
+
+	wait_queue_head_t sleep;
+
+	unsigned out_phase;
+	unsigned out_phase_peeked;
+	unsigned freqn;
+};
+
+struct usb_stream *usb_stream_new(struct usb_stream_kernel *sk,
+				  struct usb_device *dev,
+				  unsigned in_endpoint, unsigned out_endpoint,
+				  unsigned sample_rate, unsigned use_packsize,
+				  unsigned period_frames, unsigned frame_size);
+void usb_stream_free(struct usb_stream_kernel *);
+int usb_stream_start(struct usb_stream_kernel *);
+void usb_stream_stop(struct usb_stream_kernel *);
+
+
+#endif
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 3eaf155..ca2f358 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -93,9 +93,10 @@ enum {
 	SNDRV_HWDEP_IFACE_PCXHR,	/* Digigram PCXHR */
 	SNDRV_HWDEP_IFACE_SB_RC,	/* SB Extigy/Audigy2NX remote control */
 	SNDRV_HWDEP_IFACE_HDA,		/* HD-audio */
+	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_HDA
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_USB_STREAM
 };
 
 struct snd_hwdep_info {
