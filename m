From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 8/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:52:00 +0100
Message-ID: <20140115165200.5f4e6077@armhf>
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

Rename the pointer to the private data structure to 'priv' to avoid con=
fusion with the platform data pointer.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c     | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple=
-card.c
index 0f11c28..6443c87 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -47,18 +47,18 @@ static int __asoc_simple_card_dai_init(struct snd_s=
oc_dai *dai,
=20
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct simple_card_data *info =3D
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
@@ -129,21 +129,21 @@ parse_error:
 }
=20
 static int asoc_simple_card_parse_of(struct device_node *node,
-				     struct simple_card_data *info,
+				     struct simple_card_data *priv,
 				     struct device *dev)
 {
-	struct snd_soc_dai_link *dai_link =3D info->snd_card.dai_link;
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
@@ -154,7 +154,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 	np =3D of_get_child_by_name(node, "simple-audio-card,cpu");
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
-						  &info->cpu_dai,
+						  &priv->cpu_dai,
 						  &dai_link->cpu_of_node,
 						  &dai_link->cpu_dai_name);
 	if (ret < 0)
@@ -165,7 +165,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
 	np =3D of_get_child_by_name(node, "simple-audio-card,codec");
 	if (np)
 		ret =3D asoc_simple_card_sub_parse_of(np,
-						  &info->codec_dai,
+						  &priv->codec_dai,
 						  &dai_link->codec_of_node,
 						  &dai_link->codec_dai_name);
 	if (ret < 0)
@@ -181,22 +181,22 @@ static int asoc_simple_card_parse_of(struct devic=
e_node *node,
 			    GFP_KERNEL);
 	sprintf(name, "%s-%s", dai_link->cpu_dai_name,
 				dai_link->codec_dai_name);
-	info->snd_card.name =3D name;
+	priv->snd_card.name =3D name;
 	dai_link->name =3D dai_link->stream_name =3D name;
=20
 	/* simple-card assumes platform =3D=3D cpu */
 	dai_link->platform_of_node =3D dai_link->cpu_of_node;
=20
 	dev_dbg(dev, "card-name : %s\n", name);
-	dev_dbg(dev, "platform : %04x\n", info->daifmt);
+	dev_dbg(dev, "platform : %04x\n", priv->daifmt);
 	dev_dbg(dev, "cpu : %s / %04x / %d\n",
 		dai_link->cpu_dai_name,
-		info->cpu_dai.fmt,
-		info->cpu_dai.sysclk);
+		priv->cpu_dai.fmt,
+		priv->cpu_dai.sysclk);
 	dev_dbg(dev, "codec : %s / %04x / %d\n",
 		dai_link->codec_dai_name,
-		info->codec_dai.fmt,
-		info->codec_dai.sysclk);
+		priv->codec_dai.fmt,
+		priv->codec_dai.sysclk);
=20
 	return 0;
 }
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
