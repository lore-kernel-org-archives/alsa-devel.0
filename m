From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl_asrc: sound is wrong after
	suspend/resume
Date: Thu, 10 Dec 2015 19:02:48 +0800
Message-ID: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0115.outbound.protection.outlook.com [157.56.110.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D7BB2665AF
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 12:00:39 +0100 (CET)
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
 sound/soc/fsl/fsl_asrc.c | 6 ++++++
 sound/soc/fsl/fsl_asrc.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 3e404ba..942e74bc 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -990,6 +990,9 @@ static int fsl_asrc_suspend(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
 
+	regmap_read(asrc_priv->regmap, REG_ASRCFG,
+				&asrc_priv->regcache_cfg);
+
 	regcache_cache_only(asrc_priv->regmap, true);
 	regcache_mark_dirty(asrc_priv->regmap);
 
@@ -1010,6 +1013,9 @@ static int fsl_asrc_resume(struct device *dev)
 	regcache_cache_only(asrc_priv->regmap, false);
 	regcache_sync(asrc_priv->regmap);
 
+	regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
+				0x1FFFC0, asrc_priv->regcache_cfg);
+
 	/* Restart enabled pairs */
 	regmap_update_bits(asrc_priv->regmap, REG_ASRCTR,
 			   ASRCTR_ASRCEi_ALL_MASK, asrctr);
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 68802cd..3695ca9 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -453,6 +453,8 @@ struct fsl_asrc {
 
 	int asrc_rate;
 	int asrc_width;
+
+	u32 regcache_cfg;
 };
 
 extern struct snd_soc_platform_driver fsl_asrc_platform;
-- 
1.9.1
