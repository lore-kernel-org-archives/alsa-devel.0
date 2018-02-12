From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-utils: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:32:51 +0000
Message-ID: <E1elDHv-0003TT-PX@debutante>
References: <87k1y0zj8u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 74DA226791A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:32:55 +0100 (CET)
In-Reply-To: <87k1y0zj8u.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-utils: replace platform to component

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

>From 2d59ebd3e2531c48298e7bee6e621e04fccc4a72 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:40:52 +0000
Subject: [PATCH] ASoC: soc-utils: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index bcd3da2739e2..e237858c9ed4 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -284,7 +284,7 @@ static const struct snd_pcm_ops dummy_dma_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
-static const struct snd_soc_platform_driver dummy_platform = {
+static const struct snd_soc_component_driver dummy_platform = {
 	.ops = &dummy_dma_ops,
 };
 
@@ -342,7 +342,8 @@ static int snd_soc_dummy_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_register_platform(&pdev->dev, &dummy_platform);
+	ret = devm_snd_soc_register_component(&pdev->dev, &dummy_platform,
+					      NULL, 0);
 	if (ret < 0) {
 		snd_soc_unregister_codec(&pdev->dev);
 		return ret;
@@ -353,7 +354,6 @@ static int snd_soc_dummy_probe(struct platform_device *pdev)
 
 static int snd_soc_dummy_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 
 	return 0;
-- 
2.16.1
