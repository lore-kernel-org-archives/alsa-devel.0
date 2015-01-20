From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Used lock version to update shim
	registers
Date: Wed, 21 Jan 2015 07:20:23 +0800
Message-ID: <1421796023-29262-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 08CB6260705
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 00:18:44 +0100 (CET)
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

We need hold lock each time updating shirm registers, otherwise,
we may set unexpected values to them when they are set in
different thread at different time sequence.

The notification work will be scheduled in global work queue,
which won't hold this sst->spinlock itself, so here we need
change to use the lock version to update shim registers.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index eeef9a5..e18cb07 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -653,11 +653,11 @@ static void hsw_notification_work(struct work_struct *work)
 	}
 
 	/* tell DSP that notification has been handled */
-	sst_dsp_shim_update_bits_unlocked(hsw->dsp, SST_IPCD,
+	sst_dsp_shim_update_bits(hsw->dsp, SST_IPCD,
 		SST_IPCD_BUSY | SST_IPCD_DONE, SST_IPCD_DONE);
 
 	/* unmask busy interrupt */
-	sst_dsp_shim_update_bits_unlocked(hsw->dsp, SST_IMRX, SST_IMRX_BUSY, 0);
+	sst_dsp_shim_update_bits(hsw->dsp, SST_IMRX, SST_IMRX_BUSY, 0);
 }
 
 static struct ipc_message *reply_find_msg(struct sst_hsw *hsw, u32 header)
-- 
1.9.1
