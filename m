From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v2] ASoC: fsl_asrc: sound is wrong after
	suspend/resume
Date: Fri, 18 Dec 2015 16:58:18 +0800
Message-ID: <66fa43839fccc9aba8ebfc1330afc22747f05f0d.1450428914.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0142.outbound.protection.outlook.com [65.55.169.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 850B22650D1
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 09:56:12 +0100 (CET)
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
---
v1->v2:
1. fix indentation issue.
2. add a macro for the magic number.

 sound/soc/fsl/fsl_asrc.c | 7 +++++++
 sound/soc/fsl/fsl_asrc.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 484e46ca..d964016 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -990,6 +990,9 @@ static int fsl_asrc_suspend(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
 
+	regmap_read(asrc_priv->regmap, REG_ASRCFG,
+		    &asrc_priv->regcache_cfg);
+
 	regcache_cache_only(asrc_priv->regmap, true);
 	regcache_mark_dirty(asrc_priv->regmap);
 
@@ -1010,6 +1013,10 @@ static int fsl_asrc_resume(struct device *dev)
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
index 68802cd..c119cb0 100644
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
@@ -453,6 +457,8 @@ struct fsl_asrc {
 
 	int asrc_rate;
 	int asrc_width;
+
+	u32 regcache_cfg;
 };
 
 extern struct snd_soc_platform_driver fsl_asrc_platform;
-- 
1.9.1
