From: jeeja.kp@intel.com
Subject: [PATCH 07/10] ASoC: Intel: Skylake: Disable
	notifications at boot after DSP FW init
Date: Tue,  7 Mar 2017 23:44:03 +0530
Message-ID: <1488910446-26415-8-git-send-email-jeeja.kp@intel.com>
References: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 34AB2267098
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 19:02:30 +0100 (CET)
In-Reply-To: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, G Kranthi <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: G Kranthi <gudishax.kranthikumar@intel.com>

DSP firmware sends notification every 1m, which is disabled in runtime
suspend. But if a system has no runtime pm, we keep getting
notification, so disable after FW init as well.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-pcm.c      | 1 +
 sound/soc/intel/skylake/skl-sst-dsp.h  | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ed57696..29523dd 100644
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
index a5d46f7..270fec7 100644
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
index 849410d..e8d1e14 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -235,4 +235,6 @@ int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
+void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable);
+
 #endif /*__SKL_SST_DSP_H__*/
-- 
2.5.0
