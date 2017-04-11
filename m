From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hisilicon: Use
	devm_snd_soc_register_component" to the asoc tree
Date: Tue, 11 Apr 2017 21:42:03 +0100
Message-ID: <E1cy2bz-0007zu-Pt@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA1F6266DCC
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 22:42:11 +0200 (CEST)
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
To: John Stultz <john.stultz@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hisilicon: Use devm_snd_soc_register_component

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

>From e6d56d21bdcfd8968c1859bc1892608acad3e6d8 Mon Sep 17 00:00:00 2001
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 11 Apr 2017 12:15:18 -0700
Subject: [PATCH] ASoC: hisilicon: Use devm_snd_soc_register_component

Per feedback from Mark Brown, this patch updates the hi6210-i2s
driver to use devm_snd_soc_register_component which simplifies
the logic a bit.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/hisilicon/hi6210-i2s.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 27553dca7cc6..45163e5202f5 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -591,22 +591,9 @@ static int hi6210_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_register_component(&pdev->dev, &hi6210_i2s_i2s_comp,
+	ret = devm_snd_soc_register_component(&pdev->dev, &hi6210_i2s_i2s_comp,
 					 &i2s->dai, 1);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register dai\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int hi6210_i2s_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-	dev_set_drvdata(&pdev->dev, NULL);
-
-	return 0;
+	return ret;
 }
 
 static const struct of_device_id hi6210_i2s_dt_ids[] = {
@@ -618,7 +605,6 @@ MODULE_DEVICE_TABLE(of, hi6210_i2s_dt_ids);
 
 static struct platform_driver hi6210_i2s_driver = {
 	.probe = hi6210_i2s_probe,
-	.remove = hi6210_i2s_remove,
 	.driver = {
 		.name = "hi6210_i2s",
 		.of_match_table = hi6210_i2s_dt_ids,
-- 
2.11.0
