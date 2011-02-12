From: Omari Stephens <xsdg@xsdg.org>
Subject: [PATCH] New quirk for USB DAC 08bb:2704
Date: Sat, 12 Feb 2011 22:53:25 +0000
Message-ID: <4D570F65.6000108@xsdg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070202010806020703010904"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ocaml.xvm.mit.edu (SIPB-VM-99.MIT.EDU [18.181.0.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 6433A24667
	for <alsa-devel@alsa-project.org>; Sat, 12 Feb 2011 23:54:49 +0100 (CET)
Received: from c-24-6-182-69.hsd1.ca.comcast.net ([24.6.182.69]
	helo=[192.168.17.141])
	by ocaml.xvm.mit.edu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <xsdg@xsdg.org>) id 1PoOMZ-0001Hq-5O
	for alsa-devel@alsa-project.org; Sat, 12 Feb 2011 17:54:47 -0500
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

This is a multi-part message in MIME format.
--------------070202010806020703010904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Howdy, all

I have one of these:
http://www.chordelectronics.co.uk/products_detail.asp?id=63

It's got one of these USB DACs inside
ID 08bb:2704 Texas Instruments Japan

The DAC has a single mixer control, Master, which allows you to adjust 
volume and mute/unmute.  The fun thing is that the volume adjustment has 
no effect whatsoever.  On machines running pulse, this means that output 
will be at 0dB pretty much all the time.  (Of course, this is true of 
non-pulse machines also).

The attached patch disables the Master control, which causes pulse to 
control levels entirely in software, as it should for this device.

The main downside to this patch is that, while the volume part of the 
Master control is non-functional, the mute/unmute aspect does work as 
expected.  I couldn't figure out how to change the Master control to 
just a mute/unmute control, but if someone has suggestions on what to 
do, that'd be appreciated.  Judging by the comments in the code (and 
contrary to what I wrote in the map comment), I presume the mute/unmute 
control is the only reason why 08bb:2702 isn't doing this same thing.

Cheers,
--xsdg

--------------070202010806020703010904
Content-Type: text/x-patch;
 name="0001-Add-a-quirk-to-ignore-the-Master-volume-control-on-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-a-quirk-to-ignore-the-Master-volume-control-on-0.pa";
 filename*1="tch"

>From 3061b0fa281ea812f0767bc9df6bae7b8016d0d0 Mon Sep 17 00:00:00 2001
From: Omari Stephens <xsdg@xsdg.org>
Date: Sat, 12 Feb 2011 20:36:04 +0000
Subject: [PATCH] Add a quirk to ignore the Master volume control on 08bb:2704

---
 mixer.c      |    6 ++++++
 mixer_maps.c |   19 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/mixer.c b/mixer.c
index 3ed3901..38d5d77 100644
--- a/mixer.c
+++ b/mixer.c
@@ -1192,6 +1192,12 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 		/* disable non-functional volume control */
 		master_bits &= ~UAC_CONTROL_BIT(UAC_FU_VOLUME);
 		break;
+	case USB_ID(0x08bb, 0x2704):
+		snd_printk(KERN_INFO
+			   "usbmixer: master volume quirk for PCM2704 chip\n");
+		/* disable non-functional volume control */
+		master_bits &= ~UAC_CONTROL_BIT(UAC_FU_VOLUME);
+		break;
 	}
 	if (channels > 0)
 		first_ch_bits = snd_usb_combine_bytes(bmaControls + csize, csize);
diff --git a/mixer_maps.c b/mixer_maps.c
index f1324c4..40edd9b 100644
--- a/mixer_maps.c
+++ b/mixer_maps.c
@@ -208,11 +208,23 @@ static struct usbmix_name_map live24ext_map[] = {
 /* LineX FM Transmitter entry - needed to bypass controls bug */
 static struct usbmix_name_map linex_map[] = {
 	/* 1: IT pcm */
-	/* 2: OT Speaker */ 
+	/* 2: OT Speaker */
 	{ 3, "Master" }, /* FU: master volume - left / right / mute */
 	{ 0 } /* terminator */
 };
 
+/* This DAC (08bb:2704) has a single "Volume" control which isn't actually
+ * connected to anything.  The 08bb:2702 device is based off the LineX map, so
+ * presumably the 2704 one is similar but more broken.
+ */
+static struct usbmix_name_map ti_broken_usb_dac_map[] = {
+	/* 1: IT pcm */
+	/* 2: OT Speaker */
+	{ 3, NULL }, /* Master (not connected to anything) */
+	{ 0 }
+};
+
+
 static struct usbmix_name_map maya44_map[] = {
 	/* 1: IT line */
 	{ 2, "Line Playback" }, /* FU */
@@ -355,6 +367,11 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.ignore_ctl_error = 1,
 	},
 	{
+		.id = USB_ID(0x08bb, 0x2704),
+		.map = ti_broken_usb_dac_map,
+		.ignore_ctl_error = 1,
+	},
+	{
 		.id = USB_ID(0x0a92, 0x0091),
 		.map = maya44_map,
 	},
-- 
1.7.2.3


--------------070202010806020703010904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070202010806020703010904--
