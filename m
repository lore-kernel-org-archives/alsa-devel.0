From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 06/15] ASoC: wm8994: Update locking around use of DAPM pin API
Date: Mon, 17 Feb 2014 16:51:34 +0000
Message-ID: <1392655903-24537-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

The pin updates in this driver look like they are intended to be done
atomically, update to do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b9be9cb..4788c4e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2552,38 +2552,46 @@ int wm8994_vmid_mode(struct snd_soc_codec *codec, enum wm8994_vmid_mode mode)
 
 	switch (mode) {
 	case WM8994_VMID_NORMAL:
+		mutex_lock(&codec->dapm.card->dapm_mutex);
+
 		if (wm8994->hubs.lineout1_se) {
-			snd_soc_dapm_disable_pin(&codec->dapm,
-						 "LINEOUT1N Driver");
-			snd_soc_dapm_disable_pin(&codec->dapm,
-						 "LINEOUT1P Driver");
+			snd_soc_dapm_disable_pin_locked(&codec->dapm,
+							"LINEOUT1N Driver");
+			snd_soc_dapm_disable_pin_locked(&codec->dapm,
+							"LINEOUT1P Driver");
 		}
 		if (wm8994->hubs.lineout2_se) {
-			snd_soc_dapm_disable_pin(&codec->dapm,
-						 "LINEOUT2N Driver");
-			snd_soc_dapm_disable_pin(&codec->dapm,
-						 "LINEOUT2P Driver");
+			snd_soc_dapm_disable_pin_locked(&codec->dapm,
+							"LINEOUT2N Driver");
+			snd_soc_dapm_disable_pin_locked(&codec->dapm,
+							"LINEOUT2P Driver");
 		}
 
+		mutex_unlock(&codec->dapm.card->dapm_mutex);
+
 		/* Do the sync with the old mode to allow it to clean up */
 		snd_soc_dapm_sync(&codec->dapm);
 		wm8994->vmid_mode = mode;
 		break;
 
 	case WM8994_VMID_FORCE:
+		mutex_lock(&codec->dapm.card->dapm_mutex);
+
 		if (wm8994->hubs.lineout1_se) {
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "LINEOUT1N Driver");
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "LINEOUT1P Driver");
+			snd_soc_dapm_force_enable_pin_locked(&codec->dapm,
+							     "LINEOUT1N Driver");
+			snd_soc_dapm_force_enable_pin_locked(&codec->dapm,
+							     "LINEOUT1P Driver");
 		}
 		if (wm8994->hubs.lineout2_se) {
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "LINEOUT2N Driver");
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "LINEOUT2P Driver");
+			snd_soc_dapm_force_enable_pin_locked(&codec->dapm,
+							     "LINEOUT2N Driver");
+			snd_soc_dapm_force_enable_pin_locked(&codec->dapm,
+							     "LINEOUT2P Driver");
 		}
 
+		mutex_unlock(&codec->dapm.card->dapm_mutex);
+
 		wm8994->vmid_mode = mode;
 		snd_soc_dapm_sync(&codec->dapm);
 		break;
-- 
1.7.2.5
