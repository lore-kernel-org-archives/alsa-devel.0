From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Tue, 11 Sep 2018 12:20:45 +0100 (BST)
Message-ID: <20180911112045.5903C1121AF8@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C3375267795
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 13:20:45 +0200 (CEST)
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

   ASoC: omap: use devm_snd_soc_register_component()

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

>From 642a722d3116fbd22e59ac027f81b5ecd285f17c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 7 Sep 2018 01:02:54 +0000
Subject: [PATCH] ASoC: omap: use devm_snd_soc_register_component()

Now we have devm_snd_soc_register_component().
Let's use it instead of snd_soc_register_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-hdmi-audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 8a99a8837dc9..673a9eb153b2 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -348,7 +348,7 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	default:
 		return -EINVAL;
 	}
-	ret = snd_soc_register_component(ad->dssdev, &omap_hdmi_component,
+	ret = devm_snd_soc_register_component(ad->dssdev, &omap_hdmi_component,
 					 dai_drv, 1);
 	if (ret)
 		return ret;
@@ -383,7 +383,6 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(dev, "snd_soc_register_card failed (%d)\n", ret);
-		snd_soc_unregister_component(ad->dssdev);
 		return ret;
 	}
 
@@ -400,7 +399,6 @@ static int omap_hdmi_audio_remove(struct platform_device *pdev)
 	struct hdmi_audio_data *ad = platform_get_drvdata(pdev);
 
 	snd_soc_unregister_card(ad->card);
-	snd_soc_unregister_component(ad->dssdev);
 	return 0;
 }
 
-- 
2.19.0.rc2
