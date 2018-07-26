From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: align axg card driver with DT
	bindings documentation" to the asoc tree
Date: Thu, 26 Jul 2018 16:01:39 +0100 (BST)
Message-ID: <20180726150139.F013E440078@finisterre.ee.mobilebroadband>
References: <20180726124544.14740-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 38A452677A1
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 17:01:41 +0200 (CEST)
In-Reply-To: <20180726124544.14740-4-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: align axg card driver with DT bindings documentation

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

>From 435857e015dc7b337c5f21d195ac2e4ffd694283 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 26 Jul 2018 14:45:44 +0200
Subject: [PATCH] ASoC: meson: align axg card driver with DT bindings
 documentation

Drop amlogic prefix in front of the generic DT properties and change
property "name" to "model".

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-card.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index d6d1081d94ad..2914ba0d965b 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -123,7 +123,7 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	struct snd_soc_aux_dev *aux;
 	int num, i;
 
-	num = of_count_phandle_with_args(node, PREFIX "aux-devs", NULL);
+	num = of_count_phandle_with_args(node, "audio-aux-devs", NULL);
 	if (num == -ENOENT) {
 		/*
 		 * It is ok to have no auxiliary devices but for this card it
@@ -144,8 +144,8 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	card->num_aux_devs = num;
 
 	for (i = 0; i < card->num_aux_devs; i++, aux++) {
-		aux->codec_of_node = of_parse_phandle(node,
-						      PREFIX "aux-devs", i);
+		aux->codec_of_node =
+			of_parse_phandle(node, "audio-aux-devs", i);
 		if (!aux->codec_of_node)
 			return -EINVAL;
 	}
@@ -610,18 +610,18 @@ static int axg_card_probe(struct platform_device *pdev)
 	priv->card.owner = THIS_MODULE;
 	priv->card.dev = dev;
 
-	ret = snd_soc_of_parse_card_name(&priv->card, PREFIX "name");
+	ret = snd_soc_of_parse_card_name(&priv->card, "model");
 	if (ret < 0)
 		return ret;
 
-	ret = axg_card_parse_of_optional(&priv->card, PREFIX "routing",
+	ret = axg_card_parse_of_optional(&priv->card, "audio-routing",
 					 snd_soc_of_parse_audio_routing);
 	if (ret) {
 		dev_err(dev, "error while parsing routing\n");
 		return ret;
 	}
 
-	ret = axg_card_parse_of_optional(&priv->card, PREFIX "widgets",
+	ret = axg_card_parse_of_optional(&priv->card, "audio-widgets",
 					 snd_soc_of_parse_audio_simple_widgets);
 	if (ret) {
 		dev_err(dev, "error while parsing widgets\n");
-- 
2.18.0
