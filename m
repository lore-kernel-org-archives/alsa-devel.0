From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 6/9] ASoC: SOF: add mode parameter for
	snd_sof_debugfs_buf_item
Date: Mon,  3 Jun 2019 11:18:18 -0500
Message-ID: <20190603161821.7486-7-pierre-louis.bossart@linux.intel.com>
References: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 721D6F8971F
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:18:35 +0200 (CEST)
In-Reply-To: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add mode parameter for snd_sof_debugfs_buf_item() to specify
the mode while creating debugfs entries.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
index 03d852293d27..14faf3c4550e 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -547,7 +547,7 @@ int snd_sof_debugfs_io_item(struct snd_sof_dev *sdev,
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
