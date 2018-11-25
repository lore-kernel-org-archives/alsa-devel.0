From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: usb-audio: fix spelling mistake "Frequence" -> "Frequency"
Date: Sun, 25 Nov 2018 23:12:08 +0000
Message-ID: <20181125231208.14350-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in equalizer name fields, fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer_us16x08.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 26ed23b18b77..4f594f9552a8 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -1119,7 +1119,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQLOWFREQ,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ Low Frequence",
+		.name = "EQ Low Frequency",
 	},
 	{ /* EQ mid low gain */
 		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
@@ -1133,7 +1133,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQLOWMIDFREQ,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ MidLow Frequence",
+		.name = "EQ MidLow Frequency",
 	},
 	{ /* EQ mid low Q */
 		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
@@ -1154,7 +1154,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQHIGHMIDFREQ,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ MidHigh Frequence",
+		.name = "EQ MidHigh Frequency",
 	},
 	{ /* EQ mid high Q */
 		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
@@ -1175,7 +1175,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQHIGHFREQ,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ High Frequence",
+		.name = "EQ High Frequency",
 	},
 };
 
-- 
2.19.1
