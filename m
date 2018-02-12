From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: baytrail: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:32:27 +0000
Message-ID: <E1elDHX-0003PJ-MK@debutante>
References: <87mv1jgb4t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C2E32678F2
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:32:32 +0100 (CET)
In-Reply-To: <87mv1jgb4t.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: intel: baytrail: replace platform to component

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

>From 81dc5f3d806ad50283b4b58abebd08ef65817f87 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:42:02 +0000
Subject: [PATCH] ASoC: intel: baytrail: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 66 +++++++++++------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index c54529320f07..aabb35bf6b96 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -23,6 +23,7 @@
 #include "../common/sst-dsp-priv.h"
 #include "../common/sst-dsp.h"
 
+#define DRV_NAME "byt-dai"
 #define BYT_PCM_COUNT		2
 
 static const struct snd_pcm_hardware sst_byt_pcm_hardware = {
@@ -69,8 +70,8 @@ static int sst_byt_pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct sst_byt_priv_data *pdata =
-		snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_byt_priv_data *pdata = snd_soc_component_get_drvdata(component);
 	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 	u32 rate, bits;
@@ -141,8 +142,8 @@ static int sst_byt_pcm_hw_free(struct snd_pcm_substream *substream)
 static int sst_byt_pcm_restore_stream_context(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct sst_byt_priv_data *pdata =
-		snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_byt_priv_data *pdata = snd_soc_component_get_drvdata(component);
 	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 	int ret;
@@ -174,8 +175,8 @@ static void sst_byt_pcm_work(struct work_struct *work)
 static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct sst_byt_priv_data *pdata =
-		snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_byt_priv_data *pdata = snd_soc_component_get_drvdata(component);
 	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 
@@ -216,8 +217,8 @@ static u32 byt_notify_pointer(struct sst_byt_stream *stream, void *data)
 	struct snd_pcm_substream *substream = pcm_data->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct sst_byt_priv_data *pdata =
-		snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_byt_priv_data *pdata = snd_soc_component_get_drvdata(component);
 	struct sst_byt *byt = pdata->byt;
 	u32 pos, hw_pos;
 
@@ -238,8 +239,8 @@ static snd_pcm_uframes_t sst_byt_pcm_pointer(struct snd_pcm_substream *substream
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct sst_byt_priv_data *pdata =
-		snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_byt_priv_data *pdata = snd_soc_component_get_drvdata(component);
 	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 
 	dev_dbg(rtd->dev, "PCM: DMA pointer %u bytes\n", pcm_data->hw_ptr);
@@ -250,8 +251,8 @@ static snd_pcm_uframes_t sst_byt_pcm_pointer(struct snd_pcm_substream *substream
 static int sst_byt_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct sst_byt_priv_data *pdata =
-		snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_byt_priv_data *pdata = snd_soc_component_get_drvdata(component);
 	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 
@@ -278,8 +279,8 @@ static int sst_byt_pcm_open(struct snd_pcm_substream *substream)
 static int sst_byt_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct sst_byt_priv_data *pdata =
-		snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_byt_priv_data *pdata = snd_soc_component_get_drvdata(component);
 	struct sst_byt_pcm_data *pcm_data = &pdata->pcm[substream->stream];
 	struct sst_byt *byt = pdata->byt;
 	int ret;
@@ -324,8 +325,8 @@ static int sst_byt_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
 	size_t size;
-	struct snd_soc_platform *platform = rtd->platform;
-	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_pdata *pdata = dev_get_platdata(component->dev);
 	int ret = 0;
 
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream ||
@@ -366,21 +367,21 @@ static struct snd_soc_dai_driver byt_dais[] = {
 	},
 };
 
-static int sst_byt_pcm_probe(struct snd_soc_platform *platform)
+static int sst_byt_pcm_probe(struct snd_soc_component *component)
 {
-	struct sst_pdata *plat_data = dev_get_platdata(platform->dev);
+	struct sst_pdata *plat_data = dev_get_platdata(component->dev);
 	struct sst_byt_priv_data *priv_data;
 	int i;
 
 	if (!plat_data)
 		return -ENODEV;
 
-	priv_data = devm_kzalloc(platform->dev, sizeof(*priv_data),
+	priv_data = devm_kzalloc(component->dev, sizeof(*priv_data),
 				 GFP_KERNEL);
 	if (!priv_data)
 		return -ENOMEM;
 	priv_data->byt = plat_data->dsp;
-	snd_soc_platform_set_drvdata(platform, priv_data);
+	snd_soc_component_set_drvdata(component, priv_data);
 
 	for (i = 0; i < BYT_PCM_COUNT; i++) {
 		mutex_init(&priv_data->pcm[i].mutex);
@@ -390,22 +391,13 @@ static int sst_byt_pcm_probe(struct snd_soc_platform *platform)
 	return 0;
 }
 
-static int sst_byt_pcm_remove(struct snd_soc_platform *platform)
-{
-	return 0;
-}
-
-static const struct snd_soc_platform_driver byt_soc_platform = {
+static const struct snd_soc_component_driver byt_dai_component = {
+	.name		= DRV_NAME,
 	.probe		= sst_byt_pcm_probe,
-	.remove		= sst_byt_pcm_remove,
 	.ops		= &sst_byt_pcm_ops,
 	.pcm_new	= sst_byt_pcm_new,
 };
 
-static const struct snd_soc_component_driver byt_dai_component = {
-	.name		= "byt-dai",
-};
-
 #ifdef CONFIG_PM
 static int sst_byt_pcm_dev_suspend_late(struct device *dev)
 {
@@ -461,19 +453,13 @@ static int sst_byt_pcm_dev_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return -ENODEV;
 
-	ret = snd_soc_register_platform(&pdev->dev, &byt_soc_platform);
-	if (ret < 0)
-		goto err_plat;
-
-	ret = snd_soc_register_component(&pdev->dev, &byt_dai_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &byt_dai_component,
 					 byt_dais, ARRAY_SIZE(byt_dais));
 	if (ret < 0)
-		goto err_comp;
+		goto err_plat;
 
 	return 0;
 
-err_comp:
-	snd_soc_unregister_platform(&pdev->dev);
 err_plat:
 	sst_byt_dsp_free(&pdev->dev, sst_pdata);
 	return ret;
@@ -483,8 +469,6 @@ static int sst_byt_pcm_dev_remove(struct platform_device *pdev)
 {
 	struct sst_pdata *sst_pdata = dev_get_platdata(&pdev->dev);
 
-	snd_soc_unregister_platform(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
 	sst_byt_dsp_free(&pdev->dev, sst_pdata);
 
 	return 0;
-- 
2.16.1
