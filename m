From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Mon,  5 Nov 2018 09:37:30 -0500
Message-ID: <20181105143730.6071-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 sound/soc/fsl/fsl_ssi_dbg.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 1255dfe19eef..6f6294149476 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -124,17 +124,7 @@ static int fsl_ssi_stats_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int fsl_ssi_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fsl_ssi_stats_show, inode->i_private);
-}
-
-static const struct file_operations fsl_ssi_stats_ops = {
-	.open = fsl_ssi_stats_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fsl_ssi_stats);
 
 int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 {
@@ -144,7 +134,7 @@ int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 
 	ssi_dbg->dbg_stats = debugfs_create_file("stats", 0444,
 						 ssi_dbg->dbg_dir, ssi_dbg,
-						 &fsl_ssi_stats_ops);
+						 &fsl_ssi_stats_fops);
 	if (!ssi_dbg->dbg_stats) {
 		debugfs_remove(ssi_dbg->dbg_dir);
 		return -ENOMEM;
-- 
2.17.0
