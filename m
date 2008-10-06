From: pedro.lopez.cabanillas@gmail.com
Subject: [PATCH 1/1] ALSA: snd-usb-audio: support for Edirol
	UA-4FX device
Date: Mon,  6 Oct 2008 21:56:09 +0200
Message-ID: <12233229693553-git-send-email-pedro.lopez.cabanillas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 943661037F1
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 21:56:27 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id 30so23485ugs.24
	for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2008 12:56:14 -0700 (PDT)
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
Cc: tiwai@suse.de, Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

From: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>

Renamed the old quirk function for ua-700/ua-25 to become more
generic. Added a new quirk for the Edirol UA-4FX.

Signed-off-by: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index c5cf682..1077e9d 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2996,12 +2996,12 @@ static int create_standard_audio_quirk(struct snd_usb_audio *chip,
 }
 
 /*
- * Create a stream for an Edirol UA-700/UA-25 interface.  The only way
- * to detect the sample rate is by looking at wMaxPacketSize.
+ * Create a stream for an Edirol UA-700/UA-25/UA-4FX interface.  
+ * The only way to detect the sample rate is by looking at wMaxPacketSize.
  */
-static int create_ua700_ua25_quirk(struct snd_usb_audio *chip,
-				   struct usb_interface *iface,
-				   const struct snd_usb_audio_quirk *quirk)
+static int create_uaxx_quirk(struct snd_usb_audio *chip,
+			      struct usb_interface *iface,
+			      const struct snd_usb_audio_quirk *quirk)
 {
 	static const struct audioformat ua_format = {
 		.format = SNDRV_PCM_FORMAT_S24_3LE,
@@ -3016,8 +3016,8 @@ static int create_ua700_ua25_quirk(struct snd_usb_audio *chip,
 	struct audioformat *fp;
 	int stream, err;
 
-	/* both PCM and MIDI interfaces have 2 altsettings */
-	if (iface->num_altsetting != 2)
+	/* both PCM and MIDI interfaces have 2 or more altsettings */
+	if (iface->num_altsetting < 2)
 		return -ENXIO;
 	alts = &iface->altsetting[1];
 	altsd = get_iface_desc(alts);
@@ -3031,20 +3031,20 @@ static int create_ua700_ua25_quirk(struct snd_usb_audio *chip,
 			.type = QUIRK_MIDI_FIXED_ENDPOINT,
 			.data = &ua700_ep
 		};
-		static const struct snd_usb_midi_endpoint_info ua25_ep = {
+		static const struct snd_usb_midi_endpoint_info uaxx_ep = {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		};
-		static const struct snd_usb_audio_quirk ua25_quirk = {
+		static const struct snd_usb_audio_quirk uaxx_quirk = {
 			.type = QUIRK_MIDI_FIXED_ENDPOINT,
-			.data = &ua25_ep
+			.data = &uaxx_ep
 		};
 		if (chip->usb_id == USB_ID(0x0582, 0x002b))
 			return snd_usb_create_midi_interface(chip, iface,
 							     &ua700_quirk);
 		else
 			return snd_usb_create_midi_interface(chip, iface,
-							     &ua25_quirk);
+							     &uaxx_quirk);
 	}
 
 	if (altsd->bNumEndpoints != 1)
@@ -3376,9 +3376,9 @@ static int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_CME] = snd_usb_create_midi_interface,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
-		[QUIRK_AUDIO_EDIROL_UA700_UA25] = create_ua700_ua25_quirk,
 		[QUIRK_AUDIO_EDIROL_UA1000] = create_ua1000_quirk,
 		[QUIRK_AUDIO_EDIROL_UA101] = create_ua101_quirk,
+		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk
 	};
 
 	if (quirk->type < QUIRK_TYPE_COUNT) {
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index f3ca77f..36e4f7a 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -159,9 +159,9 @@ enum quirk_type {
 	QUIRK_MIDI_US122L,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
-	QUIRK_AUDIO_EDIROL_UA700_UA25,
 	QUIRK_AUDIO_EDIROL_UA1000,
 	QUIRK_AUDIO_EDIROL_UA101,
+	QUIRK_AUDIO_EDIROL_UAXX,
 
 	QUIRK_TYPE_COUNT
 };
diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 3f68359..815bf36 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -855,15 +855,15 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.data = (const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_EDIROL_UA700_UA25
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_EDIROL_UA700_UA25
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_AUDIO_EDIROL_UA700_UA25
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = -1
@@ -1197,15 +1197,15 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.data = (const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
-				.type = QUIRK_AUDIO_EDIROL_UA700_UA25
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_EDIROL_UA700_UA25
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_EDIROL_UA700_UA25
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = -1
@@ -1338,6 +1338,36 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/*
+	 * This quirk is for the "Advanced Driver" mode. If off, the UA-4FX
+	 * is standard compliant, but has only 16-bit PCM and no MIDI.
+	 */
+	USB_DEVICE(0x0582, 0x00a3),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "EDIROL",
+		.product_name = "UA-4FX",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_EDIROL_UAXX
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_EDIROL_UAXX
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_EDIROL_UAXX
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 	/* TODO: add Edirol MD-P1 support */
 {
 	USB_DEVICE(0x582, 0x00a6),
-- 
1.5.2.4
