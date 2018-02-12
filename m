From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-pcm: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:40 +0000
Message-ID: <E1elDDs-0002y3-1C@debutante>
References: <87k1wnew4b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BAF6F267428
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:43 +0100 (CET)
In-Reply-To: <87k1wnew4b.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: omap-pcm: replace platform to component

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

>From 703c13e447f84a7ed8315938719540ea05ad5045 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:50:19 +0000
Subject: [PATCH] ASoC: omap-pcm: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-pcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index aca2c43d0f03..778cc8f75b6a 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -243,7 +243,7 @@ static int omap_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static const struct snd_soc_platform_driver omap_soc_platform = {
+static const struct snd_soc_component_driver omap_soc_component = {
 	.ops		= &omap_pcm_ops,
 	.pcm_new	= omap_pcm_new,
 	.pcm_free	= omap_pcm_free_dma_buffers,
@@ -252,7 +252,8 @@ static const struct snd_soc_platform_driver omap_soc_platform = {
 int omap_pcm_platform_register(struct device *dev)
 {
 	omap_pcm_limit_supported_formats();
-	return devm_snd_soc_register_platform(dev, &omap_soc_platform);
+	return devm_snd_soc_register_component(dev, &omap_soc_component,
+					       NULL, 0);
 }
 EXPORT_SYMBOL_GPL(omap_pcm_platform_register);
 
-- 
2.16.1
