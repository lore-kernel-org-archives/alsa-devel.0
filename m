From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] more Roland SC-D70 support
Date: Tue, 21 Jan 2003 09:09:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301210857320.21713-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This patch removes the roland_ua100_hack functions from usbaudio.c and
replaces them with a new composite quirk which allows several quirks for
one device, and a quirk for a fixed PCM interface.

Additionally, it adds PCM playback support for the SC-D70. PCM recording
and mixer controls for the SC-D70 are still missing.


- add composite and PCM interface quirks
- add pcm playback support for the SC-D70


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.35
diff -u -r1.35 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	13 Jan 2003 09:50:26 -0000	1.35
+++ alsa-kernel/usb/usbaudio.c	21 Jan 2003 07:49:36 -0000
@@ -1918,75 +1918,58 @@
 	return 0;
 }

-static int snd_usb_roland_ua100_hack_intf(snd_usb_audio_t *chip, int ifnum)
+/*
+ * create a stream for an endpoint/altsetting without proper descriptors
+ */
+static int create_fixed_stream_quirk(snd_usb_audio_t *chip,
+				     struct usb_interface *iface,
+				     const snd_usb_audio_quirk_t *quirk)
 {
 	struct audioformat *fp;
-	int err;
+	struct usb_host_interface *alts;
+	int stream, err;

 	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
 	if (! fp) {
 		snd_printk(KERN_ERR "cannot malloc\n");
 		return -ENOMEM;
 	}
-	memset(fp, 0, sizeof(*fp));
-	fp->format = SNDRV_PCM_FORMAT_S16_LE;
-	fp->channels = ifnum == 0 ? 4 : 2;
-	fp->iface = ifnum;
-	fp->altsetting = 1;
-	fp->altset_idx = 1;
-	fp->attributes = ifnum == 0 ? 0 : EP_CS_ATTR_FILL_MAX;
-	fp->endpoint = ifnum == 0 ? 0x01 : 0x81;
-	fp->ep_attr = ifnum == 0 ? 0x09 : 0x05;
-	fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
-	fp->rate_min = fp->rate_max = 44100;
-
-	err = add_audio_endpoint(chip, ifnum == 0 ? SNDRV_PCM_STREAM_PLAYBACK
-				 : SNDRV_PCM_STREAM_CAPTURE, fp);
+	memcpy(fp, quirk->data, sizeof(*fp));
+	stream = (fp->endpoint & USB_DIR_IN)
+		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+	err = add_audio_endpoint(chip, stream, fp);
 	if (err < 0) {
 		kfree(fp);
 		return err;
 	}
-	usb_set_interface(chip->dev, ifnum, 0);
+	alts = &iface->altsetting[fp->altset_idx];
+	usb_set_interface(chip->dev, fp->iface, 0);
+	init_usb_pitch(chip->dev, fp->iface, alts, fp);
+	init_usb_sample_rate(chip->dev, fp->iface, alts, fp, fp->rate_max);
 	return 0;
 }

