From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: byt/hsw: Add missing kthread_stop
	to error/cleanup path
Date: Fri, 30 May 2014 10:52:29 +0300
Message-ID: <1401436349-19202-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 80AED261685
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 09:54:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Imre Deak <imre.deak@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Imre Deak <imre.deak@intel.com>

Baytrail and Haswell SST IPC don't stop the kernel thread in error and
cleanup path thus leaving orphan kernel thread behind in such a case.

Also while at it, fix one error path in sst-haswell-ipc.c that doesn't free
hsw->msg.

[Jarkko: I edited the commit log a little]
Signed-off-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c |  5 ++++-
 sound/soc/intel/sst-haswell-ipc.c  | 12 ++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 0d31dbbf4806..d4b8c827c8b8 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -824,7 +824,7 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	byt->dsp = sst_dsp_new(dev, &byt_dev, pdata);
 	if (byt->dsp == NULL) {
 		err = -ENODEV;
-		goto err_free_msg;
+		goto dsp_err;
 	}
 
 	/* keep the DSP in reset state for base FW loading */
@@ -856,6 +856,8 @@ boot_err:
 	sst_fw_free(byt_sst_fw);
 fw_err:
 	sst_dsp_free(byt->dsp);
+dsp_err:
+	kthread_stop(byt->tx_thread);
 err_free_msg:
 	kfree(byt->msg);
 
@@ -870,6 +872,7 @@ void sst_byt_dsp_free(struct device *dev, struct sst_pdata *pdata)
 	sst_dsp_reset(byt->dsp);
 	sst_fw_free_all(byt->dsp);
 	sst_dsp_free(byt->dsp);
+	kthread_stop(byt->tx_thread);
 	kfree(byt->msg);
 }
 EXPORT_SYMBOL_GPL(sst_byt_dsp_free);
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index e7996b39a484..bee192d42032 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1730,7 +1730,7 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 
 	ret = msg_empty_list_init(hsw);
 	if (ret < 0)
-		goto list_err;
+		return -ENOMEM;
 
 	/* start the IPC message thread */
 	init_kthread_worker(&hsw->kworker);
@@ -1740,7 +1740,7 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	if (IS_ERR(hsw->tx_thread)) {
 		ret = PTR_ERR(hsw->tx_thread);
 		dev_err(hsw->dev, "error: failed to create message TX task\n");
-		goto list_err;
+		goto err_free_msg;
 	}
 	init_kthread_work(&hsw->kwork, ipc_tx_msgs);
 
@@ -1750,7 +1750,7 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	hsw->dsp = sst_dsp_new(dev, &hsw_dev, pdata);
 	if (hsw->dsp == NULL) {
 		ret = -ENODEV;
-		goto list_err;
+		goto dsp_err;
 	}
 
 	/* keep the DSP in reset state for base FW loading */
@@ -1794,8 +1794,11 @@ boot_err:
 	sst_fw_free(hsw_sst_fw);
 fw_err:
 	sst_dsp_free(hsw->dsp);
+dsp_err:
+	kthread_stop(hsw->tx_thread);
+err_free_msg:
 	kfree(hsw->msg);
-list_err:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sst_hsw_dsp_init);
@@ -1808,6 +1811,7 @@ void sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata)
 	sst_fw_free_all(hsw->dsp);
 	sst_dsp_free(hsw->dsp);
 	kfree(hsw->scratch);
+	kthread_stop(hsw->tx_thread);
 	kfree(hsw->msg);
 }
 EXPORT_SYMBOL_GPL(sst_hsw_dsp_free);
-- 
2.0.0.rc2
