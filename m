From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: au1x: dma: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:28 +0000
Message-ID: <E1elDDg-0002wK-7U@debutante>
References: <87h8rrew3c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E190D267396
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:31 +0100 (CET)
In-Reply-To: <87h8rrew3c.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: au1x: dma: replace platform to component

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

>From 781a9fcccae535d3f46cd05177366c7e67aa01ef Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:50:54 +0000
Subject: [PATCH] ASoC: au1x: dma: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 19457e2b351e..efff1e293a1b 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -21,6 +21,8 @@
 
 #include "psc.h"
 
+#define DRV_NAME "au1x_dma"
+
 struct pcm_period {
 	u32 start;
 	u32 relative_end;	/* relative to start of buffer */
@@ -174,7 +176,8 @@ static const struct snd_pcm_hardware alchemy_pcm_hardware = {
 static inline struct alchemy_pcm_ctx *ss_to_ctx(struct snd_pcm_substream *ss)
 {
 	struct snd_soc_pcm_runtime *rtd = ss->private_data;
-	return snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	return snd_soc_component_get_drvdata(component);
 }
 
 static inline struct audio_stream *ss_to_as(struct snd_pcm_substream *ss)
@@ -297,7 +300,8 @@ static int alchemy_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_platform_driver alchemy_pcm_soc_platform = {
+static struct snd_soc_component_driver alchemy_pcm_soc_component = {
+	.name		= DRV_NAME,
 	.ops		= &alchemy_pcm_ops,
 	.pcm_new	= alchemy_pcm_new,
 };
@@ -312,8 +316,8 @@ static int alchemy_pcm_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
-	return devm_snd_soc_register_platform(&pdev->dev,
-					      &alchemy_pcm_soc_platform);
+	return devm_snd_soc_register_component(&pdev->dev,
+					&alchemy_pcm_soc_component, NULL, 0);
 }
 
 static struct platform_driver alchemy_pcmdma_driver = {
-- 
2.16.1
