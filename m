From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] sound: soc: codecs: wcd9335: fix Unneeded variable: "ret"
Date: Wed, 10 Jul 2019 00:07:15 +0530
Message-ID: <20190709183715.GA7634@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod Koul <vkoul@kernel.org>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Gen Zhang <blackgod016574@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

this fixes below issues reported  by coccicheck
sound/soc/codecs/wcd9335.c:3611:5-8: Unneeded variable: "ret". Return
"0" on line 3625
sound/soc/codecs/wcd9335.c:3941:5-8: Unneeded variable: "ret". Return
"0" on line 3971
sound/soc/codecs/wcd9335.c:3745:5-8: Unneeded variable: "ret". Return
"0" on line 3784
sound/soc/codecs/wcd9335.c:3896:5-8: Unneeded variable: "ret". Return
"0" on line 3934
sound/soc/codecs/wcd9335.c:3026:5-8: Unneeded variable: "ret". Return
"0" on line 3038

We cannot change return of these functions as they are callback
functions.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1bbbe42..e13af36 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3018,7 +3018,6 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = snd_soc_component_get_drvdata(comp);
 	struct wcd_slim_codec_dai_data *dai = &wcd->dai[w->shift];
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -3030,7 +3029,7 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
@@ -3603,7 +3602,6 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3617,7 +3615,7 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static void wcd9335_codec_hph_post_pa_config(struct wcd9335_codec *wcd,
@@ -3737,7 +3735,6 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3776,7 +3773,7 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
@@ -3888,7 +3885,6 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3926,14 +3922,13 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 				       struct snd_kcontrol *kc, int event)
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -3963,7 +3958,7 @@ static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
-- 
2.7.4
