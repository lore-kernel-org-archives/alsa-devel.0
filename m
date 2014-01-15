From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 2/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:51:37 +0100
Message-ID: <20140115165137.5fec601b@armhf>
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

The DT values are copied to the non-DT structure before being moved to
the card structure.
Set directly the DT values in the card and move the non-DT copy to the
non-DT sequence.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c     | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple=
-card.c
index f0784ca..7c5dc73 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -169,12 +169,13 @@ static int asoc_simple_card_parse_of(struct devic=
e_node *node,
 			    strlen(info->codec_dai.name) + 2,
 			    GFP_KERNEL);
 	sprintf(name, "%s-%s", info->cpu_dai.name, info->codec_dai.name);
-	info->name =3D info->card =3D name;
+	info->snd_card.name =3D name;
+	info->snd_link.name =3D info->snd_link.stream_name =3D name;
=20
 	/* simple-card assumes platform =3D=3D cpu */
 	*of_platform =3D *of_cpu;
=20
-	dev_dbg(dev, "card-name : %s\n", info->card);
+	dev_dbg(dev, "card-name : %s\n", name);
 	dev_dbg(dev, "platform : %04x\n", info->daifmt);
 	dev_dbg(dev, "cpu : %s / %04x / %d\n",
 		info->cpu_dai.name,
@@ -217,6 +218,9 @@ static int asoc_simple_card_probe(struct platform_d=
evice *pdev)
 				dev_err(dev, "parse error %d\n", ret);
 			return ret;
 		}
+		cinfo->snd_link.cpu_of_node	=3D of_cpu;
+		cinfo->snd_link.codec_of_node	=3D of_codec;
+		cinfo->snd_link.platform_of_node =3D of_platform;
 	} else {
 		if (!dev->platform_data) {
 			dev_err(dev, "no info for asoc-simple-card\n");
@@ -235,26 +239,24 @@ static int asoc_simple_card_probe(struct platform=
_device *pdev)
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
 			return -EINVAL;
 		}
+
+		cinfo->snd_card.name		=3D cinfo->card;
+		cinfo->snd_link.name		=3D cinfo->name;
+		cinfo->snd_link.stream_name	=3D cinfo->name;
+		cinfo->snd_link.platform_name	=3D cinfo->platform;
+		cinfo->snd_link.codec_name	=3D cinfo->codec;
 	}
=20
 	/*
 	 * init snd_soc_dai_link
 	 */
-	cinfo->snd_link.name		=3D cinfo->name;
-	cinfo->snd_link.stream_name	=3D cinfo->name;
 	cinfo->snd_link.cpu_dai_name	=3D cinfo->cpu_dai.name;
-	cinfo->snd_link.platform_name	=3D cinfo->platform;
-	cinfo->snd_link.codec_name	=3D cinfo->codec;
 	cinfo->snd_link.codec_dai_name	=3D cinfo->codec_dai.name;
-	cinfo->snd_link.cpu_of_node	=3D of_cpu;
-	cinfo->snd_link.codec_of_node	=3D of_codec;
-	cinfo->snd_link.platform_of_node =3D of_platform;
 	cinfo->snd_link.init		=3D asoc_simple_card_dai_init;
=20
 	/*
 	 * init snd_soc_card
 	 */
-	cinfo->snd_card.name		=3D cinfo->card;
 	cinfo->snd_card.owner		=3D THIS_MODULE;
 	cinfo->snd_card.dai_link	=3D &cinfo->snd_link;
 	cinfo->snd_card.num_links	=3D 1;
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
