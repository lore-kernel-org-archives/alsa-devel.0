From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: fsl_ssi: Do not create debugfs
	directory
Date: Wed,  8 Apr 2015 14:21:24 -0300
Message-ID: <1428513684-26577-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f44.google.com (mail-vn0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 141AD265375
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 19:22:04 +0200 (CEST)
Received: by vnbg129 with SMTP id g129so16195903vnb.4
 for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2015 10:22:03 -0700 (PDT)
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
should not be creating the debugfs directory locally in order to avoid
the following warning:

fsl-ssi-dai 2028000.ssi: ASoC: Failed to create component debugfs directory

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Only remove dir creation/remove as suggested by Mark Brown

 sound/soc/fsl/fsl_ssi.h     |  1 -
 sound/soc/fsl/fsl_ssi_dbg.c | 13 +++----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 5065105..68aef90 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -211,7 +211,6 @@ struct device;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 struct fsl_ssi_dbg {
-	struct dentry *dbg_dir;
 	struct dentry *dbg_stats;
 
 	struct {
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 5469ffb..46cea84 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -142,22 +142,15 @@ static const struct file_operations fsl_ssi_stats_ops = {
 
 int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 {
-	ssi_dbg->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
-	if (!ssi_dbg->dbg_dir)
+	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO, NULL,
+						 ssi_dbg, &fsl_ssi_stats_ops);
+	if (!ssi_dbg->dbg_stats)
 		return -ENOMEM;
 
-	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO,
-			ssi_dbg->dbg_dir, ssi_dbg, &fsl_ssi_stats_ops);
-	if (!ssi_dbg->dbg_stats) {
-		debugfs_remove(ssi_dbg->dbg_dir);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
 void fsl_ssi_debugfs_remove(struct fsl_ssi_dbg *ssi_dbg)
 {
 	debugfs_remove(ssi_dbg->dbg_stats);
-	debugfs_remove(ssi_dbg->dbg_dir);
 }
-- 
1.9.1
