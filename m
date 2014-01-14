From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC: simple-card: simplify code
Date: Tue, 14 Jan 2014 12:36:06 +0100
Message-ID: <20140114123606.2241d8ab@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch
- removes the fields of the platform data which are of no use to the
  non-DT platform callers,
- uses a new private structure to handle all the sound card information=
,
- simplifies the code and make easier a possible multi-DAI links extens=
ion.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
Xiubo, I also removed 'of_device_is_available' which seems really
useless: the module is not probed when the DT status is not "okay".
---
 include/sound/simple_card.h      |   4 --
  sound/soc/generic/simple-card.c | 178 ++++++++++-----------
 2 files changed, 88 insertions(+), 94 deletions(-)

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 6c74527..e1ac996 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -29,10 +29,6 @@ struct asoc_simple_card_info {
 	unsigned int daifmt;
 	struct asoc_simple_dai cpu_dai;
 	struct asoc_simple_dai codec_dai;
-
-	/* used in simple-card.c */
-	struct snd_soc_dai_link snd_link;
-	struct snd_soc_card snd_card;
 };
=20
 #endif /* __SIMPLE_CARD_H */
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple=
-card.c
index 5528dd6..580900e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -14,6 +14,13 @@
 #include <linux/module.h>
 #include <sound/simple_card.h>
=20
+struct simple_card_data {
+	struct snd_soc_card snd_card;
+	unsigned int daifmt;
+	struct asoc_simple_dai cpu_dai;
+	struct asoc_simple_dai codec_dai;
+};
+
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set,
 				       unsigned int daifmt)
@@ -38,18 +45,18 @@ static int __asoc_simple_card_dai_init(struct snd_s=
oc_dai *dai,
=20
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct asoc_simple_card_info *info =3D
+	struct simple_card_data *priv =3D
 				snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec =3D rtd->codec_dai;
 	struct snd_soc_dai *cpu =3D rtd->cpu_dai;
-	unsigned int daifmt =3D info->daifmt;
+	unsigned int daifmt =3D priv->daifmt;
 	int ret;
=20
-	ret =3D __asoc_simple_card_dai_init(codec, &info->codec_dai, daifmt);
+	ret =3D __asoc_simple_card_dai_init(codec, &priv->codec_dai, daifmt);
 	if (ret < 0)
 		return ret;
=20
-	ret =3D __asoc_simple_card_dai_init(cpu, &info->cpu_dai, daifmt);
+	ret =3D __asoc_simple_card_dai_init(cpu, &priv->cpu_dai, daifmt);
 	if (ret < 0)
 		return ret;
=20
@@ -59,7 +66,8 @@ static int asoc_simple_card_dai_init(struct snd_soc_p=
cm_runtime *rtd)
 static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
 			      struct asoc_simple_dai *dai,
-			      struct device_node **node)
+			      struct device_node **node,
+			      const char **name)
 {
 	struct clk *clk;
 	int ret;
@@ -73,7 +81,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 		return -ENODEV;
=20
 	/* get dai->name */
-	ret =3D snd_soc_of_get_dai_name(np, &dai->name);
+	ret =3D snd_soc_of_get_dai_name(np, name);
 	if (ret < 0)
 		goto parse_error;
=20
@@ -117,23 +125,21 @@ parse_error:
 }
