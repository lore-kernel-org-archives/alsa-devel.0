From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/10] ASoC: Rename snd_soc_card to
	snd_soc_machine
Date: Fri, 21 Nov 2008 14:48:24 +0000
Message-ID: <1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E67C2244E3
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:48:35 +0100 (CET)
In-Reply-To: <20081121144734.GA25238@rakim.wolfsonmicro.main>
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

One of the issues with the ASoC v1 API which has been addressed in the
ASoC v2 work that Liam Girdwood has done is that the ALSA card provided
by ASoC is distributed around the ASoC structures. For example, machine
wide data such as the struct snd_card are maintained as part of the
CODEC data structure, preventing the use of multiple codecs. This has
been addressed by refactoring the data structures so that all the data
for the ALSA card is contained in a single structure snd_soc_card which
replaces the existing snd_soc_machine and snd_soc_device.

Begin the process of backporting this by renaming struct snd_soc_machine
to struct snd_soc_card, better reflecting its function and bringing it
closer to standard ALSA terminology.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/sound/alsa/soc/machine.txt |    8 +-
 include/sound/soc.h                      |    8 +-
 sound/soc/atmel/playpaq_wm8510.c         |    4 +-
 sound/soc/atmel/sam9g20_wm8731.c         |    4 +-
 sound/soc/au1x/sample-ac97.c             |    4 +-
 sound/soc/blackfin/bf5xx-ad1980.c        |    6 +-
 sound/soc/blackfin/bf5xx-ad73311.c       |    6 +-
 sound/soc/blackfin/bf5xx-ssm2602.c       |    6 +-
 sound/soc/davinci/davinci-evm.c          |    4 +-
 sound/soc/davinci/davinci-i2s.c          |    8 +-
 sound/soc/davinci/davinci-sffsdr.c       |    4 +-
 sound/soc/fsl/fsl_dma.c                  |    2 +-
 sound/soc/fsl/mpc8610_hpcd.c             |    6 +-
 sound/soc/fsl/soc-of-simple.c            |   10 ++--
 sound/soc/omap/n810.c                    |    4 +-
 sound/soc/omap/omap2evm.c                |    4 +-
 sound/soc/omap/omap3beagle.c             |    4 +-
 sound/soc/omap/osk5912.c                 |    4 +-
 sound/soc/omap/overo.c                   |    4 +-
 sound/soc/pxa/corgi.c                    |    4 +-
 sound/soc/pxa/e800_wm9712.c              |    6 +-
 sound/soc/pxa/em-x270.c                  |    4 +-
 sound/soc/pxa/palm27x.c                  |    4 +-
 sound/soc/pxa/poodle.c                   |    4 +-
 sound/soc/pxa/spitz.c                    |    4 +-
 sound/soc/pxa/tosa.c                     |    6 +-
 sound/soc/s3c24xx/ln2440sbc_alc650.c     |    6 +-
 sound/soc/s3c24xx/neo1973_wm8753.c       |    6 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c      |    4 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c      |    6 +-
 sound/soc/sh/sh7760-ac97.c               |    4 +-
 sound/soc/soc-core.c                     |   90 +++++++++++++++---------------
 sound/soc/soc-dapm.c                     |    6 +-
 33 files changed, 127 insertions(+), 127 deletions(-)

diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/alsa/soc/machine.txt
index f370e7d..4a9f51e 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/alsa/soc/machine.txt
@@ -9,7 +9,7 @@ the audio subsystem with the kernel as a platform device and is represented by
 the following struct:-
 
 /* SoC machine */
