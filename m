From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][DON'T PUSH][PATCH 3/3] ASoC: OMAP: Add
	multilink support to McBSP DAI driver
Date: Thu,  9 Oct 2008 15:57:22 +0300
Message-ID: <1223557042-17279-4-git-send-email-jarkko.nikula@nokia.com>
References: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 09A1824481
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 14:58:12 +0200 (CEST)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m99Cvp9E020866
	for <alsa-devel@alsa-project.org>; Thu, 9 Oct 2008 07:57:52 -0500
In-Reply-To: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   72 +++++++++++++++++++++++++------------------
 sound/soc/omap/omap-mcbsp.h |   16 ++++++---
 2 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6e4c315..0a063a9 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -437,37 +437,49 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
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
