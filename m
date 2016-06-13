From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/7] ASoC: Intel: Skylake: Enable firmware
	reload in suspend
Date: Mon, 13 Jun 2016 17:59:01 +0530
Message-ID: <1465820944-14774-5-git-send-email-vinod.koul@intel.com>
References: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 35E162650D1
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:22:37 +0200 (CEST)
In-Reply-To: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

Broxton DSP needs retains code loaded during runtime_pm cycles.
But it looses that on suspend cycle, so on resume we need to
download the firmware again.

This is done by adding a new flag and based on flag status, we
download the firmware.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c     | 9 +++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h | 3 +++
 sound/soc/intel/skylake/skl-sst.c     | 1 +
 sound/soc/intel/skylake/skl.c         | 1 +
 4 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 46235b93e4f8..e50bac74f4a8 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -185,6 +185,7 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 		} else {
 			skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
 			ret = 0;
+			skl->fw_loaded = true;
 		}
 	}
 
@@ -200,6 +201,14 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx)
 
 	skl->boot_complete = false;
 
+	if (skl->fw_loaded == false) {
+		dev_dbg(ctx->dev, "Re-loading fw\n");
+		ret = bxt_load_base_firmware(ctx);
+		if (ret < 0)
+			dev_err(ctx->dev, "reload fw failed: %d\n", ret);
+		return ret;
+	}
+
 	ret = skl_dsp_enable_core(ctx);
 	if (ret < 0) {
 		dev_err(ctx->dev, "enable dsp core failed ret: %d\n", ret);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 9f24261abf3e..5102c7b415fe 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -63,6 +63,9 @@ struct skl_sst {
 
 	/* Populate module information */
 	struct list_head uuid_list;
+
+	/* Is firmware loaded */
+	bool fw_loaded;
 };
 
 struct skl_ipc_init_instance_msg {
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 4cabae54a71e..dff1076a5f9e 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -153,6 +153,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 
 		dev_dbg(ctx->dev, "Download firmware successful%d\n", ret);
 		skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
+		skl->fw_loaded = true;
 	}
 	return 0;
 transfer_firmware_failed:
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index c0f5d5565dea..734072c79205 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -248,6 +248,7 @@ static int skl_suspend(struct device *dev)
 		ret = _skl_suspend(ebus);
 		if (ret < 0)
 			return ret;
+		skl->skl_sst->fw_loaded = false;
 	}
 
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-- 
1.9.1
