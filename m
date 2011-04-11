From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Add quirks for Audio Kontrol 6
Date: Mon, 11 Apr 2011 17:56:32 +0200
Message-ID: <1302537392-3597-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7B56F24450
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 17:57:21 +0200 (CEST)
Received: by bwz10 with SMTP id 10so5028081bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 08:57:21 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Mark Hills <mark@pogo.org.uk>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This new device by Native Instruments is also compliant to the USB
standard v2.0, but hides this detail at when connected.

It needs the same boot quirks than other models, and also has two
non-class-compliant mixer controls.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Hills <mark@pogo.org.uk>
Cc: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/mixer_quirks.c |   17 +++++++++++++++++
 sound/usb/quirks-table.h |    6 ++++++
 sound/usb/quirks.c       |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 73dcc82..4a7ad7e 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -398,6 +398,17 @@ static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static struct snd_kcontrol_new snd_nativeinstruments_ak6_mixers[] = {
+	{
+		.name = "Direct Monitor Channel 1+2",
+		.private_value = _MAKE_NI_CONTROL(0x03, 0x03),
+	},
+	{
+		.name = "Direct Monitor Channel 3+4",
+		.private_value = _MAKE_NI_CONTROL(0x03, 0x05),
+	},
+};
+
 static struct snd_kcontrol_new snd_nativeinstruments_ta6_mixers[] = {
 	{
 		.name = "Direct Thru Channel A",
@@ -526,6 +537,12 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_xonar_u1_controls_create(mixer);
 		break;
 
+	case USB_ID(0x17cc, 0x1001): /* Audio Kontrol 6 */
+		err = snd_nativeinstruments_create_mixer(mixer,
+				snd_nativeinstruments_ak6_mixers,
+				ARRAY_SIZE(snd_nativeinstruments_ak6_mixers));
+		break;
+
 	case USB_ID(0x17cc, 0x1011): /* Traktor Audio 6 */
 		err = snd_nativeinstruments_create_mixer(mixer,
 				snd_nativeinstruments_ta6_mixers,
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c66d3f6..54e18c1 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2332,6 +2332,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 /* Native Instruments MK2 series */
 {
+	/* Audio Kontrol 6 */
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor = 0x17cc,
+	.idProduct = 0x1000,
+},
+{
 	/* Traktor Audio 6 */
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor = 0x17cc,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 355759b..2452edd 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -539,6 +539,7 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 		/* Access Music VirusTI Desktop */
 		return snd_usb_accessmusic_boot_quirk(dev);
 
+	case USB_ID(0x17cc, 0x1000): /* Audio Kontrol 6 */
 	case USB_ID(0x17cc, 0x1010): /* Traktor Audio 6 */
 	case USB_ID(0x17cc, 0x1020): /* Traktor Audio 10 */
 		return snd_usb_nativeinstruments_boot_quirk(dev);
-- 
1.7.1
