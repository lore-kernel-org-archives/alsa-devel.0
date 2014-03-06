From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Check Haswell IPC
	process_reply/notification return value.
Date: Thu,  6 Mar 2014 14:56:04 +0000
Message-ID: <1394117766-7242-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id AB4E4265388
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 15:56:37 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Check the return value for error when processing replies and notifications.

The patch 22981243589c: "ASoC: Intel: Add Haswell/Broadwell IPC" from
> Feb 20, 2014, leads to the following imaginary static checker warning:
>
> 	sound/soc/intel/sst-haswell-ipc.c:898 hsw_irq_thread()
> 	warn: this is always true.
>
> sound/soc/intel/sst-haswell-ipc.c
>    895                  /* Handle Immediate reply from DSP Core */
>    896                  handled = hsw_process_reply(hsw, ipcx);
>                                   ^^^^^^^^^^^^^^^^^
> Returns 1 on success/error and -EIO on error.
>
>    897
>    898                  if (handled) {
>    899                          /* clear DONE bit - tell DSP we have completed */
>    900                          sst_dsp_shim_update_bits_unlocked(sst, SST_IPCX,
>    901                                  SST_IPCX_DONE, 0);
>    902
>    903                          /* unmask Done interrupt */
>    904                          sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX,
>    905                                  SST_IMRX_DONE, 0);
>    906                  }
>

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 1f1576a..f46bb4d 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -895,7 +895,7 @@ static irqreturn_t hsw_irq_thread(int irq, void *context)
 		/* Handle Immediate reply from DSP Core */
 		handled = hsw_process_reply(hsw, ipcx);
 
-		if (handled) {
+		if (handled > 0) {
 			/* clear DONE bit - tell DSP we have completed */
 			sst_dsp_shim_update_bits_unlocked(sst, SST_IPCX,
 				SST_IPCX_DONE, 0);
@@ -913,7 +913,7 @@ static irqreturn_t hsw_irq_thread(int irq, void *context)
 		handled = hsw_process_notification(hsw);
 
 		/* clear BUSY bit and set DONE bit - accept new messages */
-		if (handled) {
+		if (handled > 0) {
 			sst_dsp_shim_update_bits_unlocked(sst, SST_IPCD,
 				SST_IPCD_BUSY | SST_IPCD_DONE, SST_IPCD_DONE);
 
-- 
1.8.3.2
