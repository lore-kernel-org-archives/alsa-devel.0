From: jeeja.kp@intel.com
Subject: [PATCH V2 06/10] ASoC: Intel: Skylake: Remove BE
	prepare ops
Date: Mon, 13 Mar 2017 22:11:28 +0530
Message-ID: <1489423292-19997-7-git-send-email-jeeja.kp@intel.com>
References: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F159266CE2
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:29:46 +0100 (CET)
In-Reply-To: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
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

Remove BE prepare ops which enables MCLK by default. If MCLK is required
to be enabled for any specific platform, it needs to be enabled in the
corresponding machine driver.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 635cbb1..e3d206d 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -262,23 +262,6 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
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
@@ -649,7 +632,6 @@ static struct snd_soc_dai_ops skl_dmic_dai_ops = {
 
 static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
 	.hw_params = skl_be_hw_params,
-	.prepare = skl_be_prepare,
 };
 
 static struct snd_soc_dai_ops skl_link_dai_ops = {
-- 
2.5.0
