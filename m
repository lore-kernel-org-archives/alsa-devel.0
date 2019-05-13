From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH V2 2/2] ASoC: ak4458: add return value for ak4458_probe
Date: Mon, 13 May 2019 10:02:44 +0000
Message-ID: <1557741724-6859-3-git-send-email-viorel.suman@nxp.com>
References: <1557741724-6859-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557741724-6859-1-git-send-email-viorel.suman@nxp.com>
Content-Language: en-US
Content-ID: <C61FD3D585FC4C449B7408E138CAF8C6@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Viorel Suman <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

AK4458 is probed successfully even if AK4458 is not present - this
is caused by probe function returning no error on i2c access failure.
Return an error on probe if i2c access has failed.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/codecs/ak4458.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index baf990a..7156215 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -539,9 +539,10 @@ static void ak4458_power_on(struct ak4458_priv *ak4458=
)
 	}
 }
=20
-static void ak4458_init(struct snd_soc_component *component)
+static int ak4458_init(struct snd_soc_component *component)
 {
 	struct ak4458_priv *ak4458 =3D snd_soc_component_get_drvdata(component);
+	int ret;
=20
 	/* External Mute ON */
 	if (ak4458->mute_gpiod)
@@ -549,21 +550,21 @@ static void ak4458_init(struct snd_soc_component *com=
ponent)
=20
 	ak4458_power_on(ak4458);
=20
-	snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
+	ret =3D snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
 			    0x80, 0x80);   /* ACKS bit =3D 1; 10000000 */
+	if (ret < 0)
+		return ret;
=20
-	ak4458_rstn_control(component, 1);
+	return ak4458_rstn_control(component, 1);
 }
=20
 static int ak4458_probe(struct snd_soc_component *component)
 {
 	struct ak4458_priv *ak4458 =3D snd_soc_component_get_drvdata(component);
=20
-	ak4458_init(component);
-
 	ak4458->fs =3D 48000;
=20
-	return 0;
+	return ak4458_init(component);
 }
=20
 static void ak4458_remove(struct snd_soc_component *component)
--=20
2.7.4
