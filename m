From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Remove needless
	snd_soc_dapm_enable_pin() from machine driver inits
Date: Mon, 19 May 2014 16:17:27 +0300
Message-ID: <1400505447-8313-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400505447-8313-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F352726517F
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 15:17:41 +0200 (CEST)
In-Reply-To: <1400505447-8313-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

ALSA SoC core marks widgets as connected by default when they are
initialized in snd_soc_dapm_new_control() so there is no need to call
snd_soc_dapm_enable_pin() from machine driver init functions.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
I think these init functions are pretty stable and didn't see reason to send
patch per machine. I can separate if needed. Note, build tested only for
sound/soc/intel.
---
 sound/soc/atmel/snd-soc-afeb9260.c             | 12 ------------
 sound/soc/intel/byt-rt5640.c                   |  5 -----
 sound/soc/intel/haswell.c                      |  6 ------
 sound/soc/kirkwood/kirkwood-t5325.c            | 13 -------------
 sound/soc/omap/ams-delta.c                     |  2 --
 sound/soc/pxa/brownstone.c                     |  5 -----
 sound/soc/pxa/palm27x.c                        |  8 --------
 sound/soc/pxa/poodle.c                         |  1 -
 sound/soc/pxa/ttc-dkb.c                        |  4 ----
 sound/soc/samsung/h1940_uda1380.c              |  5 -----
 sound/soc/samsung/rx1950_uda1380.c             |  5 -----
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |  8 --------
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |  8 --------
 sound/soc/samsung/smartq_wm8987.c              |  2 --
 sound/soc/samsung/smdk_wm8994.c                | 12 ------------
 15 files changed, 96 deletions(-)

diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index f65f08beac31..9579799ace54 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -80,17 +80,6 @@ static const struct snd_soc_dapm_route afeb9260_audio_map[] = {
 	{"MICIN", NULL, "Mic Jack"},
 };
 
