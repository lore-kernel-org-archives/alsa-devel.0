From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_asrc: sound is wrong after
	suspend/resume" to the asoc tree
Date: Tue, 05 Jan 2016 17:49:10 +0000
Message-ID: <E1aGVjK-00034b-S7@debutante>
References: <5b07db93fb5a848216a9035c827d99185250d89d.1450928293.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E9322625CF
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 18:49:26 +0100 (CET)
In-Reply-To: <5b07db93fb5a848216a9035c827d99185250d89d.1450928293.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_asrc: sound is wrong after suspend/resume

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d44c6114da8c9e83407397d06b5cd909a1cc9135 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Thu, 24 Dec 2015 11:42:11 +0800
Subject: [PATCH] ASoC: fsl_asrc: sound is wrong after suspend/resume

The register ASRCFG is volatile, but some bits need to be recovered
after suspend/resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c | 7 +++++++
 sound/soc/fsl/fsl_asrc.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 7b811485a8e5..73fd2c683b78 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -996,6 +996,9 @@ static int fsl_asrc_suspend(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
 
+	regmap_read(asrc_priv->regmap, REG_ASRCFG,
+		    &asrc_priv->regcache_cfg);
+
 	regcache_cache_only(asrc_priv->regmap, true);
 	regcache_mark_dirty(asrc_priv->regmap);
 
@@ -1016,6 +1019,10 @@ static int fsl_asrc_resume(struct device *dev)
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
index 68802cdc3f28..0f163abe4ba3 100644
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
2.7.0.rc3
