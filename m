From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ASoC: Intel: avoid format string leak to thread name
Date: Thu, 22 May 2014 11:43:55 -0700
Message-ID: <20140522184355.GA8301@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wenkai Du <wenkai.du@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>, Christian Engelmayer <cengelma@gmx.at>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This makes sure a format string can never get processed into the worker
thread name from the device name.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/soc/intel/sst-baytrail-ipc.c |    2 +-
 sound/soc/intel/sst-haswell-ipc.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 0d31dbbf4806..1b25bf168beb 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -809,7 +809,7 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	/* start the IPC message thread */
 	init_kthread_worker(&byt->kworker);
 	byt->tx_thread = kthread_run(kthread_worker_fn,
-				     &byt->kworker,
+				     &byt->kworker, "%s",
 				     dev_name(byt->dev));
 	if (IS_ERR(byt->tx_thread)) {
 		err = PTR_ERR(byt->tx_thread);
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index e7996b39a484..a8fd60c67341 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1735,7 +1735,7 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	/* start the IPC message thread */
 	init_kthread_worker(&hsw->kworker);
 	hsw->tx_thread = kthread_run(kthread_worker_fn,
-					   &hsw->kworker,
+					   &hsw->kworker, "%s",
 					   dev_name(hsw->dev));
 	if (IS_ERR(hsw->tx_thread)) {
 		ret = PTR_ERR(hsw->tx_thread);
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
