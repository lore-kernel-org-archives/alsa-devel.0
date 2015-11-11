From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/9] ASoC: Intel: Skylake: remove BE startup
	dai ops
Date: Thu, 12 Nov 2015 00:16:41 +0530
Message-ID: <1447267609-27816-2-git-send-email-vinod.koul@intel.com>
References: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 42FDF2606A5
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 19:43:35 +0100 (CET)
In-Reply-To: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

We have moved the runtime calls from BE startup to HW params, this helps to
optimize the unnecessary wakes due to users opening and closing device
As a result startup is empty so remove that

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index e652d58bd9a9..3ccfa7be95cb 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -285,6 +285,8 @@ static int skl_be_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
+	int ret;
+
 	struct skl_pipe_params p_params = {0};
 
 	p_params.s_fmt = snd_pcm_format_width(params_format(params));
@@ -292,7 +294,11 @@ static int skl_be_hw_params(struct snd_pcm_substream *substream,
 	p_params.s_freq = params_rate(params);
 	p_params.stream = substream->stream;
 
-	return skl_tplg_be_update_params(dai, &p_params);
+	ret = skl_tplg_be_update_params(dai, &p_params);
+	if (ret < 0)
+		return ret;
+
+	return pm_runtime_get_sync(dai->dev);
 }
 
 static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
@@ -402,6 +408,11 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	struct skl_dma_params *dma_params;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct skl_pipe_params p_params = {0};
+	int ret;
+
+	ret = pm_runtime_get_sync(dai->dev);
+	if (ret < 0)
+		return ret;
 
 	link_dev = snd_hdac_ext_stream_assign(ebus, substream,
 					HDAC_EXT_STREAM_TYPE_LINK);
@@ -512,12 +523,6 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int skl_be_startup(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	return pm_runtime_get_sync(dai->dev);
-}
-
 static void skl_be_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -535,19 +540,16 @@ static struct snd_soc_dai_ops skl_pcm_dai_ops = {
 };
 
 static struct snd_soc_dai_ops skl_dmic_dai_ops = {
-	.startup = skl_be_startup,
 	.hw_params = skl_be_hw_params,
 	.shutdown = skl_be_shutdown,
 };
 
 static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
-	.startup = skl_be_startup,
 	.hw_params = skl_be_hw_params,
 	.shutdown = skl_be_shutdown,
 };
 
 static struct snd_soc_dai_ops skl_link_dai_ops = {
-	.startup = skl_be_startup,
 	.prepare = skl_link_pcm_prepare,
 	.hw_params = skl_link_hw_params,
 	.hw_free = skl_link_hw_free,
-- 
1.9.1
