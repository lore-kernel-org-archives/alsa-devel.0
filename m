From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 07/15] ASoC: wm8996: Update locking around use of DAPM pin API
Date: Mon, 17 Feb 2014 16:51:35 +0000
Message-ID: <1392655903-24537-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8996.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 1a7655b..a391128 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2267,8 +2267,12 @@ int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 			    WM8996_MICB2_DISCH, 0);
 
 	/* LDO2 powers the microphones, SYSCLK clocks detection */
-	snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO2");
-	snd_soc_dapm_force_enable_pin(&codec->dapm, "SYSCLK");
+	mutex_lock(&codec->dapm.card->dapm_mutex);
+
+	snd_soc_dapm_force_enable_pin_locked(&codec->dapm, "LDO2");
+	snd_soc_dapm_force_enable_pin_locked(&codec->dapm, "SYSCLK");
+
+	mutex_unlock(&codec->dapm.card->dapm_mutex);
 
 	/* We start off just enabling microphone detection - even a
 	 * plain headphone will trigger detection.
-- 
1.7.2.5
