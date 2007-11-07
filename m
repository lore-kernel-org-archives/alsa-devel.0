From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] US-122L Driver, v0
Date: Wed, 7 Nov 2007 19:55:16 +0100
Message-ID: <200711071955.16686.fzu@wemgehoertderstaat.de>
References: <200711071641.28551.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UogMHV4Kv6zvBsQ"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	by alsa0.perex.cz (Postfix) with ESMTP id B6260245CB
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 19:55:19 +0100 (CET)
Received: from [195.4.92.20] (helo=10.mx.freenet.de)
	by mout0.freenet.de with esmtpa (Exim 4.68)
	(envelope-from <fzu@wemgehoertderstaat.de>) id 1Ipq3b-0006H7-5O
	for alsa-devel@alsa-project.org; Wed, 07 Nov 2007 19:55:19 +0100
Received: from p5b10b088.dip0.t-ipconnect.de ([91.16.176.136]:33212
	helo=[10.130.108.11])
	by 10.mx.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port
	25) (Exim 4.68 #1) id 1Ipq3Z-0007T6-UK
	for alsa-devel@alsa-project.org; Wed, 07 Nov 2007 19:55:19 +0100
In-Reply-To: <200711071641.28551.fzu@wemgehoertderstaat.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_UogMHV4Kv6zvBsQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

attached patches implement a simple driver for the tascam us-122l.
Everything except midi out works i think ;-)

For USB 2.0 you also have to aply
	http://marc.info/?l=linux-usb-devel&m=119444869917392&w=2
named "ehci-hcd: complete iso urbs ASAP ..."

Will post a jack driver to use it soon.
so far you can #define DEBUG_USB_STREAM in usb_stream.c to 
playback what is captured.

no alsa pcm interface there yet. only a hwdep to talk to the
"usb stream" thing.

A userspace plugin that works like the jack driver would be fine too.
Is that easy to do? I mean that userspace driver should export all 
those standard alsa pcm interfaces then.

Comments bug/success reports, patches welcome.

      Karsten

--Boundary-00=_UogMHV4Kv6zvBsQ
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-Driver-for-the-US-122L-usb-soundcard.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Driver-for-the-US-122L-usb-soundcard.patch"

=46rom 0a9a1787bad19a5f542a11f4f087e83951cd2d00 Mon Sep 17 00:00:00 2001
=46rom: Karsten Wiese <fzu@wemgehoertderstaat.de>
Date: Wed, 7 Nov 2007 19:36:14 +0100
Subject: [PATCH 1/1] Driver for the US-122L usb soundcard
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

uses the "usb stream" facility for pcm. The "usb stream" is made mmap()able
by means of a hwdep device.
A patch to read/write audio from userspace will follow as a jackd driver.

=46or midi in snd-usb-lib is used. Patch for the needed quirk follows.
Midi out doesn't work yet.

Works only with USB1.1 host so far. For ehci a patch is needed so
"Usb stream" doesn't have to cut the urbs on 8 =C2=B5frame boundaries.
That patch has been posted to usb-devel & alsa-devel as
"ehci-hcd: complete iso urbs ASAP for number_of_packets !=3D (n * 8) also"

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
=2D--
 include/sound/asound.h   |    3 +-
 sound/usb/Kconfig        |   11 +
 sound/usb/usbaudio.h     |    2 +-
 sound/usb/usx2y/Makefile |    2 +
 sound/usb/usx2y/us122l.c |  512 ++++++++++++++++++++++++++++++++++++++++++=
++++
 sound/usb/usx2y/us122l.h |   21 ++
 6 files changed, 549 insertions(+), 2 deletions(-)
 create mode 100644 sound/usb/usx2y/us122l.c
 create mode 100644 sound/usb/usx2y/us122l.h

diff --git a/include/sound/asound.h b/include/sound/asound.h
index c1621c6..f163f66 100644
=2D-- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -92,9 +92,10 @@ enum {
 	SNDRV_HWDEP_IFACE_USX2Y_PCM,	/* Tascam US122, US224 & US428 rawusb pcm */
 	SNDRV_HWDEP_IFACE_PCXHR,	/* Digigram PCXHR */
 	SNDRV_HWDEP_IFACE_SB_RC,	/* SB Extigy/Audigy2NX remote control */
+	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
=20
 	/* Don't forget to change the following: */
=2D	SNDRV_HWDEP_IFACE_LAST =3D SNDRV_HWDEP_IFACE_SB_RC
+	SNDRV_HWDEP_IFACE_LAST =3D SNDRV_HWDEP_IFACE_USB_STREAM
 };
