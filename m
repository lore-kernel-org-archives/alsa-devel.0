From: pedro.lopez.cabanillas@gmail.com
Subject: [PATCH] ALSA: snd-usb-audio: support for Edirol UA-4FX
	device
Date: Sat,  4 Oct 2008 16:27:36 +0200
Message-ID: <48e77d59.06a0100a.4176.ffffe9cf@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 36BC124456
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Oct 2008 16:27:40 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so606248eyc.56
	for <alsa-devel@alsa-project.org>; Sat, 04 Oct 2008 07:27:39 -0700 (PDT)
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
Cc: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>

Renamed the old quirk function for ua-700/ua-25 to become more
generic, moving the MIDI interfaces to the quirk data header.
Added a new quirk for the Edirol UA-4FX.

Signed-off-by: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index c5cf682..05c7849 100644
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
@@ -3016,37 +3016,12 @@ static int create_ua700_ua25_quirk(struct snd_usb_audio *chip,
 	struct audioformat *fp;
 	int stream, err;
 
-	/* both PCM and MIDI interfaces have 2 altsettings */
-	if (iface->num_altsetting != 2)
+	/* both PCM and MIDI interfaces have 2 or more altsettings */
+	if (iface->num_altsetting < 2)
 		return -ENXIO;
 	alts = &iface->altsetting[1];
 	altsd = get_iface_desc(alts);
 
-	if (altsd->bNumEndpoints == 2) {
-		static const struct snd_usb_midi_endpoint_info ua700_ep = {
-			.out_cables = 0x0003,
-			.in_cables  = 0x0003
-		};
-		static const struct snd_usb_audio_quirk ua700_quirk = {
-			.type = QUIRK_MIDI_FIXED_ENDPOINT,
-			.data = &ua700_ep
-		};
-		static const struct snd_usb_midi_endpoint_info ua25_ep = {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0001
-		};
-		static const struct snd_usb_audio_quirk ua25_quirk = {
-			.type = QUIRK_MIDI_FIXED_ENDPOINT,
-			.data = &ua25_ep
-		};
-		if (chip->usb_id == USB_ID(0x0582, 0x002b))
-			return snd_usb_create_midi_interface(chip, iface,
-							     &ua700_quirk);
-		else
-			return snd_usb_create_midi_interface(chip, iface,
-							     &ua25_quirk);
-	}
-
 	if (altsd->bNumEndpoints != 1)
 		return -ENXIO;
 
@@ -3376,9 +3351,9 @@ static int snd_usb_create_quirk(struct snd_usb_audio *chip,
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
index 3f68359..ad7a318 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -855,15 +855,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const struct snd_usb_midi_endpoint_info) {
+					.out_cables = 0x0003,
+					.in_cables  = 0x0003
+				}
 			},
 			{
 				.ifnum = -1
@@ -1197,15 +1201,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const struct snd_usb_midi_endpoint_info) {
+					.out_cables = 0x0001,
+					.in_cables  = 0x0001
+				}
 			},
 			{
 				.ifnum = -1
@@ -1338,6 +1346,40 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const struct snd_usb_midi_endpoint_info) {
+					.out_cables = 0x0001,
+					.in_cables  = 0x0001
+				}
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
