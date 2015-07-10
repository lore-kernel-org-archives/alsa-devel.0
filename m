From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add helper to poll register for
	DSP status" to the asoc tree
Date: Fri, 10 Jul 2015 01:25:44 +0100
Message-ID: <E1ZDM8O-0000O3-J2@debutante>
References: <1436458135-25537-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5E892664A9
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 02:25:50 +0200 (CEST)
In-Reply-To: <1436458135-25537-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Kp Jeeja <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add helper to poll register for DSP status

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7a2c52b61fd71eddda3385006962630444d15b9e Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 9 Jul 2015 21:38:52 +0530
Subject: [PATCH] ASoC: Intel: Add helper to poll register for DSP status

This patch adds helper to poll register for DSP status.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Kp, Jeeja <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp.c | 43 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-dsp.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index 64e94212d2d2..cc25f4c202af 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
@@ -222,6 +223,48 @@ int sst_dsp_shim_update_bits64(struct sst_dsp *sst, u32 offset,
 }
 EXPORT_SYMBOL_GPL(sst_dsp_shim_update_bits64);
 
+int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
+			 u32 target, u32 timeout, char *operation)
+{
+	int time, ret;
+	u32 reg;
+	bool done = false;
+
+	/*
+	 * we will poll for couple of ms using mdelay, if not successful
+	 * then go to longer sleep using usleep_range
+	 */
+
+	/* check if set state successful */
+	for (time = 0; time < 5; time++) {
+		if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) == target) {
+			done = true;
+			break;
+		}
+		mdelay(1);
+	}
+
+	if (done ==  false) {
+		/* sleeping in 10ms steps so adjust timeout value */
+		timeout /= 10;
+
+		for (time = 0; time < timeout; time++) {
+			if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) == target)
+				break;
+
+			usleep_range(5000, 10000);
+		}
+	}
+
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
2.1.4
