From: Yao-Wen Mao <yaowen@google.com>
Subject: [PATCH] sound/usb: add dB range mapping quirks.
Date: Tue, 28 Jul 2015 16:06:45 +0800
Message-ID: <1438070805-52951-1-git-send-email-yaowen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id EF55B260451
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 10:06:55 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so67845666pdj.3
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 01:06:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org
Cc: dgreid@chromium.org, Yao-Wen Mao <yaowen@google.com>
List-Id: alsa-devel@alsa-project.org

Some usb audio devices don't follow the specification of the
volume range. Add dB_mapping_quirks to fix some devices' dB
ranges so that the function snd_mixer_selem_set_playback_dB in
alsa-lib can set the correct value for those devices.

Signed-off-by: Yao-Wen Mao <yaowen@google.com>
---
 sound/usb/mixer.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6b3acba..b6b27dc 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -933,6 +933,32 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 	}
 }
 
+/* dB mapping quirks */
+static void dB_mapping_quirks(struct usb_mixer_elem_info *cval,
+			      struct snd_kcontrol *kctl)
+{
+	switch (cval->mixer->chip->usb_id) {
+	case USB_ID(0x05a7, 0x1020): /* Bose Companion 5 */
+		if (strcmp(kctl->id.name, "PCM Playback Volume") == 0) {
+			cval->dBmin = (convert_signed_value(cval, cval->min) * 100) / 16;
+			cval->dBmax = (convert_signed_value(cval, cval->max) * 100) / 16;
+		}
+		break;
+	case USB_ID(0x21b4, 0x0081): /* Dragonfly DAC 1.2 */
+		if (strcmp(kctl->id.name, "PCM Playback Volume") == 0) {
+			cval->dBmin = convert_signed_value(cval, cval->min) * 100;
+			cval->dBmax = convert_signed_value(cval, cval->max) * 100;
+		}
+		break;
+	case USB_ID(0x046d, 0x0a29): /* Logitech H800 */
+		if (strcmp(kctl->id.name, "PCM Playback Volume") == 0) {
+			cval->dBmin = convert_signed_value(cval, cval->min);
+			cval->dBmax = convert_signed_value(cval, cval->max);
+		}
+		break;
+	}
+}
+
 /*
  * retrieve the minimum and maximum values for the specified control
  */
@@ -1027,6 +1053,10 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 	 */
 	cval->dBmin = (convert_signed_value(cval, cval->min) * 100) / 256;
 	cval->dBmax = (convert_signed_value(cval, cval->max) * 100) / 256;
+
+	if (kctl)
+		dB_mapping_quirks(cval, kctl);
+
 	if (cval->dBmin > cval->dBmax) {
 		/* something is wrong; assume it's either from/to 0dB */
 		if (cval->dBmin < 0)
-- 
2.5.0.rc2.392.g76e840b
