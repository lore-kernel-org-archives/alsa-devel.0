From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Tue, 11 Sep 2018 12:27:01 +0100 (BST)
Message-ID: <20180911112701.5A9CC1121AF8@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C60222676EB
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 13:27:01 +0200 (CEST)
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

   ASoC: bcm: use devm_snd_soc_register_component()

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

>From 570f75b93551a6d70ecbd0a7b6d962b4ca4722f0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 7 Sep 2018 01:00:49 +0000
Subject: [PATCH] ASoC: bcm: use devm_snd_soc_register_component()

Now we have devm_snd_soc_register_component().
Let's use it instead of snd_soc_register_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-ssp.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index b733f1446353..b7c358b48d8d 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1334,7 +1334,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	cygaud->active_ports = 0;
 
 	dev_dbg(dev, "Registering %d DAIs\n", active_port_count);
-	err = snd_soc_register_component(dev, &cygnus_ssp_component,
+	err = devm_snd_soc_register_component(dev, &cygnus_ssp_component,
 				cygnus_ssp_dai, active_port_count);
 	if (err) {
 		dev_err(dev, "snd_soc_register_dai failed\n");
@@ -1345,32 +1345,27 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	if (cygaud->irq_num <= 0) {
 		dev_err(dev, "platform_get_irq failed\n");
 		err = cygaud->irq_num;
-		goto err_irq;
+		return err;
 	}
 
 	err = audio_clk_init(pdev, cygaud);
 	if (err) {
 		dev_err(dev, "audio clock initialization failed\n");
-		goto err_irq;
+		return err;
 	}
 
 	err = cygnus_soc_platform_register(dev, cygaud);
 	if (err) {
 		dev_err(dev, "platform reg error %d\n", err);
-		goto err_irq;
+		return err;
 	}
 
 	return 0;
-
-err_irq:
-	snd_soc_unregister_component(dev);
-	return err;
 }
 
 static int cygnus_ssp_remove(struct platform_device *pdev)
 {
 	cygnus_soc_platform_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
 }
-- 
2.19.0.rc2
