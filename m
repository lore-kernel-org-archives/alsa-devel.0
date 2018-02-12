From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: blackfin: bf5xx-ac97-pcm: replace
	platform to component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:47 +0000
Message-ID: <E1elDDz-0002zq-3u@debutante>
References: <87mv1jew59.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C34812673A2
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:50 +0100 (CET)
In-Reply-To: <87mv1jew59.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: blackfin: bf5xx-ac97-pcm: replace platform to component

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

>From 825f90183bdb6cf02a818a699137191806e088a2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:49:43 +0000
Subject: [PATCH] ASoC: blackfin: bf5xx-ac97-pcm: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 8c1d1983b8f9..08bceb519c29 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -453,7 +453,7 @@ static int bf5xx_pcm_ac97_new(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static struct snd_soc_platform_driver bf5xx_ac97_soc_platform = {
+static struct snd_soc_component_driver bf5xx_ac97_soc_component = {
 	.ops			= &bf5xx_pcm_ac97_ops,
 	.pcm_new	= bf5xx_pcm_ac97_new,
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
@@ -461,8 +461,8 @@ static struct snd_soc_platform_driver bf5xx_ac97_soc_platform = {
 
 static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return devm_snd_soc_register_platform(&pdev->dev,
-					      &bf5xx_ac97_soc_platform);
+	return devm_snd_soc_register_component(&pdev->dev,
+					&bf5xx_ac97_soc_component, NULL, 0);
 }
 
 static struct platform_driver bf5xx_pcm_driver = {
-- 
2.16.1
