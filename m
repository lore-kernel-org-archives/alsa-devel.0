From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: fix a compiling issue
Date: Mon, 13 Apr 2015 10:47:30 +0800
Message-ID: <1428893250-21092-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C9D3026145A
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 04:44:16 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Fix the compiling issue that we don't have snd_soc_suspend/resume()
when CONFIG_PM_SLEEP is not defined.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 23ae040..f84eb14 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -1313,8 +1313,9 @@ static void hsw_pcm_complete(struct device *dev)
 			dev_err(dev, "failed to restore context for PCM %d\n", i);
 	}
 
+#ifdef CONFIG_PM_SLEEP
 	snd_soc_resume(pdata->soc_card->dev);
-
+#endif
 	err = sst_hsw_dsp_runtime_resume(hsw);
 	if (err < 0)
 		return;
@@ -1367,7 +1368,9 @@ static int hsw_pcm_prepare(struct device *dev)
 		sst_hsw_dsp_runtime_sleep(hsw);
 	}
 
+#ifdef CONFIG_PM_SLEEP
 	snd_soc_suspend(pdata->soc_card->dev);
+#endif
 	snd_soc_poweroff(pdata->soc_card->dev);
 
 	pdata->pm_state = HSW_PM_STATE_D3;
-- 
1.9.1
