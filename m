From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Change to use
	DEFINE_SHOW_ATTRIBUTE macro" to the asoc tree
Date: Wed,  7 Nov 2018 15:01:03 +0000 (GMT)
Message-ID: <20181107150103.D0CF81124E14@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC73267839
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2018 16:01:04 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d3ff06b03c106171cdc7a718c4de724ce6ae346d Mon Sep 17 00:00:00 2001
From: Yangtao Li <tiny.windzz@gmail.com>
Date: Mon, 5 Nov 2018 09:37:30 -0500
Subject: [PATCH] ASoC: fsl_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
