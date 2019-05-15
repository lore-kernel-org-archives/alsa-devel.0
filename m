From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH RESEND V6 2/3] ASoC: fsl_asrc: replace the process_option
 table with function
Date: Wed, 15 May 2019 06:42:22 +0000
Message-ID: <7d683186c3de9314e361fd4ead42f9691968e65c.1557901312.git.shengjiu.wang@nxp.com>
References: <cover.1557901312.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1557901312.git.shengjiu.wang@nxp.com>
Content-Language: en-US
Content-ID: <5C0AFBBD663E6B41ADF889F596EA3EFA@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

When we want to support more sample rate, for example 12kHz/24kHz
we need update the process_option table, if we want to support more
sample rate next time, the table need to be updated again. which
is not flexible.

We got a function fsl_asrc_sel_proc to replace the table, which can
give the pre-processing and post-processing options according to
the sample rate.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 71 +++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index ea035c12a325..a8d6710f2541 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -26,24 +26,6 @@
 #define pair_dbg(fmt, ...) \
 	dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS_=
_)
=20
-/* Sample rates are aligned with that defined in pcm.h file */
-static const u8 process_option[][12][2] =3D {
-	/* 8kHz 11.025kHz 16kHz 22.05kHz 32kHz 44.1kHz 48kHz   64kHz   88.2kHz 96=
kHz   176kHz  192kHz */
-	{{0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, =
{0, 0}, {0, 0}, {0, 0},},	/* 5512Hz */
-	{{0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, =
{0, 0}, {0, 0}, {0, 0},},	/* 8kHz */
-	{{0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, =
{0, 0}, {0, 0}, {0, 0},},	/* 11025Hz */
-	{{1, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, =
{0, 0}, {0, 0}, {0, 0},},	/* 16kHz */
-	{{1, 2}, {1, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, =
{0, 0}, {0, 0}, {0, 0},},	/* 22050Hz */
-	{{1, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, =
{0, 0}, {0, 0}, {0, 0},},	/* 32kHz */
-	{{2, 2}, {2, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, =
{0, 1}, {0, 0}, {0, 0},},	/* 44.1kHz */
-	{{2, 2}, {2, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, =
{0, 1}, {0, 0}, {0, 0},},	/* 48kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 1}, {1, 2}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, =
{0, 1}, {0, 1}, {0, 0},},	/* 64kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, =
{1, 1}, {1, 1}, {1, 1},},	/* 88.2kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, =
{1, 1}, {1, 1}, {1, 1},},	/* 96kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, =
{2, 1}, {2, 1}, {2, 1},},	/* 176kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, =
{2, 1}, {2, 1}, {2, 1},},	/* 192kHz */
-};
-
 /* Corresponding to process_option */
 static int supported_input_rate[] =3D {
 	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
@@ -79,6 +61,52 @@ static unsigned char output_clk_map_imx53[] =3D {
=20
 static unsigned char *clk_map[2];
=20
+/**
+ * Select the pre-processing and post-processing options
+ * Make sure to exclude following unsupported cases before
+ * calling this function:
+ * 1) inrate > 8.125 * outrate
+ * 2) inrate > 16.125 * outrate
+ *
+ * inrate: input sample rate
+ * outrate: output sample rate
+ * pre_proc: return value for pre-processing option
+ * post_proc: return value for post-processing option
+ */
+static void fsl_asrc_sel_proc(int inrate, int outrate,
+			     int *pre_proc, int *post_proc)
+{
+	bool post_proc_cond2;
+	bool post_proc_cond0;
+
+	/* select pre_proc between [0, 2] */
+	if (inrate * 8 > 33 * outrate)
+		*pre_proc =3D 2;
+	else if (inrate * 8 > 15 * outrate) {
+		if (inrate > 152000)
+			*pre_proc =3D 2;
+		else
+			*pre_proc =3D 1;
+	} else if (inrate < 76000)
+		*pre_proc =3D 0;
+	else if (inrate > 152000)
+		*pre_proc =3D 2;
+	else
+		*pre_proc =3D 1;
+
+	/* Condition for selection of post-processing */
+	post_proc_cond2 =3D (inrate * 15 > outrate * 16 && outrate < 56000) ||
+			  (inrate > 56000 && outrate < 56000);
+	post_proc_cond0 =3D inrate * 23 < outrate * 8;
+
+	if (post_proc_cond2)
+		*post_proc =3D 2;
+	else if (post_proc_cond0)
+		*post_proc =3D 0;
+	else
+		*post_proc =3D 1;
+}
+
 /**
  * Request ASRC pair
  *
@@ -239,6 +267,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *p=
air)
 	u32 inrate, outrate, indiv, outdiv;
 	u32 clk_index[2], div[2];
 	int in, out, channels;
+	int pre_proc, post_proc;
 	struct clk *clk;
 	bool ideal;
=20
@@ -377,11 +406,13 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair =
*pair)
 			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
 			   ASRCTR_IDR(index) | ASRCTR_USR(index));
=20
+	fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
+
 	/* Apply configurations for pre- and post-processing */
 	regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
 			   ASRCFG_PREMODi_MASK(index) |	ASRCFG_POSTMODi_MASK(index),
-			   ASRCFG_PREMOD(index, process_option[in][out][0]) |
-			   ASRCFG_POSTMOD(index, process_option[in][out][1]));
+			   ASRCFG_PREMOD(index, pre_proc) |
+			   ASRCFG_POSTMOD(index, post_proc));
=20
 	return fsl_asrc_set_ideal_ratio(pair, inrate, outrate);
 }
--=20
2.21.0
