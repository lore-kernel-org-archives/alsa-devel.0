From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/4] ASoC: Intel: Skylake: Verify the status
	bit before handling interrupt
Date: Fri,  9 Oct 2015 09:01:49 +0100
Message-ID: <1444377711-9720-3-git-send-email-vinod.koul@intel.com>
References: <1444377711-9720-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C1812617C6
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 10:02:13 +0200 (CEST)
In-Reply-To: <1444377711-9720-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Like we have in legacy mode HDA driver, we need to check the
status bit and handle interrupt only when it is not zero or all
bits set.  We typically see the status as all 1's when controller
resumes from suspend, So add the check here as well and don't
handle for these cases.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 194bd0036454..1bfb7f63b572 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -262,6 +262,11 @@ irqreturn_t skl_dsp_sst_interrupt(int irq, void *dev_id)
 	val = sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPIS);
 	ctx->intr_status = val;
 
+	if (val == 0xffffffff) {
+		spin_unlock(&ctx->spinlock);
+		return IRQ_NONE;
+	}
+
 	if (val & SKL_ADSPIS_IPC) {
 		skl_ipc_int_disable(ctx);
 		result = IRQ_WAKE_THREAD;
-- 
2.4.3
