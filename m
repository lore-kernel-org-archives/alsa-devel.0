From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Push platform registration down into
	the card
Date: Wed,  3 Dec 2008 13:24:51 +0000
Message-ID: <1228310694-6082-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081203132005.GA5943@rakim.wolfsonmicro.main>
	<1228310694-6082-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13FF71037F9
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 14:24:57 +0100 (CET)
In-Reply-To: <1228310694-6082-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

As part of the deprecation of snd_soc_device push the registration of
the platform down into the card structure.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h                  |    2 +-
 sound/soc/atmel/playpaq_wm8510.c     |    2 +-
 sound/soc/atmel/sam9g20_wm8731.c     |    2 +-
 sound/soc/blackfin/bf5xx-ad1980.c    |    2 +-
 sound/soc/blackfin/bf5xx-ad73311.c   |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c   |    2 +-
 sound/soc/davinci/davinci-evm.c      |    2 +-
 sound/soc/davinci/davinci-i2s.c      |    2 +-
 sound/soc/davinci/davinci-sffsdr.c   |    2 +-
 sound/soc/fsl/mpc8610_hpcd.c         |    2 +-
 sound/soc/fsl/soc-of-simple.c        |    2 +-
 sound/soc/omap/n810.c                |    2 +-
 sound/soc/omap/omap2evm.c            |    2 +-
 sound/soc/omap/omap3beagle.c         |    2 +-
 sound/soc/omap/osk5912.c             |    2 +-
 sound/soc/omap/overo.c               |    2 +-
 sound/soc/omap/sdp3430.c             |    2 +-
 sound/soc/pxa/corgi.c                |    2 +-
 sound/soc/pxa/e800_wm9712.c          |    2 +-
 sound/soc/pxa/em-x270.c              |    2 +-
 sound/soc/pxa/palm27x.c              |    2 +-
 sound/soc/pxa/poodle.c               |    2 +-
 sound/soc/pxa/spitz.c                |    2 +-
 sound/soc/pxa/tosa.c                 |    2 +-
 sound/soc/pxa/zylonite.c             |    2 +-
 sound/soc/s3c24xx/ln2440sbc_alc650.c |    2 +-
 sound/soc/s3c24xx/neo1973_wm8753.c   |    2 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c  |    2 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c  |    2 +-
 sound/soc/sh/sh7760-ac97.c           |    2 +-
 sound/soc/soc-core.c                 |   44 +++++++++++++++++++--------------
 31 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 359ec49..ad8141a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -352,6 +352,7 @@ struct snd_soc_card {
 
 	struct snd_soc_device *socdev;
 
+	struct snd_soc_platform *platform;
 	struct delayed_work delayed_work;
 	struct work_struct deferred_resume_work;
 };
