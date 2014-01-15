From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 7/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:51:56 +0100
Message-ID: <20140115165156.3e49fb84@armhf>
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

The platform data structure contains information which is used only by
the driver, and the driver allocates platform information fields which
are of no use.
Move the driver specific data to a new private structure and cleanup
the platform data structure.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 include/sound/simple_card.h     |  4 --
 sound/soc/generic/simple-card.c | 14 +++++++++++---
 2 files changed, 11 insertions(+), 7 deletions(-)

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
index 90c6fd5..0f11c28 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -15,6 +15,14 @@
 #include <linux/string.h>
 #include <sound/simple_card.h>
=20
+struct simple_card_data {
+	struct snd_soc_card snd_card;
+	unsigned int daifmt;
+	struct asoc_simple_dai cpu_dai;
+	struct asoc_simple_dai codec_dai;
+	struct snd_soc_dai_link snd_link;
+};
+
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set,
 				       unsigned int daifmt)
@@ -39,7 +47,7 @@ static int __asoc_simple_card_dai_init(struct snd_soc=
_dai *dai,
=20
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct asoc_simple_card_info *info =3D
+	struct simple_card_data *info =3D
 				snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec =3D rtd->codec_dai;
 	struct snd_soc_dai *cpu =3D rtd->cpu_dai;
@@ -121,7 +129,7 @@ parse_error:
 }
=20
 static int asoc_simple_card_parse_of(struct device_node *node,
-				     struct asoc_simple_card_info *info,
+				     struct simple_card_data *info,
 				     struct device *dev)
 {
 	struct snd_soc_dai_link *dai_link =3D info->snd_card.dai_link;
@@ -195,7 +203,7 @@ static int asoc_simple_card_parse_of(struct device_=
node *node,
=20
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
-	struct asoc_simple_card_info *priv;
+	struct simple_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct device_node *np =3D pdev->dev.of_node;
 	struct device *dev =3D &pdev->dev;
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
