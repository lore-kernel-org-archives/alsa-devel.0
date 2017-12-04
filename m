From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	msm8916" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:26 +0000
Message-ID: <E1eLvny-0000UN-6U@debutante>
References: <87fuc7kl88.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F19026762F
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:29 +0100 (CET)
In-Reply-To: <87fuc7kl88.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use snd_soc_component_init_regmap() on msm8916

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

>From 42e193cdcb9e197e788638bd33bab3d1905815f6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:06:29 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on msm8916

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 066ea2f4ce7b..44062bb7bf2f 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -712,6 +712,8 @@ static int pm8916_wcd_analog_probe(struct snd_soc_codec *codec)
 		return err;
 	}
 
+	snd_soc_codec_init_regmap(codec,
+				  dev_get_regmap(codec->dev->parent, NULL));
 	snd_soc_codec_set_drvdata(codec, priv);
 	priv->pmic_rev = snd_soc_read(codec, CDC_D_REVISION1);
 	priv->codec_version = snd_soc_read(codec, CDC_D_PERPH_SUBTYPE);
@@ -943,11 +945,6 @@ static int pm8916_wcd_analog_set_jack(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static struct regmap *pm8916_get_regmap(struct device *dev)
-{
-	return dev_get_regmap(dev->parent, NULL);
-}
-
 static irqreturn_t mbhc_btn_release_irq_handler(int irq, void *arg)
 {
 	struct pm8916_wcd_analog_priv *priv = arg;
@@ -1082,7 +1079,6 @@ static const struct snd_soc_codec_driver pm8916_wcd_analog = {
 	.probe = pm8916_wcd_analog_probe,
 	.remove = pm8916_wcd_analog_remove,
 	.set_jack = pm8916_wcd_analog_set_jack,
-	.get_regmap = pm8916_get_regmap,
 	.component_driver = {
 		.controls = pm8916_wcd_analog_snd_controls,
 		.num_controls = ARRAY_SIZE(pm8916_wcd_analog_snd_controls),
-- 
2.15.0
