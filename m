From: jeeja.kp@intel.com
Subject: [PATCH 06/12] ASoC: Intel: Skylake: Remove unused SSP
	BE prepare DAI ops
Date: Fri,  2 Dec 2016 23:11:43 +0530
Message-ID: <1480700509-23380-7-git-send-email-jeeja.kp@intel.com>
References: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EA16F267814
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 18:32:09 +0100 (CET)
In-Reply-To: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Removed unused prepare DAI ops as previous patch uses set_tristate
ops and this is no longer in use so remove the BE DAI prepare opd.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 3c16d41..688d6f7 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -259,23 +259,6 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int skl_be_prepare(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	struct skl *skl = get_skl_ctx(dai->dev);
-	struct skl_sst *ctx = skl->skl_sst;
-	struct skl_module_cfg *mconfig;
-
-	if (dai->playback_widget->power || dai->capture_widget->power)
-		return 0;
-
-	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
-	if (mconfig == NULL)
-		return -EINVAL;
-
-	return skl_dsp_set_dma_control(ctx, mconfig);
-}
-
 static int skl_pcm_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-- 
2.5.0