=20
 static int asoc_simple_card_parse_of(struct device_node *node,
-				     struct asoc_simple_card_info *info,
-				     struct device *dev,
-				     struct device_node **of_cpu,
-				     struct device_node **of_codec,
-				     struct device_node **of_platform)
+				     struct simple_card_data *priv,
+				     struct device *dev)
 {
+	struct snd_soc_dai_link *dai_link =3D priv->snd_card.dai_link;
 	struct device_node *np;
 	char *name;
 	int ret;
=20
 	/* get CPU/CODEC common format via simple-audio-card,format */
-	info->daifmt =3D snd_soc_of_parse_daifmt(node, "simple-audio-card,") =
&
+	priv->daifmt =3D snd_soc_of_parse_daifmt(node, "simple-audio-card,") =
&
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
=20
 	/* DAPM routes */
 	if (of_property_read_bool(node, "simple-audio-card,routing")) {
-		ret =3D snd_soc_of_parse_audio_routing(&info->snd_card,
+		ret =3D snd_soc_of_parse_audio_routing(&priv->snd_card,
 					"simple-audio-card,routing");
 		if (ret)
 			return ret;
@@ -144,8 +150,10 @@ static int asoc_simple_card_parse_of(struct device=
_node *node,
 	np =3D of_get_child_by_name(node, "simple-audio-card,cpu");
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
-						  &info->cpu_dai,
-						  of_cpu);
+						  &priv->cpu_dai,
+					  (struct device_node **)
+						  &dai_link->cpu_of_node,
+						  &dai_link->cpu_dai_name);
 	if (ret < 0)
 		return ret;
=20
@@ -154,109 +162,99 @@ static int asoc_simple_card_parse_of(struct devi=
ce_node *node,
 	np =3D of_get_child_by_name(node, "simple-audio-card,codec");
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
-						  &info->codec_dai,
-						  of_codec);
+						  &priv->codec_dai,
+					  (struct device_node **)
+						  &dai_link->codec_of_node,
+						  &dai_link->codec_dai_name);
 	if (ret < 0)
 		return ret;
=20
 	/* card name is created from CPU/CODEC dai name */
 	name =3D devm_kzalloc(dev,
-			    strlen(info->cpu_dai.name)   +
-			    strlen(info->codec_dai.name) + 2,
+			    strlen(dai_link->cpu_dai_name)   +
+			    strlen(dai_link->codec_dai_name) + 2,
 			    GFP_KERNEL);
-	sprintf(name, "%s-%s", info->cpu_dai.name, info->codec_dai.name);
-	info->name =3D info->card =3D name;
+	sprintf(name, "%s-%s", dai_link->cpu_dai_name, dai_link->codec_dai_na=
me);
+	priv->snd_card.name =3D name;
+	dai_link->name =3D dai_link->stream_name =3D name;
=20
 	/* simple-card assumes platform =3D=3D cpu */
-	*of_platform =3D *of_cpu;
+	dai_link->platform_of_node =3D dai_link->cpu_of_node;
=20
-	dev_dbg(dev, "card-name : %s\n", info->card);
-	dev_dbg(dev, "platform : %04x\n", info->daifmt);
+	dev_dbg(dev, "card-name : %s\n", name);
+	dev_dbg(dev, "platform : %04x\n", priv->daifmt);
 	dev_dbg(dev, "cpu : %s / %04x / %d\n",
-		info->cpu_dai.name,
-		info->cpu_dai.fmt,
-		info->cpu_dai.sysclk);
+		dai_link->cpu_dai_name,
+		priv->cpu_dai.fmt,
+		priv->cpu_dai.sysclk);
 	dev_dbg(dev, "codec : %s / %04x / %d\n",
-		info->codec_dai.name,
-		info->codec_dai.fmt,
-		info->codec_dai.sysclk);
+		dai_link->codec_dai_name,
+		priv->codec_dai.fmt,
+		priv->codec_dai.sysclk);
=20
 	return 0;
 }
=20
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
+	struct simple_card_data *priv;
+	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_card_info *cinfo;
 	struct device_node *np =3D pdev->dev.of_node;
-	struct device_node *of_cpu, *of_codec, *of_platform;
 	struct device *dev =3D &pdev->dev;