-struct snd_soc_machine {
+struct snd_soc_card {_
 	char *name;
 
 	int (*probe)(struct platform_device *pdev);
@@ -67,10 +67,10 @@ static struct snd_soc_dai_link corgi_dai = {
 	.ops = &corgi_ops,
 };
 
-struct snd_soc_machine then sets up the machine with it's DAIs. e.g.
+struct snd_soc_card then sets up the machine with it's DAIs. e.g.
 
 /* corgi audio machine driver */
-static struct snd_soc_machine snd_soc_machine_corgi = {
+static struct snd_soc_card snd_soc_corgi = {
 	.name = "Corgi",
 	.dai_link = &corgi_dai,
 	.num_links = 1,
@@ -90,7 +90,7 @@ static struct wm8731_setup_data corgi_wm8731_setup = {
 
 /* corgi audio subsystem */
 static struct snd_soc_device corgi_snd_devdata = {
-	.machine = &snd_soc_machine_corgi,
+	.machine = &snd_soc_corgi,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
 	.codec_data = &corgi_wm8731_setup,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 077dfe4..3be17b3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -482,8 +482,8 @@ struct snd_soc_dai_link  {
 	struct snd_pcm *pcm;
 };
 
-/* SoC machine */
-struct snd_soc_machine {
+/* SoC card */
+struct snd_soc_card {
 	char *name;
 
 	int (*probe)(struct platform_device *pdev);
@@ -497,7 +497,7 @@ struct snd_soc_machine {
 	int (*resume_post)(struct platform_device *pdev);
 
 	/* callbacks */
-	int (*set_bias_level)(struct snd_soc_machine *,
+	int (*set_bias_level)(struct snd_soc_card *,
 			      enum snd_soc_bias_level level);
 
 	/* CPU <--> Codec DAI links  */
@@ -508,7 +508,7 @@ struct snd_soc_machine {
 /* SoC Device - the audio subsystem */
 struct snd_soc_device {
 	struct device *dev;
-	struct snd_soc_machine *machine;
+	struct snd_soc_card *card;
 	struct snd_soc_platform *platform;
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_device *codec_dev;
diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index ea7935d..d40b5a5 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -361,7 +361,7 @@ static struct snd_soc_dai_link playpaq_wm8510_dai = {
 
 
 
-static struct snd_soc_machine snd_soc_machine_playpaq = {
+static struct snd_soc_card snd_soc_playpaq = {
 	.name = "LRS_PlayPaq_WM8510",
 	.dai_link = &playpaq_wm8510_dai,
 	.num_links = 1,
@@ -377,7 +377,7 @@ static struct wm8510_setup_data playpaq_wm8510_setup = {
 
 
 static struct snd_soc_device playpaq_wm8510_snd_devdata = {
-	.machine = &snd_soc_machine_playpaq,
+	.card = &snd_soc_playpaq,
 	.platform = &at32_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8510,
 	.codec_data = &playpaq_wm8510_setup,
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 710addc..fdc1d02 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -242,7 +242,7 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.ops = &at91sam9g20ek_ops,
 };
 
-static struct snd_soc_machine snd_soc_machine_at91sam9g20ek = {
+static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.name = "WM8731",
 	.dai_link = &at91sam9g20ek_dai,
 	.num_links = 1,
@@ -254,7 +254,7 @@ static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
 };
 
 static struct snd_soc_device at91sam9g20ek_snd_devdata = {
-	.machine = &snd_soc_machine_at91sam9g20ek,
+	.card = &snd_soc_at91sam9g20ek,
 	.platform = &atmel_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
 	.codec_data = &at91sam9g20ek_wm8731_setup,
diff --git a/sound/soc/au1x/sample-ac97.c b/sound/soc/au1x/sample-ac97.c
index f75ae7f..27683eb 100644
--- a/sound/soc/au1x/sample-ac97.c
+++ b/sound/soc/au1x/sample-ac97.c
@@ -42,14 +42,14 @@ static struct snd_soc_dai_link au1xpsc_sample_ac97_dai = {
 	.ops		= NULL,
 };
 
-static struct snd_soc_machine au1xpsc_sample_ac97_machine = {
+static struct snd_soc_card au1xpsc_sample_ac97_machine = {
 	.name		= "Au1xxx PSC AC97 Audio",
 	.dai_link	= &au1xpsc_sample_ac97_dai,
 	.num_links	= 1,
 };
 
 static struct snd_soc_device au1xpsc_sample_ac97_devdata = {
-	.machine	= &au1xpsc_sample_ac97_machine,
+	.card		= &au1xpsc_sample_ac97_machine,
 	.platform	= &au1xpsc_soc_platform, /* see dbdma2.c */
 	.codec_dev	= &soc_codec_dev_ac97,
 };
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index 124425d..36c569a 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -43,7 +43,7 @@
 #include "bf5xx-ac97-pcm.h"
 #include "bf5xx-ac97.h"
 
-static struct snd_soc_machine bf5xx_board;
+static struct snd_soc_card bf5xx_board;
 
 static int bf5xx_board_startup(struct snd_pcm_substream *substream)
 {
@@ -67,14 +67,14 @@ static struct snd_soc_dai_link bf5xx_board_dai = {
 	.ops = &bf5xx_board_ops,
 };
 
-static struct snd_soc_machine bf5xx_board = {
+static struct snd_soc_card bf5xx_board = {
 	.name = "bf5xx-board",
 	.dai_link = &bf5xx_board_dai,
 	.num_links = 1,
 };
 
 static struct snd_soc_device bf5xx_board_snd_devdata = {
-	.machine = &bf5xx_board,
+	.card = &bf5xx_board,
 	.platform = &bf5xx_ac97_soc_platform,
 	.codec_dev = &soc_codec_dev_ad1980,
 };
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 47da49b..57da147 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -65,7 +65,7 @@
 
 #define GPIO_SE CONFIG_SND_BFIN_AD73311_SE
 
-static struct snd_soc_machine bf5xx_ad73311;
+static struct snd_soc_card bf5xx_ad73311;
 
 static int snd_ad73311_startup(void)
 {
@@ -190,7 +190,7 @@ static struct snd_soc_dai_link bf5xx_ad73311_dai = {
 	.ops = &bf5xx_ad73311_ops,
 };
 
-static struct snd_soc_machine bf5xx_ad73311 = {
+static struct snd_soc_card bf5xx_ad73311 = {
 	.name = "bf5xx_ad73311",
 	.probe = bf5xx_probe,
 	.dai_link = &bf5xx_ad73311_dai,
@@ -198,7 +198,7 @@ static struct snd_soc_machine bf5xx_ad73311 = {
 };
 
 static struct snd_soc_device bf5xx_ad73311_snd_devdata = {
-	.machine = &bf5xx_ad73311,
+	.card = &bf5xx_ad73311,
 	.platform = &bf5xx_i2s_soc_platform,
 	.codec_dev = &soc_codec_dev_ad73311,
 };
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 744a90e..0078dfc 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -44,7 +44,7 @@
 #include "bf5xx-i2s-pcm.h"
 #include "bf5xx-i2s.h"
 
-static struct snd_soc_machine bf5xx_ssm2602;
+static struct snd_soc_card bf5xx_ssm2602;
 
 static int bf5xx_ssm2602_startup(struct snd_pcm_substream *substream)
 {
@@ -135,14 +135,14 @@ static struct ssm2602_setup_data bf5xx_ssm2602_setup = {
 	.i2c_address = 0x1b,
 };
 
-static struct snd_soc_machine bf5xx_ssm2602 = {
+static struct snd_soc_card bf5xx_ssm2602 = {
 	.name = "bf5xx_ssm2602",
 	.dai_link = &bf5xx_ssm2602_dai,
 	.num_links = 1,
 };
 
 static struct snd_soc_device bf5xx_ssm2602_snd_devdata = {
-	.machine = &bf5xx_ssm2602,
+	.card = &bf5xx_ssm2602,
 	.platform = &bf5xx_i2s_soc_platform,
 	.codec_dev = &soc_codec_dev_ssm2602,
 	.codec_data = &bf5xx_ssm2602_setup,
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 9e6062c..2ce34d4 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -128,7 +128,7 @@ static struct snd_soc_dai_link evm_dai = {
 };
 
 /* davinci-evm audio machine driver */
-static struct snd_soc_machine snd_soc_machine_evm = {
+static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
 	.dai_link = &evm_dai,
 	.num_links = 1,
@@ -142,7 +142,7 @@ static struct aic3x_setup_data evm_aic3x_setup = {
 
 /* evm audio subsystem */
 static struct snd_soc_device evm_snd_devdata = {
-	.machine = &snd_soc_machine_evm,
+	.card = &snd_soc_card_evm,
 	.platform = &davinci_soc_platform,
 	.codec_dev = &soc_codec_dev_aic3x,
 	.codec_data = &evm_aic3x_setup,
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 11c20d0..95df51e 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -375,8 +375,8 @@ static int davinci_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_machine *machine = socdev->machine;
-	struct snd_soc_dai *cpu_dai = machine->dai_link[pdev->id].cpu_dai;
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_dai *cpu_dai = card->dai_link[pdev->id].cpu_dai;
 	struct davinci_mcbsp_dev *dev;
 	struct resource *mem, *ioarea;
 	struct evm_snd_platform_data *pdata;
@@ -437,8 +437,8 @@ static void davinci_i2s_remove(struct platform_device *pdev,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_machine *machine = socdev->machine;
-	struct snd_soc_dai *cpu_dai = machine->dai_link[pdev->id].cpu_dai;
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_dai *cpu_dai = card->dai_link[pdev->id].cpu_dai;
 	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
 	struct resource *mem;
 
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 69a8a76..fa38f9c 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -73,7 +73,7 @@ static struct snd_soc_dai_link sffsdr_dai = {
 };
 
 /* davinci-sffsdr audio machine driver */
-static struct snd_soc_machine snd_soc_machine_sffsdr = {
+static struct snd_soc_card snd_soc_sffsdr = {
 	.name = "DaVinci SFFSDR",
 	.dai_link = &sffsdr_dai,
 	.num_links = 1,
@@ -89,7 +89,7 @@ static struct pcm3008_setup_data sffsdr_pcm3008_setup = {
 
 /* sffsdr audio subsystem */
 static struct snd_soc_device sffsdr_snd_devdata = {
-	.machine = &snd_soc_machine_sffsdr,
+	.card = &snd_soc_sffsdr,
 	.platform = &davinci_soc_platform,
 	.codec_dev = &soc_codec_dev_pcm3008,
 	.codec_data = &sffsdr_pcm3008_setup,
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index d2d3da9..bf92331 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -284,7 +284,7 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
  * fsl_dma_new: initialize this PCM driver.
  *
  * This function is called when the codec driver calls snd_soc_new_pcms(),
- * once for each .dai_link in the machine driver's snd_soc_machine
+ * once for each .dai_link in the machine driver's snd_soc_card
  * structure.
  */
 static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 94f89de..1cf4d6e 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -29,7 +29,7 @@
 struct mpc8610_hpcd_data {
 	struct snd_soc_device sound_devdata;
 	struct snd_soc_dai_link dai;
-	struct snd_soc_machine machine;
+	struct snd_soc_card machine;
 	unsigned int dai_format;
 	unsigned int codec_clk_direction;
 	unsigned int cpu_clk_direction;
@@ -185,7 +185,7 @@ static struct snd_soc_ops mpc8610_hpcd_ops = {
 /**
  * mpc8610_hpcd_machine: ASoC machine data
  */
-static struct snd_soc_machine mpc8610_hpcd_machine = {
+static struct snd_soc_card mpc8610_hpcd_machine = {
 	.probe = mpc8610_hpcd_machine_probe,
 	.remove = mpc8610_hpcd_machine_remove,
 	.name = "MPC8610 HPCD",
@@ -465,7 +465,7 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 		goto error;
 	}
 
-	machine_data->sound_devdata.machine = &mpc8610_hpcd_machine;
+	machine_data->sound_devdata.card = &mpc8610_hpcd_machine;
 	machine_data->sound_devdata.codec_dev = &soc_codec_device_cs4270;
 	machine_data->sound_devdata.platform = &fsl_soc_platform;
 
diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
index 0382fda..53be649 100644
--- a/sound/soc/fsl/soc-of-simple.c
+++ b/sound/soc/fsl/soc-of-simple.c
@@ -31,7 +31,7 @@ struct of_snd_soc_device {
 	int id;
 	struct list_head list;
 	struct snd_soc_device device;
-	struct snd_soc_machine machine;
+	struct snd_soc_card card;
 	struct snd_soc_dai_link dai_link;
 	struct platform_device *pdev;
 	struct device_node *platform_node;
@@ -58,9 +58,9 @@ of_snd_soc_get_device(struct device_node *codec_node)
 	/* Initialize the structure and add it to the global list */
 	of_soc->codec_node = codec_node;
 	of_soc->id = of_snd_soc_next_index++;
-	of_soc->machine.dai_link = &of_soc->dai_link;
-	of_soc->machine.num_links = 1;
-	of_soc->device.machine = &of_soc->machine;
+	of_soc->card.dai_link = &of_soc->dai_link;
+	of_soc->card.num_links = 1;
+	of_soc->device.card = &of_soc->card;
 	of_soc->dai_link.ops = &of_snd_soc_ops;
 	list_add(&of_soc->list, &of_snd_soc_device_list);
 
@@ -159,7 +159,7 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
 	of_soc->platform_node = node;
 	of_soc->dai_link.cpu_dai = cpu_dai;
 	of_soc->device.platform = platform;
-	of_soc->machine.name = of_soc->dai_link.cpu_dai->name;
+	of_soc->card.name = of_soc->dai_link.cpu_dai->name;
 
 	/* Now try to register the SoC device */
 	of_snd_soc_register_device(of_soc);
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index fae3ad3..d216b4f 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -282,7 +282,7 @@ static struct snd_soc_dai_link n810_dai = {
 };
 
 /* Audio machine driver */
-static struct snd_soc_machine snd_soc_machine_n810 = {
+static struct snd_soc_card snd_soc_n810 = {
 	.name = "N810",
 	.dai_link = &n810_dai,
 	.num_links = 1,
@@ -298,7 +298,7 @@ static struct aic3x_setup_data n810_aic33_setup = {
 
 /* Audio subsystem */
 static struct snd_soc_device n810_snd_devdata = {
-	.machine = &snd_soc_machine_n810,
+	.card = &snd_soc_n810,
 	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_aic3x,
 	.codec_data = &n810_aic33_setup,
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
index c376213..5bea311 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -90,7 +90,7 @@ static struct snd_soc_dai_link omap2evm_dai = {
 };
 
 /* Audio machine driver */
-static struct snd_soc_machine snd_soc_machine_omap2evm = {
+static struct snd_soc_card snd_soc_omap2evm = {
 	.name = "omap2evm",
 	.dai_link = &omap2evm_dai,
 	.num_links = 1,
@@ -98,7 +98,7 @@ static struct snd_soc_machine snd_soc_machine_omap2evm = {
 
 /* Audio subsystem */
 static struct snd_soc_device omap2evm_snd_devdata = {
-	.machine = &snd_soc_machine_omap2evm,
+	.card = &snd_soc_omap2evm,
 	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_twl4030,
 };
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index ec84a9b..3ed2546 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -88,7 +88,7 @@ static struct snd_soc_dai_link omap3beagle_dai = {
 };
 
 /* Audio machine driver */
-static struct snd_soc_machine snd_soc_machine_omap3beagle = {
+static struct snd_soc_card snd_soc_omap3beagle = {
 	.name = "omap3beagle",
 	.dai_link = &omap3beagle_dai,
 	.num_links = 1,
@@ -96,7 +96,7 @@ static struct snd_soc_machine snd_soc_machine_omap3beagle = {
 
 /* Audio subsystem */
 static struct snd_soc_device omap3beagle_snd_devdata = {
-	.machine = &snd_soc_machine_omap3beagle,
+	.card = &snd_soc_omap3beagle,
 	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_twl4030,
 };
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index 0fe7337..7a8f14d 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -143,7 +143,7 @@ static struct snd_soc_dai_link osk_dai = {
 };
 
 /* Audio machine driver */
-static struct snd_soc_machine snd_soc_machine_osk = {
+static struct snd_soc_card snd_soc_card_osk = {
 	.name = "OSK5912",
 	.dai_link = &osk_dai,
 	.num_links = 1,
@@ -151,7 +151,7 @@ static struct snd_soc_machine snd_soc_machine_osk = {
 
 /* Audio subsystem */
 static struct snd_soc_device osk_snd_devdata = {
-	.machine = &snd_soc_machine_osk,
+	.card = &snd_soc_card_osk,
 	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_tlv320aic23,
 };
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index c26d1de..eea0c37 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -88,7 +88,7 @@ static struct snd_soc_dai_link overo_dai = {
 };
 
 /* Audio machine driver */
-static struct snd_soc_machine snd_soc_machine_overo = {
+static struct snd_soc_card snd_soc_card_overo = {
 	.name = "overo",
 	.dai_link = &overo_dai,
 	.num_links = 1,
@@ -96,7 +96,7 @@ static struct snd_soc_machine snd_soc_machine_overo = {
 
 /* Audio subsystem */
 static struct snd_soc_device overo_snd_devdata = {
-	.machine = &snd_soc_machine_overo,
+	.card = &snd_soc_card_overo,
 	.platform = &omap_soc_platform,
 	.codec_dev = &soc_codec_dev_twl4030,
 };
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 2718eaf..647f056 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -314,7 +314,7 @@ static struct snd_soc_dai_link corgi_dai = {
 };
 
 /* corgi audio machine driver */
-static struct snd_soc_machine snd_soc_machine_corgi = {
+static struct snd_soc_card snd_soc_corgi = {
 	.name = "Corgi",
 	.dai_link = &corgi_dai,
 	.num_links = 1,
@@ -328,7 +328,7 @@ static struct wm8731_setup_data corgi_wm8731_setup = {
 
 /* corgi audio subsystem */
 static struct snd_soc_device corgi_snd_devdata = {
-	.machine = &snd_soc_machine_corgi,
+	.card = &snd_soc_corgi,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
 	.codec_data = &corgi_wm8731_setup,
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 6781c5b..60c6486 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -29,7 +29,7 @@
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"
 
-static struct snd_soc_machine e800;
+static struct snd_soc_card e800;
 
 static struct snd_soc_dai_link e800_dai[] = {
 {
@@ -40,14 +40,14 @@ static struct snd_soc_dai_link e800_dai[] = {
 },
 };
 
-static struct snd_soc_machine e800 = {
+static struct snd_soc_card e800 = {
 	.name = "Toshiba e800",
 	.dai_link = e800_dai,
 	.num_links = ARRAY_SIZE(e800_dai),
 };
 
 static struct snd_soc_device e800_snd_devdata = {
-	.machine = &e800,
+	.card = &e800,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9712,
 };
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index e6ff692..4a61925 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -53,14 +53,14 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 	},
 };
 
-static struct snd_soc_machine em_x270 = {
+static struct snd_soc_card em_x270 = {
 	.name = "EM-X270",
 	.dai_link = em_x270_dai,
 	.num_links = ARRAY_SIZE(em_x270_dai),
 };
 
 static struct snd_soc_device em_x270_snd_devdata = {
-	.machine = &em_x270,
+	.card = &em_x270,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9712,
 };
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index e364abc..3bb8879 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -189,14 +189,14 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 },
 };
 
-static struct snd_soc_machine palm27x_asoc = {
+static struct snd_soc_card palm27x_asoc = {
 	.name = "Palm/PXA27x",
 	.dai_link = palm27x_dai,
 	.num_links = ARRAY_SIZE(palm27x_dai),
 };
 
 static struct snd_soc_device palm27x_snd_devdata = {
-	.machine = &palm27x_asoc,
+	.card = &palm27x_asoc,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9712,
 };
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 4d9930c..03b510a 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -276,7 +276,7 @@ static struct snd_soc_dai_link poodle_dai = {
 };
 
 /* poodle audio machine driver */
-static struct snd_soc_machine snd_soc_machine_poodle = {
+static struct snd_soc_card snd_soc_poodle = {
 	.name = "Poodle",
 	.dai_link = &poodle_dai,
 	.num_links = 1,
@@ -290,7 +290,7 @@ static struct wm8731_setup_data poodle_wm8731_setup = {
 
 /* poodle audio subsystem */
 static struct snd_soc_device poodle_snd_devdata = {
-	.machine = &snd_soc_machine_poodle,
+	.card = &snd_soc_poodle,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
 	.codec_data = &poodle_wm8731_setup,
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index d307b67..579d933 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -319,7 +319,7 @@ static struct snd_soc_dai_link spitz_dai = {
 };
 
 /* spitz audio machine driver */
-static struct snd_soc_machine snd_soc_machine_spitz = {
+static struct snd_soc_card snd_soc_spitz = {
 	.name = "Spitz",
 	.dai_link = &spitz_dai,
 	.num_links = 1,
@@ -333,7 +333,7 @@ static struct wm8750_setup_data spitz_wm8750_setup = {
 
 /* spitz audio subsystem */
 static struct snd_soc_device spitz_snd_devdata = {
-	.machine = &snd_soc_machine_spitz,
+	.card = &snd_soc_spitz,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8750,
 	.codec_data = &spitz_wm8750_setup,
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index afefe41..9d9be5a 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -38,7 +38,7 @@
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"
 
-static struct snd_soc_machine tosa;
+static struct snd_soc_card tosa;
 
 #define TOSA_HP        0
 #define TOSA_MIC_INT   1
@@ -230,14 +230,14 @@ static struct snd_soc_dai_link tosa_dai[] = {
 },
 };
 
-static struct snd_soc_machine tosa = {
+static struct snd_soc_card tosa = {
 	.name = "Tosa",
 	.dai_link = tosa_dai,
 	.num_links = ARRAY_SIZE(tosa_dai),
 };
 
 static struct snd_soc_device tosa_snd_devdata = {
-	.machine = &tosa,
+	.card = &tosa,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm9712,
 };
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index 4eab2c1..a70cbc0 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -27,7 +27,7 @@
 #include "s3c24xx-pcm.h"
 #include "s3c24xx-ac97.h"
 
-static struct snd_soc_machine ln2440sbc;
+static struct snd_soc_card ln2440sbc;
 
 static struct snd_soc_dai_link ln2440sbc_dai[] = {
 {
@@ -38,14 +38,14 @@ static struct snd_soc_dai_link ln2440sbc_dai[] = {
 },
 };
 
-static struct snd_soc_machine ln2440sbc = {
+static struct snd_soc_card ln2440sbc = {
 	.name = "LN2440SBC",
 	.dai_link = ln2440sbc_dai,
 	.num_links = ARRAY_SIZE(ln2440sbc_dai),
 };
 
 static struct snd_soc_device ln2440sbc_snd_ac97_devdata = {
-	.machine = &ln2440sbc,
+	.card = &ln2440sbc,
 	.platform = &s3c24xx_soc_platform,
 	.codec_dev = &soc_codec_dev_ac97,
 };
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 87ddfef..528fc3f 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -59,7 +59,7 @@
 #define NEO_CAPTURE_HEADSET		7
 #define NEO_CAPTURE_BLUETOOTH		8
 
-static struct snd_soc_machine neo1973;
+static struct snd_soc_card neo1973;
 static struct i2c_client *i2c;
 
 static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
@@ -579,7 +579,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 },
 };
 
-static struct snd_soc_machine neo1973 = {
+static struct snd_soc_card neo1973 = {
 	.name = "neo1973",
 	.dai_link = neo1973_dai,
 	.num_links = ARRAY_SIZE(neo1973_dai),
@@ -591,7 +591,7 @@ static struct wm8753_setup_data neo1973_wm8753_setup = {
 };
 
 static struct snd_soc_device neo1973_snd_devdata = {
-	.machine = &neo1973,
+	.card = &neo1973,
 	.platform = &s3c24xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8753,
 	.codec_data = &neo1973_wm8753_setup,
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 92d90f2..23325fc 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -232,7 +232,7 @@ static struct snd_soc_dai_link s3c24xx_uda134x_dai_link = {
 	.ops = &s3c24xx_uda134x_ops,
 };
 
-static struct snd_soc_machine snd_soc_machine_s3c24xx_uda134x = {
+static struct snd_soc_card snd_soc_s3c24xx_uda134x = {
 	.name = "S3C24XX_UDA134X",
 	.dai_link = &s3c24xx_uda134x_dai_link,
 	.num_links = 1,
@@ -270,7 +270,7 @@ static struct uda134x_platform_data s3c24xx_uda134x = {
 };
 
 static struct snd_soc_device s3c24xx_uda134x_snd_devdata = {
-	.machine = &snd_soc_machine_s3c24xx_uda134x,
+	.card = &snd_soc_s3c24xx_uda134x,
 	.platform = &s3c24xx_soc_platform,
 	.codec_dev = &soc_codec_dev_uda134x,
 	.codec_data = &s3c24xx_uda134x,
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 8515d6f..3d2e6a0 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -23,7 +23,7 @@
 #include "s3c24xx-pcm.h"
 #include "s3c24xx-ac97.h"
 
-static struct snd_soc_machine smdk2443;
+static struct snd_soc_card smdk2443;
 
 static struct snd_soc_dai_link smdk2443_dai[] = {
 {
@@ -34,14 +34,14 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
 },
 };
 
-static struct snd_soc_machine smdk2443 = {
+static struct snd_soc_card smdk2443 = {
 	.name = "SMDK2443",
 	.dai_link = smdk2443_dai,
 	.num_links = ARRAY_SIZE(smdk2443_dai),
 };
 
 static struct snd_soc_device smdk2443_snd_ac97_devdata = {
-	.machine = &smdk2443,
+	.card = &smdk2443,
 	.platform = &s3c24xx_soc_platform,
 	.codec_dev = &soc_codec_dev_ac97,
 };
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index 92bfaf4..8b44f9c 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -38,14 +38,14 @@ static struct snd_soc_dai_link sh7760_ac97_dai = {
 	.ops = NULL,
 };
 
-static struct snd_soc_machine sh7760_ac97_soc_machine  = {
+static struct snd_soc_card sh7760_ac97_soc_machine  = {
 	.name = "SH7760 AC97",
 	.dai_link = &sh7760_ac97_dai,
 	.num_links = 1,
 };
 
 static struct snd_soc_device sh7760_ac97_snd_devdata = {
-	.machine = &sh7760_ac97_soc_machine,
+	.card = &sh7760_ac97_soc_machine,
 	.platform = &sh7760_soc_platform,
 	.codec_dev = &soc_codec_dev_ac97,
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9feaa7b..c5cb951 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -620,7 +620,7 @@ static struct snd_pcm_ops soc_pcm_ops = {
 static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 	struct snd_soc_codec *codec = socdev->codec;
@@ -644,14 +644,14 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	}
 
 	/* suspend all pcms */
-	for (i = 0; i < machine->num_links; i++)
-		snd_pcm_suspend_all(machine->dai_link[i].pcm);
+	for (i = 0; i < card->num_links; i++)
+		snd_pcm_suspend_all(card->dai_link[i].pcm);
 
-	if (machine->suspend_pre)
-		machine->suspend_pre(pdev, state);
+	if (card->suspend_pre)
+		card->suspend_pre(pdev, state);
 
-	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_dai  *cpu_dai = machine->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai  *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->suspend && cpu_dai->type != SND_SOC_DAI_AC97)
 			cpu_dai->suspend(pdev, cpu_dai);
 		if (platform->suspend)
@@ -676,14 +676,14 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	if (codec_dev->suspend)
 		codec_dev->suspend(pdev, state);
 
-	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->suspend && cpu_dai->type == SND_SOC_DAI_AC97)
 			cpu_dai->suspend(pdev, cpu_dai);
 	}
 
-	if (machine->suspend_post)
-		machine->suspend_post(pdev, state);
+	if (card->suspend_post)
+		card->suspend_post(pdev, state);
 
 	return 0;
 }
@@ -696,7 +696,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	struct snd_soc_device *socdev = container_of(work,
 						     struct snd_soc_device,
 						     deferred_resume_work);
-	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 	struct snd_soc_codec *codec = socdev->codec;
@@ -709,11 +709,11 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	dev_info(socdev->dev, "starting resume work\n");
 
-	if (machine->resume_pre)
-		machine->resume_pre(pdev);
+	if (card->resume_pre)
+		card->resume_pre(pdev);
 
-	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->resume && cpu_dai->type == SND_SOC_DAI_AC97)
 			cpu_dai->resume(pdev, cpu_dai);
 	}
@@ -739,16 +739,16 @@ static void soc_resume_deferred(struct work_struct *work)
 			dai->dai_ops.digital_mute(dai, 0);
 	}
 
-	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->resume && cpu_dai->type != SND_SOC_DAI_AC97)
 			cpu_dai->resume(pdev, cpu_dai);
 		if (platform->resume)
 			platform->resume(pdev, cpu_dai);
 	}
 
-	if (machine->resume_post)
-		machine->resume_post(pdev);
+	if (card->resume_post)
+		card->resume_post(pdev);
 
 	dev_info(socdev->dev, "resume work completed\n");
 
@@ -779,18 +779,18 @@ static int soc_probe(struct platform_device *pdev)
 {
 	int ret = 0, i;
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 
-	if (machine->probe) {
-		ret = machine->probe(pdev);
+	if (card->probe) {
+		ret = card->probe(pdev);
 		if (ret < 0)
 			return ret;
 	}
 
-	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->probe) {
 			ret = cpu_dai->probe(pdev, cpu_dai);
 			if (ret < 0)
@@ -825,13 +825,13 @@ platform_err:
 
 cpu_dai_err:
 	for (i--; i >= 0; i--) {
-		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->remove)
 			cpu_dai->remove(pdev, cpu_dai);
 	}
 
-	if (machine->remove)
-		machine->remove(pdev);
+	if (card->remove)
+		card->remove(pdev);
 
 	return ret;
 }
@@ -841,7 +841,7 @@ static int soc_remove(struct platform_device *pdev)
 {
 	int i;
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 
@@ -853,14 +853,14 @@ static int soc_remove(struct platform_device *pdev)
 	if (codec_dev->remove)
 		codec_dev->remove(pdev);
 
-	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->remove)
 			cpu_dai->remove(pdev, cpu_dai);
 	}
 
-	if (machine->remove)
-		machine->remove(pdev);
+	if (card->remove)
+		card->remove(pdev);
 
 	return 0;
 }
@@ -1212,7 +1212,7 @@ EXPORT_SYMBOL_GPL(snd_soc_test_bits);
 int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
 {
 	struct snd_soc_codec *codec = socdev->codec;
-	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_card *card = socdev->card;
 	int ret = 0, i;
 
 	mutex_lock(&codec->mutex);
@@ -1231,11 +1231,11 @@ int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
 	strncpy(codec->card->driver, codec->name, sizeof(codec->card->driver));
 
 	/* create the pcms */
-	for (i = 0; i < machine->num_links; i++) {
-		ret = soc_new_pcm(socdev, &machine->dai_link[i], i);
+	for (i = 0; i < card->num_links; i++) {
+		ret = soc_new_pcm(socdev, &card->dai_link[i], i);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't create pcm %s\n",
-				machine->dai_link[i].stream_name);
+				card->dai_link[i].stream_name);
 			mutex_unlock(&codec->mutex);
 			return ret;
 		}
@@ -1258,26 +1258,26 @@ EXPORT_SYMBOL_GPL(snd_soc_new_pcms);
 int snd_soc_register_card(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->codec;
-	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_card *card = socdev->card;
 	int ret = 0, i, ac97 = 0, err = 0;
 
-	for (i = 0; i < machine->num_links; i++) {
-		if (socdev->machine->dai_link[i].init) {
-			err = socdev->machine->dai_link[i].init(codec);
+	for (i = 0; i < card->num_links; i++) {
+		if (card->dai_link[i].init) {
+			err = card->dai_link[i].init(codec);
 			if (err < 0) {
 				printk(KERN_ERR "asoc: failed to init %s\n",
-					socdev->machine->dai_link[i].stream_name);
+					card->dai_link[i].stream_name);
 				continue;
 			}
 		}
-		if (socdev->machine->dai_link[i].codec_dai->type ==
+		if (card->dai_link[i].codec_dai->type ==
 			SND_SOC_DAI_AC97_BUS)
 			ac97 = 1;
 	}
 	snprintf(codec->card->shortname, sizeof(codec->card->shortname),
-		 "%s", machine->name);
+		 "%s",  card->name);
 	snprintf(codec->card->longname, sizeof(codec->card->longname),
-		 "%s (%s)", machine->name, codec->name);
+		 "%s (%s)", card->name, codec->name);
 
 	ret = snd_card_register(codec->card);
 	if (ret < 0) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0fecbb4..61d7d85 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1402,11 +1402,11 @@ int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
 				enum snd_soc_bias_level level)
 {
 	struct snd_soc_codec *codec = socdev->codec;
-	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_card *card = socdev->card;
 	int ret = 0;
 
-	if (machine->set_bias_level)
-		ret = machine->set_bias_level(machine, level);
+	if (card->set_bias_level)
+		ret = card->set_bias_level(card, level);
 	if (ret == 0 && codec->set_bias_level)
 		ret = codec->set_bias_level(codec, level);
 
-- 
1.5.6.5
