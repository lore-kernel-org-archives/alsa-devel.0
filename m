From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Roland UA-100 PCM support
Date: Thu, 24 Oct 2002 09:19:56 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210240907400.23677-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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


The UA-100 doesn't have any class-specific descriptors, so the PCM format
information has to be supplied by the driver as well.


Index: usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.21
diff -u -r1.21 usbaudio.c
--- usb/usbaudio.c	22 Oct 2002 10:14:19 -0000	1.21
+++ usb/usbaudio.c	24 Oct 2002 07:06:41 -0000
@@ -1891,12 +1891,94 @@
 	return 0;
 }

-static inline int snd_usb_create_quirk(snd_usb_audio_t *chip,
-				       struct usb_interface *iface,
-	       			       const snd_usb_audio_quirk_t *quirk)
+static int snd_usb_roland_ua100_hack_intf(snd_usb_audio_t *chip, int ifnum)
 {
-	/* in the future, there may be quirks for PCM devices */
-	return snd_usb_create_midi_interface(chip, iface, quirk);
+	struct audioformat *fp;
+	int err;
+
+	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+	if (! fp) {
+		snd_printk(KERN_ERR "cannot malloc\n");
+		return -ENOMEM;
+	}
+	memset(fp, 0, sizeof(*fp));
+	fp->format = SNDRV_PCM_FORMAT_S16_LE;
+	fp->channels = ifnum == 0 ? 4 : 2;
+	fp->iface = ifnum;
+	fp->altsetting = 1;
+	fp->altset_idx = 1;
+	fp->attributes = ifnum == 0 ? 0 : EP_CS_ATTR_FILL_MAX;
+	fp->endpoint = ifnum == 0 ? 0x01 : 0x81;
+	fp->ep_attr = ifnum == 0 ? 0x09 : 0x05;
+	fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
+	fp->rate_min = fp->rate_max = 44100;
+
+	err = add_audio_endpoint(chip, ifnum == 0 ? SNDRV_PCM_STREAM_PLAYBACK
+				 : SNDRV_PCM_STREAM_CAPTURE, fp);
+	if (err < 0) {
+		kfree(fp);
+		return err;
+	}
+	usb_set_interface(chip->dev, ifnum, 0);
+	return 0;
+}
+
+static int snd_usb_roland_ua100_hack(snd_usb_audio_t *chip)
+{
+	static const snd_usb_audio_quirk_t midi_quirk = {
+		.vendor_name = "Roland",
+		.product_name = "UA-100",
+		.ifnum = 2,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.epnum = -1,
+			.out_cables = 0x0007,
+			.in_cables  = 0x0007
+		}
+	};
+	struct usb_config_descriptor *cfg = chip->dev->actconfig;
+	struct usb_interface *iface;
+	int err;
+
+	if (cfg->bNumInterfaces != 3) {
+		snd_printdd(KERN_ERR "invalid UA-100 descriptor\n");
+		return -ENXIO;
+	}
+	/* if 0: output */
+	if ((err = snd_usb_roland_ua100_hack_intf(chip, 0)) < 0)
+		return err;
+	/* if 1: input */
+	iface = &cfg->interface[1];
+	if (! usb_interface_claimed(iface)) {
+		if ((err = snd_usb_roland_ua100_hack_intf(chip, 1)) < 0)
+			return err;
+		usb_driver_claim_interface(&usb_audio_driver, iface, (void*)-1);
+	}
+	/* if 2: MIDI */
+	iface = &cfg->interface[2];
+	if (! usb_interface_claimed(iface)) {
+		if ((err = snd_usb_create_midi_interface(chip, iface, &midi_quirk)) < 0)
+			return err;
+		usb_driver_claim_interface(&usb_audio_driver, iface, (void*)-1);
+	}
+	return 0;
+}
+
+static int snd_usb_create_quirk(snd_usb_audio_t *chip,
+				struct usb_interface *iface,
+				const snd_usb_audio_quirk_t *quirk)
+{
+	switch (quirk->type) {
+	case QUIRK_MIDI_FIXED_ENDPOINT:
+	case QUIRK_MIDI_YAMAHA:
+	case QUIRK_MIDI_MIDIMAN:
+		return snd_usb_create_midi_interface(chip, iface, quirk);
+	case QUIRK_ROLAND_UA100:
+		return snd_usb_roland_ua100_hack(chip);
+	default:
+		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
+		return -ENXIO;
+	}
 }


Index: usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.5
diff -u -r1.5 usbaudio.h
--- usb/usbaudio.h	22 Oct 2002 10:14:19 -0000	1.5
+++ usb/usbaudio.h	24 Oct 2002 07:06:41 -0000
@@ -149,6 +149,7 @@
 #define QUIRK_MIDI_FIXED_ENDPOINT	0
 #define QUIRK_MIDI_YAMAHA		1
 #define QUIRK_MIDI_MIDIMAN		2
+#define QUIRK_ROLAND_UA100		3

 typedef struct snd_usb_audio_quirk snd_usb_audio_quirk_t;
 typedef struct snd_usb_midi_endpoint_info snd_usb_midi_endpoint_info_t;
@@ -171,6 +172,8 @@
 /* for QUIRK_MIDI_YAMAHA, data is NULL */

 /* for QUIRK_MIDI_MIDIMAN, data is the number of ports */
+
+/* for QUIRK_ROLAND_UA100, data is NULL */

 /*
  */
Index: usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.5
diff -u -r1.5 usbquirks.h
--- usb/usbquirks.h	23 Oct 2002 10:00:31 -0000	1.5
+++ usb/usbquirks.h	24 Oct 2002 07:06:41 -0000
@@ -179,13 +179,8 @@
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "UA-100",
-		.ifnum = 2,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
-			.out_cables = 0x0007,
-			.in_cables  = 0x0007
-		}
+		.ifnum = 0,
+		.type = QUIRK_ROLAND_UA100
 	}
 },
 {



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4729346;7592162;s?http://www.sun.com/javavote
