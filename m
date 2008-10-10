From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: OMAP: Add multilink support to McBSP
	DAI driver
Date: Fri, 10 Oct 2008 15:52:15 +0100
Message-ID: <1223650337-15371-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081010145127.GA15329@rakim.wolfsonmicro.main>
	<1223650337-15371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43F472476C
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 16:52:36 +0200 (CEST)
In-Reply-To: <1223650337-15371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-mcbsp.c |   72 +++++++++++++++++++++++++------------------
 sound/soc/omap/omap-mcbsp.h |   16 ++++++---
 2 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index fb920e1..d32eb47 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -381,37 +381,49 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	return err;
 }
 
-struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS] = {
-{
-	.name = "omap-mcbsp-dai",
-	.id = 0,
-	.type = SND_SOC_DAI_I2S,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = OMAP_MCBSP_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = OMAP_MCBSP_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.ops = {
-		.startup = omap_mcbsp_dai_startup,
-		.shutdown = omap_mcbsp_dai_shutdown,
-		.trigger = omap_mcbsp_dai_trigger,
-		.hw_params = omap_mcbsp_dai_hw_params,
-	},
-	.dai_ops = {
-		.set_fmt = omap_mcbsp_dai_set_dai_fmt,
-		.set_clkdiv = omap_mcbsp_dai_set_clkdiv,
-		.set_sysclk = omap_mcbsp_dai_set_dai_sysclk,
-	},
-	.private_data = &mcbsp_data[0].bus_id,
-},
+#define OMAP_MCBSP_DAI_BUILDER(link_id)				\
+{								\
+	.name = "omap-mcbsp-dai-(link_id)",			\
+	.id = (link_id),					\
+	.type = SND_SOC_DAI_I2S,				\
+	.playback = {						\
+		.channels_min = 2,				\
+		.channels_max = 2,				\
+		.rates = OMAP_MCBSP_RATES,			\
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
+	},							\
+	.capture = {						\
+		.channels_min = 2,				\
+		.channels_max = 2,				\
+		.rates = OMAP_MCBSP_RATES,			\
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
+	},							\
+	.ops = {						\
+		.startup = omap_mcbsp_dai_startup,		\
+		.shutdown = omap_mcbsp_dai_shutdown,		\
+		.trigger = omap_mcbsp_dai_trigger,		\
+		.hw_params = omap_mcbsp_dai_hw_params,		\
+	},							\
+	.dai_ops = {						\
+		.set_fmt = omap_mcbsp_dai_set_dai_fmt,		\
+		.set_clkdiv = omap_mcbsp_dai_set_clkdiv,	\
+		.set_sysclk = omap_mcbsp_dai_set_dai_sysclk,	\
+	},							\
+	.private_data = &mcbsp_data[(link_id)].bus_id,		\
+}
+
+struct snd_soc_dai omap_mcbsp_dai[] = {
+	OMAP_MCBSP_DAI_BUILDER(0),
+	OMAP_MCBSP_DAI_BUILDER(1),
+#if NUM_LINKS >= 3
+	OMAP_MCBSP_DAI_BUILDER(2),
+#endif
+#if NUM_LINKS == 5
+	OMAP_MCBSP_DAI_BUILDER(3),
+	OMAP_MCBSP_DAI_BUILDER(4),
+#endif
 };
+
 EXPORT_SYMBOL_GPL(omap_mcbsp_dai);
 
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index ed8afb5..df7ad13 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -38,11 +38,17 @@ enum omap_mcbsp_div {
 	OMAP_MCBSP_CLKGDV,		/* Sample rate generator divider */
 };
 
-/*
- * REVISIT: Preparation for the ASoC v2. Let the number of available links to
- * be same than number of McBSP ports found in OMAP(s) we are compiling for.
- */
-#define NUM_LINKS	1
+#if defined(CONFIG_ARCH_OMAP2420)
+#define NUM_LINKS	2
+#endif
+#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
+#undef  NUM_LINKS
+#define NUM_LINKS	3
+#endif
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#undef  NUM_LINKS
+#define NUM_LINKS	5
+#endif
 
 extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
 
-- 
1.5.6.5
