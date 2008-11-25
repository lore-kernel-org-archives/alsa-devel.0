From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/13] ASoC: Remove DAI type information
Date: Tue, 25 Nov 2008 15:44:42 +0000
Message-ID: <1227627889-8373-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CE61244A1
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:53 +0100 (CET)
In-Reply-To: <1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

DAI type information is only ever used within ASoC in order to special
case AC97 and for diagnostic purposes. Since modern CPUs and codecs
support multi function DAIs which can be configured for several modes
it is more trouble than it's worth to maintain anything other than a
flag identifying AC97 DAIs so remove the type field and replace it with
an ac97_control flag.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h            |    2 +-
 include/sound/soc.h                |    8 --------
 sound/soc/atmel/atmel_ssc_dai.c    |    3 ---
 sound/soc/au1x/psc-ac97.c          |    2 +-
 sound/soc/au1x/psc-i2s.c           |    1 -
 sound/soc/blackfin/bf5xx-ac97.c    |    2 +-
 sound/soc/blackfin/bf5xx-i2s.c     |    1 -
 sound/soc/codecs/ac97.c            |    2 +-
 sound/soc/codecs/pcm3008.c         |    1 -
 sound/soc/codecs/wm9712.c          |    2 +-
 sound/soc/codecs/wm9713.c          |    2 +-
 sound/soc/davinci/davinci-i2s.c    |    1 -
 sound/soc/fsl/mpc5200_psc_i2s.c    |    1 -
 sound/soc/omap/omap-mcbsp.c        |    1 -
 sound/soc/pxa/pxa-ssp.c            |    4 ----
 sound/soc/pxa/pxa2xx-ac97.c        |    6 +++---
 sound/soc/pxa/pxa2xx-i2s.c         |    1 -
 sound/soc/s3c24xx/neo1973_wm8753.c |    1 -
 sound/soc/s3c24xx/s3c2412-i2s.c    |    1 -
 sound/soc/s3c24xx/s3c2443-ac97.c   |    4 ++--
 sound/soc/s3c24xx/s3c24xx-i2s.c    |    1 -
 sound/soc/sh/hac.c                 |    4 ++--
 sound/soc/sh/ssi.c                 |    2 --
 sound/soc/soc-core.c               |   31 ++++++++-----------------------
 24 files changed, 21 insertions(+), 63 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index f51cb55..a01a24b 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -184,7 +184,7 @@ struct snd_soc_dai {
 	/* DAI description */
 	char *name;
 	unsigned int id;
-	unsigned char type;
+	int ac97_control;
 
 	/* DAI callbacks */
 	int (*probe)(struct platform_device *pdev,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index e4465f7..444f9c2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -143,14 +143,6 @@ enum snd_soc_bias_level {
 	SND_SOC_BIAS_OFF,
 };
 
-/*
- * Digital Audio Interface (DAI) types
- */
-#define SND_SOC_DAI_AC97	0x1
-#define SND_SOC_DAI_I2S		0x2
-#define SND_SOC_DAI_PCM		0x4
-#define SND_SOC_DAI_AC97_BUS	0x8	/* for custom i.e. non ac97_codec.c */
-
 struct snd_soc_device;
 struct snd_soc_pcm_stream;
 struct snd_soc_ops;
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 916f73b..0bb18df 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -702,7 +702,6 @@ static int atmel_ssc_resume(struct platform_device *pdev,
 struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 	{	.name = "atmel-ssc0",
 		.id = 0,
-		.type = SND_SOC_DAI_PCM,
 		.suspend = atmel_ssc_suspend,
 		.resume = atmel_ssc_resume,
 		.playback = {
@@ -727,7 +726,6 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 #if NUM_SSC_DEVICES == 3
 	{	.name = "atmel-ssc1",
 		.id = 1,
-		.type = SND_SOC_DAI_PCM,
 		.suspend = atmel_ssc_suspend,
 		.resume = atmel_ssc_resume,
 		.playback = {
@@ -751,7 +749,6 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 	},
 	{	.name = "atmel-ssc2",
 		.id = 2,
-		.type = SND_SOC_DAI_PCM,
 		.suspend = atmel_ssc_suspend,
 		.resume = atmel_ssc_resume,
 		.playback = {
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index ad60a60..a0bcfea 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -346,7 +346,7 @@ static int au1xpsc_ac97_resume(struct platform_device *pdev,
 
 struct snd_soc_dai au1xpsc_ac97_dai = {
 	.name			= "au1xpsc_ac97",
-	.type			= SND_SOC_DAI_AC97,
+	.ac97_control		= 1,
 	.probe			= au1xpsc_ac97_probe,
 	.remove			= au1xpsc_ac97_remove,
 	.suspend		= au1xpsc_ac97_suspend,
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 05a5acb..f4217e7 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -371,7 +371,6 @@ static int au1xpsc_i2s_resume(struct platform_device *pdev,
 
 struct snd_soc_dai au1xpsc_i2s_dai = {
 	.name			= "au1xpsc_i2s",
-	.type			= SND_SOC_DAI_I2S,
 	.probe			= au1xpsc_i2s_probe,
 	.remove			= au1xpsc_i2s_remove,
 	.suspend		= au1xpsc_i2s_suspend,
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 5dcd3f6..709bdf0 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -409,7 +409,7 @@ static void bf5xx_ac97_remove(struct platform_device *pdev,
 struct snd_soc_dai bfin_ac97_dai = {
 	.name = "bf5xx-ac97",
 	.id = 0,
-	.type = SND_SOC_DAI_AC97,
+	.ac97_control = 1,
 	.probe = bf5xx_ac97_probe,
 	.remove = bf5xx_ac97_remove,
 	.suspend = bf5xx_ac97_suspend,
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 4e675b5..6e5036b 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -292,7 +292,6 @@ static int bf5xx_i2s_resume(struct platform_device *pdev,
 struct snd_soc_dai bf5xx_i2s_dai = {
 	.name = "bf5xx-i2s",
 	.id = 0,
-	.type = SND_SOC_DAI_I2S,
 	.probe = bf5xx_i2s_probe,
 	.remove = bf5xx_i2s_remove,
 	.suspend = bf5xx_i2s_suspend,
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 8a93aff..c4208c8 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -43,7 +43,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 
 struct snd_soc_dai ac97_dai = {
 	.name = "AC97 HiFi",
-	.type = SND_SOC_DAI_AC97,
+	.ac97_control = 1,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 1,
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 2b26e1d..651a15e 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -33,7 +33,6 @@
 
 struct snd_soc_dai pcm3008_dai = {
 	.name = "PCM3008 HiFi",
-	.type = SND_SOC_DAI_I2S,
 	.playback = {
 		.stream_name = "PCM3008 Playback",
 		.channels_min = 1,
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 6e3e0f3..40f1406 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -535,7 +535,7 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 struct snd_soc_dai wm9712_dai[] = {
 {
 	.name = "AC97 HiFi",
-	.type = SND_SOC_DAI_AC97_BUS,
+	.ac97_control = 1,
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index a502667..9dad0bf 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1024,7 +1024,7 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 struct snd_soc_dai wm9713_dai[] = {
 {
 	.name = "AC97 HiFi",
-	.type = SND_SOC_DAI_AC97_BUS,
+	.ac97_control = 1,
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 7a17cd0..cf31b3b 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -460,7 +460,6 @@ static void davinci_i2s_remove(struct platform_device *pdev,
 struct snd_soc_dai davinci_i2s_dai = {
 	.name = "davinci-i2s",
 	.id = 0,
-	.type = SND_SOC_DAI_I2S,
 	.probe = davinci_i2s_probe,
 	.remove = davinci_i2s_remove,
 	.playback = {
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index e2c172f..9ad8f9a 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -469,7 +469,6 @@ static int psc_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
  * psc_i2s_dai_template: template CPU Digital Audio Interface
  */
 static struct snd_soc_dai psc_i2s_dai_template = {
-	.type = SND_SOC_DAI_I2S,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 2eeb135..252bc7e 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -456,7 +456,6 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 {								\
 	.name = "omap-mcbsp-dai-"#link_id,			\
 	.id = (link_id),					\
-	.type = SND_SOC_DAI_I2S,				\
 	.playback = {						\
 		.channels_min = 2,				\
 		.channels_max = 2,				\
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index d0dd624..402fc5b 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -788,7 +788,6 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 	{
 		.name = "pxa2xx-ssp1",
 		.id = 0,
-		.type = SND_SOC_DAI_PCM,
 		.probe = pxa_ssp_probe,
 		.remove = pxa_ssp_remove,
 		.suspend = pxa_ssp_suspend,
@@ -820,7 +819,6 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 	},
 	{	.name = "pxa2xx-ssp2",
 		.id = 1,
-		.type = SND_SOC_DAI_PCM,
 		.probe = pxa_ssp_probe,
 		.remove = pxa_ssp_remove,
 		.suspend = pxa_ssp_suspend,
@@ -853,7 +851,6 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 	{
 		.name = "pxa2xx-ssp3",
 		.id = 2,
-		.type = SND_SOC_DAI_PCM,
 		.probe = pxa_ssp_probe,
 		.remove = pxa_ssp_remove,
 		.suspend = pxa_ssp_suspend,
@@ -886,7 +883,6 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 	{
 		.name = "pxa2xx-ssp4",
 		.id = 3,
-		.type = SND_SOC_DAI_PCM,
 		.probe = pxa_ssp_probe,
 		.remove = pxa_ssp_remove,
 		.suspend = pxa_ssp_suspend,
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 86667d2..bffbe28 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -173,7 +173,7 @@ struct snd_soc_dai pxa_ac97_dai[] = {
 {
 	.name = "pxa2xx-ac97",
 	.id = 0,
-	.type = SND_SOC_DAI_AC97,
+	.ac97_control = 1,
 	.probe = pxa2xx_ac97_probe,
 	.remove = pxa2xx_ac97_remove,
 	.suspend = pxa2xx_ac97_suspend,
@@ -196,7 +196,7 @@ struct snd_soc_dai pxa_ac97_dai[] = {
 {
 	.name = "pxa2xx-ac97-aux",
 	.id = 1,
-	.type = SND_SOC_DAI_AC97,
+	.ac97_control = 1,
 	.playback = {
 		.stream_name = "AC97 Aux Playback",
 		.channels_min = 1,
@@ -215,7 +215,7 @@ struct snd_soc_dai pxa_ac97_dai[] = {
 {
 	.name = "pxa2xx-ac97-mic",
 	.id = 2,
-	.type = SND_SOC_DAI_AC97,
+	.ac97_control = 1,
 	.capture = {
 		.stream_name = "AC97 Mic Capture",
 		.channels_min = 1,
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 9a3e55b..f9a9e2e 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -340,7 +340,6 @@ static int pxa2xx_i2s_resume(struct platform_device *pdev,
 struct snd_soc_dai pxa_i2s_dai = {
 	.name = "pxa2xx-i2s",
 	.id = 0,
-	.type = SND_SOC_DAI_I2S,
 	.suspend = pxa2xx_i2s_suspend,
 	.resume = pxa2xx_i2s_resume,
 	.playback = {
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 528fc3f..3df2224 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -548,7 +548,6 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai bt_dai = {
 	.name = "Bluetooth",
 	.id = 0,
-	.type = SND_SOC_DAI_PCM,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 1,
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 360cc2a..1c74104 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -713,7 +713,6 @@ static int s3c2412_i2s_resume(struct platform_device *pdev,
 struct snd_soc_dai s3c2412_i2s_dai = {
 	.name	= "s3c2412-i2s",
 	.id	= 0,
-	.type	= SND_SOC_DAI_I2S,
 	.probe	= s3c2412_i2s_probe,
 	.suspend = s3c2412_i2s_suspend,
 	.resume = s3c2412_i2s_resume,
diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
index 3137782..41bde6a 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -358,7 +358,7 @@ struct snd_soc_dai s3c2443_ac97_dai[] = {
 {
 	.name = "s3c2443-ac97",
 	.id = 0,
-	.type = SND_SOC_DAI_AC97,
+	.ac97_control = 1,
 	.probe = s3c2443_ac97_probe,
 	.remove = s3c2443_ac97_remove,
 	.playback = {
@@ -380,7 +380,7 @@ struct snd_soc_dai s3c2443_ac97_dai[] = {
 {
 	.name = "pxa2xx-ac97-mic",
 	.id = 1,
-	.type = SND_SOC_DAI_AC97,
+	.ac97_control = 1,
 	.capture = {
 		.stream_name = "AC97 Mic Capture",
 		.channels_min = 1,
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 1bac9dd..8d9135f 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -461,7 +461,6 @@ static int s3c24xx_i2s_resume(struct platform_device *pdev,
 struct snd_soc_dai s3c24xx_i2s_dai = {
 	.name = "s3c24xx-i2s",
 	.id = 0,
-	.type = SND_SOC_DAI_I2S,
 	.probe = s3c24xx_i2s_probe,
 	.suspend = s3c24xx_i2s_suspend,
 	.resume = s3c24xx_i2s_resume,
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index 3318071..c435913 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -271,7 +271,7 @@ struct snd_soc_dai sh4_hac_dai[] = {
 {
 	.name			= "HAC0",
 	.id			= 0,
-	.type			= SND_SOC_DAI_AC97,
+	.ac97_control		= 1,
 	.playback = {
 		.rates		= AC97_RATES,
 		.formats	= AC97_FMTS,
@@ -291,8 +291,8 @@ struct snd_soc_dai sh4_hac_dai[] = {
 #ifdef CONFIG_CPU_SUBTYPE_SH7760
 {
 	.name			= "HAC1",
+	.ac97_control		= 1,
 	.id			= 1,
-	.type			= SND_SOC_DAI_AC97,
 	.playback = {
 		.rates		= AC97_RATES,
 		.formats	= AC97_FMTS,
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 52a2338..fed544a 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -340,7 +340,6 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 {
 	.name			= "SSI0",
 	.id			= 0,
-	.type			= SND_SOC_DAI_I2S,
 	.playback = {
 		.rates		= SSI_RATES,
 		.formats	= SSI_FMTS,
@@ -367,7 +366,6 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 {
 	.name			= "SSI1",
 	.id			= 1,
-	.type			= SND_SOC_DAI_I2S,
 	.playback = {
 		.rates		= SSI_RATES,
 		.formats	= SSI_FMTS,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 43f4060..0d47696 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -100,20 +100,6 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 }
 #endif
 
-static inline const char *get_dai_name(int type)
-{
-	switch (type) {
-	case SND_SOC_DAI_AC97_BUS:
-	case SND_SOC_DAI_AC97:
-		return "AC97";
-	case SND_SOC_DAI_I2S:
-		return "I2S";
-	case SND_SOC_DAI_PCM:
-		return "PCM";
-	}
-	return NULL;
-}
-
 /*
  * Called by ALSA when a PCM substream is opened, the runtime->hw record is
  * then initialized and any private data can be allocated. This also calls
@@ -652,7 +638,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai  *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->suspend && cpu_dai->type != SND_SOC_DAI_AC97)
+		if (cpu_dai->suspend && !cpu_dai->ac97_control)
 			cpu_dai->suspend(pdev, cpu_dai);
 		if (platform->suspend)
 			platform->suspend(pdev, cpu_dai);
@@ -678,7 +664,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->suspend && cpu_dai->type == SND_SOC_DAI_AC97)
+		if (cpu_dai->suspend && cpu_dai->ac97_control)
 			cpu_dai->suspend(pdev, cpu_dai);
 	}
 
@@ -714,7 +700,7 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->resume && cpu_dai->type == SND_SOC_DAI_AC97)
+		if (cpu_dai->resume && cpu_dai->ac97_control)
 			cpu_dai->resume(pdev, cpu_dai);
 	}
 
@@ -741,7 +727,7 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->resume && cpu_dai->type != SND_SOC_DAI_AC97)
+		if (cpu_dai->resume && !cpu_dai->ac97_control)
 			cpu_dai->resume(pdev, cpu_dai);
 		if (platform->resume)
 			platform->resume(pdev, cpu_dai);
@@ -898,8 +884,8 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	codec_dai->codec = socdev->codec;
 
 	/* check client and interface hw capabilities */
-	sprintf(new_name, "%s %s-%s-%d", dai_link->stream_name, codec_dai->name,
-		get_dai_name(cpu_dai->type), num);
+	sprintf(new_name, "%s %s-%d", dai_link->stream_name, codec_dai->name,
+		num);
 
 	if (codec_dai->playback.channels_min)
 		playback = 1;
@@ -1270,8 +1256,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 				continue;
 			}
 		}
-		if (card->dai_link[i].codec_dai->type ==
-			SND_SOC_DAI_AC97_BUS)
+		if (card->dai_link[i].codec_dai->ac97_control)
 			ac97 = 1;
 	}
 	snprintf(codec->card->shortname, sizeof(codec->card->shortname),
@@ -1335,7 +1320,7 @@ void snd_soc_free_pcms(struct snd_soc_device *socdev)
 #ifdef CONFIG_SND_SOC_AC97_BUS
 	for (i = 0; i < codec->num_dai; i++) {
 		codec_dai = &codec->dai[i];
-		if (codec_dai->type == SND_SOC_DAI_AC97_BUS && codec->ac97) {
+		if (codec_dai->ac97_control && codec->ac97) {
 			soc_ac97_dev_unregister(codec);
 			goto free_card;
 		}
-- 
1.5.6.5
