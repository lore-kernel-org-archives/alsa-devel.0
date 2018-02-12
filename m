From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-generic-dmaengine-pcm: replace
	platform to component" to the asoc tree
Date: Mon, 12 Feb 2018 12:32:48 +0000
Message-ID: <E1elDHs-0003Sb-Gl@debutante>
References: <87r2qvgb6l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E077926790A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:32:52 +0100 (CET)
In-Reply-To: <87r2qvgb6l.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-generic-dmaengine-pcm: replace platform to component

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

>From be7ee5f32a9a4eba881d18e85d58e9a03a9cca99 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:41:09 +0000
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: replace platform to
 component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/dmaengine_pcm.h         |  2 ++
 sound/soc/soc-generic-dmaengine-pcm.c | 55 +++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 67be2445941a..8a5a8404966e 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -161,4 +161,6 @@ int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct dma_slave_config *slave_config);
 
+#define SND_DMAENGINE_PCM_DRV_NAME "snd_dmaengine_pcm"
+
 #endif
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index d53786498b61..c07d5c79ca91 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -33,13 +33,13 @@
 struct dmaengine_pcm {
 	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
 	const struct snd_dmaengine_pcm_config *config;
-	struct snd_soc_platform platform;
+	struct snd_soc_component component;
 	unsigned int flags;
 };
 
-static struct dmaengine_pcm *soc_platform_to_pcm(struct snd_soc_platform *p)
+static struct dmaengine_pcm *soc_component_to_pcm(struct snd_soc_component *p)
 {
-	return container_of(p, struct dmaengine_pcm, platform);
+	return container_of(p, struct dmaengine_pcm, component);
 }
 
 static struct device *dmaengine_dma_dev(struct dmaengine_pcm *pcm,
@@ -88,7 +88,9 @@ static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SND_DMAENGINE_PCM_DRV_NAME);
+	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
 	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params,
@@ -119,7 +121,9 @@ static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
 static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SND_DMAENGINE_PCM_DRV_NAME);
+	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 	struct device *dma_dev = dmaengine_dma_dev(pcm, substream);
 	struct dma_chan *chan = pcm->chan[substream->stream];
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -206,7 +210,9 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 static int dmaengine_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SND_DMAENGINE_PCM_DRV_NAME);
+	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 	struct dma_chan *chan = pcm->chan[substream->stream];
 	int ret;
 
@@ -221,7 +227,9 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	struct snd_soc_pcm_runtime *rtd,
 	struct snd_pcm_substream *substream)
 {
-	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SND_DMAENGINE_PCM_DRV_NAME);
+	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	dma_filter_fn fn = NULL;
 
@@ -260,9 +268,11 @@ static bool dmaengine_pcm_can_report_residue(struct device *dev,
 
 static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
-	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SND_DMAENGINE_PCM_DRV_NAME);
+	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 	const struct snd_dmaengine_pcm_config *config = pcm->config;
-	struct device *dev = rtd->platform->dev;
+	struct device *dev = component->dev;
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct snd_pcm_substream *substream;
 	size_t prealloc_buffer_size;
@@ -296,7 +306,7 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		}
 
 		if (!pcm->chan[i]) {
-			dev_err(rtd->platform->dev,
+			dev_err(component->dev,
 				"Missing dma channel for stream: %d\n", i);
 			return -EINVAL;
 		}
@@ -320,7 +330,9 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 	struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SND_DMAENGINE_PCM_DRV_NAME);
+	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		return snd_dmaengine_pcm_pointer_no_residue(substream);
@@ -338,10 +350,9 @@ static const struct snd_pcm_ops dmaengine_pcm_ops = {
 	.pointer	= dmaengine_pcm_pointer,
 };
 
-static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
-	.component_driver = {
-		.probe_order = SND_SOC_COMP_ORDER_LATE,
-	},
+static const struct snd_soc_component_driver dmaengine_pcm_component = {
+	.name		= SND_DMAENGINE_PCM_DRV_NAME,
+	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 	.ops		= &dmaengine_pcm_ops,
 	.pcm_new	= dmaengine_pcm_new,
 };
@@ -438,8 +449,8 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (ret)
 		goto err_free_dma;
 
-	ret = snd_soc_add_platform(dev, &pcm->platform,
-		&dmaengine_pcm_platform);
+	ret = snd_soc_add_component(dev, &pcm->component,
+				    &dmaengine_pcm_component, NULL, 0);
 	if (ret)
 		goto err_free_dma;
 
@@ -461,16 +472,16 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
  */
 void snd_dmaengine_pcm_unregister(struct device *dev)
 {
-	struct snd_soc_platform *platform;
+	struct snd_soc_component *component;
 	struct dmaengine_pcm *pcm;
 
-	platform = snd_soc_lookup_platform(dev);
-	if (!platform)
+	component = snd_soc_lookup_component(dev, SND_DMAENGINE_PCM_DRV_NAME);
+	if (!component)
 		return;
 
-	pcm = soc_platform_to_pcm(platform);
+	pcm = soc_component_to_pcm(component);
 
-	snd_soc_remove_platform(platform);
+	snd_soc_unregister_component(dev);
 	dmaengine_pcm_release_chan(pcm);
 	kfree(pcm);
 }
-- 
2.16.1
