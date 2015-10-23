From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support to disable
	module notifications" to the asoc tree
Date: Sat, 24 Oct 2015 02:47:44 +0900
Message-ID: <E1ZpgRM-0006U0-Lt@finisterre>
References: <1445536362-26670-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CC0826516A
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:47:53 +0200 (CEST)
In-Reply-To: <1445536362-26670-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support to disable module notifications

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

>From 4e10996ba810031a493d903539f595e053826103 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 22 Oct 2015 23:22:39 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support to disable module
 notifications

Each FW modules can report underrun/overrun notification from
all modules. This patch disables underrun/overrun notification after
firmware is loaded.
This will be supportted for debug mode only thru debugfs

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 28 ++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl-topology.h |  5 +++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 77c0736..ca7bbee 100644
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
index 2399535..76053a8 100644
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
2.6.1