-static int afeb9260_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Line In");
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-
-	return 0;
-}
 
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link afeb9260_dai = {
@@ -100,7 +89,6 @@ static struct snd_soc_dai_link afeb9260_dai = {
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "atmel_pcm-audio",
 	.codec_name = "tlv320aic23-codec.0-001a",
-	.init = afeb9260_tlv320aic23_init,
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
 		   SND_SOC_DAIFMT_CBM_CFM,
 	.ops = &afeb9260_ops,
diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index eee001f70964..5535c3fb7922 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -100,11 +100,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_ignore_suspend(dapm, "SPORP");
 	snd_soc_dapm_ignore_suspend(dapm, "SPORN");
 
-	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
-	snd_soc_dapm_enable_pin(dapm, "Headphone");
-	snd_soc_dapm_enable_pin(dapm, "Speaker");
-	snd_soc_dapm_enable_pin(dapm, "Internal Mic");
-
 	return ret;
 }
 
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/haswell.c
index 54345a2a7386..94c2c33ffe49 100644
--- a/sound/soc/intel/haswell.c
+++ b/sound/soc/intel/haswell.c
@@ -89,8 +89,6 @@ static struct snd_soc_ops haswell_rt5640_ops = {
 
 static int haswell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct sst_pdata *pdata = dev_get_platdata(rtd->platform->dev);
 	struct sst_hsw *haswell = pdata->dsp;
 	int ret;
@@ -104,10 +102,6 @@ static int haswell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	/* always connected */
-	snd_soc_dapm_enable_pin(dapm, "Headphones");
-	snd_soc_dapm_enable_pin(dapm, "Mic");
-
 	return 0;
 }
 
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index d213832b0c72..844b8415a011 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -52,18 +52,6 @@ static const struct snd_soc_dapm_route t5325_route[] = {
 	{ "MIC2",		NULL,	"Mic Jack" },
 };
 
-static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Speaker");
-
-	return 0;
-}
-
 static struct snd_soc_dai_link t5325_dai[] = {
 {
 	.name = "ALC5621",
@@ -74,7 +62,6 @@ static struct snd_soc_dai_link t5325_dai[] = {
 	.codec_name = "alc562x-codec.0-001a",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &t5325_ops,
-	.init = t5325_dai_init,
 },
 };
 
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index b0f8dbc1f635..bb243c663e6b 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -520,8 +520,6 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 
 	/* Set up initial pin constellation */
 	snd_soc_dapm_disable_pin(dapm, "Mouthpiece");
-	snd_soc_dapm_enable_pin(dapm, "Earpiece");
-	snd_soc_dapm_enable_pin(dapm, "Microphone");
 	snd_soc_dapm_disable_pin(dapm, "Speaker");
 	snd_soc_dapm_disable_pin(dapm, "AGCIN");
 	snd_soc_dapm_disable_pin(dapm, "AGCOUT");
diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 9c128d4c8cbf..c8dd53f9c35d 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -50,11 +50,6 @@ static int brownstone_wm8994_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
-	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
-	snd_soc_dapm_enable_pin(dapm, "Main Mic");
-
 	/* set endpoints to not connected */
 	snd_soc_dapm_nc_pin(dapm, "HPOUT2P");
 	snd_soc_dapm_nc_pin(dapm, "HPOUT2N");
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 3284c4b901cb..17f9521ff6ea 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -79,14 +79,6 @@ static int palm27x_ac97_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	/* connected pins */
-	if (machine_is_palmld())
-		snd_soc_dapm_enable_pin(dapm, "MIC1");
-	snd_soc_dapm_enable_pin(dapm, "HPOUTL");
-	snd_soc_dapm_enable_pin(dapm, "HPOUTR");
-	snd_soc_dapm_enable_pin(dapm, "LOUT2");
-	snd_soc_dapm_enable_pin(dapm, "ROUT2");
-
 	/* not connected pins */
 	snd_soc_dapm_nc_pin(dapm, "OUT3");
 	snd_soc_dapm_nc_pin(dapm, "MONOOUT");
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index c6bdc6c0eff6..21f340065318 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -230,7 +230,6 @@ static int poodle_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 
 	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
 	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
-	snd_soc_dapm_enable_pin(dapm, "MICIN");
 
 	return 0;
 }
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index 0b535b570622..9d7c5b7e9539 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -78,10 +78,6 @@ static int ttc_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	/* connected pins */
-	snd_soc_dapm_enable_pin(dapm, "Ext Speaker");
-	snd_soc_dapm_enable_pin(dapm, "Ext Mic 1");
-	snd_soc_dapm_enable_pin(dapm, "Ext Mic 3");
 	snd_soc_dapm_disable_pin(dapm, "Headset Mic 2");
 	snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
 
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 88b09e022503..9f2fb69dbaae 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -176,11 +176,6 @@ static struct platform_device *s3c24xx_snd_device;
 static int h1940_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Speaker");
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
 		&hp_jack);
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 2982d9e7f268..5b3e504d3a32 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -221,11 +221,6 @@ static int rx1950_hw_params(struct snd_pcm_substream *substream,
 static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Speaker");
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
 		&hp_jack);
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index d8a0543cae5e..2d30b7b6818a 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -63,14 +63,6 @@ static const struct snd_soc_dapm_route base_map[] = {
 */
 static int simtec_hermes_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Line In");
-	snd_soc_dapm_enable_pin(dapm, "Line Out");
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-
 	simtec_audio_init(rtd);
 
 	return 0;
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index 1ac0d7a63a3a..83f6c7d49cd6 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -52,14 +52,6 @@ static const struct snd_soc_dapm_route base_map[] = {
 */
 static int simtec_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Line In");
-	snd_soc_dapm_enable_pin(dapm, "Line Out");
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-
 	simtec_audio_init(rtd);
 
 	return 0;
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index c3b2adafb7b5..df55db5d3554 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -162,8 +162,6 @@ static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "ROUT1");
 
 	/* set endpoints to default off mode */
-	snd_soc_dapm_enable_pin(dapm, "Internal Speaker");
-	snd_soc_dapm_enable_pin(dapm, "Internal Mic");
 	snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 
 	/* Headphone jack detection */
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 682eb4f7ba0c..fc25cc00f0f2 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -89,18 +89,6 @@ static int smdk_wm8994_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	/* HeadPhone */
-	snd_soc_dapm_enable_pin(dapm, "HPOUT1R");
-	snd_soc_dapm_enable_pin(dapm, "HPOUT1L");
-
-	/* MicIn */
-	snd_soc_dapm_enable_pin(dapm, "IN1LN");
-	snd_soc_dapm_enable_pin(dapm, "IN1RN");
-
-	/* LineIn */
-	snd_soc_dapm_enable_pin(dapm, "IN2LN");
-	snd_soc_dapm_enable_pin(dapm, "IN2RN");
-
 	/* Other pins NC */
 	snd_soc_dapm_nc_pin(dapm, "HPOUT2P");
 	snd_soc_dapm_nc_pin(dapm, "HPOUT2N");
-- 
2.0.0.rc2
