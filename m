From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 4/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:51:45 +0100
Message-ID: <20140115165145.2c2da894@armhf>
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

Have a cleaner code using a DAI link pointer.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c     | 29 ++++++++++++----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple=
-card.c
index 89f83b3..797696f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -123,6 +123,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 				     struct asoc_simple_card_info *info,
 				     struct device *dev)
 {
+	struct snd_soc_dai_link *dai_link =3D info->snd_card.dai_link;
 	struct device_node *np;
 	char *name;
 	int ret;
@@ -145,7 +146,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
 						  &info->cpu_dai,
-						  &info->snd_link.cpu_of_node);
+						  &dai_link->cpu_of_node);
 	if (ret < 0)
 		return ret;
=20
@@ -155,7 +156,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
 						  &info->codec_dai,
-						  &info->snd_link.codec_of_node);
+						  &dai_link->codec_of_node);
 	if (ret < 0)
 		return ret;
=20
@@ -169,10 +170,10 @@ static int asoc_simple_card_parse_of(struct devic=
e_node *node,
 			    GFP_KERNEL);
 	sprintf(name, "%s-%s", info->cpu_dai.name, info->codec_dai.name);
 	info->snd_card.name =3D name;
-	info->snd_link.name =3D info->snd_link.stream_name =3D name;
+	dai_link->name =3D dai_link->stream_name =3D name;
=20
 	/* simple-card assumes platform =3D=3D cpu */
-	info->snd_link.platform_of_node =3D info->snd_link.cpu_of_node;
+	dai_link->platform_of_node =3D dai_link->cpu_of_node;
=20
 	dev_dbg(dev, "card-name : %s\n", name);
 	dev_dbg(dev, "platform : %04x\n", info->daifmt);
@@ -191,6 +192,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct asoc_simple_card_info *cinfo;
+	struct snd_soc_dai_link *dai_link;
 	struct device_node *np =3D pdev->dev.of_node;
 	struct device *dev =3D &pdev->dev;
 	int ret;
@@ -204,8 +206,9 @@ static int asoc_simple_card_probe(struct platform_d=
evice *pdev)
 	 */
 	cinfo->snd_card.owner		=3D THIS_MODULE;
 	cinfo->snd_card.dev =3D dev;
-	cinfo->snd_card.dai_link	=3D &cinfo->snd_link;
-	cinfo->snd_card.num_links	=3D 1;
+	dai_link =3D &cinfo->snd_link;
+	cinfo->snd_card.dai_link =3D dai_link;
+	cinfo->snd_card.num_links =3D 1;
=20
 	if (np && of_device_is_available(np)) {
=20
@@ -233,18 +236,18 @@ static int asoc_simple_card_probe(struct platform=
_device *pdev)
 		}
=20
 		cinfo->snd_card.name		=3D cinfo->card;
-		cinfo->snd_link.name		=3D cinfo->name;
-		cinfo->snd_link.stream_name	=3D cinfo->name;
-		cinfo->snd_link.platform_name	=3D cinfo->platform;
-		cinfo->snd_link.codec_name	=3D cinfo->codec;
+		dai_link->name		=3D cinfo->name;
+		dai_link->stream_name	=3D cinfo->name;
+		dai_link->platform_name	=3D cinfo->platform;
+		dai_link->codec_name	=3D cinfo->codec;
 	}
=20
 	/*
 	 * init snd_soc_dai_link
 	 */
-	cinfo->snd_link.cpu_dai_name	=3D cinfo->cpu_dai.name;
-	cinfo->snd_link.codec_dai_name	=3D cinfo->codec_dai.name;
-	cinfo->snd_link.init		=3D asoc_simple_card_dai_init;
+	dai_link->cpu_dai_name	=3D cinfo->cpu_dai.name;
+	dai_link->codec_dai_name =3D cinfo->codec_dai.name;
+	dai_link->init =3D asoc_simple_card_dai_init;
=20
 	snd_soc_card_set_drvdata(&cinfo->snd_card, cinfo);
=20
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
