From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 1/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:51:33 +0100
Message-ID: <20140115165133.507595c9@armhf>
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

The check of the mandatory fields is done for DT in its specific sequen=
ce.
Move the global check to the non-DT sequence.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple=
-card.c
index 2a1b1b5..f0784ca 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -225,16 +225,16 @@ static int asoc_simple_card_probe(struct platform=
_device *pdev)
=20
 		memcpy(cinfo, dev->platform_data, sizeof(*cinfo));
 		cinfo->snd_card.dev =3D dev;
-	}
=20
-	if (!cinfo->name	||
-	    !cinfo->card	||
-	    !cinfo->codec_dai.name	||
-	    !(cinfo->codec		|| of_codec)	||
-	    !(cinfo->platform		|| of_platform)	||
-	    !(cinfo->cpu_dai.name	|| of_cpu)) {
-		dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-		return -EINVAL;
+		if (!cinfo->name	||
+		    !cinfo->card	||
+		    !cinfo->codec_dai.name	||
+		    !cinfo->codec	||
+		    !cinfo->platform	||
+		    !cinfo->cpu_dai.name) {
+			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
+			return -EINVAL;
+		}
 	}
=20
 	/*
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
