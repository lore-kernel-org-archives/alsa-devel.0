From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/5] ASoC: Intel: use local values for ssp
	configuration
Date: Wed,  6 May 2015 22:06:41 +0530
Message-ID: <1430930204-32184-3-git-send-email-vinod.koul@intel.com>
References: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C3A2260632
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:36:32 +0200 (CEST)
In-Reply-To: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, praveen.diwakar@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, broonie@kernel.org, sathyanarayana.nujella@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

So right now SSP configuration is statically coded in the driver. While we
would like to keep this configuration intact for the users who are using
these defaults, we need to provide a way for users to program it.
So create a local value in driver structure which is populate with default
value for now

Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 53 ++++++++++++++++++--------------
 sound/soc/intel/atom/sst-mfld-platform.h |  2 ++
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 59517b3fa04d..93c6c8b5fbc6 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -793,45 +793,52 @@ static const struct sst_ssp_config sst_ssp_configs = {
 	.data_polarity = 1,
 };
 
+void sst_fill_ssp_defaults(struct snd_soc_dai *dai)
+{
+	const struct sst_ssp_config *config;
+	struct sst_data *ctx = snd_soc_dai_get_drvdata(dai);
+
+	config = &sst_ssp_configs;
+
+	ctx->ssp_cmd.selection = config->ssp_id;
+	ctx->ssp_cmd.nb_bits_per_slots = config->bits_per_slot;
+	ctx->ssp_cmd.nb_slots = config->slots;
+	ctx->ssp_cmd.mode = config->ssp_mode | (config->pcm_mode << 1);
+	ctx->ssp_cmd.duplex = config->duplex;
+	ctx->ssp_cmd.active_tx_slot_map = config->active_slot_map;
+	ctx->ssp_cmd.active_rx_slot_map = config->active_slot_map;
+	ctx->ssp_cmd.frame_sync_frequency = config->fs_frequency;
+	ctx->ssp_cmd.frame_sync_polarity = config->frame_sync_polarity;
+	ctx->ssp_cmd.data_polarity = config->data_polarity;
+	ctx->ssp_cmd.frame_sync_width = config->fs_width;
+	ctx->ssp_cmd.ssp_protocol = config->ssp_protocol;
+	ctx->ssp_cmd.start_delay = config->start_delay;
+	ctx->ssp_cmd.reserved1 = ctx->ssp_cmd.reserved2 = 0xFF;
+}
+
 int send_ssp_cmd(struct snd_soc_dai *dai, const char *id, bool enable)
 {
-	struct sst_cmd_sba_hw_set_ssp cmd;
 	struct sst_data *drv = snd_soc_dai_get_drvdata(dai);
 	const struct sst_ssp_config *config;
 
 	dev_info(dai->dev, "Enter: enable=%d port_name=%s\n", enable, id);
 
-	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
-	cmd.header.command_id = SBA_HW_SET_SSP;
-	cmd.header.length = sizeof(struct sst_cmd_sba_hw_set_ssp)
+	SST_FILL_DEFAULT_DESTINATION(drv->ssp_cmd.header.dst);
+	drv->ssp_cmd.header.command_id = SBA_HW_SET_SSP;
+	drv->ssp_cmd.header.length = sizeof(struct sst_cmd_sba_hw_set_ssp)
 				- sizeof(struct sst_dsp_header);
 
 	config = &sst_ssp_configs;
 	dev_dbg(dai->dev, "ssp_id: %u\n", config->ssp_id);
 
 	if (enable)
-		cmd.switch_state = SST_SWITCH_ON;
+		drv->ssp_cmd.switch_state = SST_SWITCH_ON;
 	else
-		cmd.switch_state = SST_SWITCH_OFF;
-
-	cmd.selection = config->ssp_id;
-	cmd.nb_bits_per_slots = config->bits_per_slot;
-	cmd.nb_slots = config->slots;
-	cmd.mode = config->ssp_mode | (config->pcm_mode << 1);
-	cmd.duplex = config->duplex;
-	cmd.active_tx_slot_map = config->active_slot_map;
-	cmd.active_rx_slot_map = config->active_slot_map;
-	cmd.frame_sync_frequency = config->fs_frequency;
-	cmd.frame_sync_polarity = SSP_FS_ACTIVE_HIGH;
-	cmd.data_polarity = 1;
-	cmd.frame_sync_width = config->fs_width;
-	cmd.ssp_protocol = config->ssp_protocol;
-	cmd.start_delay = config->start_delay;
-	cmd.reserved1 = cmd.reserved2 = 0xFF;
+		drv->ssp_cmd.switch_state = SST_SWITCH_OFF;
 
 	return sst_fill_and_send_cmd(drv, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
-				SST_TASK_SBA, 0, &cmd,
-				sizeof(cmd.header) + cmd.header.length);
+				SST_TASK_SBA, 0, &drv->ssp_cmd,
+				sizeof(drv->ssp_cmd.header) + drv->ssp_cmd.header.length);
 }
 
 static int sst_set_be_modules(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/intel/atom/sst-mfld-platform.h b/sound/soc/intel/atom/sst-mfld-platform.h
index 9094314be2b0..2409b23eeacf 100644
--- a/sound/soc/intel/atom/sst-mfld-platform.h
+++ b/sound/soc/intel/atom/sst-mfld-platform.h
@@ -22,6 +22,7 @@
 #define __SST_PLATFORMDRV_H__
 
 #include "sst-mfld-dsp.h"
+#include "sst-atom-controls.h"
 
 extern struct sst_device *sst;
 
@@ -175,6 +176,7 @@ struct sst_data {
 	struct snd_sst_bytes_v2 *byte_stream;
 	struct mutex lock;
 	struct snd_soc_card *soc_card;
+	struct sst_cmd_sba_hw_set_ssp ssp_cmd;
 };
 int sst_register_dsp(struct sst_device *sst);
 int sst_unregister_dsp(struct sst_device *sst);
-- 
1.9.1
