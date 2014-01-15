From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 6/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:51:52 +0100
Message-ID: <20140115165152.0ad6e344@armhf>
References: <20140115113551.0eb13409@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140115113551.0eb13409@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

In the non-DT sequence, the platform data is copied as a whole to the
dynamic card info and the same pointer 'cinfo' is used to copy the
platform information to the card.

Use 'priv' as the pointer to the dynamic card info and copy only the
useful information from the platform data.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c     | 34 +++++++++++++---------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple=
-card.c
index 9068ab4..90c6fd5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -195,40 +195,42 @@ static int asoc_simple_card_parse_of(struct devic=
e_node *node,
=20
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
-	struct asoc_simple_card_info *cinfo;
+	struct asoc_simple_card_info *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct device_node *np =3D pdev->dev.of_node;
 	struct device *dev =3D &pdev->dev;
 	int ret;
=20
-	cinfo =3D devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
-	if (!cinfo)
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
=20
 	/*
 	 * init snd_soc_card
 	 */
-	cinfo->snd_card.owner		=3D THIS_MODULE;
-	cinfo->snd_card.dev =3D dev;
-	dai_link =3D &cinfo->snd_link;
-	cinfo->snd_card.dai_link =3D dai_link;
-	cinfo->snd_card.num_links =3D 1;
+	priv->snd_card.owner =3D THIS_MODULE;
+	priv->snd_card.dev =3D dev;
+	dai_link =3D &priv->snd_link;
+	priv->snd_card.dai_link =3D dai_link;
+	priv->snd_card.num_links =3D 1;
=20
 	if (np && of_device_is_available(np)) {
=20
-		ret =3D asoc_simple_card_parse_of(np, cinfo, dev);
+		ret =3D asoc_simple_card_parse_of(np, priv, dev);
 		if (ret < 0) {
 			if (ret !=3D -EPROBE_DEFER)
 				dev_err(dev, "parse error %d\n", ret);
 			return ret;
 		}
 	} else {
-		if (!dev->platform_data) {
+		struct asoc_simple_card_info *cinfo;
+
+		cinfo =3D dev->platform_data;
+		if (!cinfo) {
 			dev_err(dev, "no info for asoc-simple-card\n");
 			return -EINVAL;
 		}
=20
-		memcpy(cinfo, dev->platform_data, sizeof(*cinfo));
 		if (!cinfo->name	||
 		    !cinfo->card	||
 		    !cinfo->codec_dai.name	||
@@ -239,13 +241,17 @@ static int asoc_simple_card_probe(struct platform=
_device *pdev)
 			return -EINVAL;
 		}
=20
-		cinfo->snd_card.name		=3D cinfo->card;
+		priv->snd_card.name	=3D cinfo->card;
 		dai_link->name		=3D cinfo->name;
 		dai_link->stream_name	=3D cinfo->name;
 		dai_link->platform_name	=3D cinfo->platform;
 		dai_link->codec_name	=3D cinfo->codec;
 		dai_link->cpu_dai_name	=3D cinfo->cpu_dai.name;
 		dai_link->codec_dai_name =3D cinfo->codec_dai.name;
+		memcpy(&priv->cpu_dai, &cinfo->cpu_dai,
+						sizeof(priv->cpu_dai));
+		memcpy(&priv->codec_dai, &cinfo->codec_dai,
+						sizeof(priv->codec_dai));
 	}
=20
 	/*
@@ -253,9 +259,9 @@ static int asoc_simple_card_probe(struct platform_d=
evice *pdev)
 	 */
 	dai_link->init =3D asoc_simple_card_dai_init;
=20
-	snd_soc_card_set_drvdata(&cinfo->snd_card, cinfo);
+	snd_soc_card_set_drvdata(&priv->snd_card, priv);
=20
-	return devm_snd_soc_register_card(&pdev->dev, &cinfo->snd_card);
+	return devm_snd_soc_register_card(&pdev->dev, &priv->snd_card);
 }
=20
 static const struct of_device_id asoc_simple_of_match[] =3D {
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
