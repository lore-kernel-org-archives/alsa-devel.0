From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/11] ASoC: Rename snd_soc_dai_driver struct
	ac97_control field to bus_control
Date: Mon, 10 Nov 2014 22:41:52 +0100
Message-ID: <1415655713-29842-11-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 960AB261AE0
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:49:07 +0100 (CET)
In-Reply-To: <1415655713-29842-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Setting the ac97_control field on a CPU DAI tells the ASoC core that this
DAI in addition to audio data also transports control data to the CODEC.
This causes the core to suspend the DAI after the CODEC and resume it before
the CODEC so communication to the CODEC is still possible. This is not
necessarily something that is specific to AC'97 and can be used by other
buses with the same requirement. This patch renames the flag from
ac97_control to bus_control to make this explicit.

While we are at it also change the type from int to bool.

The following semantich patch was used for automatic conversion of the
drivers:
// <smpl>
@@
identifier drv;
@@
struct snd_soc_dai_driver drv = {
-	.ac97_control
+	.bus_control
	=
-	1
+	true
};
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h          |  3 ++-
 sound/soc/au1x/ac97c.c           |  2 +-
 sound/soc/au1x/psc-ac97.c        |  2 +-
 sound/soc/blackfin/bf5xx-ac97.c  |  2 +-
 sound/soc/cirrus/ep93xx-ac97.c   |  2 +-
 sound/soc/fsl/fsl_ssi.c          |  2 +-
 sound/soc/fsl/imx-ssi.c          |  2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c |  4 ++--
 sound/soc/nuc900/nuc900-ac97.c   |  2 +-
 sound/soc/pxa/pxa2xx-ac97.c      |  6 +++---
 sound/soc/samsung/ac97.c         |  4 ++--
 sound/soc/sh/hac.c               |  2 +-
 sound/soc/soc-core.c             | 26 ++++++++++++++------------
 sound/soc/tegra/tegra20_ac97.c   |  2 +-
 sound/soc/txx9/txx9aclc-ac97.c   |  2 +-
 15 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index fbc55fa..2df96b1 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -206,7 +206,6 @@ struct snd_soc_dai_driver {
 	/* DAI description */
 	const char *name;
 	unsigned int id;
-	int ac97_control;
 	unsigned int base;
 
 	/* DAI driver callbacks */
@@ -216,6 +215,8 @@ struct snd_soc_dai_driver {
 	int (*resume)(struct snd_soc_dai *dai);
 	/* compress dai */
 	bool compress_dai;
+	/* DAI is also used for the control bus */
+	bool bus_control;
 
 	/* ops */
 	const struct snd_soc_dai_ops *ops;
diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index c8a2de1..5159a50 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -205,7 +205,7 @@ static int au1xac97c_dai_probe(struct snd_soc_dai *dai)
 
 static struct snd_soc_dai_driver au1xac97c_dai_driver = {
 	.name			= "alchemy-ac97c",
-	.ac97_control		= 1,
+	.bus_control		= true,
 	.probe			= au1xac97c_dai_probe,
 	.playback = {
 		.rates		= AC97_RATES,
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 84f31e1..c6daec98 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -343,7 +343,7 @@ static const struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
 };
 
 static const struct snd_soc_dai_driver au1xpsc_ac97_dai_template = {
-	.ac97_control		= 1,
+	.bus_control		= true,
 	.probe			= au1xpsc_ac97_probe,
 	.playback = {
 		.rates		= AC97_RATES,
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index e82eb37..6bf21a6 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -260,7 +260,7 @@ static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 #endif
 
 static struct snd_soc_dai_driver bfin_ac97_dai = {
-	.ac97_control = 1,
+	.bus_control = true,
 	.suspend = bf5xx_ac97_suspend,
 	.resume = bf5xx_ac97_resume,
 	.playback = {
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index f30dadf..6b8a366 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -338,7 +338,7 @@ static const struct snd_soc_dai_ops ep93xx_ac97_dai_ops = {
 static struct snd_soc_dai_driver ep93xx_ac97_dai = {
 	.name		= "ep93xx-ac97",
 	.id		= 0,
-	.ac97_control	= 1,
+	.bus_control	= true,
 	.probe		= ep93xx_ac97_dai_probe,
 	.playback	= {
 		.stream_name	= "AC97 Playback",
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e695517..7fd3cbc 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1099,7 +1099,7 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 };
 
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
-	.ac97_control = 1,
+	.bus_control = true,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index ab2fdd7..60b0a5b 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -382,7 +382,7 @@ static struct snd_soc_dai_driver imx_ssi_dai = {
 
 static struct snd_soc_dai_driver imx_ac97_dai = {
 	.probe = imx_ssi_dai_probe,
-	.ac97_control = 1,
+	.bus_control = true,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 640801a..c6ed6ba 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -237,7 +237,7 @@ static const struct snd_soc_dai_ops psc_ac97_digital_ops = {
 static struct snd_soc_dai_driver psc_ac97_dai[] = {
 {
 	.name = "mpc5200-psc-ac97.0",
-	.ac97_control = 1,
+	.bus_control = true,
 	.probe	= psc_ac97_probe,
 	.playback = {
 		.stream_name	= "AC97 Playback",
@@ -257,7 +257,7 @@ static struct snd_soc_dai_driver psc_ac97_dai[] = {
 },
 {
 	.name = "mpc5200-psc-ac97.1",
-	.ac97_control = 1,
+	.bus_control = true,
 	.playback = {
 		.stream_name	= "AC97 SPDIF",
 		.channels_min   = 1,
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index f2f6794..dff443e 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -298,7 +298,7 @@ static const struct snd_soc_dai_ops nuc900_ac97_dai_ops = {
 static struct snd_soc_dai_driver nuc900_ac97_dai = {
 	.probe			= nuc900_ac97_probe,
 	.remove			= nuc900_ac97_remove,
-	.ac97_control		= 1,
+	.bus_control		= true,
 	.playback = {
 		.rates		= SNDRV_PCM_RATE_8000_48000,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE,
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index ae956e3..73ca282 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -157,7 +157,7 @@ static const struct snd_soc_dai_ops pxa_ac97_mic_dai_ops = {
 static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 {
 	.name = "pxa2xx-ac97",
-	.ac97_control = 1,
+	.bus_control = true,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
@@ -174,7 +174,7 @@ static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 },
 {
 	.name = "pxa2xx-ac97-aux",
-	.ac97_control = 1,
+	.bus_control = true,
 	.playback = {
 		.stream_name = "AC97 Aux Playback",
 		.channels_min = 1,
@@ -191,7 +191,7 @@ static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 },
 {
 	.name = "pxa2xx-ac97-mic",
-	.ac97_control = 1,
+	.bus_control = true,
 	.capture = {
 		.stream_name = "AC97 Mic Capture",
 		.channels_min = 1,
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index e161511..7952a62 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -288,7 +288,7 @@ static int s3c_ac97_mic_dai_probe(struct snd_soc_dai *dai)
 static struct snd_soc_dai_driver s3c_ac97_dai[] = {
 	[S3C_AC97_DAI_PCM] = {
 		.name =	"samsung-ac97",
-		.ac97_control = 1,
+		.bus_control = true,
 		.playback = {
 			.stream_name = "AC97 Playback",
 			.channels_min = 2,
@@ -306,7 +306,7 @@ static struct snd_soc_dai_driver s3c_ac97_dai[] = {
 	},
 	[S3C_AC97_DAI_MIC] = {
 		.name = "samsung-ac97-mic",
-		.ac97_control = 1,
+		.bus_control = true,
 		.capture = {
 			.stream_name = "AC97 Mic Capture",
 			.channels_min = 1,
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index 0af2e4d..d5f567e 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -272,7 +272,7 @@ static const struct snd_soc_dai_ops hac_dai_ops = {
 static struct snd_soc_dai_driver sh4_hac_dai[] = {
 {
 	.name			= "hac-dai.0",
-	.ac97_control		= 1,
+	.bus_control		= true,
 	.playback = {
 		.rates		= AC97_RATES,
 		.formats	= AC97_FMTS,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e3618bc..3796c0a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -546,7 +546,7 @@ int snd_soc_suspend(struct device *dev)
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->suspend && !cpu_dai->driver->ac97_control)
+		if (cpu_dai->driver->suspend && !cpu_dai->driver->bus_control)
 			cpu_dai->driver->suspend(cpu_dai);
 	}
 
@@ -620,7 +620,7 @@ int snd_soc_suspend(struct device *dev)
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->suspend && cpu_dai->driver->ac97_control)
+		if (cpu_dai->driver->suspend && cpu_dai->driver->bus_control)
 			cpu_dai->driver->suspend(cpu_dai);
 
 		/* deactivate pins to sleep state */
@@ -656,14 +656,14 @@ static void soc_resume_deferred(struct work_struct *work)
 	if (card->resume_pre)
 		card->resume_pre(card);
 
-	/* resume AC97 DAIs */
+	/* resume control bus DAIs */
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->resume && cpu_dai->driver->ac97_control)
+		if (cpu_dai->driver->resume && cpu_dai->driver->bus_control)
 			cpu_dai->driver->resume(cpu_dai);
 	}
 
@@ -723,7 +723,7 @@ static void soc_resume_deferred(struct work_struct *work)
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->resume && !cpu_dai->driver->ac97_control)
+		if (cpu_dai->driver->resume && !cpu_dai->driver->bus_control)
 			cpu_dai->driver->resume(cpu_dai);
 	}
 
@@ -744,7 +744,8 @@ static void soc_resume_deferred(struct work_struct *work)
 int snd_soc_resume(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
-	int i, ac97_control = 0;
+	bool bus_control = false;
+	int i;
 
 	/* If the card is not initialized yet there is nothing to do */
 	if (!card->instantiated)
@@ -767,17 +768,18 @@ int snd_soc_resume(struct device *dev)
 		}
 	}
 
-	/* AC97 devices might have other drivers hanging off them so
-	 * need to resume immediately.  Other drivers don't have that
-	 * problem and may take a substantial amount of time to resume
+	/*
+	 * DAIs that also act as the control bus master might have other drivers
+	 * hanging off them so need to resume immediately. Other drivers don't
+	 * have that problem and may take a substantial amount of time to resume
 	 * due to I/O costs and anti-pop so handle them out of line.
 	 */
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		ac97_control |= cpu_dai->driver->ac97_control;
+		bus_control |= cpu_dai->driver->bus_control;
 	}
-	if (ac97_control) {
-		dev_dbg(dev, "ASoC: Resuming AC97 immediately\n");
+	if (bus_control) {
+		dev_dbg(dev, "ASoC: Resuming control bus master immediately\n");
 		soc_resume_deferred(&card->deferred_resume_work);
 	} else {
 		dev_dbg(dev, "ASoC: Scheduling resume work\n");
diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index 3b0fa12..29a9957 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -228,7 +228,7 @@ static int tegra20_ac97_probe(struct snd_soc_dai *dai)
 
 static struct snd_soc_dai_driver tegra20_ac97_dai = {
 	.name = "tegra-ac97-pcm",
-	.ac97_control = 1,
+	.bus_control = true,
 	.probe = tegra20_ac97_probe,
 	.playback = {
 		.stream_name = "PCM Playback",
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 9edd68d..f7135cd 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -152,7 +152,7 @@ static int txx9aclc_ac97_remove(struct snd_soc_dai *dai)
 }
 
 static struct snd_soc_dai_driver txx9aclc_ac97_dai = {
-	.ac97_control		= 1,
+	.bus_control		= true,
 	.probe			= txx9aclc_ac97_probe,
 	.remove			= txx9aclc_ac97_remove,
 	.playback = {
-- 
1.8.0
