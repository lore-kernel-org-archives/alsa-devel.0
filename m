From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8524: remove unnecessary
	snd_soc_unregister_platform()" to the asoc tree
Date: Wed, 23 Aug 2017 12:24:54 +0100
Message-ID: <E1dkTmI-0007Dm-Qu@debutante>
References: <87o9r6x4b5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C554267328
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:25:00 +0200 (CEST)
In-Reply-To: <87o9r6x4b5.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8524: remove unnecessary snd_soc_unregister_platform()

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

>From 6cbcad079ecdb8ecd214d33688fd7f19167fe57a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 23 Aug 2017 05:11:44 +0000
Subject: [PATCH] ASoC: wm8524: remove unnecessary
 snd_soc_unregister_platform()

wm8524 doesn't register platform, unregister platform is not needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8524.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index b66147e0631b..856a6950a451 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -233,10 +233,8 @@ static int wm8524_codec_probe(struct platform_device *pdev)
 
 	ret =  snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm8524, &wm8524_dai, 1);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
-		snd_soc_unregister_platform(&pdev->dev);
-	}
 
 	return ret;
 }
-- 
2.14.1
