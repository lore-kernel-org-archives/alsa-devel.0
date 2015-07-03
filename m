From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/6] ASoC: Intel: Add helper to poll
	register for DSP status
Date: Fri,  3 Jul 2015 16:04:02 +0530
Message-ID: <1435919647-14049-2-git-send-email-vinod.koul@intel.com>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC8B2625D7
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 12:32:26 +0200 (CEST)
In-Reply-To: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Kp, Jeeja" <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This patch adds helper to poll register for DSP status.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Kp, Jeeja <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-dsp.c | 23 +++++++++++++++++++++++
 sound/soc/intel/common/sst-dsp.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index 64e94212d2d2..3356792d6933 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
@@ -222,6 +223,28 @@ int sst_dsp_shim_update_bits64(struct sst_dsp *sst, u32 offset,
 }
 EXPORT_SYMBOL_GPL(sst_dsp_shim_update_bits64);
 
+int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
+			 u32 expected_value, u32 timeout, char *operation)
+{
+	int time, ret;
+	u32 reg;
+
+	/* check if set state successful */
+	for (time = 0; time < timeout; time++) {
+		if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) == expected_value)
+			break;
+
+		mdelay(1);
+	}
+	reg = sst_dsp_shim_read_unlocked(ctx, offset);
+	dev_info(ctx->dev, "FW Poll Status: reg=%#x %s %s\n", reg, operation,
+			(time < timeout) ? "successful" : "timedout");
+	ret = time < timeout ? 0 : -ETIME;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_dsp_register_poll);
+
 void sst_dsp_dump(struct sst_dsp *sst)
 {
 	if (sst->ops->dump)
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index 96aeb2556ad4..cc3197be4cf7 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -278,6 +278,8 @@ void sst_dsp_inbox_read(struct sst_dsp *dsp, void *message, size_t bytes);
 void sst_dsp_outbox_write(struct sst_dsp *dsp, void *message, size_t bytes);
 void sst_dsp_outbox_read(struct sst_dsp *dsp, void *message, size_t bytes);
 void sst_dsp_mailbox_dump(struct sst_dsp *dsp, size_t bytes);
+int sst_dsp_register_poll(struct sst_dsp  *dsp, u32 offset, u32 mask,
+		 u32 expected_value, u32 timeout, char *operation);
 
 /* Debug */
 void sst_dsp_dump(struct sst_dsp *sst);
-- 
1.9.1
