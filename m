From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 3/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:51:41 +0100
Message-ID: <20140115165141.3ab93dc1@armhf>
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

The OF pointers are put in the stack and then copied to the card
descriptor.
Put them directly at their right place.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c     | 55 ++++++++--------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple=
-card.c
index 7c5dc73..89f83b3 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -60,8 +60,9 @@ static int asoc_simple_card_dai_init(struct snd_soc_p=
cm_runtime *rtd)
 static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
 			      struct asoc_simple_dai *dai,
-			      struct device_node **node)
+			      const struct device_node **p_node)
 {
+	struct device_node *node;
 	struct clk *clk;
 	int ret;
=20
@@ -69,9 +70,10 @@ asoc_simple_card_sub_parse_of(struct device_node *np=
,
 	 * get node via "sound-dai =3D <&phandle port>"
 	 * it will be used as xxx_of_node on soc_bind_dai_link()
 	 */
-	*node =3D of_parse_phandle(np, "sound-dai", 0);
-	if (!*node)
+	node =3D of_parse_phandle(np, "sound-dai", 0);
+	if (!node)
 		return -ENODEV;
+	*p_node =3D node;
=20
 	/* get dai->name */
 	ret =3D snd_soc_of_get_dai_name(np, &dai->name);
@@ -104,7 +106,7 @@ asoc_simple_card_sub_parse_of(struct device_node *n=
p,
 				     "system-clock-frequency",
 				     &dai->sysclk);
 	} else {
-		clk =3D of_clk_get(*node, 0);
+		clk =3D of_clk_get(node, 0);
 		if (!IS_ERR(clk))
 			dai->sysclk =3D clk_get_rate(clk);
 	}
@@ -112,17 +114,14 @@ asoc_simple_card_sub_parse_of(struct device_node =
*np,
 	ret =3D 0;
=20
 parse_error:
-	of_node_put(*node);
+	of_node_put(node);
=20
 	return ret;
 }
=20
 static int asoc_simple_card_parse_of(struct device_node *node,
 				     struct asoc_simple_card_info *info,
-				     struct device *dev,
-				     struct device_node **of_cpu,
-				     struct device_node **of_codec,
-				     struct device_node **of_platform)
+				     struct device *dev)
 {
 	struct device_node *np;
 	char *name;
@@ -146,7 +145,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
 						  &info->cpu_dai,
-						  of_cpu);
+						  &info->snd_link.cpu_of_node);
 	if (ret < 0)
 		return ret;
=20
@@ -156,7 +155,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
 						  &info->codec_dai,
-						  of_codec);
+						  &info->snd_link.codec_of_node);
 	if (ret < 0)
 		return ret;
=20
@@ -173,7 +172,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 	info->snd_link.name =3D info->snd_link.stream_name =3D name;
=20
 	/* simple-card assumes platform =3D=3D cpu */
-	*of_platform =3D *of_cpu;
+	info->snd_link.platform_of_node =3D info->snd_link.cpu_of_node;
=20
 	dev_dbg(dev, "card-name : %s\n", name);
 	dev_dbg(dev, "platform : %04x\n", info->daifmt);
@@ -193,34 +192,29 @@ static int asoc_simple_card_probe(struct platform=
_device *pdev)
 {
 	struct asoc_simple_card_info *cinfo;
 	struct device_node *np =3D pdev->dev.of_node;
-	struct device_node *of_cpu, *of_codec, *of_platform;
 	struct device *dev =3D &pdev->dev;
 	int ret;
=20
-	cinfo		=3D NULL;
-	of_cpu		=3D NULL;
-	of_codec	=3D NULL;
-	of_platform	=3D NULL;
-
 	cinfo =3D devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
 	if (!cinfo)
 		return -ENOMEM;
=20
+	/*
+	 * init snd_soc_card
+	 */
+	cinfo->snd_card.owner		=3D THIS_MODULE;
+	cinfo->snd_card.dev =3D dev;
+	cinfo->snd_card.dai_link	=3D &cinfo->snd_link;
+	cinfo->snd_card.num_links	=3D 1;
+
 	if (np && of_device_is_available(np)) {
-		cinfo->snd_card.dev =3D dev;
=20
-		ret =3D asoc_simple_card_parse_of(np, cinfo, dev,
-						&of_cpu,
-						&of_codec,
-						&of_platform);
+		ret =3D asoc_simple_card_parse_of(np, cinfo, dev);
 		if (ret < 0) {
 			if (ret !=3D -EPROBE_DEFER)
 				dev_err(dev, "parse error %d\n", ret);
 			return ret;
 		}
-		cinfo->snd_link.cpu_of_node	=3D of_cpu;
-		cinfo->snd_link.codec_of_node	=3D of_codec;
-		cinfo->snd_link.platform_of_node =3D of_platform;
 	} else {
 		if (!dev->platform_data) {
 			dev_err(dev, "no info for asoc-simple-card\n");
@@ -228,8 +222,6 @@ static int asoc_simple_card_probe(struct platform_d=
evice *pdev)
 		}
=20
 		memcpy(cinfo, dev->platform_data, sizeof(*cinfo));
-		cinfo->snd_card.dev =3D dev;
-
 		if (!cinfo->name	||
 		    !cinfo->card	||
 		    !cinfo->codec_dai.name	||
@@ -254,13 +246,6 @@ static int asoc_simple_card_probe(struct platform_=
device *pdev)
 	cinfo->snd_link.codec_dai_name	=3D cinfo->codec_dai.name;
 	cinfo->snd_link.init		=3D asoc_simple_card_dai_init;
=20
-	/*
-	 * init snd_soc_card
-	 */
-	cinfo->snd_card.owner		=3D THIS_MODULE;
-	cinfo->snd_card.dai_link	=3D &cinfo->snd_link;
-	cinfo->snd_card.num_links	=3D 1;
-
 	snd_soc_card_set_drvdata(&cinfo->snd_card, cinfo);
=20
 	return devm_snd_soc_register_card(&pdev->dev, &cinfo->snd_card);
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
