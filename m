From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Configure DSP clock
	source" to the asoc tree
Date: Wed, 06 Dec 2017 17:49:33 +0000
Message-ID: <E1eMdp7-0004mA-Tb@debutante>
References: <20171128111021.11830-5-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 071E9267A39
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:49:36 +0100 (CET)
In-Reply-To: <20171128111021.11830-5-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Configure DSP clock source

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9452314d92d600e8702533b10f10ec440aad5db9 Mon Sep 17 00:00:00 2001
From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Date: Wed, 6 Dec 2017 16:34:03 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Configure DSP clock source

DSP clock source is configured by sending the A-State table to the FW.
Add the large config set IPC to configure the desired clock source

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 18 ++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c      |  6 ++++++
 sound/soc/intel/skylake/skl-sst-dsp.h  |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index f637829833e6..4e63213a8d55 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -55,6 +55,19 @@ static int skl_free_dma_buf(struct device *dev, struct snd_dma_buffer *dmab)
 	return 0;
 }
 
+#define SKL_ASTATE_PARAM_ID	4
+
+void skl_dsp_set_astate_cfg(struct skl_sst *ctx, u32 cnt, void *data)
+{
+	struct skl_ipc_large_config_msg	msg = {0};
+
+	msg.large_param_id = SKL_ASTATE_PARAM_ID;
+	msg.param_data_size = (cnt * sizeof(struct skl_astate_param) +
+				sizeof(cnt));
+
+	skl_ipc_set_large_config(&ctx->ipc, &msg, data);
+}
+
 #define NOTIFICATION_PARAM_ID 3
 #define NOTIFICATION_MASK 0xf
 
@@ -409,6 +422,11 @@ int skl_resume_dsp(struct skl *skl)
 		return ret;
 
 	skl_dsp_enable_notification(skl->skl_sst, false);
+
+	if (skl->cfg.astate_cfg != NULL) {
+		skl_dsp_set_astate_cfg(skl->skl_sst, skl->cfg.astate_cfg->count,
+					skl->cfg.astate_cfg);
+	}
 	return ret;
 }
 
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 18138dc872d9..cc6535ab84d1 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1350,6 +1350,12 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 		skl_populate_modules(skl);
 		skl->skl_sst->update_d0i3c = skl_update_d0i3c;
 		skl_dsp_enable_notification(skl->skl_sst, false);
+
+		if (skl->cfg.astate_cfg != NULL) {
+			skl_dsp_set_astate_cfg(skl->skl_sst,
+					skl->cfg.astate_cfg->count,
+					skl->cfg.astate_cfg);
+		}
 	}
 	pm_runtime_mark_last_busy(platform->dev);
 	pm_runtime_put_autosuspend(platform->dev);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index eba20d37ba8c..b8e799ed65ef 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -251,6 +251,9 @@ void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
 void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable);
+
+void skl_dsp_set_astate_cfg(struct skl_sst *ctx, u32 cnt, void *data);
+
 int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 		struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp,
 		struct sst_dsp_device *skl_dev);
-- 
2.15.0
