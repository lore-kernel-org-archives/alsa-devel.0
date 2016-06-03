From: jeeja.kp@intel.com
Subject: [PATCH 06/10] ASoC: Intel: Skylake: Clean up of driver
	resources in suspend
Date: Fri,  3 Jun 2016 18:29:39 +0530
Message-ID: <1464958783-19344-7-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 31A842661B0
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:56:34 +0200 (CEST)
In-Reply-To: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

On suspend firmware is re-initialized so resources are reset inside
firmware. Driver should also clear the firmware counters at this time.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c      | 12 +++++++--
 sound/soc/intel/skylake/skl-sst-ipc.h  |  1 +
 sound/soc/intel/skylake/skl-sst.c      | 10 +++++++
 sound/soc/intel/skylake/skl-topology.c | 49 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c          |  1 +
 sound/soc/intel/skylake/skl.h          |  2 ++
 6 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index ff04917..1590bef 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1197,9 +1197,17 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(platform->dev);
+	struct skl *skl = ebus_to_skl(ebus);
+	int ret;
 
-	if (ebus->ppcap)
-		return skl_tplg_init(platform, ebus);
+	if (ebus->ppcap) {
+		ret = skl_tplg_init(platform, ebus);
+		if (ret < 0) {
+			dev_err(platform->dev, "Failed to init topology!\n");
+			return ret;
+		}
+		skl->platform = platform;
+	}
 
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 7b55182..9f24261 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -139,5 +139,6 @@ void skl_ipc_int_disable(struct sst_dsp *dsp);
 bool skl_ipc_int_status(struct sst_dsp *dsp);
 void skl_ipc_free(struct sst_generic_ipc *ipc);
 int skl_ipc_init(struct device *dev, struct skl_sst *skl);
+void skl_clear_module_cnt(struct sst_dsp *ctx);
 
 #endif /* __SKL_IPC_H */
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 6021fa6..4cabae5 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -379,6 +379,16 @@ static int skl_unload_module(struct sst_dsp *ctx, u16 mod_id)
 	return ret;
 }
 
+void skl_clear_module_cnt(struct sst_dsp *ctx)
+{
+	struct skl_module_table *module;
+
+	list_for_each_entry(module, &ctx->module_list, list) {
+		module->usage_cnt = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(skl_clear_module_cnt);
+
 static void skl_clear_module_table(struct sst_dsp *ctx)
 {
 	struct skl_module_table *module, *tmp;
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 67b1ab5..263c03d 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1557,6 +1557,55 @@ static void skl_tplg_fill_fmt(struct skl_module_fmt *dst_fmt,
 	}
 }
 
+static void skl_clear_pin_config(struct snd_soc_platform *platform,
+				struct snd_soc_dapm_widget *w)
+{
+	int i;
+	struct skl_module_cfg *mconfig;
+	struct skl_pipe *pipe;
+
+	if (!strncmp(w->dapm->component->name, platform->component.name,
+					strlen(platform->component.name))) {
+		mconfig = w->priv;
+		pipe = mconfig->pipe;
+		for (i = 0; i < mconfig->max_in_queue; i++) {
+			mconfig->m_in_pin[i].in_use = false;
+			mconfig->m_in_pin[i].pin_state = SKL_PIN_UNBIND;
+		}
+		for (i = 0; i < mconfig->max_out_queue; i++) {
+			mconfig->m_out_pin[i].in_use = false;
+			mconfig->m_out_pin[i].pin_state = SKL_PIN_UNBIND;
+		}
+		pipe->state = SKL_PIPE_INVALID;
+		mconfig->m_state = SKL_MODULE_UNINIT;
+	}
+}
+
+void skl_cleanup_resources(struct skl *skl)
+{
+	struct skl_sst *ctx = skl->skl_sst;
+	struct snd_soc_platform *soc_platform = skl->platform;
+	struct snd_soc_dapm_widget *w;
+	struct snd_soc_card *card;
+
+	if (soc_platform == NULL)
+		return;
+
+	card = soc_platform->component.card;
+	if (!card || !card->instantiated)
+		return;
+
+	skl->resource.mem = 0;
+	skl->resource.mcps = 0;
+
+	list_for_each_entry(w, &card->widgets, list) {
+		if (is_skl_dsp_widget_type(w) && (w->priv != NULL))
+			skl_clear_pin_config(soc_platform, w);
+	}
+
+	skl_clear_module_cnt(ctx->dsp);
+}
+
 /*
  * Topology core widget load callback
  *
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 5a08826..1e62900 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -199,6 +199,7 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 	skl_enable_miscbdcge(bus->dev, false);
 	snd_hdac_bus_enter_link_reset(bus);
 	skl_enable_miscbdcge(bus->dev, true);
+	skl_cleanup_resources(skl);
 
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index bd8db1d..98fc87a 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -67,6 +67,7 @@ struct skl {
 	unsigned int init_failed:1; /* delayed init failed */
 	struct platform_device *dmic_dev;
 	struct platform_device *i2s_dev;
+	struct snd_soc_platform *platform;
 
 	struct nhlt_acpi_table *nhlt; /* nhlt ptr */
 	struct skl_sst *skl_sst; /* sst skl ctx */
@@ -115,4 +116,5 @@ int skl_init_dsp(struct skl *skl);
 int skl_free_dsp(struct skl *skl);
 int skl_suspend_dsp(struct skl *skl);
 int skl_resume_dsp(struct skl *skl);
+void skl_cleanup_resources(struct skl *skl);
 #endif /* __SOUND_SOC_SKL_H */
-- 
2.5.0
