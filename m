From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 5/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:51:48 +0100
Message-ID: <20140115165148.2e0e19f3@armhf>
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

The CPU and CODEC DAI names are still copied to the user info structure=
=2E
Put them directly in the DAI links.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c     | 28 ++++++++++++----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple=
-card.c
index 797696f..9068ab4 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -60,7 +60,8 @@ static int asoc_simple_card_dai_init(struct snd_soc_p=
cm_runtime *rtd)
 static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
 			      struct asoc_simple_dai *dai,
-			      const struct device_node **p_node)
+			      const struct device_node **p_node,
+			      const char **name)
 {
 	struct device_node *node;
 	struct clk *clk;
@@ -76,7 +77,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	*p_node =3D node;
=20
 	/* get dai->name */
-	ret =3D snd_soc_of_get_dai_name(np, &dai->name);
+	ret =3D snd_soc_of_get_dai_name(np, name);
 	if (ret < 0)
 		goto parse_error;
=20
@@ -146,7 +147,8 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
 						  &info->cpu_dai,
-						  &dai_link->cpu_of_node);
+						  &dai_link->cpu_of_node,
+						  &dai_link->cpu_dai_name);
 	if (ret < 0)
 		return ret;
=20
@@ -156,19 +158,21 @@ static int asoc_simple_card_parse_of(struct devic=
e_node *node,
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
 						  &info->codec_dai,
-						  &dai_link->codec_of_node);
+						  &dai_link->codec_of_node,
+						  &dai_link->codec_dai_name);
 	if (ret < 0)
 		return ret;
=20
-	if (!info->cpu_dai.name || !info->codec_dai.name)
+	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name)
 		return -EINVAL;
=20
 	/* card name is created from CPU/CODEC dai name */
 	name =3D devm_kzalloc(dev,
-			    strlen(info->cpu_dai.name)   +
-			    strlen(info->codec_dai.name) + 2,
+			    strlen(dai_link->cpu_dai_name)   +
+			    strlen(dai_link->codec_dai_name) + 2,
 			    GFP_KERNEL);
-	sprintf(name, "%s-%s", info->cpu_dai.name, info->codec_dai.name);
+	sprintf(name, "%s-%s", dai_link->cpu_dai_name,
+				dai_link->codec_dai_name);
 	info->snd_card.name =3D name;
 	dai_link->name =3D dai_link->stream_name =3D name;
=20
@@ -178,11 +182,11 @@ static int asoc_simple_card_parse_of(struct devic=
e_node *node,
 	dev_dbg(dev, "card-name : %s\n", name);
 	dev_dbg(dev, "platform : %04x\n", info->daifmt);
 	dev_dbg(dev, "cpu : %s / %04x / %d\n",
-		info->cpu_dai.name,
+		dai_link->cpu_dai_name,
 		info->cpu_dai.fmt,
 		info->cpu_dai.sysclk);
 	dev_dbg(dev, "codec : %s / %04x / %d\n",
-		info->codec_dai.name,
+		dai_link->codec_dai_name,
 		info->codec_dai.fmt,
 		info->codec_dai.sysclk);
=20
@@ -240,13 +244,13 @@ static int asoc_simple_card_probe(struct platform=
_device *pdev)
 		dai_link->stream_name	=3D cinfo->name;
 		dai_link->platform_name	=3D cinfo->platform;
 		dai_link->codec_name	=3D cinfo->codec;
+		dai_link->cpu_dai_name	=3D cinfo->cpu_dai.name;
+		dai_link->codec_dai_name =3D cinfo->codec_dai.name;
 	}
=20
 	/*
 	 * init snd_soc_dai_link
 	 */
-	dai_link->cpu_dai_name	=3D cinfo->cpu_dai.name;
-	dai_link->codec_dai_name =3D cinfo->codec_dai.name;
 	dai_link->init =3D asoc_simple_card_dai_init;
=20
 	snd_soc_card_set_drvdata(&cinfo->snd_card, cinfo);
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
