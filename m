From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel; Add debug output when boot fails.
Date: Thu, 30 Oct 2014 14:34:00 +0000
Message-ID: <1414679640-11108-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 70247260611
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:34:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add the debug output from IPCD and IPCX when booting fails.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index b37d3ee..0ea7c3d 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1927,7 +1927,9 @@ int sst_hsw_dsp_runtime_resume(struct sst_hsw *hsw)
 	ret = wait_event_timeout(hsw->boot_wait, hsw->boot_complete,
 		msecs_to_jiffies(IPC_BOOT_MSECS));
 	if (ret == 0) {
-		dev_err(hsw->dev, "error: audio DSP boot timeout\n");
+		dev_err(hsw->dev, "error: audio DSP boot timeout IPCD 0x%x IPCX 0x%x\n",
+			sst_dsp_shim_read_unlocked(hsw->dsp, SST_IPCD),
+			sst_dsp_shim_read_unlocked(hsw->dsp, SST_IPCX));
 		return -EIO;
 	}
 
@@ -2038,7 +2040,9 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 		msecs_to_jiffies(IPC_BOOT_MSECS));
 	if (ret == 0) {
 		ret = -EIO;
-		dev_err(hsw->dev, "error: ADSP boot timeout\n");
+		dev_err(hsw->dev, "error: audio DSP boot timeout IPCD 0x%x IPCX 0x%x\n",
+			sst_dsp_shim_read_unlocked(hsw->dsp, SST_IPCD),
+			sst_dsp_shim_read_unlocked(hsw->dsp, SST_IPCX));
 		goto boot_err;
 	}
 
-- 
2.1.0
