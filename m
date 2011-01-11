From: damien.zammit@gmail.com
Subject: [PATCH] Support for Digidesign Mbox 2 duplex analogue
	mode.
Date: Tue, 11 Jan 2011 23:11:07 +1100
Message-ID: <1294747867-27075-1-git-send-email-damien.zammit@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Damien Zammit <damien.zammit@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Damien Zammit <damien.zammit@gmail.com>

Added suggestions by Takashi Iwai 
(see previous post on Mbox 2).
Some lines are still longer than 80 characters, but all other warnings
have been fixed.

Signed-off-by: Damien Zammit <damien.zammit@gmail.com>
---
 sound/usb/midi.c         |   12 ++++
 sound/usb/quirks-table.h |   51 +++++++++++++++++
 sound/usb/quirks.c       |  137 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks.h       |    5 ++
 sound/usb/usbaudio.h     |    1 +
 5 files changed, 206 insertions(+), 0 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 25bce7e..5dace7e 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2122,6 +2122,18 @@ int snd_usbmidi_create(struct snd_card *card,
 		umidi->usb_protocol_ops = &snd_usbmidi_novation_ops;
 		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
+	case QUIRK_MIDI_MBOX2:
+		/* Digidesign Mbox 2 uses MIDIMAN MIDI protocol */
+		umidi->usb_protocol_ops = &snd_usbmidi_midiman_ops;
+		/*
+		 * We have to make sure that the USB core looks
+		 * again at interface 6 by calling usb_set_interface() on it.
+		 */
+		usb_set_interface(umidi->dev, 6, 0);
+		memcpy(&endpoints[0], quirk->data,
+			sizeof(struct snd_usb_midi_endpoint_info));
+		err = 0;
+		break;
 	case QUIRK_MIDI_RAW_BYTES:
 		umidi->usb_protocol_ops = &snd_usbmidi_raw_ops;
 		/*
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index ad7079d..ba61dfe 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2477,6 +2477,57 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+/* DIGIDESIGN MBOX 2 */
+{
+	USB_DEVICE(0x0dba, 0x3000),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Digidesign",
+		.product_name = "Mbox 2",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 4,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 5,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 6,
+				.type = QUIRK_MIDI_MBOX2,
+				.data = &(const struct snd_usb_midi_endpoint_info) {
+					.out_ep =  0x02,
+					.out_cables = 0x0001,
+					.in_ep = 0x81,
+					.in_interval = 0x01,
+					.in_cables = 0x0001
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+
 {
 	/*
 	 * Some USB MIDI devices don't have an audio control interface,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index cf8bf08..483a959 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
+#include <linux/wait.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
@@ -287,6 +288,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_YAMAHA] = create_any_midi_quirk,
 		[QUIRK_MIDI_MIDIMAN] = create_any_midi_quirk,
 		[QUIRK_MIDI_NOVATION] = create_any_midi_quirk,
+		[QUIRK_MIDI_MBOX2] = create_any_midi_quirk,
 		[QUIRK_MIDI_RAW_BYTES] = create_any_midi_quirk,
 		[QUIRK_MIDI_EMAGIC] = create_any_midi_quirk,
 		[QUIRK_MIDI_CME] = create_any_midi_quirk,
@@ -479,6 +481,9 @@ int snd_usb_apply_interface_quirk(struct snd_usb_audio *chip,
 	if (chip->usb_id == USB_ID(0x0763, 0x2003))
 		return audiophile_skip_setting_quirk(chip, iface, altno);
 
+	if (chip->usb_id == USB_ID(0x0dba, 0x3000))
+		return mbox2_skip_setting_quirk(chip, iface, altno);
+
 	return 0;
 }
 
@@ -506,6 +511,10 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 	if (id == USB_ID(0x0d8c, 0x0102))
 		return snd_usb_cm6206_boot_quirk(dev);
 
+	/* Digidesign Mbox 2 */
+	if (id == USB_ID(0x0dba, 0x3000))
+		return snd_usb_mbox2_boot_quirk(dev);
+
 	/* Access Music VirusTI Desktop */
 	if (id == USB_ID(0x133e, 0x0815))
 		return snd_usb_accessmusic_boot_quirk(dev);
@@ -527,6 +536,9 @@ int snd_usb_is_big_endian_format(struct snd_usb_audio *chip, struct audioformat
 		if (chip->setup == 0x00 ||
 		    fp->altsetting==1 || fp->altsetting==2 || fp->altsetting==3)
 			return 1;
+		break;
+	case USB_ID(0x0dba, 0x3000): /* Digidesign Mbox 2 */
+		return 1;
 	}
 	return 0;
 }
@@ -594,3 +606,128 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	}
 }
 
+#define MBOX2_FIRMWARE_SIZE    646
+#define MBOX2_BOOT_LOADING     0x01 /* Hard coded into the device */
+#define MBOX2_BOOT_READY       0x02 /* Hard coded into the device */
+
+static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
+{
+	struct usb_host_config *config = dev->actconfig;
+	int err;
+	wait_queue_head_t mbox2_wait_queue;
+	u8 enablemagic[3];
+	u8 bootresponse;
+	u8 temp[3];
+	int fwsize;
+	int count;
+
+	init_waitqueue_head(&mbox2_wait_queue);
+	fwsize = le16_to_cpu(get_cfg_desc(config)->wTotalLength);
+
+	if (fwsize == MBOX2_FIRMWARE_SIZE) {
+		snd_printk(KERN_INFO "Sending Digidesign Mbox 2 boot sequence...\n");
+		/* From USB Snoop,
+		 *
+		 * SetupPacket = RT RQ VHVL INDX SIZE
+		 * RT = 0xRT Request Type
+		 * RQ = 0xRQ Request
+		 * VHVL = 0xVLVH Value in reverse byte order
+		 * INDX = 0xDXIN Index in reverse byte order
+		 * SIZE = 0xZESI Size in reverse byte order
+		 *
+		 * Magic boot code setup packet: c0 85 01 00 00 00 12 00
+		 *           RQ    RT    VLVH    DXIN                 ZESI
+		 * becomes 0x85, 0xc0, 0x0001, 0x0000, &RETURNDATA, 0x0012, TIMEOUT
+		 * for snd_usb_ctl_msg()
+		 */
+
+		count = 0;
+		bootresponse = MBOX2_BOOT_LOADING;
+		while ((bootresponse == MBOX2_BOOT_LOADING) && (count < 5)) {
+			snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+				0x85, 0xc0, 0x0001, 0x0000,
+				&bootresponse, 0x0012, 1000);
+			if (bootresponse == MBOX2_BOOT_READY)
+				break;
+
+			snd_printk(KERN_INFO "device not ready, resending boot sequence...\n");
+			count++;
+			/* 1 second delay */
+			wait_event_timeout(mbox2_wait_queue,
+				bootresponse == MBOX2_BOOT_READY,
+				msecs_to_jiffies(1000));
+		}
+
+		if (bootresponse == MBOX2_BOOT_READY) {
+			snd_printk(KERN_INFO "device initialised!\n");
+
+			err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
+				&dev->descriptor, sizeof(dev->descriptor));
+			config = dev->actconfig;
+			if (err < 0)
+				snd_printk(KERN_ERR "error usb_get_descriptor: %d\n", err);
+			err = usb_reset_configuration(dev);
+			if (err < 0)
+				snd_printk(KERN_ERR "error usb_reset_configuration: %d\n", err);
+			snd_printk("mbox2_boot: new boot length = %d\n",
+				le16_to_cpu(get_cfg_desc(config)->wTotalLength));
+
+			/* We want 48 kHz mode for now */
+			enablemagic[0] = 0x80;
+			enablemagic[1] = 0xbb;
+			enablemagic[2] = 0x00;
+
+			/* Send the magic! */
+			snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+				0x01, 0x22, 0x0100, 0x0085,
+				&temp, 0x0003, 1000);
+			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				0x81, 0xa2, 0x0100, 0x0085,
+				&enablemagic, 0x0003, 1000);
+			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				0x81, 0xa2, 0x0100, 0x0086,
+				&enablemagic, 0x0003, 1000);
+			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				0x81, 0xa2, 0x0100, 0x0003,
+				&enablemagic, 0x0003, 1000);
+			snd_printk(KERN_INFO "Digidesign Mbox 2: 24 Bit 48kHz Analogue");
+
+			return 0; /* Succesful boot */
+		}
+
+		snd_printk(KERN_ERR "Unknown bootresponse, or timed out, ignoring device: %d\n", bootresponse);
+		return -ENODEV;
+	}
+	snd_printk(KERN_ERR "Invalid firmware size: %d\n", fwsize);
+	return -ENODEV;
+}
+
+static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
+					int iface, int altno)
+{
+	u8 srate[3];
+	u8 temp[3];
+
+	/* Reset ifaces 2,4,5 to 0 altsetting. */
+	usb_set_interface(chip->dev, iface, 0);
+
+	/* setup 48k */
+	srate[0] = 0x80;
+	srate[1] = 0xbb;
+	srate[2] = 0x00;
+
+	/* Send the magic! */
+	snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
+		0x01, 0x22, 0x0100, 0x0085, &temp, 0x0003, 1000);
+	snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+		0x81, 0xa2, 0x0100, 0x0085, &srate, 0x0003, 1000);
+	snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+		0x81, 0xa2, 0x0100, 0x0086, &srate, 0x0003, 1000);
+	snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+		0x81, 0xa2, 0x0100, 0x0003, &srate, 0x0003, 1000);
+
+	if (altno != 3)
+		return -1;
+
+	return 0;
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 03e5e94..1643f3f 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -20,4 +20,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 int snd_usb_is_big_endian_format(struct snd_usb_audio *chip,
 				 struct audioformat *fp);
 
+static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
+				    int iface, int altno);
+
+static int snd_usb_mbox2_boot_quirk(struct usb_device *dev);
+
 #endif /* __USBAUDIO_QUIRKS_H */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index db3eb21..128c3f4 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -70,6 +70,7 @@ enum quirk_type {
 	QUIRK_MIDI_YAMAHA,
 	QUIRK_MIDI_MIDIMAN,
 	QUIRK_MIDI_NOVATION,
+	QUIRK_MIDI_MBOX2,
 	QUIRK_MIDI_RAW_BYTES,
 	QUIRK_MIDI_EMAGIC,
 	QUIRK_MIDI_CME,
-- 
1.6.3.3
