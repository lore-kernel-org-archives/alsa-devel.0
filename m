From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Tue, 11 Sep 2018 12:18:48 +0100 (BST)
Message-ID: <20180911111848.153661121AF8@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B43D7267795
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 13:18:48 +0200 (CEST)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh: use devm_snd_soc_register_component()

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

>From afa88ee37b1383490df003ea005d1d9bc8afa8a8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 7 Sep 2018 01:03:25 +0000
Subject: [PATCH] ASoC: sh: use devm_snd_soc_register_component()

Now we have devm_snd_soc_register_component().
Let's use it instead of snd_soc_register_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/hac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index c2b496398e6b..17622ceb98c0 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -319,13 +319,12 @@ static int hac_soc_platform_probe(struct platform_device *pdev)
 	if (ret != 0)
 		return ret;
 
-	return snd_soc_register_component(&pdev->dev, &sh4_hac_component,
+	return devm_snd_soc_register_component(&pdev->dev, &sh4_hac_component,
 					  sh4_hac_dai, ARRAY_SIZE(sh4_hac_dai));
 }
 
 static int hac_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_set_ac97_ops(NULL);
 	return 0;
 }
-- 
2.19.0.rc2