@@ -360,7 +361,6 @@ struct snd_soc_card {
 struct snd_soc_device {
 	struct device *dev;
 	struct snd_soc_card *card;
-	struct snd_soc_platform *platform;
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_device *codec_dev;
 	void *codec_data;
diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index d40b5a5..43dd8ce 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -363,6 +363,7 @@ static struct snd_soc_dai_link playpaq_wm8510_dai = {
 
 static struct snd_soc_card snd_soc_playpaq = {
 	.name = "LRS_PlayPaq_WM8510",
+	.platform = &at32_soc_platform,
 	.dai_link = &playpaq_wm8510_dai,
 	.num_links = 1,
 };
@@ -378,7 +379,6 @@ static struct wm8510_setup_data playpaq_wm8510_setup = {
 
 static struct snd_soc_device playpaq_wm8510_snd_devdata = {
 	.card = &snd_soc_playpaq,
-	.platform = &at32_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8510,
 	.codec_data = &playpaq_wm8510_setup,
 };
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index fdc1d02..1fb59a9 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -244,6 +244,7 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
 
 static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.name = "WM8731",
+	.platform = &atmel_soc_platform,
 	.dai_link = &at91sam9g20ek_dai,
 	.num_links = 1,
 };
@@ -255,7 +256,6 @@ static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
 
 static struct snd_soc_device at91sam9g20ek_snd_devdata = {
 	.card = &snd_soc_at91sam9g20ek,
-	.platform = &atmel_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
 	.codec_data = &at91sam9g20ek_wm8731_setup,
 };
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index 36c569a..d8f5912 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -69,13 +69,13 @@ static struct snd_soc_dai_link bf5xx_board_dai = {
 
 static struct snd_soc_card bf5xx_board = {
 	.name = "bf5xx-board",
+	.platform = &bf5xx_ac97_soc_platform,
 	.dai_link = &bf5xx_board_dai,
 	.num_links = 1,
 };
 
 static struct snd_soc_device bf5xx_board_snd_devdata = {
 	.card = &bf5xx_board,
-	.platform = &bf5xx_ac97_soc_platform,
 	.codec_dev = &soc_codec_dev_ad1980,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 57da147..7f2a5e1 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -192,6 +192,7 @@ static struct snd_soc_dai_link bf5xx_ad73311_dai = {
 
 static struct snd_soc_card bf5xx_ad73311 = {
 	.name = "bf5xx_ad73311",
+	.platform = &bf5xx_i2s_soc_platform,
 	.probe = bf5xx_probe,
 	.dai_link = &bf5xx_ad73311_dai,
 	.num_links = 1,
@@ -199,7 +200,6 @@ static struct snd_soc_card bf5xx_ad73311 = {
 
 static struct snd_soc_device bf5xx_ad73311_snd_devdata = {
 	.card = &bf5xx_ad73311,
-	.platform = &bf5xx_i2s_soc_platform,
 	.codec_dev = &soc_codec_dev_ad73311,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 0078dfc..bc0cdde 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -137,13 +137,13 @@ static struct ssm2602_setup_data bf5xx_ssm2602_setup = {
 
 static struct snd_soc_card bf5xx_ssm2602 = {
 	.name = "bf5xx_ssm2602",
+	.platform = &bf5xx_i2s_soc_platform,
 	.dai_link = &bf5xx_ssm2602_dai,
 	.num_links = 1,
 };
 
 static struct snd_soc_device bf5xx_ssm2602_snd_devdata = {
 	.card = &bf5xx_ssm2602,
-	.platform = &bf5xx_i2s_soc_platform,
 	.codec_dev = &soc_codec_dev_ssm2602,
 	.codec_data = &bf5xx_ssm2602_setup,
 };
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 2ce34d4..d87b911 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -130,6 +130,7 @@ static struct snd_soc_dai_link evm_dai = {
 /* davinci-evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
+	.platform = &davinci_soc_platform,
 	.dai_link = &evm_dai,
 	.num_links = 1,
 };
@@ -143,7 +144,6 @@ static struct aic3x_setup_data evm_aic3x_setup = {
 /* evm audio subsystem */
 static struct snd_soc_device evm_snd_devdata = {
 	.card = &snd_soc_card_evm,
-	.platform = &davinci_soc_platform,
 	.codec_dev = &soc_codec_dev_aic3x,
 	.codec_data = &evm_aic3x_setup,
 };
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index cf31b3b..8b99efb 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -112,7 +112,7 @@ static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = socdev->card->platform;
 	u32 w;
 	int ret;
 
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index e95fde1..f67579d 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -76,6 +76,7 @@ static struct snd_soc_dai_link sffsdr_dai = {
 /* davinci-sffsdr audio machine driver */
 static struct snd_soc_card snd_soc_sffsdr = {
 	.name = "DaVinci SFFSDR",
+	.platform = &davinci_soc_platform,
 	.dai_link = &sffsdr_dai,
 	.num_links = 1,
 };
@@ -91,7 +92,6 @@ static struct pcm3008_setup_data sffsdr_pcm3008_setup = {
 /* sffsdr audio subsystem */
 static struct snd_soc_device sffsdr_snd_devdata = {
 	.card = &snd_soc_sffsdr,
-	.platform = &davinci_soc_platform,
 	.codec_dev = &soc_codec_dev_pcm3008,
 	.codec_data = &sffsdr_pcm3008_setup,
 };
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 1cf4d6e..bcec3f6 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -467,7 +467,7 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 
 	machine_data->sound_devdata.card = &mpc8610_hpcd_machine;
 	machine_data->sound_devdata.codec_dev = &soc_codec_device_cs4270;
-	machine_data->sound_devdata.platform = &fsl_soc_platform;
+	machine_data->machine.platform = &fsl_soc_platform;
 
 	sound_device->dev.platform_data = machine_data;
 
diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
index 53be649..8bc5cd9 100644
--- a/sound/soc/fsl/soc-of-simple.c
+++ b/sound/soc/fsl/soc-of-simple.c
@@ -158,7 +158,7 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
 
 	of_soc->platform_node = node;
 	of_soc->dai_link.cpu_dai = cpu_dai;
-	of_soc->device.platform = platform;
+	of_soc->card.platform = platform;
 	of_soc->card.name = of_soc->dai_link.cpu_dai->name;
 
 	/* Now try to register the SoC device */
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 18e2062..25593fe 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -288,6 +288,7 @@ static struct snd_soc_dai_link n810_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_n810 = {
 	.name = "N810",
+	.platform = &omap_soc_platform,
 	.dai_link = &n810_dai,
 	.num_links = 1,
 };
@@ -303,7 +304,6 @@ static struct aic3x_setup_data n810_aic33_setup = {
 /* Audio subsystem */
 static struct snd_soc_device n810_snd_devdata = {
 	.card = &snd_soc_n810,
-	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_aic3x,
 	.codec_data = &n810_aic33_setup,
 };
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
index 7b160f9..0c2322d 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -93,6 +93,7 @@ static struct snd_soc_dai_link omap2evm_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_omap2evm = {
 	.name = "omap2evm",
+	.platform = &omap_soc_platform,
 	.dai_link = &omap2evm_dai,
 	.num_links = 1,
 };
@@ -100,7 +101,6 @@ static struct snd_soc_card snd_soc_omap2evm = {
 /* Audio subsystem */
 static struct snd_soc_device omap2evm_snd_devdata = {
 	.card = &snd_soc_omap2evm,
-	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_twl4030,
 };
 
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index 3ed2546..fd24a4a 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -90,6 +90,7 @@ static struct snd_soc_dai_link omap3beagle_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_omap3beagle = {
 	.name = "omap3beagle",
+	.platform = &omap_soc_platform,
 	.dai_link = &omap3beagle_dai,
 	.num_links = 1,
 };
@@ -97,7 +98,6 @@ static struct snd_soc_card snd_soc_omap3beagle = {
 /* Audio subsystem */
 static struct snd_soc_device omap3beagle_snd_devdata = {
 	.card = &snd_soc_omap3beagle,
-	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_twl4030,
 };
 
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index 7a8f14d..845bf41 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -145,6 +145,7 @@ static struct snd_soc_dai_link osk_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_card_osk = {
 	.name = "OSK5912",
+	.platform = &omap_soc_platform,
 	.dai_link = &osk_dai,
 	.num_links = 1,
 };
@@ -152,7 +153,6 @@ static struct snd_soc_card snd_soc_card_osk = {
 /* Audio subsystem */
 static struct snd_soc_device osk_snd_devdata = {
 	.card = &snd_soc_card_osk,
-	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_tlv320aic23,
 };
 
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index eea0c37..a72dc4e 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -90,6 +90,7 @@ static struct snd_soc_dai_link overo_dai = {
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_card_overo = {
 	.name = "overo",
+	.platform = &omap_soc_platform,
 	.dai_link = &overo_dai,
 	.num_links = 1,
 };
@@ -97,7 +98,6 @@ static struct snd_soc_card snd_soc_card_overo = {
 /* Audio subsystem */
 static struct snd_soc_device overo_snd_devdata = {
 	.card = &snd_soc_card_overo,
-	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_twl4030,
 };
 
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 85fd160..ad97836 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -93,6 +93,7 @@ static struct snd_soc_dai_link sdp3430_dai = {
 /* Audio machine driver */
 static struct snd_soc_machine snd_soc_machine_sdp3430 = {
 	.name = "SDP3430",
+	.platform = &omap_soc_platform,
 	.dai_link = &sdp3430_dai,
 	.num_links = 1,
 };
@@ -100,7 +101,6 @@ static struct snd_soc_machine snd_soc_machine_sdp3430 = {
 /* Audio subsystem */
 static struct snd_soc_device sdp3430_snd_devdata = {
 	.machine = &snd_soc_machine_sdp3430,
-	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_twl4030,
 };
 
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index e56bf4b..1ba25a5 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -312,6 +312,7 @@ static struct snd_soc_dai_link corgi_dai = {
 /* corgi audio machine driver */
 static struct snd_soc_card snd_soc_corgi = {
 	.name = "Corgi",
+	.platform = &pxa2xx_soc_platform,
 	.dai_link = &corgi_dai,
 	.num_links = 1,
 };
@@ -325,7 +326,6 @@ static struct wm8731_setup_data corgi_wm8731_setup = {
 /* corgi audio subsystem */
 static struct snd_soc_device corgi_snd_devdata = {
 	.card = &snd_soc_corgi,
-	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
 	.codec_data = &corgi_wm8731_setup,
 };
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 60c6486..2e3386d 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -42,13 +42,13 @@ static struct snd_soc_dai_link e800_dai[] = {
 
 static struct snd_soc_card e800 = {
 	.name = "Toshiba e800",
+	.platform = &pxa2xx_soc_platform,
 	.dai_link = e800_dai,
 	.num_links = ARRAY_SIZE(e800_dai),
 };
 
 static struct snd_soc_device e800_snd_devdata = {
 	.card = &e800,
-	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9712,
 };
 
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index d6884b7..fe4a729 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -54,13 +54,13 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 
 static struct snd_soc_card em_x270 = {
 	.name = "EM-X270",
+	.platform = &pxa2xx_soc_platform,
 	.dai_link = em_x270_dai,
 	.num_links = ARRAY_SIZE(em_x270_dai),
 };
 
 static struct snd_soc_device em_x270_snd_devdata = {
 	.card = &em_x270,
-	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9712,
 };
 
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 3bb8879..4a9cf30 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -191,13 +191,13 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 
 static struct snd_soc_card palm27x_asoc = {
 	.name = "Palm/PXA27x",
+	.platform = &pxa2xx_soc_platform,
 	.dai_link = palm27x_dai,
 	.num_links = ARRAY_SIZE(palm27x_dai),
 };
 
 static struct snd_soc_device palm27x_snd_devdata = {
 	.card = &palm27x_asoc,
-	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9712,
 };
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 03b510a..6e98271 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -278,6 +278,7 @@ static struct snd_soc_dai_link poodle_dai = {
 /* poodle audio machine driver */
 static struct snd_soc_card snd_soc_poodle = {
 	.name = "Poodle",
+	.platform = &pxa2xx_soc_platform,
 	.dai_link = &poodle_dai,
 	.num_links = 1,
 };
@@ -291,7 +292,6 @@ static struct wm8731_setup_data poodle_wm8731_setup = {
 /* poodle audio subsystem */
 static struct snd_soc_device poodle_snd_devdata = {
 	.card = &snd_soc_poodle,
-	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
 	.codec_data = &poodle_wm8731_setup,
 };
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 579d933..a3b9e6b 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -321,6 +321,7 @@ static struct snd_soc_dai_link spitz_dai = {
 /* spitz audio machine driver */
 static struct snd_soc_card snd_soc_spitz = {
 	.name = "Spitz",
+	.platform = &pxa2xx_soc_platform,
 	.dai_link = &spitz_dai,
 	.num_links = 1,
 };
@@ -334,7 +335,6 @@ static struct wm8750_setup_data spitz_wm8750_setup = {
 /* spitz audio subsystem */
 static struct snd_soc_device spitz_snd_devdata = {
 	.card = &snd_soc_spitz,
-	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8750,
 	.codec_data = &spitz_wm8750_setup,
 };
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 48242b3..c77194f 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -252,6 +252,7 @@ static int tosa_remove(struct platform_device *dev)
 
 static struct snd_soc_card tosa = {
 	.name = "Tosa",
+	.platform = &pxa2xx_soc_platform,
 	.dai_link = tosa_dai,
 	.num_links = ARRAY_SIZE(tosa_dai),
 	.probe = tosa_probe,
@@ -260,7 +261,6 @@ static struct snd_soc_card tosa = {
 
 static struct snd_soc_device tosa_snd_devdata = {
 	.card = &tosa,
-	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9712,
 };
 
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 842d650..f8e9ecd 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -175,13 +175,13 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 
 static struct snd_soc_card zylonite = {
 	.name = "Zylonite",
+	.platform = &pxa2xx_soc_platform,
 	.dai_link = zylonite_dai,
 	.num_links = ARRAY_SIZE(zylonite_dai),
 };
 
 static struct snd_soc_device zylonite_snd_ac97_devdata = {
 	.card = &zylonite,
-	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9713,
 };
 
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index a70cbc0..12c7148 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -40,13 +40,13 @@ static struct snd_soc_dai_link ln2440sbc_dai[] = {
 
 static struct snd_soc_card ln2440sbc = {
 	.name = "LN2440SBC",
+	.platform = &s3c24xx_soc_platform,
 	.dai_link = ln2440sbc_dai,
 	.num_links = ARRAY_SIZE(ln2440sbc_dai),
 };
 
 static struct snd_soc_device ln2440sbc_snd_ac97_devdata = {
 	.card = &ln2440sbc,
-	.platform = &s3c24xx_soc_platform,
 	.codec_dev = &soc_codec_dev_ac97,
 };
 
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 3df2224..45bb12e 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -580,6 +580,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 
 static struct snd_soc_card neo1973 = {
 	.name = "neo1973",
+	.platform = &s3c24xx_soc_platform,
 	.dai_link = neo1973_dai,
 	.num_links = ARRAY_SIZE(neo1973_dai),
 };
@@ -591,7 +592,6 @@ static struct wm8753_setup_data neo1973_wm8753_setup = {
 
 static struct snd_soc_device neo1973_snd_devdata = {
 	.card = &neo1973,
-	.platform = &s3c24xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8753,
 	.codec_data = &neo1973_wm8753_setup,
 };
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 23325fc..a0a4d18 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -234,6 +234,7 @@ static struct snd_soc_dai_link s3c24xx_uda134x_dai_link = {
 
 static struct snd_soc_card snd_soc_s3c24xx_uda134x = {
 	.name = "S3C24XX_UDA134X",
+	.platform = &s3c24xx_soc_platform,
 	.dai_link = &s3c24xx_uda134x_dai_link,
 	.num_links = 1,
 };
@@ -271,7 +272,6 @@ static struct uda134x_platform_data s3c24xx_uda134x = {
 
 static struct snd_soc_device s3c24xx_uda134x_snd_devdata = {
 	.card = &snd_soc_s3c24xx_uda134x,
-	.platform = &s3c24xx_soc_platform,
 	.codec_dev = &soc_codec_dev_uda134x,
 	.codec_data = &s3c24xx_uda134x,
 };
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 3d2e6a0..a2a4f53 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -36,13 +36,13 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
 
 static struct snd_soc_card smdk2443 = {
 	.name = "SMDK2443",
+	.platform = &s3c24xx_soc_platform,
 	.dai_link = smdk2443_dai,
 	.num_links = ARRAY_SIZE(smdk2443_dai),
 };
 
 static struct snd_soc_device smdk2443_snd_ac97_devdata = {
 	.card = &smdk2443,
-	.platform = &s3c24xx_soc_platform,
 	.codec_dev = &soc_codec_dev_ac97,
 };
 
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index 8b44f9c..ce7f95b 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -40,13 +40,13 @@ static struct snd_soc_dai_link sh7760_ac97_dai = {
 
 static struct snd_soc_card sh7760_ac97_soc_machine  = {
 	.name = "SH7760 AC97",
+	.platform = &sh7760_soc_platform,
 	.dai_link = &sh7760_ac97_dai,
 	.num_links = 1,
 };
 
 static struct snd_soc_device sh7760_ac97_snd_devdata = {
 	.card = &sh7760_ac97_soc_machine,
-	.platform = &sh7760_soc_platform,
 	.codec_dev = &soc_codec_dev_ac97,
 };
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c4b22e6..fe89260 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -109,9 +109,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_card *card = socdev->card;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
 	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	int ret = 0;
@@ -302,7 +303,7 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
 	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	struct snd_soc_codec *codec = socdev->codec;
@@ -370,7 +371,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
 	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	struct snd_soc_codec *codec = socdev->codec;
@@ -464,7 +465,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
 	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	int ret = 0;
@@ -534,7 +536,8 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
 	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	struct snd_soc_codec *codec = socdev->codec;
@@ -568,8 +571,9 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_card *card= socdev->card;
 	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
 	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	int ret;
@@ -610,7 +614,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 	struct snd_soc_codec *codec = socdev->codec;
 	int i;
@@ -686,7 +690,7 @@ static void soc_resume_deferred(struct work_struct *work)
 						 struct snd_soc_card,
 						 deferred_resume_work);
 	struct snd_soc_device *socdev = card->socdev;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct platform_device *pdev = to_platform_device(socdev->dev);
@@ -770,7 +774,7 @@ static int soc_probe(struct platform_device *pdev)
 	int ret = 0, i;
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 
 	/* Bodge while we push things out of socdev */
@@ -835,7 +839,7 @@ static int soc_remove(struct platform_device *pdev)
 	int i;
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 
 	run_delayed_work(&card->delayed_work);
@@ -875,6 +879,8 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	struct snd_soc_dai_link *dai_link, int num)
 {
 	struct snd_soc_codec *codec = socdev->codec;
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_dai *codec_dai = dai_link->codec_dai;
 	struct snd_soc_dai *cpu_dai = dai_link->cpu_dai;
 	struct snd_soc_pcm_runtime *rtd;
@@ -910,13 +916,13 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 
 	dai_link->pcm = pcm;
 	pcm->private_data = rtd;
-	soc_pcm_ops.mmap = socdev->platform->pcm_ops->mmap;
-	soc_pcm_ops.pointer = socdev->platform->pcm_ops->pointer;
-	soc_pcm_ops.ioctl = socdev->platform->pcm_ops->ioctl;
-	soc_pcm_ops.copy = socdev->platform->pcm_ops->copy;
-	soc_pcm_ops.silence = socdev->platform->pcm_ops->silence;
-	soc_pcm_ops.ack = socdev->platform->pcm_ops->ack;
-	soc_pcm_ops.page = socdev->platform->pcm_ops->page;
+	soc_pcm_ops.mmap = platform->pcm_ops->mmap;
+	soc_pcm_ops.pointer = platform->pcm_ops->pointer;
+	soc_pcm_ops.ioctl = platform->pcm_ops->ioctl;
+	soc_pcm_ops.copy = platform->pcm_ops->copy;
+	soc_pcm_ops.silence = platform->pcm_ops->silence;
+	soc_pcm_ops.ack = platform->pcm_ops->ack;
+	soc_pcm_ops.page = platform->pcm_ops->page;
 
 	if (playback)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
@@ -924,14 +930,14 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	if (capture)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
 
-	ret = socdev->platform->pcm_new(codec->card, codec_dai, pcm);
+	ret = platform->pcm_new(codec->card, codec_dai, pcm);
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: platform pcm constructor failed\n");
 		kfree(rtd);
 		return ret;
 	}
 
-	pcm->private_free = socdev->platform->pcm_free;
+	pcm->private_free = platform->pcm_free;
 	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
 		cpu_dai->name);
 	return ret;
-- 
1.5.6.5
