From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Remove custom
	fsl_ssi_debugfs_create/remove()
Date: Wed,  8 Apr 2015 13:54:22 -0300
Message-ID: <1428512062-17229-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f48.google.com (mail-vn0-f48.google.com
 [209.85.216.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E6CA265375
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:54:39 +0200 (CEST)
Received: by vnbg190 with SMTP id g190so14580377vnb.12
 for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2015 09:54:38 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 81c7cfd1b22a0 ("ASoC: Move debugfs registration to the
component level") ASoC core code deals with registering debugfs, so we
should remove the custom fsl_ssi_debugfs_create/remove() to avoid the
following warning:

fsl-ssi-dai 2028000.ssi: ASoC: Failed to create component debugfs directory

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c     | 11 +----------
 sound/soc/fsl/fsl_ssi.h     | 13 -------------
 sound/soc/fsl/fsl_ssi_dbg.c | 22 ----------------------
 3 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6b0c8f7..b8cdb8f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1411,10 +1411,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = fsl_ssi_debugfs_create(&ssi_private->dbg_stats, &pdev->dev);
-	if (ret)
-		goto error_irq;
-
 	/*
 	 * If codec-handle property is missing from SSI node, we assume
 	 * that the machine driver uses new binding which does not require
@@ -1441,7 +1437,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (IS_ERR(ssi_private->pdev)) {
 		ret = PTR_ERR(ssi_private->pdev);
 		dev_err(&pdev->dev, "failed to register platform: %d\n", ret);
-		goto error_sound_card;
+		goto error_irq;
 	}
 
 done:
@@ -1451,9 +1447,6 @@ done:
 
 	return 0;
 
-error_sound_card:
-	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
-
 error_irq:
 	snd_soc_unregister_component(&pdev->dev);
 
@@ -1468,8 +1461,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 {
 	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&pdev->dev);
 
-	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
-
 	if (ssi_private->pdev)
 		platform_device_unregister(ssi_private->pdev);
 	snd_soc_unregister_component(&pdev->dev);
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 5065105..4767df1 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -241,10 +241,6 @@ struct fsl_ssi_dbg {
 
 void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *ssi_dbg, u32 sisr);
 
-int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev);
-
-void fsl_ssi_debugfs_remove(struct fsl_ssi_dbg *ssi_dbg);
-
 #else
 
 struct fsl_ssi_dbg {
@@ -254,15 +250,6 @@ static inline void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *stats, u32 sisr)
 {
 }
 
-static inline int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg,
-		struct device *dev)
-{
-	return 0;
-}
-
-static inline void fsl_ssi_debugfs_remove(struct fsl_ssi_dbg *ssi_dbg)
-{
-}
 #endif  /* ! IS_ENABLED(CONFIG_DEBUG_FS) */
 
 #endif
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 5469ffb..118064c 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -139,25 +139,3 @@ static const struct file_operations fsl_ssi_stats_ops = {
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-
-int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
-{
-	ssi_dbg->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
-	if (!ssi_dbg->dbg_dir)
-		return -ENOMEM;
-
-	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO,
-			ssi_dbg->dbg_dir, ssi_dbg, &fsl_ssi_stats_ops);
-	if (!ssi_dbg->dbg_stats) {
-		debugfs_remove(ssi_dbg->dbg_dir);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void fsl_ssi_debugfs_remove(struct fsl_ssi_dbg *ssi_dbg)
-{
-	debugfs_remove(ssi_dbg->dbg_stats);
-	debugfs_remove(ssi_dbg->dbg_dir);
-}
-- 
1.9.1
