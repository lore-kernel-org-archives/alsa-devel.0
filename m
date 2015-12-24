From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v3] ASoC: fsl_asrc: sound is wrong after
	suspend/resume
Date: Thu, 24 Dec 2015 11:42:11 +0800
Message-ID: <5b07db93fb5a848216a9035c827d99185250d89d.1450928293.git.zidan.wang@freescale.com>
References: <fd32d943839609d46ca4523e316706f563bf21f0.1450928100.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0106.outbound.protection.outlook.com [65.55.169.106])
 by alsa0.perex.cz (Postfix) with ESMTP id 7136A266578
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 04:39:23 +0100 (CET)
In-Reply-To: <fd32d943839609d46ca4523e316706f563bf21f0.1450928100.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org

The register ASRCFG is volatile, but some bits need to be recovered
after suspend/resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
v1->v2:
1. fix indentation issue.
2. add a macro for the magic number.
v2->v3:
1. a comment to describe variable regcache_cfg

 sound/soc/fsl/fsl_asrc.c | 7 +++++++
 sound/soc/fsl/fsl_asrc.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index d7d81cf..ed29a1b 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -992,6 +992,9 @@ static int fsl_asrc_suspend(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
 
+	regmap_read(asrc_priv->regmap, REG_ASRCFG,
+		    &asrc_priv->regcache_cfg);
+
 	regcache_cache_only(asrc_priv->regmap, true);
 	regcache_mark_dirty(asrc_priv->regmap);
 
@@ -1012,6 +1015,10 @@ static int fsl_asrc_resume(struct device *dev)
 	regcache_cache_only(asrc_priv->regmap, false);
 	regcache_sync(asrc_priv->regmap);
 
+	regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
+			   ASRCFG_NDPRi_ALL_MASK | ASRCFG_POSTMODi_ALL_MASK |
+			   ASRCFG_PREMODi_ALL_MASK, asrc_priv->regcache_cfg);
+
 	/* Restart enabled pairs */
 	regmap_update_bits(asrc_priv->regmap, REG_ASRCTR,
 			   ASRCTR_ASRCEi_ALL_MASK, asrctr);
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 68802cd..0f163ab 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -132,10 +132,13 @@
 #define ASRCFG_INIRQi			(1 << ASRCFG_INIRQi_SHIFT(i))
 #define ASRCFG_NDPRi_SHIFT(i)		(18 + i)
 #define ASRCFG_NDPRi_MASK(i)		(1 << ASRCFG_NDPRi_SHIFT(i))
+#define ASRCFG_NDPRi_ALL_SHIFT		18
+#define ASRCFG_NDPRi_ALL_MASK		(7 << ASRCFG_NDPRi_ALL_SHIFT)
 #define ASRCFG_NDPRi			(1 << ASRCFG_NDPRi_SHIFT(i))
 #define ASRCFG_POSTMODi_SHIFT(i)	(8 + (i << 2))
 #define ASRCFG_POSTMODi_WIDTH		2
 #define ASRCFG_POSTMODi_MASK(i)		(((1 << ASRCFG_POSTMODi_WIDTH) - 1) << ASRCFG_POSTMODi_SHIFT(i))
+#define ASRCFG_POSTMODi_ALL_MASK	(ASRCFG_POSTMODi_MASK(0) | ASRCFG_POSTMODi_MASK(1) | ASRCFG_POSTMODi_MASK(2))
 #define ASRCFG_POSTMOD(i, v)		((v) << ASRCFG_POSTMODi_SHIFT(i))
 #define ASRCFG_POSTMODi_UP(i)		(0 << ASRCFG_POSTMODi_SHIFT(i))
 #define ASRCFG_POSTMODi_DCON(i)		(1 << ASRCFG_POSTMODi_SHIFT(i))
@@ -143,6 +146,7 @@
 #define ASRCFG_PREMODi_SHIFT(i)		(6 + (i << 2))
 #define ASRCFG_PREMODi_WIDTH		2
 #define ASRCFG_PREMODi_MASK(i)		(((1 << ASRCFG_PREMODi_WIDTH) - 1) << ASRCFG_PREMODi_SHIFT(i))
+#define ASRCFG_PREMODi_ALL_MASK		(ASRCFG_PREMODi_MASK(0) | ASRCFG_PREMODi_MASK(1) | ASRCFG_PREMODi_MASK(2))
 #define ASRCFG_PREMOD(i, v)		((v) << ASRCFG_PREMODi_SHIFT(i))
 #define ASRCFG_PREMODi_UP(i)		(0 << ASRCFG_PREMODi_SHIFT(i))
 #define ASRCFG_PREMODi_DCON(i)		(1 << ASRCFG_PREMODi_SHIFT(i))
@@ -434,6 +438,7 @@ struct fsl_asrc_pair {
  * @channel_avail: non-occupied channel numbers
  * @asrc_rate: default sample rate for ASoC Back-Ends
  * @asrc_width: default sample width for ASoC Back-Ends
+ * @regcache_cfg: store register value of REG_ASRCFG
  */
 struct fsl_asrc {
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -453,6 +458,8 @@ struct fsl_asrc {
 
 	int asrc_rate;
 	int asrc_width;
+
+	u32 regcache_cfg;
 };
 
 extern struct snd_soc_platform_driver fsl_asrc_platform;
-- 
1.9.1
