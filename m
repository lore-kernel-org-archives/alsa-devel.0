From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/8] ALSA: usb-audio: remove invalid extra
	mixers for Komplete Audio 6
Date: Wed, 18 May 2011 11:28:41 +0200
Message-ID: <1305710925-3857-5-git-send-email-zonque@gmail.com>
References: <1305710925-3857-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B887103850
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 11:29:01 +0200 (CEST)
In-Reply-To: <1305710925-3857-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was a flaw in the reading of the spec tables - Native Instrument's
"Komplete Audio 6" device has no such extra controls.

This patch also fixes the device name in two comments.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/mixer_quirks.c |   17 -----------------
 sound/usb/quirks-table.h |    2 +-
 sound/usb/quirks.c       |    2 +-
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 4a7ad7e..73dcc82 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -398,17 +398,6 @@ static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_nativeinstruments_ak6_mixers[] = {
-	{
-		.name = "Direct Monitor Channel 1+2",
-		.private_value = _MAKE_NI_CONTROL(0x03, 0x03),
-	},
-	{
-		.name = "Direct Monitor Channel 3+4",
-		.private_value = _MAKE_NI_CONTROL(0x03, 0x05),
-	},
-};
-
 static struct snd_kcontrol_new snd_nativeinstruments_ta6_mixers[] = {
 	{
 		.name = "Direct Thru Channel A",
@@ -537,12 +526,6 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_xonar_u1_controls_create(mixer);
 		break;
 
-	case USB_ID(0x17cc, 0x1001): /* Audio Kontrol 6 */
-		err = snd_nativeinstruments_create_mixer(mixer,
-				snd_nativeinstruments_ak6_mixers,
-				ARRAY_SIZE(snd_nativeinstruments_ak6_mixers));
-		break;
-
 	case USB_ID(0x17cc, 0x1011): /* Traktor Audio 6 */
 		err = snd_nativeinstruments_create_mixer(mixer,
 				snd_nativeinstruments_ta6_mixers,
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 54e18c1..5c1a176 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2332,7 +2332,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 /* Native Instruments MK2 series */
 {
-	/* Audio Kontrol 6 */
+	/* Komplete Audio 6 */
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor = 0x17cc,
 	.idProduct = 0x1000,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index de50eea..bd13d72 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -540,7 +540,7 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 		/* Access Music VirusTI Desktop */
 		return snd_usb_accessmusic_boot_quirk(dev);
 
-	case USB_ID(0x17cc, 0x1000): /* Audio Kontrol 6 */
+	case USB_ID(0x17cc, 0x1000): /* Komplete Audio 6 */
 	case USB_ID(0x17cc, 0x1010): /* Traktor Audio 6 */
 	case USB_ID(0x17cc, 0x1020): /* Traktor Audio 10 */
 		return snd_usb_nativeinstruments_boot_quirk(dev);
-- 
1.7.5.1
