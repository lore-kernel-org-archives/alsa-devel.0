From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH] ASoC: fsl_spdif: fix sysclk_df type
Date: Mon, 18 Feb 2019 15:25:00 +0000
Message-ID: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to RM SPDIF STC SYSCLK_DF field is 9-bit wide, values
being in 0..511 range. Use a proper type to handle sysclk_df.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index a26686e..4842e6d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -96,7 +96,7 @@ struct fsl_spdif_priv {
 	bool dpll_locked;
 	u32 txrate[SPDIF_TXRATE_MAX];
 	u8 txclk_df[SPDIF_TXRATE_MAX];
-	u8 sysclk_df[SPDIF_TXRATE_MAX];
+	u16 sysclk_df[SPDIF_TXRATE_MAX];
 	u8 txclk_src[SPDIF_TXRATE_MAX];
 	u8 rxclk_src;
 	struct clk *txclk[SPDIF_TXRATE_MAX];
@@ -376,7 +376,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substre=
am *substream,
 	struct platform_device *pdev =3D spdif_priv->pdev;
 	unsigned long csfs =3D 0;
 	u32 stc, mask, rate;
-	u8 clk, txclk_df, sysclk_df;
+	u16 sysclk_df;
+	u8 clk, txclk_df;
 	int ret;
=20
 	switch (sample_rate) {
@@ -1109,8 +1110,9 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_pr=
iv *spdif_priv,
 	static const u32 rate[] =3D { 32000, 44100, 48000, 96000, 192000 };
 	bool is_sysclk =3D clk_is_match(clk, spdif_priv->sysclk);
 	u64 rate_ideal, rate_actual, sub;
-	u32 sysclk_dfmin, sysclk_dfmax;
-	u32 txclk_df, sysclk_df, arate;
+	u32 arate;
+	u16 sysclk_dfmin, sysclk_dfmax, sysclk_df;
+	u8 txclk_df;
=20
 	/* The sysclk has an extra divisor [2, 512] */
 	sysclk_dfmin =3D is_sysclk ? 2 : 1;
--=20
2.7.4
