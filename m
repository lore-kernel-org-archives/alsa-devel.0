From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Fix the driver data not set issue
Date: Tue,  4 Nov 2014 14:45:24 +0800
Message-ID: <1415083524-22756-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C6C2605F2
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 07:45:05 +0100 (CET)
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

The priv_data is allocated again here wrongly, and it
is not set to the driver data after assignment. This
make the pdata->dev is NULL and oops occurs on the first
call to hsw_volume_put.

The resource has been allocated in driver probe callback
hsw_pcm_dev_probe, so here just remove this sencond
allocation is OK.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 21f1316..bc02a6e 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -866,7 +866,6 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 	dev = platform->dev;
 	dma_dev = pdata->dma_dev;
 
-	priv_data = devm_kzalloc(platform->dev, sizeof(*priv_data), GFP_KERNEL);
 	priv_data->hsw = pdata->dsp;
 	priv_data->dev = platform->dev;
 	priv_data->pm_state = HSW_PM_STATE_D0;
-- 
1.9.1
