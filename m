From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nuc900: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Mon, 10 Sep 2018 15:21:42 +0100 (BST)
Message-ID: <20180910142142.2675D1122D51@debutante.sirena.org.uk>
References: <87efe6rur9.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C5EEC267803
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 16:21:42 +0200 (CEST)
In-Reply-To: <87efe6rur9.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: nuc900: use devm_snd_soc_register_component()

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

>From bfacaa8c8956dd6076641043b7be848267a708eb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 7 Sep 2018 01:02:38 +0000
Subject: [PATCH] ASoC: nuc900: use devm_snd_soc_register_component()

Now we have devm_snd_soc_register_component().
Let's use it instead of snd_soc_register_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/nuc900/nuc900-ac97.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 81b09d740ed9..6384bb6dacfd 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -356,7 +356,7 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	ret = snd_soc_register_component(&pdev->dev, &nuc900_ac97_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &nuc900_ac97_component,
 					 &nuc900_ac97_dai, 1);
 	if (ret)
 		goto out;
@@ -373,8 +373,6 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 
 static int nuc900_ac97_drvremove(struct platform_device *pdev)
 {
-	snd_soc_unregister_component(&pdev->dev);
-
 	nuc900_ac97_data = NULL;
 	snd_soc_set_ac97_ops(NULL);
 
-- 
2.19.0.rc1
