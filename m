From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/5] sound: SoC: sof: no need to check return
	value of debugfs_create functions
Date: Fri, 14 Jun 2019 11:47:52 +0200
Message-ID: <20190614094756.2965-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C67C3F896E0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 12:07:25 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/debug.c    | 32 ++++++++++----------------------
 sound/soc/sof/sof-priv.h |  1 -
 sound/soc/sof/trace.c    |  9 ++-------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 55f1d808dba0..429daa0dc9bf 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -77,8 +77,7 @@ static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
 		if (!pm_runtime_active(sdev->dev) &&
 		    dfse->access_type == SOF_DEBUGFS_ACCESS_D0_ONLY) {
 			dev_err(sdev->dev,
-				"error: debugfs entry %s cannot be read in DSP D3\n",
-				dfse->dfsentry->d_name.name);
+				"error: debugfs entry cannot be read in DSP D3\n");
 			kfree(buf);
 			return -EINVAL;
 		}
@@ -142,17 +141,11 @@ int snd_sof_debugfs_io_item(struct snd_sof_dev *sdev,
 	}
 #endif
 
-	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
-					     dfse, &sof_dfs_fops);
-	if (!dfse->dfsentry) {
-		/* can't rely on debugfs, only log error and keep going */
-		dev_err(sdev->dev, "error: cannot create debugfs entry %s\n",
-			name);
-	} else {
-		/* add to dfsentry list */
-		list_add(&dfse->list, &sdev->dfsentry_list);
+	debugfs_create_file(name, 0444, sdev->debugfs_root, dfse,
+			    &sof_dfs_fops);
 
-	}
+	/* add to dfsentry list */
+	list_add(&dfse->list, &sdev->dfsentry_list);
 
 	return 0;
 }
@@ -177,16 +170,11 @@ int snd_sof_debugfs_buf_item(struct snd_sof_dev *sdev,
 	dfse->size = size;
 	dfse->sdev = sdev;
 
-	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
-					     dfse, &sof_dfs_fops);
-	if (!dfse->dfsentry) {
-		/* can't rely on debugfs, only log error and keep going */
-		dev_err(sdev->dev, "error: cannot create debugfs entry %s\n",
-			name);
-	} else {
-		/* add to dfsentry list */
-		list_add(&dfse->list, &sdev->dfsentry_list);
-	}
+	debugfs_create_file(name, 0444, sdev->debugfs_root, dfse,
+			    &sof_dfs_fops);
+
+	/* add to dfsentry list */
+	list_add(&dfse->list, &sdev->dfsentry_list);
 
 	return 0;
 }
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 1e85d6f9c5c3..d0f7cc3ddcbf 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -217,7 +217,6 @@ enum sof_debugfs_access_type {
 
 /* FS entry for debug files that can expose DSP memories, registers */
 struct snd_sof_dfsentry {
-	struct dentry *dfsentry;
 	size_t size;
 	enum sof_dfsentry_type type;
 	/*
diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index d588e4b70fad..2986d9a563b0 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -119,13 +119,8 @@ static int trace_debugfs_create(struct snd_sof_dev *sdev)
 	dfse->size = sdev->dmatb.bytes;
 	dfse->sdev = sdev;
 
-	dfse->dfsentry = debugfs_create_file("trace", 0444, sdev->debugfs_root,
-					     dfse, &sof_dfs_trace_fops);
-	if (!dfse->dfsentry) {
-		/* can't rely on debugfs, only log error and keep going */
-		dev_err(sdev->dev,
-			"error: cannot create debugfs entry for trace\n");
-	}
+	debugfs_create_file("trace", 0444, sdev->debugfs_root, dfse,
+			    &sof_dfs_trace_fops);
 
 	return 0;
 }
-- 
2.22.0
