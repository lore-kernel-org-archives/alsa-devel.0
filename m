From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: mmp: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:29:04 +0000
Message-ID: <E1elDEG-00034J-Iz@debutante>
References: <87tvvrew7x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B34C2674D6
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:29:08 +0100 (CET)
In-Reply-To: <87tvvrew7x.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: pxa: mmp: replace platform to component

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

>From 797d16971a2a4fc3aafc4e5ff13c7ebfae4bf91b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:48:18 +0000
Subject: [PATCH] ASoC: pxa: mmp: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/mmp-pcm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 624d9bd5dadd..d2d4652de32c 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -25,6 +25,8 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
+#define DRV_NAME "mmp-pcm"
+
 struct mmp_dma_data {
 	int ssp_id;
 	struct resource *dma_res;
@@ -100,7 +102,8 @@ static bool filter(struct dma_chan *chan, void *param)
 static int mmp_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct platform_device *pdev = to_platform_device(component->dev);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct mmp_dma_data dma_data;
 	struct resource *r;
@@ -211,7 +214,8 @@ static int mmp_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static const struct snd_soc_platform_driver mmp_soc_platform = {
+static const struct snd_soc_component_driver mmp_soc_component = {
+	.name		= DRV_NAME,
 	.ops		= &mmp_pcm_ops,
 	.pcm_new	= mmp_pcm_new,
 	.pcm_free	= mmp_pcm_free_dma_buffers,
@@ -231,7 +235,8 @@ static int mmp_pcm_probe(struct platform_device *pdev)
 		mmp_pcm_hardware[SNDRV_PCM_STREAM_CAPTURE].period_bytes_max =
 						pdata->period_max_capture;
 	}
-	return devm_snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
+	return devm_snd_soc_register_component(&pdev->dev, &mmp_soc_component,
+					       NULL, 0);
 }
 
 static struct platform_driver mmp_pcm_driver = {
-- 
2.16.1
