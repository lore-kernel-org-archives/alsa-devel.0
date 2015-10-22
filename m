From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/9] ASoC: Intel: Skylake: Add support to
	disable module notifications
Date: Thu, 22 Oct 2015 23:22:39 +0530
Message-ID: <1445536362-26670-7-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BB04F2607E8
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:53:31 +0200 (CEST)
In-Reply-To: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Each FW modules can report underrun/overrun notification from
all modules. This patch disables underrun/overrun notification after
firmware is loaded.
This will be supportted for debug mode only thru debugfs

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 28 ++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl-topology.h |  5 +++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 77c0736d3c9e..ca7bbeea2cd9 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -54,6 +54,24 @@ static int skl_free_dma_buf(struct device *dev, struct snd_dma_buffer *dmab)
 	return 0;
 }
 
+#define NOTIFICATION_PARAM_ID 3
+#define NOTIFICATION_MASK 0xf
+
+/* disable notfication for underruns/overruns from firmware module */
+static void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable)
+{
+	struct notification_mask mask;
+	struct skl_ipc_large_config_msg	msg = {0};
+
+	mask.notify = NOTIFICATION_MASK;
+	mask.enable = enable;
+
+	msg.large_param_id = NOTIFICATION_PARAM_ID;
+	msg.param_data_size = sizeof(mask);
+
+	skl_ipc_set_large_config(&ctx->ipc, &msg, (u32 *)&mask);
+}
+
 int skl_init_dsp(struct skl *skl)
 {
 	void __iomem *mmio_base;
@@ -79,7 +97,7 @@ int skl_init_dsp(struct skl *skl)
 
 	ret = skl_sst_dsp_init(bus->dev, mmio_base, irq,
 			loader_ops, &skl->skl_sst);
-
+	skl_dsp_enable_notification(skl->skl_sst, false);
 	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
 
 	return ret;
@@ -122,6 +140,7 @@ int skl_suspend_dsp(struct skl *skl)
 int skl_resume_dsp(struct skl *skl)
 {
 	struct skl_sst *ctx = skl->skl_sst;
+	int ret;
 
 	/* if ppcap is not supported return 0 */
 	if (!skl->ebus.ppcap)
@@ -131,7 +150,12 @@ int skl_resume_dsp(struct skl *skl)
 	snd_hdac_ext_bus_ppcap_enable(&skl->ebus, true);
 	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, true);
 
-	return skl_dsp_wake(ctx->dsp);
+	ret = skl_dsp_wake(ctx->dsp);
+	if (ret < 0)
+		return ret;
+
+	skl_dsp_enable_notification(skl->skl_sst, false);
+	return ret;
 }
 
 enum skl_bitdepth skl_get_bit_depth(int params)
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 2399535a196a..76053a8de41c 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -129,6 +129,11 @@ struct skl_src_module_cfg {
 	enum skl_s_freq src_cfg;
 } __packed;
 
+struct notification_mask {
+	u32 notify;
+	u32 enable;
+} __packed;
+
 struct skl_up_down_mixer_cfg {
 	struct skl_base_cfg base_cfg;
 	enum skl_ch_cfg out_ch_cfg;
-- 
1.9.1
