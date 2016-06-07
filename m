From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Clean up of driver
	resources in suspend" to the asoc tree
Date: Tue, 07 Jun 2016 14:27:42 +0100
Message-ID: <E1bAH2k-0001ga-41@debutante>
References: <1464958783-19344-7-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 296D126657D
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:27:48 +0200 (CEST)
In-Reply-To: <1464958783-19344-7-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Clean up of driver resources in suspend

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

>From fe3f4442e2166453f68f0995fd4a95e98c0cd1c9 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Fri, 3 Jun 2016 18:29:39 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Clean up of driver resources in suspend

On suspend firmware is re-initialized so resources are reset inside
firmware. Driver should also clear the firmware counters at this time.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      | 12 +++++++--
 sound/soc/intel/skylake/skl-sst-ipc.h  |  1 +
 sound/soc/intel/skylake/skl-sst.c      | 10 +++++++
 sound/soc/intel/skylake/skl-topology.c | 49 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c          |  1 +
 sound/soc/intel/skylake/skl.h          |  2 ++
 6 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index ff0491716e06..1590beff644d 100644
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
index 7b55182b7895..9f24261abf3e 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -139,5 +139,6 @@ void skl_ipc_int_disable(struct sst_dsp *dsp);
 bool skl_ipc_int_status(struct sst_dsp *dsp);
 void skl_ipc_free(struct sst_generic_ipc *ipc);
 int skl_ipc_init(struct device *dev, struct skl_sst *skl);
+void skl_clear_module_cnt(struct sst_dsp *ctx);
 
 #endif /* __SKL_IPC_H */
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 6021fa6ed80d..4cabae54a71e 100644
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
index 67b1ab501918..263c03df9a2a 100644
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
index cb3eb41524ec..c0f5d5565dea 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -201,6 +201,7 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 	skl_enable_miscbdcge(bus->dev, false);
 	snd_hdac_bus_enter_link_reset(bus);
 	skl_enable_miscbdcge(bus->dev, true);
+	skl_cleanup_resources(skl);
 
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 25b8d4897ff5..9064e5b0d676 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -67,6 +67,7 @@ struct skl {
 	unsigned int init_failed:1; /* delayed init failed */
 	struct platform_device *dmic_dev;
 	struct platform_device *i2s_dev;
+	struct snd_soc_platform *platform;
 
 	struct nhlt_acpi_table *nhlt; /* nhlt ptr */
 	struct skl_sst *skl_sst; /* sst skl ctx */
@@ -121,4 +122,5 @@ int skl_init_dsp(struct skl *skl);
 int skl_free_dsp(struct skl *skl);
 int skl_suspend_dsp(struct skl *skl);
 int skl_resume_dsp(struct skl *skl);
+void skl_cleanup_resources(struct skl *skl);
 #endif /* __SOUND_SOC_SKL_H */
-- 
2.8.1