=20
-	cinfo		=3D NULL;
-	of_cpu		=3D NULL;
-	of_codec	=3D NULL;
-	of_platform	=3D NULL;
-	if (np && of_device_is_available(np)) {
-		cinfo =3D devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
-		if (cinfo) {
-			int ret;
-			cinfo->snd_card.dev =3D &pdev->dev;
-			ret =3D asoc_simple_card_parse_of(np, cinfo, dev,
-							&of_cpu,
-							&of_codec,
-							&of_platform);
-			if (ret < 0) {
-				if (ret !=3D -EPROBE_DEFER)
-					dev_err(dev, "parse error %d\n", ret);
-				return ret;
-			}
-		} else {
-			return -ENOMEM;
-		}
-	} else {
-		cinfo =3D pdev->dev.platform_data;
-		if (!cinfo) {
-			dev_err(dev, "no info for asoc-simple-card\n");
+	priv =3D devm_kzalloc(dev,
+			sizeof(*priv) + sizeof(*dai_link),
+			GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->snd_card.owner =3D THIS_MODULE;
+	priv->snd_card.dev =3D &pdev->dev;
+	dai_link =3D (struct snd_soc_dai_link *) (priv + 1);
+	priv->snd_card.dai_link =3D dai_link;
+	priv->snd_card.num_links =3D 1;
+
+	cinfo =3D pdev->dev.platform_data;
+	if (cinfo) {
+		if (!cinfo->name	||
+		    !cinfo->card	||
+		    !cinfo->codec_dai.name	||
+		    !cinfo->codec	||
+		    !cinfo->platform	||
+		    !cinfo->cpu_dai.name) {
+			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
 			return -EINVAL;
 		}
=20
-		cinfo->snd_card.dev =3D &pdev->dev;
-	}
-
-	if (!cinfo->name	||
-	    !cinfo->card	||
-	    !cinfo->codec_dai.name	||
-	    !(cinfo->codec		|| of_codec)	||
-	    !(cinfo->platform		|| of_platform)	||
-	    !(cinfo->cpu_dai.name	|| of_cpu)) {
-		dev_err(dev, "insufficient asoc_simple_card_info settings\n");
+		dai_link->name		=3D cinfo->name;
+		dai_link->stream_name	=3D cinfo->name;
+		dai_link->cpu_dai_name	=3D cinfo->cpu_dai.name;
+		dai_link->platform_name	=3D cinfo->platform;
+		dai_link->codec_name	=3D cinfo->codec;
+		dai_link->codec_dai_name =3D cinfo->codec_dai.name;
+		memcpy(&priv->cpu_dai, &cinfo->cpu_dai,
+				sizeof(priv->cpu_dai));
+		memcpy(&priv->codec_dai, &cinfo->codec_dai,
+				sizeof(priv->codec_dai));
+		dai_link->init		=3D asoc_simple_card_dai_init;
+	} else if (np) {
+		int ret;
+
+		ret =3D asoc_simple_card_parse_of(np, priv, dev);
+		if (ret < 0) {
+			if (ret !=3D -EPROBE_DEFER)
+				dev_err(dev, "parse error %d\n", ret);
+			return ret;
+		}
+	} else {
+		dev_err(dev, "no info for asoc-simple-card\n");
 		return -EINVAL;
 	}
=20
-	/*
-	 * init snd_soc_dai_link
-	 */
-	cinfo->snd_link.name		=3D cinfo->name;
-	cinfo->snd_link.stream_name	=3D cinfo->name;
-	cinfo->snd_link.cpu_dai_name	=3D cinfo->cpu_dai.name;
-	cinfo->snd_link.platform_name	=3D cinfo->platform;
-	cinfo->snd_link.codec_name	=3D cinfo->codec;
-	cinfo->snd_link.codec_dai_name	=3D cinfo->codec_dai.name;
-	cinfo->snd_link.cpu_of_node	=3D of_cpu;
-	cinfo->snd_link.codec_of_node	=3D of_codec;
-	cinfo->snd_link.platform_of_node =3D of_platform;
-	cinfo->snd_link.init		=3D asoc_simple_card_dai_init;
-
-	/*
-	 * init snd_soc_card
-	 */
-	cinfo->snd_card.name		=3D cinfo->card;
-	cinfo->snd_card.owner		=3D THIS_MODULE;
-	cinfo->snd_card.dai_link	=3D &cinfo->snd_link;
-	cinfo->snd_card.num_links	=3D 1;
-
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