-static int snd_usb_roland_ua100_hack(snd_usb_audio_t *chip)
+static int snd_usb_create_quirk(snd_usb_audio_t *chip,
+				struct usb_interface *iface,
+				const snd_usb_audio_quirk_t *quirk);
+
+/*
+ * handle the quirk(s) for the current interface
+ */
+static int create_composite_quirk(snd_usb_audio_t *chip,
+				  struct usb_interface *iface,
+				  const snd_usb_audio_quirk_t *quirk)
 {
-	static const snd_usb_midi_endpoint_info_t ep_quirk = {
-		.out_cables = 0x0007,
-		.in_cables  = 0x0007
-	};
-	static const snd_usb_audio_quirk_t midi_quirk = {
-		.vendor_name = "Roland",
-		.product_name = "UA-100",
-		.ifnum = 2,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = &ep_quirk
-	};
-	struct usb_host_config *cfg = chip->dev->actconfig;
-	struct usb_interface *iface;
+	struct usb_host_interface *alts = &iface->altsetting[0];
+	int ifnum = get_iface_desc(alts)->bInterfaceNumber;
 	int err;

-	if (get_cfg_desc(cfg)->bNumInterfaces != 3) {
-		snd_printdd(KERN_ERR "invalid UA-100 descriptor\n");
-		return -ENXIO;
-	}
-	/* if 0: output */
-	if ((err = snd_usb_roland_ua100_hack_intf(chip, 0)) < 0)
-		return err;
-	/* if 1: input */
-	iface = &cfg->interface[1];
-	if (! usb_interface_claimed(iface)) {
-		if ((err = snd_usb_roland_ua100_hack_intf(chip, 1)) < 0)
-			return err;
-		usb_driver_claim_interface(&usb_audio_driver, iface, (void*)-1);
-	}
-	/* if 2: MIDI */
-	iface = &cfg->interface[2];
-	if (! usb_interface_claimed(iface)) {
-		if ((err = snd_usb_create_midi_interface(chip, iface, &midi_quirk)) < 0)
-			return err;
-		usb_driver_claim_interface(&usb_audio_driver, iface, (void*)-1);
+	for (quirk = quirk->data; quirk->ifnum >= 0; ++quirk) {
+		if (quirk->ifnum == ifnum) {
+			err = snd_usb_create_quirk(chip, iface, quirk);
+			if (err < 0)
+				return err;
+		}
 	}
 	return 0;
 }
@@ -2000,8 +1983,10 @@
 	case QUIRK_MIDI_YAMAHA:
 	case QUIRK_MIDI_MIDIMAN:
 		return snd_usb_create_midi_interface(chip, iface, quirk);
-	case QUIRK_ROLAND_UA100:
-		return snd_usb_roland_ua100_hack(chip);
+	case QUIRK_COMPOSITE:
+		return create_composite_quirk(chip, iface, quirk);
+	case QUIRK_AUDIO_FIXED_ENDPOINT:
+		return create_fixed_stream_quirk(chip, iface, quirk);
 	default:
 		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 		return -ENXIO;
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.13
diff -u -r1.13 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	13 Jan 2003 09:50:26 -0000	1.13
+++ alsa-kernel/usb/usbaudio.h	21 Jan 2003 07:49:36 -0000
@@ -151,7 +151,8 @@
 #define QUIRK_MIDI_FIXED_ENDPOINT	0
 #define QUIRK_MIDI_YAMAHA		1
 #define QUIRK_MIDI_MIDIMAN		2
-#define QUIRK_ROLAND_UA100		3
+#define QUIRK_COMPOSITE			3
+#define QUIRK_AUDIO_FIXED_ENDPOINT	4

 typedef struct snd_usb_audio_quirk snd_usb_audio_quirk_t;
 typedef struct snd_usb_midi_endpoint_info snd_usb_midi_endpoint_info_t;
@@ -176,7 +177,10 @@
 /* for QUIRK_MIDI_MIDIMAN, data points to a snd_usb_midi_endpoint_info
  * structure (out_cables and in_cables only) */

-/* for QUIRK_ROLAND_UA100, data is NULL */
+/* for QUIRK_COMPOSITE, data points to an array of snd_usb_audio_quirk
+ * structures, terminated with .ifnum = -1 */
+
+/* for QUIRK_AUDIO_FIXED_ENDPOINT, data points to an audioformat structure */

 /*
  */
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.12
diff -u -r1.12 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	10 Jan 2003 10:31:58 -0000	1.12
+++ alsa-kernel/usb/usbquirks.h	21 Jan 2003 07:49:38 -0000
@@ -242,8 +242,55 @@
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "UA-100",
-		.ifnum = 0,
-		.type = QUIRK_ROLAND_UA100
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const snd_usb_audio_quirk_t[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.format = SNDRV_PCM_FORMAT_S16_LE,
+					.channels = 4,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x01,
+					.ep_attr = 0x09,
+					.rates = SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min = 44100,
+					.rate_max = 44100,
+				}
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.format = SNDRV_PCM_FORMAT_S16_LE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = EP_CS_ATTR_FILL_MAX,
+					.endpoint = 0x81,
+					.ep_attr = 0x05,
+					.rates = SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min = 44100,
+					.rate_max = 44100,
+				}
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const snd_usb_midi_endpoint_info_t) {
+					.out_cables = 0x0007,
+					.in_cables  = 0x0007
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
 	}
 },
 {
@@ -355,11 +402,37 @@
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "SC-D70",
-		.ifnum = 2,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.out_cables = 0x0007,
-			.in_cables  = 0x0007
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const snd_usb_audio_quirk_t[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.format = SNDRV_PCM_FORMAT_S24_3LE,
+					.channels = 2,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x01,
+					.ep_attr = 0x01,
+					.rates = SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min = 44100,
+					.rate_max = 44100,
+				}
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const snd_usb_midi_endpoint_info_t) {
+					.out_cables = 0x0007,
+					.in_cables  = 0x0007
+				}
+			},
+			{
+				.ifnum = -1
+			}
 		}
 	}
 },



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
