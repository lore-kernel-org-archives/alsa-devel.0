From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 2/9] ASoC: Intel: Skylake: Use num_core to
	allocate instead of macro
Date: Wed,  2 Aug 2017 21:51:13 +0530
Message-ID: <20170802162120.8935-3-guneshwor.o.singh@intel.com>
References: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B6AC267346
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 18:25:26 +0200 (CEST)
In-Reply-To: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

For different platforms, number of dsp cores can vary. So instead of
creating array of size SKL_DSP_CORES_MAX, use num_core in dsp_ops() of
the respective platform to allocate core usage counts and states.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 18 +++++++++++++++++-
 sound/soc/intel/skylake/skl-sst-dsp.c  |  2 +-
 sound/soc/intel/skylake/skl-sst-ipc.h  |  6 ++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 7892e445e87b..c6b60ee5b196 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -253,6 +253,7 @@ int skl_init_dsp(struct skl *skl)
 	struct skl_dsp_loader_ops loader_ops;
 	int irq = bus->irq;
 	const struct skl_dsp_ops *ops;
+	struct skl_dsp_cores *cores;
 	int ret;
 
 	/* enable ppcap interrupt */
@@ -279,7 +280,19 @@ int skl_init_dsp(struct skl *skl)
 		return ret;
 
 	skl->skl_sst->dsp_ops = ops;
-	skl->skl_sst->cores.count = ops->num_cores;
+	cores = &skl->skl_sst->cores;
+	cores->count = ops->num_cores;
+
+	cores->state = kcalloc(cores->count, sizeof(*cores->state), GFP_KERNEL);
+	if (!cores->state)
+		return -ENOMEM;
+
+	cores->usage_count = kcalloc(cores->count, sizeof(*cores->usage_count),
+				     GFP_KERNEL);
+	if (!cores->usage_count) {
+		kfree(cores->state);
+		return -ENOMEM;
+	}
 
 	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
 
@@ -297,6 +310,9 @@ int skl_free_dsp(struct skl *skl)
 
 	ctx->dsp_ops->cleanup(bus->dev, ctx);
 
+	kfree(ctx->cores.state);
+	kfree(ctx->cores.usage_count);
+
 	if (ctx->dsp->addr.lpe)
 		iounmap(ctx->dsp->addr.lpe);
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 08332723c700..c2ba5ff1632c 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -47,7 +47,7 @@ void skl_dsp_init_core_state(struct sst_dsp *ctx)
 	skl->cores.state[SKL_DSP_CORE0_ID] = SKL_DSP_RUNNING;
 	skl->cores.usage_count[SKL_DSP_CORE0_ID] = 1;
 
-	for (i = SKL_DSP_CORE0_ID + 1; i < SKL_DSP_CORES_MAX; i++) {
+	for (i = SKL_DSP_CORE0_ID + 1; i < skl->cores.count; i++) {
 		skl->cores.state[i] = SKL_DSP_RESET;
 		skl->cores.usage_count[i] = 0;
 	}
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index e057da2713c6..e485e8f5ea2c 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -44,12 +44,10 @@ struct skl_ipc_header {
 	u32 extension;
 };
 
-#define SKL_DSP_CORES_MAX  2
-
 struct skl_dsp_cores {
 	unsigned int count;
-	enum skl_dsp_states state[SKL_DSP_CORES_MAX];
-	int usage_count[SKL_DSP_CORES_MAX];
+	enum skl_dsp_states *state;
+	int *usage_count;
 };
 
 /**
-- 
2.13.0
