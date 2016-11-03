From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 7/9] ASoC: Intel: Skylake: Add D0i3 mode ref
	counting
Date: Thu,  3 Nov 2016 17:07:20 +0530
Message-ID: <1478173042-9458-8-git-send-email-vinod.koul@intel.com>
References: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id D883C260083
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 12:28:35 +0100 (CET)
In-Reply-To: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org

For device opened/closed, we check the D0i3 capability for the device
and invoke skl_tplg_d0i3_get/put, which counts the use case based on the
mode supported.

These counters are then used to decide if the device can enter D0i3 mode
of streaming or non-streaming or no D0i3.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c      |  5 +++++
 sound/soc/intel/skylake/skl-pcm.c      |  9 ++++++++
 sound/soc/intel/skylake/skl-sst-ipc.c  | 17 +++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h  |  2 ++
 sound/soc/intel/skylake/skl-topology.c | 38 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  3 +++
 6 files changed, 74 insertions(+)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index fed818fe2e69..1f9f33d34000 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -610,10 +610,15 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	if (ret)
 		return ret;
 
+	/* set the D0i3 check */
+	skl->ipc.ops.check_dsp_lp_on = skl_ipc_check_D0i0;
+
 	skl->cores.count = 2;
 	skl->boot_complete = false;
 	init_waitqueue_head(&skl->boot_wait);
 	skl->is_first_boot = true;
+	INIT_DELAYED_WORK(&skl->d0i3.work, bxt_set_dsp_D0i3);
+	skl->d0i3.state = SKL_DSP_D0I3_NONE;
 
 	if (dsp)
 		*dsp = skl;
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index b69e05ec6844..84b5101e6ca6 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -144,6 +144,8 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	struct hdac_ext_stream *stream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct skl_dma_params *dma_params;
+	struct skl *skl = get_skl_ctx(dai->dev);
+	struct skl_module_cfg *mconfig;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
@@ -177,6 +179,9 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	skl_set_suspend_active(substream, dai, true);
 	snd_pcm_set_sync(substream);
 
+	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
+	skl_tplg_d0i3_get(skl, mconfig->d0i3_caps);
+
 	return 0;
 }
 
@@ -302,6 +307,7 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct skl_dma_params *dma_params = NULL;
 	struct skl *skl = ebus_to_skl(ebus);
+	struct skl_module_cfg *mconfig;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
@@ -325,6 +331,9 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 		skl->skl_sst->miscbdcg_disabled = false;
 	}
 
+	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
+	skl_tplg_d0i3_put(skl, mconfig->d0i3_caps);
+
 	kfree(dma_params);
 }
 
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 734408a34a24..594623a4b4cd 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -306,6 +306,23 @@ static void skl_ipc_tx_msg(struct sst_generic_ipc *ipc, struct ipc_message *msg)
 		header->primary | SKL_ADSP_REG_HIPCI_BUSY);
 }
 
+int skl_ipc_check_D0i0(struct sst_dsp *dsp, bool state)
+{
+	int ret;
+
+	/* check D0i3 support */
+	if (!dsp->fw_ops.set_state_D0i0)
+		return 0;
+
+	/* Attempt D0i0 or D0i3 based on state */
+	if (state)
+		ret = dsp->fw_ops.set_state_D0i0(dsp);
+	else
+		ret = dsp->fw_ops.set_state_D0i3(dsp);
+
+	return ret;
+}
+
 static struct ipc_message *skl_ipc_reply_get_msg(struct sst_generic_ipc *ipc,
 				u64 ipc_header)
 {
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 83bf1689f62e..0568f2e8fc57 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -187,6 +187,8 @@ int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
 int skl_ipc_set_d0ix(struct sst_generic_ipc *ipc,
 		struct skl_ipc_d0ix_msg *msg);
 
+int skl_ipc_check_D0i0(struct sst_dsp *dsp, bool state);
+
 void skl_ipc_int_enable(struct sst_dsp *dsp);
 void skl_ipc_op_int_enable(struct sst_dsp *ctx);
 void skl_ipc_op_int_disable(struct sst_dsp *ctx);
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 86597d491982..bd313c907b20 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -36,6 +36,44 @@
 #define SKL_IN_DIR_BIT_MASK		BIT(0)
 #define SKL_PIN_COUNT_MASK		GENMASK(7, 4)
 
+void skl_tplg_d0i3_get(struct skl *skl, enum d0i3_capability caps)
+{
+	struct skl_d0i3_data *d0i3 =  &skl->skl_sst->d0i3;
+
+	switch (caps) {
+	case SKL_D0I3_NONE:
+		d0i3->non_d0i3++;
+		break;
+
+	case SKL_D0I3_STREAMING:
+		d0i3->streaming++;
+		break;
+
+	case SKL_D0I3_NON_STREAMING:
+		d0i3->non_streaming++;
+		break;
+	}
+}
+
+void skl_tplg_d0i3_put(struct skl *skl, enum d0i3_capability caps)
+{
+	struct skl_d0i3_data *d0i3 =  &skl->skl_sst->d0i3;
+
+	switch (caps) {
+	case SKL_D0I3_NONE:
+		d0i3->non_d0i3--;
+		break;
+
+	case SKL_D0I3_STREAMING:
+		d0i3->streaming--;
+		break;
+
+	case SKL_D0I3_NON_STREAMING:
+		d0i3->non_streaming--;
+		break;
+	}
+}
+
 /*
  * SKL DSP driver modelling uses only few DAPM widgets so for rest we will
  * ignore. This helpers checks if the SKL driver handles this widget type
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 38809f6d20d6..3b962d84bcb8 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -369,6 +369,9 @@ struct skl_module_cfg *skl_tplg_fe_get_cpr_module(
 int skl_tplg_update_pipe_params(struct device *dev,
 		struct skl_module_cfg *mconfig, struct skl_pipe_params *params);
 
+void skl_tplg_d0i3_get(struct skl *skl, enum d0i3_capability caps);
+void skl_tplg_d0i3_put(struct skl *skl, enum d0i3_capability caps);
+
 int skl_create_pipeline(struct skl_sst *ctx, struct skl_pipe *pipe);
 
 int skl_run_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
-- 
1.9.1
