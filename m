From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Disable notifications
	at boot after DSP FW init" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:29 +0000
Message-ID: <E1coDQP-0002GR-MM@debutante>
References: <1488910446-26415-8-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7331C267056
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:38 +0100 (CET)
In-Reply-To: <1488910446-26415-8-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: G Kranthi <gudishax.kranthikumar@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Disable notifications at boot after DSP FW init

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

>From cb729d80b5c556acf38f1f04a1f0550472a75987 Mon Sep 17 00:00:00 2001
From: G Kranthi <gudishax.kranthikumar@intel.com>
Date: Mon, 13 Mar 2017 22:11:29 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Disable notifications at boot after DSP
 FW init

DSP firmware sends notification every 1ms, which is disabled in runtime
suspend. But if a system has no runtime pm, we keep getting
notification, so disable after FW init as well.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-pcm.c      | 1 +
 sound/soc/intel/skylake/skl-sst-dsp.h  | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ed576965cacc..29523ddcfab0 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -58,7 +58,7 @@ static int skl_free_dma_buf(struct device *dev, struct snd_dma_buffer *dmab)
 #define NOTIFICATION_MASK 0xf
 
 /* disable notfication for underruns/overruns from firmware module */
-static void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable)
+void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable)
 {
 	struct notification_mask mask;
 	struct skl_ipc_large_config_msg	msg = {0};
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index e3d206d50f3e..2f90bc40be77 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1214,6 +1214,7 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 		}
 		skl_populate_modules(skl);
 		skl->skl_sst->update_d0i3c = skl_update_d0i3c;
+		skl_dsp_enable_notification(skl->skl_sst, false);
 	}
 	pm_runtime_mark_last_busy(platform->dev);
 	pm_runtime_put_autosuspend(platform->dev);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 849410d0823e..e8d1e149e0cd 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -235,4 +235,6 @@ int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
+void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable);
+
 #endif /*__SKL_SST_DSP_H__*/
-- 
2.11.0
