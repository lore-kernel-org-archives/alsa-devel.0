From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH] ASoC: fsl_spdif: fix TXCLK_DF mask
Date: Mon, 18 Feb 2019 14:12:17 +0000
Message-ID: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to RM SPDIF TXCLK_DF mask is 7-bit wide.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/fsl/fsl_spdif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 7666dab..e6c61e0 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -152,7 +152,7 @@ enum spdif_gainsel {
 #define STC_TXCLK_ALL_EN_MASK		(1 << STC_TXCLK_ALL_EN_OFFSET)
 #define STC_TXCLK_ALL_EN		(1 << STC_TXCLK_ALL_EN_OFFSET)
 #define STC_TXCLK_DF_OFFSET		0
-#define STC_TXCLK_DF_MASK		(0x7ff << STC_TXCLK_DF_OFFSET)
+#define STC_TXCLK_DF_MASK		(0x7f << STC_TXCLK_DF_OFFSET)
 #define STC_TXCLK_DF(x)		((((x) - 1) << STC_TXCLK_DF_OFFSET) & STC_TXCLK_D=
F_MASK)
 #define STC_TXCLK_SRC_MAX		8
=20
--=20
2.7.4
