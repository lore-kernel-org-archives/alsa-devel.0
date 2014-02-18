From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 08/17 v2] ASoC: wm8994: Update locking around use of DAPM pin API
Date: Tue, 18 Feb 2014 15:22:19 +0000
Message-ID: <1392736948-26623-9-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

The pin updates in this driver look like they are intended to be done
atomically, update to do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   45 +++++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b9be9cb..e8daf55 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2549,43 +2549,52 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 int wm8994_vmid_mode(struct snd_soc_codec *codec, enum wm8994_vmid_mode mode)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	switch (mode) {
 	case WM8994_VMID_NORMAL:
+		snd_soc_dapm_mutex_lock(dapm);
+
 		if (wm8994->hubs.lineout1_se) {
-			snd_soc_dapm_disable_pin(&codec->dapm,
-						 "LINEOUT1N Driver");
-			snd_soc_dapm_disable_pin(&codec->dapm,
-						 "LINEOUT1P Driver");
+			snd_soc_dapm_disable_pin_unlocked(dapm,
+							  "LINEOUT1N Driver");
+			snd_soc_dapm_disable_pin_unlocked(dapm,
+							  "LINEOUT1P Driver");
 		}
 		if (wm8994->hubs.lineout2_se) {
-			snd_soc_dapm_disable_pin(&codec->dapm,
-						 "LINEOUT2N Driver");
-			snd_soc_dapm_disable_pin(&codec->dapm,
-						 "LINEOUT2P Driver");
+			snd_soc_dapm_disable_pin_unlocked(dapm,
+							  "LINEOUT2N Driver");
+			snd_soc_dapm_disable_pin_unlocked(dapm,
+							  "LINEOUT2P Driver");
 		}
 
 		/* Do the sync with the old mode to allow it to clean up */
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_sync_unlocked(dapm);
 		wm8994->vmid_mode = mode;
+
+		snd_soc_dapm_mutex_unlock(dapm);
 		break;
 
 	case WM8994_VMID_FORCE:
+		snd_soc_dapm_mutex_lock(dapm);
+
 		if (wm8994->hubs.lineout1_se) {
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "LINEOUT1N Driver");
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "LINEOUT1P Driver");
+			snd_soc_dapm_force_enable_pin_unlocked(dapm,
+							       "LINEOUT1N Driver");
+			snd_soc_dapm_force_enable_pin_unlocked(dapm,
+							       "LINEOUT1P Driver");
 		}
 		if (wm8994->hubs.lineout2_se) {
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "LINEOUT2N Driver");
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "LINEOUT2P Driver");
+			snd_soc_dapm_force_enable_pin_unlocked(dapm,
+							       "LINEOUT2N Driver");
+			snd_soc_dapm_force_enable_pin_unlocked(dapm,
+							       "LINEOUT2P Driver");
 		}
 
 		wm8994->vmid_mode = mode;
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_sync_unlocked(dapm);
+
+		snd_soc_dapm_mutex_unlock(dapm);
 		break;
 
 	default:
-- 
1.7.2.5
