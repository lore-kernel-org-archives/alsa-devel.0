From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: remove
	pm_runtime_get/put calls" to the asoc tree
Date: Wed, 18 Nov 2015 18:47:15 +0000
Message-ID: <E1Zz7lD-0001Ou-2S@debutante>
References: <1447422733-2484-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5021265B90
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:47:20 +0100 (CET)
In-Reply-To: <1447422733-2484-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: remove pm_runtime_get/put calls

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

>From 28823f1538ce2f67b7c21e30d6b84c3e86f8c0fd Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 13 Nov 2015 19:22:05 +0530
Subject: [PATCH] ASoC: Intel: Skylake: remove pm_runtime_get/put calls

The ASoC core already does pm_runtime_get/put in the core before
opening/closing the devices.
So we do not need to do this is driver, hence remove

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index c8d942887348..dae332beea3f 100644
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
2.6.2