=20
 struct snd_hwdep_info {
diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 315360f..3da2fb4 100644
=2D-- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -57,5 +57,16 @@ config SND_USB_CAIAQ_INPUT
 	   * Native Instruments RigKontrol2
 	   * Native Instruments Audio Kontrol 1
=20
+config SND_USB_US122L
+	tristate "Tascam US-122L USB driver"
+	depends on SND && USB && (X86 || PPC || ALPHA)
+	select SND_RAWMIDI
+	help
+	  Say Y here to include support for Tascam USB Audio/MIDI
+	  interfaces or controllers US-122L.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-usb-us122l.
+
 endmenu
=20
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 2272f45..23b13f4 100644
=2D-- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -160,7 +160,7 @@ enum quirk_type {
 	QUIRK_AUDIO_EDIROL_UA700_UA25,
 	QUIRK_AUDIO_EDIROL_UA1000,
 	QUIRK_AUDIO_EDIROL_UA101,
=2D
+	QUIRK_MIDI_US122L,
 	QUIRK_TYPE_COUNT
 };
=20
diff --git a/sound/usb/usx2y/Makefile b/sound/usb/usx2y/Makefile
index 9ac22bc..4b537ff 100644
=2D-- a/sound/usb/usx2y/Makefile
+++ b/sound/usb/usx2y/Makefile
@@ -1,3 +1,5 @@
 snd-usb-usx2y-objs :=3D usbusx2y.o usX2Yhwdep.o usx2yhwdeppcm.o
+snd-usb-us122l-objs :=3D us122l.o usb_stream.o
=20
 obj-$(CONFIG_SND_USB_USX2Y) +=3D snd-usb-usx2y.o
+obj-$(CONFIG_SND_USB_US122L) +=3D snd-usb-us122l.o
\ No newline at end of file
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
new file mode 100644
index 0000000..ac9a46d
=2D-- /dev/null
+++ b/sound/usb/usx2y/us122l.c
@@ -0,0 +1,512 @@
+/*
+ * Copyright (c) 2007 by Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/hwdep.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <linux/usb.h>
+#include "usb_stream.h"
+#include "../usbaudio.h"
+#include "us122l.h"
+
+MODULE_AUTHOR("Karsten Wiese <fzu@wemgehoertderstaat.de>");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.1");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX; /* Index 0-max */
+static char* id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR; /* Id for this card */
+static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP; /* Enable thi=
s card */
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
+	static struct snd_usb_midi_endpoint_info quirk_data =3D {
+		.out_ep =3D 4,
+		.in_ep =3D 3,
+		.out_cables =3D	0x001,
+		.in_cables =3D	0x001
+	};
+	static struct snd_usb_audio_quirk quirk =3D {
+		.vendor_name =3D	"US122L",
+		.product_name =3D	NAME_ALLCAPS,
+		.ifnum =3D 	1,
+       		.type =3D QUIRK_MIDI_US122L,
+		.data =3D &quirk_data
+	};
+	struct usb_device *dev =3D US122L(card)->chip.dev;
+	struct usb_interface *iface =3D usb_ifnum_to_if(dev, 1);
+
+	return snd_usb_create_midi_interface(&US122L(card)->chip, iface, &quirk);
+}
+
+/*
+ * Wrapper for usb_control_msg().
+ * Allocates a temp buffer to prevent dmaing from/to the stack.
+ */
+static int us122l_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 =
request,
+		    __u8 requesttype, __u16 value, __u16 index, void *data,
+		    __u16 size, int timeout)
+{
+	int err;
+	void *buf =3D NULL;
+
+	if (size > 0) {
+		buf =3D kmemdup(data, size, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+	}
+	err =3D usb_control_msg(dev, pipe, request, requesttype,
+			      value, index, buf, size, timeout);
+	if (size > 0) {
+		memcpy(data, buf, size);
+		kfree(buf);
+	}
+	return err;
+}
+
+static int us122l_set_sample_rate(struct usb_device *dev, int rate)
+{
+	unsigned int ep =3D 0x81;
+	unsigned char data[3];
+	int err;
+
+		data[0] =3D rate;
+		data[1] =3D rate >> 8;
+		data[2] =3D rate >> 16;
+		if ((err =3D us122l_ctl_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR,
+					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
+					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
+			snd_printk(KERN_ERR "%d: cannot set freq %d to ep 0x%x\n",
+				   dev->devnum, rate, ep);
+			return err;
+		}
+
+	return 0;
+}
+
+
+static struct page * usb_stream_hwdep_vm_nopage(struct vm_area_struct *are=
a, unsigned long address, int *type)
+{
+	unsigned long offset;
+	struct page *page;
+	void *vaddr;
+	struct us122l *us122l =3D area->vm_private_data;
+
+	offset =3D area->vm_pgoff << PAGE_SHIFT;
+	offset +=3D address - area->vm_start;
+	snd_assert((offset % PAGE_SIZE) =3D=3D 0, return NOPAGE_OOM);
+	if (offset < PAGE_ALIGN(us122l->usb_stream->read_size)) {
+		vaddr =3D (char *)us122l->usb_stream + offset;
+		printk(KERN_WARNING"%s:%i 0x%lx\n", __FUNCTION__, __LINE__, offset);
+	} else {
+		vaddr =3D (char *)us122l->usb_stream->write_page +
+			offset - PAGE_ALIGN(us122l->usb_stream->read_size);
+		printk(KERN_WARNING"%s:%i 0x%lx\n", __FUNCTION__, __LINE__,
+		       offset - PAGE_ALIGN(us122l->usb_stream->read_size));
+	}
+
+	page =3D virt_to_page(vaddr);
+	get_page(page);
+
+	if (type)
+		*type =3D VM_FAULT_MINOR;
+
+	return page;
+}
+
+
+static struct vm_operations_struct usb_stream_hwdep_vm_ops =3D {
+	.nopage =3D usb_stream_hwdep_vm_nopage,
+};
+
+
+static int usb_stream_hwdep_open(struct snd_hwdep *hw, struct file *file)
+{
+	printk(KERN_DEBUG"%s:%i\n", __FUNCTION__, __LINE__);
+	return 0;
+}
+
+static int usb_stream_hwdep_mmap(struct snd_hwdep *hw, struct file *filp, =
struct vm_area_struct *area)
+{
+	unsigned long	size =3D area->vm_end - area->vm_start;
+	struct us122l	*us122l =3D hw->private_data;
+	unsigned long offset;
+	struct usb_stream *s =3D us122l->usb_stream;
+	bool read;
+
+	offset =3D area->vm_pgoff << PAGE_SHIFT;
+	read =3D offset < s->read_size;
+	if (read && area->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	printk(KERN_WARNING"%s %lu %u\n", __FUNCTION__, size, read ? s->read_size=
 : s->write_size);=20
+	/* if userspace tries to mmap beyond end of our buffer, fail */=20
+	if (size > PAGE_ALIGN(read ? s->read_size : s->write_size)) {
+		printk(KERN_WARNING"%lu > %u\n", size, read ? s->read_size : s->write_si=
ze);=20
+		return -EINVAL;
+	}
+
+
+	area->vm_ops =3D &usb_stream_hwdep_vm_ops;
+	area->vm_flags |=3D VM_RESERVED;
+	area->vm_private_data =3D us122l;
+	return 0;
+}
+
+static unsigned int usb_stream_hwdep_poll(struct snd_hwdep *hw, struct fil=
e *file, poll_table *wait)
+{
+	struct us122l	*us122l =3D hw->private_data;
+	struct usb_stream *s =3D us122l->usb_stream;
+	unsigned int mask;
+
+	poll_wait(file, &s->sleep, wait);
+
+	switch (s->state) {
+	case usb_stream_ready:
+		if (s->periods_polled !=3D s->periods_done) {
+			s->periods_polled =3D s->periods_done;
+			mask =3D POLLIN | POLLOUT | POLLWRNORM;
+			break;
+		}
+		/* Fall through */
+		mask =3D 0;
+		break;
+	default:
+		mask =3D POLLIN | POLLOUT | POLLWRNORM | POLLERR;
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
+	usb_stream_stop(us122l->usb_stream);
+	usb_stream_free(us122l->usb_stream);
+	us122l->usb_stream =3D NULL;
+}
+static bool us122l_start(struct us122l *us122l, unsigned rate, unsigned pe=
riod_frames)
+{
+	struct list_head *p;
+	int err;
+	us122l->usb_stream =3D usb_stream_new(us122l->chip.dev,
+					    1, 2, rate, period_frames, 6);
+	if (!us122l->usb_stream)
+		return false;
+	printk(KERN_DEBUG"%s:%i\n", __FUNCTION__, __LINE__);
+	msleep(130);
+	msleep(30);
+	printk(KERN_DEBUG"%s:%i\n", __FUNCTION__, __LINE__);
+	err =3D us122l_set_sample_rate(us122l->chip.dev, rate);
+	printk(KERN_DEBUG"%s:%i\n", __FUNCTION__, __LINE__);
+
+	if (err) {
+		snd_printk(KERN_ERR "us144_set_sample_rate error \n");
+		return false;
+	}
+	if ((err =3D usb_stream_start(us122l->usb_stream)) < 0) {
+		us122l_stop(us122l);
+		snd_printk(KERN_ERR "us122l_start error %i \n", err);
+		return false;
+	}
+
+	list_for_each(p, &us122l->chip.midi_list)
+		snd_usbmidi_input_start(p);
+
+	return true;
+}
+
+static long usb_stream_hwdep_write(struct snd_hwdep *hw, const char __user=
 *buf,
+				   long count, loff_t *offset)
+{
+	struct usb_stream_config cfg;
+	struct us122l *us122l;
+
+	if (count !=3D sizeof(cfg))
+		return -EFAULT;
+
+	if (copy_from_user(&cfg, buf, sizeof(cfg)))
+		return -EFAULT;
+
+	if (cfg.version !=3D USB_STREAM_INTERFACE_VERSION ||
+	    (cfg.sample_rate !=3D 44100 && cfg.sample_rate !=3D 48000) ||
+	    cfg.frame_size !=3D 6 ||
+	    cfg.period_frames < 64 || cfg.period_frames > 1024)
+		return -EFAULT;
+
+	us122l =3D hw->private_data;
+
+	us122l_stop(us122l);
+	msleep(530);
+	if (!us122l_start(us122l, cfg.sample_rate, cfg.period_frames))
+		return -EFAULT;
+
+	return count;
+}
+
+#define SND_USB_STREAM_ID "USB STREAM"
+static int usb_stream_hwdep_new(struct snd_card *card)
+{
+	int err;
+	struct snd_hwdep *hw;
+	struct usb_device *dev =3D US122L(card)->chip.dev;
+
+	if ((err =3D snd_hwdep_new(card, SND_USB_STREAM_ID, 0, &hw)) < 0)
+		return err;
+
+	hw->iface =3D SNDRV_HWDEP_IFACE_USB_STREAM;
+	hw->private_data =3D US122L(card);
+	hw->ops.open =3D usb_stream_hwdep_open;
+	hw->ops.write =3D usb_stream_hwdep_write;
+ 	hw->ops.mmap =3D usb_stream_hwdep_mmap;
+	hw->ops.poll =3D usb_stream_hwdep_poll;
+	hw->exclusive =3D 1;
+	sprintf(hw->name, "/proc/bus/usb/%03d/%03d/hwdeppcm", dev->bus->busnum, d=
ev->devnum);
+	return 0;
+}
+
+
+static bool us122l_create_card(struct snd_card *card)
+{
+	int err;
+	struct us122l *us122l =3D US122L(card);
+	printk(KERN_DEBUG"%s:%i\n", __FUNCTION__, __LINE__);
+
+	err =3D usb_set_interface(us122l->chip.dev, 1, 1);
+	if (err) {
+		snd_printk(KERN_ERR "usb_set_interface error \n");
+		return false;
+	}
+	if (!us122l_start(us122l, 44100, 256))
+		return false;
+
+	if ((err =3D us122l_create_usbmidi(card)) < 0) {
+		snd_printk(KERN_ERR "us122l_create_usbmidi error %i \n", err);
+		us122l_stop(us122l);
+		return false;
+	}
+
+	if ((err =3D usb_stream_hwdep_new(card)) < 0) {
+/* release the midi resources */
+		struct list_head *p;
+		list_for_each(p, &us122l->chip.midi_list)
+			snd_usbmidi_disconnect(p);
+
+		us122l_stop(us122l);
+		return false;
+	}
+	return true;
+}=20
+
+static struct snd_card *usx2y_create_card(struct usb_device *device)
+{
+	int		dev;
+	struct snd_card *	card;
+	for (dev =3D 0; dev < SNDRV_CARDS; ++dev)
+		if (enable[dev] && !snd_us122l_card_used[dev])
+			break;
+	if (dev >=3D SNDRV_CARDS)
+		return NULL;
+	card =3D snd_card_new(index[dev], id[dev], THIS_MODULE, sizeof(struct us1=
22l));
+	if (!card)
+		return NULL;
+	snd_us122l_card_used[US122L(card)->chip.index =3D dev] =3D 1;
+
+	US122L(card)->chip.dev =3D device;
+	US122L(card)->chip.card =3D card;
+	mutex_init(&US122L(card)->prepare_mutex);
+	INIT_LIST_HEAD(&US122L(card)->chip.midi_list);
+	strcpy(card->driver, "USB "NAME_ALLCAPS"");
+	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
+	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
+		card->shortname,=20
+		le16_to_cpu(device->descriptor.idVendor),
+		le16_to_cpu(device->descriptor.idProduct),
+		0,//us428(card)->usbmidi.ifnum,
+		US122L(card)->chip.dev->bus->busnum, US122L(card)->chip.dev->devnum
+		);
+	snd_card_set_dev(card, &device->dev);
+	return card;
+}
+
+static void *us122l_usb_probe(struct usb_interface *intf, const struct usb=
_device_id *device_id)
+{
+	struct snd_card *card;
+	struct usb_device *device =3D interface_to_usbdev(intf);
+	if (!(card =3D usx2y_create_card(device)))
+		return NULL;
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
+static int snd_us122l_probe(struct usb_interface *intf, const struct usb_d=
evice_id *id)
+{
+	struct snd_card *card;
+	printk(KERN_DEBUG"%s:%i:%p:%i\n", __FUNCTION__, __LINE__, intf, intf->cur=
_altsetting->desc.bInterfaceNumber);
+	if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 1)
+		return -EIO;
+
+	card =3D us122l_usb_probe(usb_get_intf(intf), id);
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
+	card =3D usb_get_intfdata(intf);
+	if (!card)
+		return;
+	usb_set_intfdata(intf, NULL);
+	printk(KERN_DEBUG"%s:%i\n", __FUNCTION__, __LINE__);
+=09
+	snd_card_disconnect(card);
+
+	us122l =3D US122L(card);
+	us122l_stop(us122l);
+	us122l->chip.shutdown =3D 1;
+=09
+/* release the midi resources */
+	list_for_each(p, &us122l->chip.midi_list) {
+		snd_usbmidi_disconnect(p);
+	}
+
+	usb_put_intf(intf);
+	usb_put_dev(US122L(card)->chip.dev);
+
+	snd_card_free(card);
+}
+
+static int snd_us122l_suspend(struct usb_interface *intf, pm_message_t mes=
sage)
+{
+	struct snd_card *card;
+	struct us122l *us122l;
+	struct list_head *p;
+
+	card =3D dev_get_drvdata(&intf->dev);
+	if (!card)
+		return 0;
+
+	us122l =3D US122L(card);
+	if (!us122l)
+		return 0;
+
+	list_for_each(p, &us122l->chip.midi_list)
+		snd_usbmidi_input_stop(p);
+
+	usb_stream_stop(us122l->usb_stream);
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
+	printk(KERN_DEBUG"%s:%i\n", __FUNCTION__, __LINE__);
+	card =3D dev_get_drvdata(&intf->dev);
+	if (!card)
+		return 0;
+
+	us122l =3D US122L(card);
+	if (!us122l)
+		return 0;
+
+	err =3D usb_set_interface(us122l->chip.dev, 1, 1);
+	if (err) {
+		snd_printk(KERN_ERR "usb_set_interface error \n");
+		return err;
+	}
+	if ((err =3D usb_stream_start(us122l->usb_stream)))
+	    return err;
+
+	list_for_each(p, &us122l->chip.midi_list)
+		snd_usbmidi_input_start(p);
+
+	return 0;
+}
+
+static struct usb_device_id snd_us122l_usb_id_table[] =3D {
+	{
+		.match_flags =3D	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =3D	0x0644,
+		.idProduct =3D	USB_ID_US122L
+	},
+/*  	{ */
+/* 		.match_flags =3D	USB_DEVICE_ID_MATCH_DEVICE, */
+/* 		.idVendor =3D	0x0644, */
+/* 		.idProduct =3D	USB_ID_US144 */
+/* 	}, */
+	{ /* terminator */ }
+};
+
+MODULE_DEVICE_TABLE(usb, snd_us122l_usb_id_table);
+static struct usb_driver snd_us122l_usb_driver =3D {
+	.name =3D		"snd-usb-us122l",
+	.probe =3D	snd_us122l_probe,
+	.disconnect =3D	snd_us122l_disconnect,
+	.suspend =3D	snd_us122l_suspend,
+	.resume =3D	snd_us122l_resume,
+	.reset_resume =3D	snd_us122l_resume,
+	.id_table =3D	snd_us122l_usb_id_table,
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
index 0000000..c046943
=2D-- /dev/null
+++ b/sound/usb/usx2y/us122l.h
@@ -0,0 +1,21 @@
+#ifndef US122L_H
+#define US122L_H
+
+
+struct us122l {
+	struct snd_usb_audio 	chip;
+	int			stride;
+	struct usb_stream	*usb_stream;
+
+	struct mutex		prepare_mutex;
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
=2D-=20
1.5.3.3


--Boundary-00=_UogMHV4Kv6zvBsQ
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-Midi-in-support-for-the-US-122L-usb-soundcard.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Midi-in-support-for-the-US-122L-usb-soundcard.patch"

=46rom 1a4fe60461598309dac69cbcb4300244c1ae3459 Mon Sep 17 00:00:00 2001
=46rom: Karsten Wiese <fzu@wemgehoertderstaat.de>
Date: Tue, 6 Nov 2007 21:37:12 +0100
Subject: [PATCH 1/1] Midi in support for the US-122L usb soundcard

The US-122L sends midi in data in 9 byte long packets.
Only the bytes up to before the first 0xFD are midi data.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
=2D--
 sound/usb/usbmidi.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
index 99295f9..8a8e97f 100644
=2D-- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -621,6 +621,18 @@ static void snd_usbmidi_raw_input(struct snd_usb_midi_=
in_endpoint* ep,
 	snd_usbmidi_input_data(ep, 0, buffer, buffer_length);
 }
=20
+static void snd_usbmidi_us122l_input(struct snd_usb_midi_in_endpoint* ep,
+				  uint8_t* buffer, int buffer_length)
+{
+	if (buffer_length !=3D 9)
+		return;
+	buffer_length =3D 8;
+	while (buffer_length && buffer[buffer_length - 1] =3D=3D 0xFD)
+		buffer_length--;
+	if (buffer_length)
+		snd_usbmidi_input_data(ep, 0, buffer, buffer_length);
+}
+
 static void snd_usbmidi_raw_output(struct snd_usb_midi_out_endpoint* ep)
 {
 	int count;
@@ -642,6 +654,11 @@ static struct usb_protocol_ops snd_usbmidi_raw_ops =3D=
 {
 	.output =3D snd_usbmidi_raw_output,
 };
=20
+static struct usb_protocol_ops snd_usbmidi_122l_ops =3D {
+	.input =3D snd_usbmidi_us122l_input,
+	.output =3D snd_usbmidi_raw_output,
+};
+
 /*
  * Emagic USB MIDI protocol: raw MIDI with "F5 xx" port switching.
  */
@@ -1661,6 +1678,8 @@ int snd_usb_create_midi_interface(struct snd_usb_audi=
o* chip,
 			umidi->usb_protocol_ops =3D
 				&snd_usbmidi_maudio_broken_running_status_ops;
 		break;
+	case QUIRK_MIDI_US122L:
+		umidi->usb_protocol_ops =3D &snd_usbmidi_122l_ops;
 	case QUIRK_MIDI_FIXED_ENDPOINT:
 		memcpy(&endpoints[0], quirk->data,
 		       sizeof(struct snd_usb_midi_endpoint_info));
=2D-=20
1.5.3.3


--Boundary-00=_UogMHV4Kv6zvBsQ
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-usb-stream-for-isochrone-usb-i-o.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-usb-stream-for-isochrone-usb-i-o.patch"

=46rom 27e99f95786b5765685cbc16337b2f4e05e01a48 Mon Sep 17 00:00:00 2001
=46rom: Karsten Wiese <fzu@wemgehoertderstaat.de>
Date: Wed, 7 Nov 2007 19:27:14 +0100
Subject: [PATCH 1/1] "usb stream" for isochrone usb i/o

Provides a combination of an in pipe isochron stream with an out pipe one.
The out pipe's urbs are scheduled with packet lengths taken from the inpipe=
's
urbs just red.

A client reads/writes data in equally sized chunks. The chunks are specified
as "no of frames per transfer" with frame_size during initialisation.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
=2D--
 sound/usb/usx2y/usb_stream.c |  676 ++++++++++++++++++++++++++++++++++++++=
++++
 sound/usb/usx2y/usb_stream.h |  111 +++++++
 2 files changed, 787 insertions(+), 0 deletions(-)
 create mode 100644 sound/usb/usx2y/usb_stream.c
 create mode 100644 sound/usb/usx2y/usb_stream.h

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
new file mode 100644
index 0000000..7440df3
=2D-- /dev/null
+++ b/sound/usb/usx2y/usb_stream.c
@@ -0,0 +1,676 @@
+/*
+ * Copyright (c) 2007 by Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY
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
+static unsigned usb_stream_next_packet_size(struct usb_stream *s)
+{
+	s->out_phase_peeked =3D (s->out_phase & 0xffff) + s->freqn;
+	return (s->out_phase_peeked >> 16) * s->cfg.frame_size;
+}
+
+static void playback_prep_freqn(struct usb_stream *s, struct urb *urb)
+{
+	unsigned l =3D 0;
+	int pack;
+
+	urb->iso_frame_desc[0].length =3D	usb_stream_next_packet_size(s);
+	s->out_phase =3D s->out_phase_peeked;
+	urb->transfer_buffer_length =3D urb->iso_frame_desc[0].length;
+
+	for (pack =3D 1; pack < s->max_packs; pack++) {
+		l =3D usb_stream_next_packet_size(s);
+		if (s->idle_outsize + urb->transfer_buffer_length + l >
+		    s->period_size)
+			goto check;
+
+		s->out_phase =3D s->out_phase_peeked;
+		urb->iso_frame_desc[pack].offset =3D urb->transfer_buffer_length;
+		urb->iso_frame_desc[pack].length =3D l;
+		urb->transfer_buffer_length +=3D l;
+	}
+	printk(KERN_WARNING"%s:%i %i\n", __FUNCTION__, __LINE__, urb->transfer_bu=
ffer_length);
+
+check:
+	urb->number_of_packets =3D pack;
+	s->idle_outsize +=3D urb->transfer_buffer_length - s->period_size;
+	printk(KERN_WARNING"%s:%i idle=3D%i ul=3D%i ps=3D%i\n",
+	       __FUNCTION__, __LINE__,
+	       s->idle_outsize, urb->transfer_buffer_length, s->period_size);
+}
+
+static void init_pipe_urbs(struct usb_stream *s,
+			   struct urb **urbs, char *transfer,
+			   struct usb_device *dev, int pipe)
+{
+	int u, p;
+	int maxpacket =3D usb_maxpacket(dev, pipe, usb_pipeout(pipe));
+	int transfer_length =3D maxpacket * s->max_packs;
+
+	for (u =3D 0; u < USB_STREAM_NURBS;
+	     ++u, transfer +=3D transfer_length) {
+		struct urb *urb =3D urbs[u];
+		struct usb_iso_packet_descriptor *desc;
+		usb_init_urb(urb);
+		urb->transfer_flags =3D URB_ISO_ASAP;
+		urb->transfer_buffer =3D transfer;
+		urb->dev =3D dev;
+		urb->pipe =3D pipe;
+		urb->number_of_packets =3D s->max_packs;
+		urb->context =3D s;
+		urb->interval =3D 1;
+		if (usb_pipeout(pipe))
+			continue;
+
+		urb->transfer_buffer_length =3D transfer_length;
+		desc =3D urb->iso_frame_desc;
+		desc->length =3D maxpacket;
+		for (p =3D 1; p < s->max_packs; ++p) {
+			desc[p].offset =3D desc[p - 1].offset + maxpacket;
+			desc[p].length =3D maxpacket;
+		}
+	}
+}
+
+static void init_urbs(struct usb_stream *s,
+		      struct usb_device *dev, int in_pipe, int out_pipe)
+{
+	int u, urbsize;
+	s->inurb[0] =3D (void *)((char *)s + sizeof(*s));
+	urbsize =3D sizeof(struct urb) +
+		sizeof(struct usb_iso_packet_descriptor) * s->max_packs;
+	for (u =3D 1; u < USB_STREAM_NURBS; ++u)
+		s->inurb[u] =3D (void *)((char *)s->inurb[u - 1] + urbsize);
+
+	s->outurb[0] =3D (void *)((char *)s->inurb[USB_STREAM_NURBS-1] +
+				urbsize);
+	for (u =3D 1; u < USB_STREAM_NURBS; ++u)
+		s->outurb[u] =3D (void *)((char *)s->outurb[u - 1] + urbsize);
+
+	init_pipe_urbs(s, s->inurb,
+		       (char *)s->outurb[USB_STREAM_NURBS-1] + urbsize,
+		       dev, in_pipe);
+	init_pipe_urbs(s, s->outurb, s->write_page,
+		       dev, out_pipe);
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
+void usb_stream_free(struct usb_stream *s)
+{
+	if (!s)
+		return;
+	free_pages((unsigned long)s->write_page, get_order(s->write_size));
+	free_pages((unsigned long)s, get_order(s->read_size));
+}
+
+struct usb_stream *usb_stream_new(struct usb_device *dev,
+				  unsigned in_endpoint,unsigned out_endpoint,
+				  unsigned sample_rate,
+				  unsigned period_frames, unsigned frame_size)
+{
+	struct usb_stream *s =3D NULL;
+	int packs, max_packsize;
+	int in_pipe, out_pipe;
+	int read_size =3D sizeof(*s);
+	int write_size;
+	int usb_frames =3D dev->speed =3D=3D USB_SPEED_HIGH ? 8000 : 1000;
+	int pg;
+
+	in_pipe =3D usb_rcvisocpipe(dev, in_endpoint);
+	out_pipe =3D usb_sndisocpipe(dev, out_endpoint);
+
+	read_size +=3D USB_STREAM_NURBS * 2 * sizeof(struct urb);
+
+	max_packsize =3D usb_maxpacket(dev, in_pipe, 0);
+
+	/*
+		t_period =3D period_frames / sample_rate
+		iso_packs =3D t_period / t_iso_frame
+			=3D (period_frames / sample_rate) * (1 / t_iso_frame)
+	*/
+
+	packs =3D period_frames * usb_frames / sample_rate + 1;
+
+	if (dev->speed =3D=3D USB_SPEED_HIGH)
+		packs =3D (packs + 7) & ~7;
+
+	read_size +=3D (sizeof(struct usb_iso_packet_descriptor) + max_packsize) *
+		packs * USB_STREAM_NURBS;
+	read_size +=3D sizeof(struct usb_iso_packet_descriptor) *
+		packs *	USB_STREAM_NURBS;
+
+	max_packsize =3D usb_maxpacket(dev, out_pipe, 1);
+	write_size =3D max_packsize * packs * USB_STREAM_NURBS;
+
+	if (read_size >=3D 128*PAGE_SIZE || write_size >=3D 128*PAGE_SIZE) {
+		printk(KERN_ERR"%s: a size exceeds 128*PAGE_SIZE\n", __FUNCTION__);
+		goto out;
+	}
+
+	pg =3D get_order(read_size);
+	if ((s =3D (void *) __get_free_pages(GFP_KERNEL|__GFP_COMP, pg)) =3D=3D N=
ULL) {
+		printk(KERN_ERR"%s: couldn't __get_free_pages()\n", __FUNCTION__);
+		goto out;
+	}
+	memset(s, 0, (read_size + PAGE_SIZE - 1) & PAGE_MASK);
+	s->cfg.version =3D USB_STREAM_INTERFACE_VERSION;
+	s->read_kernel_address =3D (unsigned long)s;
+	s->read_size =3D read_size;
+	s->urb_number_of_packets_offset =3D offsetof(struct urb, number_of_packet=
s);
+	s->urb_iso_frame_desc_offset =3D offsetof(struct urb, iso_frame_desc);
+	s->urb_transfer_buffer_offset =3D offsetof(struct urb, transfer_buffer);
+
+	s->cfg.sample_rate =3D sample_rate;
+	s->cfg.frame_size =3D frame_size;
+	s->max_packs =3D packs;
+	s->cfg.period_frames =3D period_frames;
+	s->period_size =3D frame_size * period_frames;
+	init_waitqueue_head(&s->sleep);
+
+	s->write_size =3D write_size;
+	pg =3D get_order(write_size);
+	s->write_kernel_address =3D __get_free_pages(GFP_KERNEL|__GFP_COMP, pg);
+	if ((s->write_page =3D (void *)s->write_kernel_address) =3D=3D NULL) {
+		printk(KERN_ERR"%s: couldn't __get_free_pages()\n", __FUNCTION__);
+		usb_stream_free(s);
+		return NULL;
+	}
+	memset(s->write_page, 0, (write_size + PAGE_SIZE - 1) & PAGE_MASK);
+
+	/* calculate the frequency in 16.16 format */
+	if (dev->speed =3D=3D USB_SPEED_FULL)
+		s->freqn =3D get_usb_full_speed_rate(sample_rate);
+	else
+		s->freqn =3D get_usb_high_speed_rate(sample_rate);
+
+	init_urbs(s, dev, in_pipe, out_pipe);
+	s->state =3D usb_stream_stopped;
+out:
+	return s;
+}
+
+
+/*                             start                                  */
+
+static bool balance_check(struct usb_stream *s, struct urb *urb)
+{
+	bool r;
+	if (unlikely(urb->status)) {
+		printk(KERN_WARNING"%s: status=3D%i\n", __FUNCTION__, urb->status);
+		s->iso_frame_balance =3D 0x7FFFFFFF;
+		return false;
+	}
+	r =3D s->iso_frame_balance =3D=3D 0;
+	if (!r)
+		s->i_urb =3D urb;
+	return r;
+}
+
+static bool balance_playback(struct urb *urb)
+{
+	struct usb_stream *s =3D urb->context;
+	s->iso_frame_balance +=3D urb->number_of_packets;
+	return balance_check(s, urb);
+}
+
+static bool balance_capture(struct urb *urb)
+{
+	struct usb_stream *s =3D urb->context;
+	s->iso_frame_balance -=3D urb->number_of_packets;
+	return balance_check(s, urb);
+}
+
+static void subs_set_complete(struct urb ** urbs, void (*complete)(struct =
urb *))
+{
+	int u;
+
+	for (u =3D 0; u < USB_STREAM_NURBS; u++) {
+		struct urb *urb =3D urbs[u];
+		urb->complete =3D complete;
+	}
+}
+
+int usb_stream_prepare_playback(struct usb_stream *s, struct urb *inurb)
+{
+	struct urb *io;
+	struct usb_iso_packet_descriptor *id, *od;
+	int p, l =3D 0;
+
+	io =3D s->idle_outurb;
+	od =3D io->iso_frame_desc;
+	io->transfer_buffer_length =3D 0;
+
+	for (p =3D 0; s->sync_packet < 0; ++p, ++s->sync_packet) {
+		struct urb *ii =3D s->completed_inurb;
+		id =3D ii->iso_frame_desc + ii->number_of_packets + s->sync_packet;
+		l =3D id->actual_length;
+
+		od[p].length =3D l;
+		od[p].offset =3D io->transfer_buffer_length;
+		io->transfer_buffer_length +=3D l;
+	}
+
+	for (;
+	     s->sync_packet < inurb->number_of_packets && p < s->max_packs;
+	     ++p, ++s->sync_packet) {
+		id =3D inurb->iso_frame_desc + s->sync_packet;
+		l =3D id->actual_length;
+
+		if (s->idle_outsize + io->transfer_buffer_length + l > s->period_size)
+			goto check_ok;
+
+		od[p].length =3D l;
+		od[p].offset =3D io->transfer_buffer_length;
+		io->transfer_buffer_length +=3D l;
+	}
+
+check_ok:
+	s->sync_packet -=3D inurb->number_of_packets;
+	if (s->sync_packet < -2 || s->sync_packet > 0) {
+		printk(KERN_ERR"%s: invalid sync_packet =3D %i; p=3D%i nop=3D%i %i %x %x=
 %x > %x %i %i\n",
+		       __FUNCTION__, s->sync_packet, p, inurb->number_of_packets, s->idl=
e_outsize + io->transfer_buffer_length + l, s->idle_outsize , io->transfer_=
buffer_length,  l, s->period_size,
+		       (s->idle_outsize + io->transfer_buffer_length + l > s->period_siz=
e),
+		       (s->idle_outsize + io->transfer_buffer_length + (int)l > s->perio=
d_size));
+		return -1;
+	}
+	if (io->transfer_buffer_length % s->cfg.frame_size) {
+		printk(KERN_ERR"%s: invalid outsize =3D %i\n",
+		       __FUNCTION__, io->transfer_buffer_length);
+		return -1;
+	}
+	s->idle_outsize +=3D io->transfer_buffer_length - s->period_size;
+	io->number_of_packets =3D p;
+	if (s->idle_outsize > 0) {
+		printk(KERN_DEBUG"%s:%i idle=3D%i\n", __FUNCTION__, __LINE__, s->idle_ou=
tsize);
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
+	iu->number_of_packets =3D number_of_packets;
+	id =3D iu->iso_frame_desc;
+	id->offset =3D 0;
+	for (p =3D 0; p < iu->number_of_packets - 1; ++p)
+		id[p + 1].offset =3D id[p].offset + id[p].length;
+
+	iu->transfer_buffer_length =3D
+		id[0].length * iu->number_of_packets;
+}
+
+static int submit_urbs(struct usb_stream *s, struct urb *inurb, struct urb=
 *outurb)
+{
+	int err;
+	prepare_inurb(s->idle_outurb->number_of_packets, s->idle_inurb);
+	if ((err =3D usb_submit_urb(s->idle_inurb, GFP_ATOMIC)) < 0) {
+		printk(KERN_WARNING"%s: usb_submit_urb()"
+		       " returned %i\n", __FUNCTION__, err);
+		return err;
+	}
+	s->idle_inurb =3D s->completed_inurb;
+	s->completed_inurb =3D inurb;
+	if ((err =3D usb_submit_urb(s->idle_outurb, GFP_ATOMIC)) < 0) {
+		printk(KERN_WARNING"%s: usb_submit_urb()"
+		       " returned %i\n", __FUNCTION__, err);
+		return err;
+	}
+	s->idle_outurb =3D s->completed_outurb;
+	s->completed_outurb =3D outurb;
+	return 0;
+}
+
+#ifdef DEBUG_LOOP_BACK
+/*
+  This loop_back() shows how to read/write the period data.
+ */
+static void loop_back(struct usb_stream *s)
+{
+	char *i, *o;
+	int il, ol, l, p;
+	struct urb *iu;
+	struct usb_iso_packet_descriptor *id;
+
+	o =3D s->playback1st_to;
+	ol =3D s->playback1st_size;
+	l =3D 0;
+
+	if (s->insplit_pack >=3D 0) {
+		iu =3D s->idle_inurb;
+		id =3D iu->iso_frame_desc;
+		p =3D s->insplit_pack;
+	} else
+		goto second;
+loop:
+	for (;p < iu->number_of_packets && l < s->period_size; ++p) {
+		i =3D iu->transfer_buffer + id[p].offset;
+		il =3D id[p].actual_length;
+		if (l + il > s->period_size)
+			il =3D s->period_size - l;
+		if (il <=3D ol) {
+			memcpy(o, i, il);
+			o +=3D il;
+			ol -=3D il;
+		} else {
+			memcpy(o, i, ol);
+			singen_6pack(o, ol);
+			o =3D s->playback_to;
+			memcpy(o, i + ol, il - ol);
+			o +=3D il - ol;
+			ol =3D s->period_size - s->playback1st_size;
+		}
+		l +=3D il;
+	}
+	if (iu =3D=3D s->completed_inurb) {
+		if (l !=3D s->period_size)
+			printk(KERN_DEBUG"%s:%i %i\n", __FUNCTION__, __LINE__,
+			       l/(int)s->cfg.frame_size);
+
+		return;
+	}
+second:
+	iu =3D s->completed_inurb;
+	id =3D iu->iso_frame_desc;
+	p =3D 0;
+	goto loop;
+
+}
+#else
+static void loop_back(struct usb_stream *s)
+{
+}
+#endif
+
+static void stream_idle(struct usb_stream *s, struct urb *inurb, struct ur=
b *outurb)
+{
+	int l, p;
+	int insize =3D s->idle_insize;
+	int urb_size =3D 0;
+
+	s->insplit_pack =3D s->next_insplit_pack;
+	s->insplit_offset =3D s->next_insplit_offset;
+	s->next_insplit_pack =3D -1;
+	for (p =3D 0; p < inurb->number_of_packets; ++p) {
+		struct usb_iso_packet_descriptor *id =3D inurb->iso_frame_desc;
+		l =3D id[p].actual_length;
+		if (unlikely(l =3D=3D 0 || id[p].status)) {
+			printk(KERN_ERR"%s:%i underrun, status=3D%u\n", __FUNCTION__, __LINE__,
+			       id[p].status);
+			goto err_out;
+		}
+		if (insize + l > s->period_size) {
+			s->next_insplit_pack =3D p;
+			s->next_insplit_offset =3D s->period_size - insize;
+			insize =3D l - s->next_insplit_offset;
+		} else
+			insize +=3D l;
+		urb_size +=3D l;
+	}
+	s->idle_insize +=3D urb_size - s->period_size;
+	if (s->idle_insize < 0) {
+		printk(KERN_DEBUG"%s:%i %i\n", __FUNCTION__, __LINE__,
+		       (s->idle_insize)/(int)s->cfg.frame_size);
+		goto err_out;
+	}
+	s->insize_done +=3D urb_size;
+
+	l =3D s->idle_outsize;
+	s->playback1st_to =3D s->idle_outurb->transfer_buffer - l;
+
+	if (usb_stream_prepare_playback(s, inurb) < 0)
+		goto err_out;
+
+	if (s->insplit_pack >=3D 0) {
+		struct usb_iso_packet_descriptor *isd =3D
+			s->completed_inurb->iso_frame_desc + s->insplit_pack;
+		isd->offset +=3D s->insplit_offset;
+		isd->actual_length -=3D s->insplit_offset;
+	}
+
+	s->playback1st_size =3D s->idle_outurb->transfer_buffer_length + l;
+	s->playback_to =3D s->completed_outurb->transfer_buffer;
+
+	if (submit_urbs(s, inurb, outurb) < 0)
+		goto err_out;
+
+	loop_back(s);
+	s->periods_done++;
+	wake_up(&s->sleep);
+	return;
+err_out:
+	s->state =3D usb_stream_xrun;
+}
+
+static void i_capture_idle(struct urb *urb)
+{
+	struct usb_stream *s =3D urb->context;
+	if (balance_capture(urb))
+		stream_idle(s, urb, s->i_urb);
+}
+
+static void i_playback_idle(struct urb *urb)
+{
+	struct usb_stream *s =3D urb->context;
+	if (balance_playback(urb))
+		stream_idle(s, s->i_urb, urb);
+}
+
+static void stream_start(struct usb_stream *s, struct urb *inurb, struct u=
rb *outurb)
+{
+	if (s->state >=3D usb_stream_sync1) {
+		int l, p;
+		int urb_size =3D 0;
+
+		for (p =3D 0; p < inurb->number_of_packets; ++p) {
+			l =3D inurb->iso_frame_desc[p].actual_length;
+			urb_size +=3D l;
+		}
+		if (s->idle_insize + urb_size < s->period_size) {
+			printk(KERN_DEBUG"%s:%i %i %i\n", __FUNCTION__, __LINE__,
+			       (s->idle_insize + urb_size)/(int)s->cfg.frame_size,
+			       s->insize_done/(int)s->cfg.frame_size);
+			s->idle_insize =3D s->period_size - urb_size + s->cfg.frame_size;
+			s->insize_done =3D -urb_size;
+		}
+		s->idle_insize +=3D urb_size - s->period_size;
+		if (s->idle_insize < 0) {
+			printk(KERN_DEBUG"%s:%i %i\n", __FUNCTION__, __LINE__,
+ 			       (s->idle_insize)/(int)s->cfg.frame_size);
+			return;
+		}
+		s->insize_done +=3D urb_size;
+
+		if (usb_stream_prepare_playback(s, inurb) < 0)
+			return;
+
+	} else
+		playback_prep_freqn(s, s->idle_outurb);
+
+	if (submit_urbs(s, inurb, outurb) < 0)
+		return;
+
+	if (s->state =3D=3D usb_stream_sync1 && s->insize_done > 360000) {
+		/* 48000/s needs longer than 44100/s         ^^^^^^ */
+		s->state =3D usb_stream_ready;
+		subs_set_complete(s->inurb, i_capture_idle);
+		subs_set_complete(s->outurb, i_playback_idle);
+	}
+}
+
+static void i_capture_start(struct urb *urb)
+{
+	struct usb_stream *s =3D urb->context;
+	int pack;
+	int empty =3D 0;
+
+	if (urb->status) {
+		printk(KERN_WARNING"%s: status=3D%i\n", __FUNCTION__, urb->status);
+		return;
+	}
+
+	for (pack =3D 0; pack < urb->number_of_packets; ++pack) {
+		int l =3D urb->iso_frame_desc[pack].actual_length;
+		if (l < s->cfg.frame_size) {
+			++empty;
+			if (s->state >=3D usb_stream_sync0) {
+				printk(KERN_WARNING"%s:%i\n",
+				       __FUNCTION__, __LINE__);
+				return;
+			}
+		}
+
+	}
+
+	if (empty) {
+		printk(KERN_DEBUG"%s:%i: %i", __FUNCTION__, __LINE__,
+		       urb->iso_frame_desc[0].actual_length);
+		for (pack =3D 1; pack < urb->number_of_packets; ++pack) {
+			int l =3D urb->iso_frame_desc[pack].actual_length;
+			printk(" %i", l);
+		}
+		printk("\n");
+	}
+
+	if (!empty && s->state < usb_stream_sync1)
+		if (++s->state =3D=3D usb_stream_sync1)
+			;//s->idle_outsize =3D 0;
+	if (balance_capture(urb))
+		stream_start(s, urb, s->i_urb);
+}
+
+static void i_playback_start(struct urb *urb)
+{
+	struct usb_stream *s =3D urb->context;
+	if (balance_playback(urb))
+		stream_start(s, s->i_urb, urb);
+}
+
+int usb_stream_start(struct usb_stream *s)
+{
+	int u, err;
+	int try =3D 0;
+
+	if (s->state !=3D usb_stream_stopped)
+		return -EAGAIN;
+
+	subs_set_complete(s->inurb, i_capture_start);
+	subs_set_complete(s->outurb, i_playback_start);
+	memset(s->write_page, 0, s->write_size);
+dotry:
+	s->insize_done =3D 0;
+	s->idle_insize =3D 0;
+	s->idle_outsize =3D 0;
+	s->sync_packet =3D -1;
+	s->iso_frame_balance =3D 0;
+	++try;
+	for (u =3D 0; u < 2; u++) {
+		playback_prep_freqn(s, s->outurb[u]);
+		s->inurb[u]->number_of_packets =3D s->outurb[u]->number_of_packets;
+		s->inurb[u]->transfer_buffer_length =3D
+			s->inurb[u]->number_of_packets *
+			s->inurb[u]->iso_frame_desc[0].length;
+		preempt_disable();
+		if ((err =3D usb_submit_urb(s->inurb[u], GFP_ATOMIC)) < 0) {
+			preempt_enable();
+			printk(KERN_ERR "%s: usb_submit_urb(s->inurb[%i])"
+			       " returned %i\n", __FUNCTION__, u, err);
+			return err;
+		}
+
+		if ((err =3D usb_submit_urb(s->outurb[u], GFP_ATOMIC)) < 0) {
+			preempt_enable();
+			printk(KERN_ERR "%s: usb_submit_urb(s->outurb[%i])"
+			       " returned %i\n", __FUNCTION__, u, err);
+			return err;
+		}
+		preempt_enable();
+		if (s->inurb[u]->start_frame !=3D s->outurb[u]->start_frame)
+			goto check_retry;
+	}
+	try =3D 0;
+check_retry:
+	if (try) {
+		usb_stream_stop(s);
+		if (try < 5) {
+			printk(KERN_DEBUG"%s:%i: goto dotry;\n",
+			       __FUNCTION__, __LINE__);
+			msleep(500);
+			goto dotry;
+		}
+		printk(KERN_ERR"%s: couldn't start all urbs"
+		       " on the same start_frame.\n", __FUNCTION__);
+		return -EFAULT;
+	}
+
+	s->idle_inurb =3D s->inurb[USB_STREAM_NURBS - 2];
+	s->idle_outurb =3D s->outurb[USB_STREAM_NURBS - 2];
+	s->completed_inurb =3D s->inurb[USB_STREAM_NURBS - 1];
+	s->completed_outurb =3D s->outurb[USB_STREAM_NURBS - 1];
+
+/* wait, check */
+	{
+		int wait_ms =3D 3000;
+		while (s->state !=3D usb_stream_ready && wait_ms > 0) {
+			msleep(200);
+			wait_ms -=3D 200;
+		}
+	}
+
+	return s->state =3D=3D usb_stream_ready ? 0 : -EFAULT;
+}
+
+
+/*                             stop                                   */
+
+void usb_stream_stop(struct usb_stream *s)
+{
+	int u;
+	if (!s)
+		return;
+	for (u =3D 0; u < USB_STREAM_NURBS; ++u) {
+		usb_kill_urb(s->inurb[u]);
+		usb_kill_urb(s->outurb[u]);
+	}
+	s->state =3D usb_stream_stopped;
+}
diff --git a/sound/usb/usx2y/usb_stream.h b/sound/usb/usx2y/usb_stream.h
new file mode 100644
index 0000000..a6f75aa
=2D-- /dev/null
+++ b/sound/usb/usx2y/usb_stream.h
@@ -0,0 +1,111 @@
+/*
+ * Copyright (c) 2007 by Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define USB_STREAM_INTERFACE_VERSION 1
+
+#if !__KERNEL__
+struct usb_iso_packet_descriptor {
+	unsigned int offset;
+	unsigned int length;		/* expected length */
+	unsigned int actual_length;
+	int status;
+};
+
+typedef int wait_queue_head_t;
+
+#endif
+
+#define USB_STREAM_NURBS 4
+struct usb_stream_config {
+	unsigned version;
+	unsigned sample_rate;
+	unsigned period_frames;
+	unsigned frame_size;
+};
+
+struct usb_stream {
+	struct usb_stream_config cfg;
+	unsigned long read_kernel_address;
+	unsigned read_size;
+	unsigned write_size;
+	void *write_page;
+	unsigned long write_kernel_address;
+	unsigned urb_number_of_packets_offset;
+	unsigned urb_iso_frame_desc_offset;
+	unsigned urb_transfer_buffer_offset;
+
+	struct urb *inurb[USB_STREAM_NURBS];
+	struct urb *idle_inurb;
+	struct urb *completed_inurb;
+	struct urb *outurb[USB_STREAM_NURBS];
+	struct urb *idle_outurb;
+	struct urb *completed_outurb;
+	struct urb *i_urb;
+
+	int period_size;
+	int iso_frame_balance;
+	unsigned max_packs;
+
+	unsigned state;
+
+	unsigned out_phase;
+	unsigned out_phase_peeked;
+	unsigned freqn;
+
+/*
+  Consumer info; Userspace has to offset pointers
+*/
+	void *playback1st_to;
+	unsigned playback1st_size;
+	void *playback_to;
+
+	int insplit_pack;
+	int insplit_offset;
+	int next_insplit_pack;
+	int next_insplit_offset;
+	int idle_insize;
+	int idle_outsize;
+	int sync_packet;
+	unsigned insize_done;
+	unsigned periods_done;
+	unsigned periods_polled;
+	wait_queue_head_t sleep;
+
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
+struct usb_stream *usb_stream_new(struct usb_device *dev,
+				  unsigned in_endpoint,unsigned out_endpoint,
+				  unsigned sample_rate,
+				  unsigned period_frames, unsigned frame_size);
+void usb_stream_free(struct usb_stream *);
+int usb_stream_start(struct usb_stream *);
+void usb_stream_stop(struct usb_stream *);
+
+#endif
=2D-=20
1.5.3.3


--Boundary-00=_UogMHV4Kv6zvBsQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_UogMHV4Kv6zvBsQ--
