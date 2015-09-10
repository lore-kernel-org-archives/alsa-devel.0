From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: Fix SSP port configuration after
	RTD3 resume." to the asoc tree
Date: Thu, 10 Sep 2015 11:49:54 +0100
Message-ID: <E1ZZzQQ-000115-EN@finisterre>
References: <1441797031-4857-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 540262614C4
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 12:50:03 +0200 (CEST)
In-Reply-To: <1441797031-4857-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: Fix SSP port configuration after RTD3 resume.

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

>From f1ec5ec7a94ba8138f9cbdc1e9e3b03aee29c4df Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Wed, 9 Sep 2015 12:10:31 +0100
Subject: [PATCH] ASoC: intel: Fix SSP port configuration after RTD3 resume.

Currently the SSP port settings are being clobbered as part of the DSP
RTD3 restore logic. make sure we save the correct params and restore them
at resume. The FW sadly does not save SSP settings as part of the PM
context.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index f95f271..5bc9855 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -302,6 +302,10 @@ struct sst_hsw {
 	struct sst_hsw_ipc_dx_reply dx;
 	void *dx_context;
 	dma_addr_t dx_context_paddr;
+	enum sst_hsw_device_id dx_dev;
+	enum sst_hsw_device_mclk dx_mclk;
+	enum sst_hsw_device_mode dx_mode;
+	u32 dx_clock_divider;
 
 	/* boot */
 	wait_queue_head_t boot_wait;
@@ -1400,10 +1404,10 @@ int sst_hsw_device_set_config(struct sst_hsw *hsw,
 
 	trace_ipc_request("set device config", dev);
 
-	config.ssp_interface = dev;
-	config.clock_frequency = mclk;
-	config.mode = mode;
-	config.clock_divider = clock_divider;
+	hsw->dx_dev = config.ssp_interface = dev;
+	hsw->dx_mclk = config.clock_frequency = mclk;
+	hsw->dx_mode = config.mode = mode;
+	hsw->dx_clock_divider = config.clock_divider = clock_divider;
 	if (mode == SST_HSW_DEVICE_TDM_CLOCK_MASTER)
 		config.channels = 4;
 	else
@@ -1704,10 +1708,10 @@ int sst_hsw_dsp_runtime_resume(struct sst_hsw *hsw)
 		return -EIO;
 	}
 
-	/* Set ADSP SSP port settings */
-	ret = sst_hsw_device_set_config(hsw, SST_HSW_DEVICE_SSP_0,
-					SST_HSW_DEVICE_MCLK_FREQ_24_MHZ,
-					SST_HSW_DEVICE_CLOCK_MASTER, 9);
+	/* Set ADSP SSP port settings - sadly the FW does not store SSP port
+	   settings as part of the PM context. */
+	ret = sst_hsw_device_set_config(hsw, hsw->dx_dev, hsw->dx_mclk,
+					hsw->dx_mode, hsw->dx_clock_divider);
 	if (ret < 0)
 		dev_err(dev, "error: SSP re-initialization failed\n");
 
-- 
2.5.0
