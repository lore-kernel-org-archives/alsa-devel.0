From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: debug: fix possible memory leak in sof_dfsentry_write()" to the asoc tree
Date: Fri,  5 Jul 2019 18:19:50 +0100 (BST)
Message-ID: <20190705171950.730AE2742A10@ypsilon.sirena.org.uk>
References: <20190705081637.157169-1-weiyongjun1@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190705081637.157169-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: debug: fix possible memory leak in sof_dfsentry_write()

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

>From b90bab3b1b1b6c56dd6f9d5c960932239f36f6d3 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Fri, 5 Jul 2019 08:16:37 +0000
Subject: [PATCH] ASoC: SOF: debug: fix possible memory leak in
 sof_dfsentry_write()

'string' is malloced in sof_dfsentry_write() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: 091c12e1f50c ("ASoC: SOF: debug: add new debugfs entries for IPC flood test")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20190705081637.157169-1-weiyongjun1@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 54bb53bfc81b..2388477a965e 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -162,7 +162,7 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 	else
 		ret = kstrtoul(string, 0, &ipc_count);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* limit max duration/ipc count for flood test */
 	if (flood_duration_test) {
@@ -191,7 +191,7 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 				    "error: debugfs write failed to resume %d\n",
 				    ret);
 		pm_runtime_put_noidle(sdev->dev);
-		return ret;
+		goto out;
 	}
 
 	/* flood test */
-- 
2.20.1
