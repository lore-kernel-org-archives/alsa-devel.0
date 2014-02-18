From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 09/17 v2] ASoC: wm8996: Update locking around use of DAPM pin API
Date: Tue, 18 Feb 2014 15:22:20 +0000
Message-ID: <1392736948-26623-10-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8996.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 1a7655b..d565d0a 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2251,6 +2251,7 @@ int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		  wm8996_polarity_fn polarity_cb)
 {
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	wm8996->jack = jack;
 	wm8996->detecting = true;
@@ -2267,8 +2268,12 @@ int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 			    WM8996_MICB2_DISCH, 0);
 
 	/* LDO2 powers the microphones, SYSCLK clocks detection */
-	snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO2");
-	snd_soc_dapm_force_enable_pin(&codec->dapm, "SYSCLK");
+	snd_soc_dapm_mutex_lock(dapm);
+
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO2");
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "SYSCLK");
+
+	snd_soc_dapm_mutex_unlock(dapm);
 
 	/* We start off just enabling microphone detection - even a
 	 * plain headphone will trigger detection.
-- 
1.7.2.5
