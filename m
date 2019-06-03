From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: add mode parameter for
	snd_sof_debugfs_buf_item" to the asoc tree
Date: Mon,  3 Jun 2019 19:02:00 +0100 (BST)
Message-ID: <20190603180200.D90AB440049@finisterre.sirena.org.uk>
References: <20190603161821.7486-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89A8DF89735
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:02:02 +0200 (CEST)
In-Reply-To: <20190603161821.7486-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: add mode parameter for snd_sof_debugfs_buf_item

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 5c9714f637365a84e05f0532cd9ae00c65b70dc1 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Mon, 3 Jun 2019 11:18:18 -0500
Subject: [PATCH] ASoC: SOF: add mode parameter for snd_sof_debugfs_buf_item

Add mode parameter for snd_sof_debugfs_buf_item() to specify
the mode while creating debugfs entries.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/debug.c    | 4 ++--
 sound/soc/sof/loader.c   | 4 ++--
 sound/soc/sof/sof-priv.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 55f1d808dba0..219c3becf670 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -161,7 +161,7 @@ EXPORT_SYMBOL_GPL(snd_sof_debugfs_io_item);
 /* create FS entry for debug files to expose kernel memory */
 int snd_sof_debugfs_buf_item(struct snd_sof_dev *sdev,
 			     void *base, size_t size,
-			     const char *name)
+			     const char *name, mode_t mode)
 {
 	struct snd_sof_dfsentry *dfse;
 
@@ -177,7 +177,7 @@ int snd_sof_debugfs_buf_item(struct snd_sof_dev *sdev,
 	dfse->size = size;
 	dfse->sdev = sdev;
 
-	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
+	dfse->dfsentry = debugfs_create_file(name, mode, sdev->debugfs_root,
 					     dfse, &sof_dfs_fops);
 	if (!dfse->dfsentry) {
 		/* can't rely on debugfs, only log error and keep going */
diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 16b016b76fd8..952a19091c58 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -335,11 +335,11 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
 	init_waitqueue_head(&sdev->boot_wait);
 	sdev->boot_complete = false;
 
-	/* create fw_version debugfs to store boot version info */
+	/* create read-only fw_version debugfs to store boot version info */
 	if (sdev->first_boot) {
 		ret = snd_sof_debugfs_buf_item(sdev, &sdev->fw_version,
 					       sizeof(sdev->fw_version),
-					       "fw_version");
+					       "fw_version", 0444);
 		/* errors are only due to memory allocation, not debugfs */
 		if (ret < 0) {
 			dev_err(sdev->dev, "error: snd_sof_debugfs_buf_item failed\n");
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 01a6219c326b..ce22240cd93a 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -546,7 +546,7 @@ int snd_sof_debugfs_io_item(struct snd_sof_dev *sdev,
 			    enum sof_debugfs_access_type access_type);
 int snd_sof_debugfs_buf_item(struct snd_sof_dev *sdev,
 			     void *base, size_t size,
-			     const char *name);
+			     const char *name, mode_t mode);
 int snd_sof_trace_update_pos(struct snd_sof_dev *sdev,
 			     struct sof_ipc_dma_trace_posn *posn);
 void snd_sof_trace_notify_for_error(struct snd_sof_dev *sdev);
-- 
2.20.1
