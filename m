From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/9] ASoC: Intel: Skylake: remove
	pm_runtime_get/put calls
Date: Fri, 13 Nov 2015 19:22:05 +0530
Message-ID: <1447422733-2484-2-git-send-email-vinod.koul@intel.com>
References: <1447422733-2484-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F359265AD3
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 14:48:46 +0100 (CET)
In-Reply-To: <1447422733-2484-1-git-send-email-vinod.koul@intel.com>
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

The ASoC core already does pm_runtime_get/put in the core before
opening/closing the devices.
So we do not need to do this is driver, hence remove

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index e652d58bd9a9..a96909f8a29a 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -112,12 +112,8 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	struct hdac_ext_stream *stream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct skl_dma_params *dma_params;
-	int ret;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
-	ret = pm_runtime_get_sync(dai->dev);
-	if (ret < 0)
-		return ret;
 
 	stream = snd_hdac_ext_stream_assign(ebus, substream,
 					skl_get_host_stream_type(ebus));
@@ -262,8 +258,6 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 	 */
 	snd_soc_dai_set_dma_data(dai, substream, NULL);
 
-	pm_runtime_mark_last_busy(dai->dev);
-	pm_runtime_put_autosuspend(dai->dev);
 	kfree(dma_params);
 }
 
@@ -512,19 +506,6 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int skl_be_startup(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	return pm_runtime_get_sync(dai->dev);
-}
-
-static void skl_be_shutdown(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	pm_runtime_mark_last_busy(dai->dev);
-	pm_runtime_put_autosuspend(dai->dev);
-}
-
 static struct snd_soc_dai_ops skl_pcm_dai_ops = {
 	.startup = skl_pcm_open,
 	.shutdown = skl_pcm_close,
@@ -535,24 +516,18 @@ static struct snd_soc_dai_ops skl_pcm_dai_ops = {
 };
 
 static struct snd_soc_dai_ops skl_dmic_dai_ops = {
-	.startup = skl_be_startup,
 	.hw_params = skl_be_hw_params,
-	.shutdown = skl_be_shutdown,
 };
 
 static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
-	.startup = skl_be_startup,
 	.hw_params = skl_be_hw_params,
-	.shutdown = skl_be_shutdown,
 };
 
 static struct snd_soc_dai_ops skl_link_dai_ops = {
-	.startup = skl_be_startup,
 	.prepare = skl_link_pcm_prepare,
 	.hw_params = skl_link_hw_params,
 	.hw_free = skl_link_hw_free,
 	.trigger = skl_link_pcm_trigger,
-	.shutdown = skl_be_shutdown,
 };
 
 static struct snd_soc_dai_driver skl_platform_dai[] = {
-- 
1.9.1
