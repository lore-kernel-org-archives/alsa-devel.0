From: pedro.lopez.cabanillas@gmail.com
Subject: [PATCH 1/1] ALSA: usb-audio: dynamic detection of MIDI
	interfaces in uaxx-quirk
Date: Tue,  7 Oct 2008 20:54:18 +0200
Message-ID: <12234056582291-git-send-email-pedro.lopez.cabanillas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CEF6243B1
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 20:54:46 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so1007095eyc.56
	for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2008 11:54:33 -0700 (PDT)
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

The MIDI interfaces have to be detected dynamically for Edirol devices
ua-700, ua-25 and ua4-fx. This patch reverses the wrong changes made by
my other patch in uaxx-quirk.

Signed-off-by: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 6e70ba4..bbd70d5 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -3023,6 +3023,31 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 	alts = &iface->altsetting[1];
 	altsd = get_iface_desc(alts);
 
+	if (altsd->bNumEndpoints == 2) {
+		static const struct snd_usb_midi_endpoint_info ua700_ep = {
+			.out_cables = 0x0003,
+			.in_cables  = 0x0003
+		};
+		static const struct snd_usb_audio_quirk ua700_quirk = {
+			.type = QUIRK_MIDI_FIXED_ENDPOINT,
+			.data = &ua700_ep
+		};
+		static const struct snd_usb_midi_endpoint_info uaxx_ep = {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		};
+		static const struct snd_usb_audio_quirk uaxx_quirk = {
+			.type = QUIRK_MIDI_FIXED_ENDPOINT,
+			.data = &uaxx_ep
+		};
+		if (chip->usb_id == USB_ID(0x0582, 0x002b))
+			return snd_usb_create_midi_interface(chip, iface,
+							     &ua700_quirk);
+		else
+			return snd_usb_create_midi_interface(chip, iface,
+							     &uaxx_quirk);
+	}
+
 	if (altsd->bNumEndpoints != 1)
 		return -ENXIO;
 
diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 85532cf..69689e7 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -870,11 +870,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0003,
-					.in_cables  = 0x0003
-				}
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = -1
@@ -1216,11 +1212,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = -1
@@ -1375,11 +1367,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
-					.out_cables = 0x0001,
-					.in_cables  = 0x0001
-				}
+				.type = QUIRK_AUDIO_EDIROL_UAXX
 			},
 			{
 				.ifnum = -1
-- 
1.5.2.4
