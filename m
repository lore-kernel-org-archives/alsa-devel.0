From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uda134x: Move state struct allocation
	to bus probe" to the asoc tree
Date: Mon, 13 Jul 2015 12:16:59 +0100
Message-ID: <E1ZEbjH-0006ev-TA@debutante>
References: <1436783208-1529-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 113632604D6
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:17:06 +0200 (CEST)
In-Reply-To: <1436783208-1529-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uda134x: Move state struct allocation to bus probe

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

>From f15c444e58ed5b5dfc6056249ef8a74d00118be3 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 13 Jul 2015 12:26:45 +0200
Subject: [PATCH] ASoC: uda134x: Move state struct allocation to bus probe

Resource allocations should be done in the bus probe rather than the CODEC
probe. Move the allocation of the drivers state struct there.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/uda134x.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 913edf283239..a89f98a773d6 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -478,8 +478,8 @@ static struct snd_soc_dai_driver uda134x_dai = {
 static int uda134x_soc_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct uda134x_priv *uda134x;
 	struct uda134x_platform_data *pd = codec->component.card->dev->platform_data;
+	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 	const struct snd_soc_dapm_widget *widgets;
 	unsigned num_widgets;
 
@@ -506,10 +506,6 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	uda134x = kzalloc(sizeof(struct uda134x_priv), GFP_KERNEL);
-	if (uda134x == NULL)
-		return -ENOMEM;
-	snd_soc_codec_set_drvdata(codec, uda134x);
 
 	codec->control_data = pd;
 
@@ -530,7 +526,6 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 	if (ret) {
 		printk(KERN_ERR "%s failed to register dapm controls: %d",
 			__func__, ret);
-		kfree(uda134x);
 		return ret;
 	}
 
@@ -551,31 +546,19 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 	default:
 		printk(KERN_ERR "%s unknown codec type: %d",
 			__func__, pd->model);
-		kfree(uda134x);
 		return -EINVAL;
 	}
 
 	if (ret < 0) {
 		printk(KERN_ERR "UDA134X: failed to register controls\n");
-		kfree(uda134x);
 		return ret;
 	}
 
 	return 0;
 }
 
-/* power down chip */
-static int uda134x_soc_remove(struct snd_soc_codec *codec)
-{
-	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
-
-	kfree(uda134x);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 	.probe =        uda134x_soc_probe,
-	.remove =       uda134x_soc_remove,
 	.reg_cache_size = sizeof(uda134x_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = uda134x_reg,
@@ -592,6 +575,14 @@ static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 
 static int uda134x_codec_probe(struct platform_device *pdev)
 {
+	struct uda134x_priv *uda134x;
+
+	uda134x = devm_kzalloc(&pdev->dev, sizeof(*uda134x), GFP_KERNEL);
+	if (!uda134x)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, uda134x);
+
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_uda134x, &uda134x_dai, 1);
 }
-- 
2.1.4
