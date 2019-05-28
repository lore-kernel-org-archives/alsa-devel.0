From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 3/3] ASoC: fsl_sai: Read SAI clock source 0 from DT
Date: Tue, 28 May 2019 13:21:03 +0000
Message-ID: <20190528132034.3908-4-daniel.baluta@nxp.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528132034.3908-1-daniel.baluta@nxp.com>
Content-Language: en-US
Content-ID: <C2E969A3D2B45545A97375DBC035038B@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>
List-Id: alsa-devel@alsa-project.org

SAI provide multiple master clock source options selectable
via bit MSEL of TCR2/RCR2.

All possible master clock sources are stored in sai->mclk_clk
array. Current implementation assumes that MCLK0 source is always
busclk, but this is wrong!

For example, on i.MX8QM we have:

00b - Bus Clock selected.
01b - Master Clock (MCLK) 1 option selected.
10b - Master Clock (MCLK) 2 option selected.
11b - Master Clock (MCLK) 3 option selected.

while on i.MX6SX we have:

00b - Master Clock (MCLK) 1 option selected.
01b - Master Clock (MCLK) 1 option selected.
10b - Master Clock (MCLK) 2 option selected.
11b - Master Clock (MCLK) 3 option selected.

So, this patch will read mclk0 source clock from device tree.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index db9e0872f73d..b563004fb89f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -826,8 +826,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->bus_clk =3D NULL;
 	}
=20
-	sai->mclk_clk[0] =3D sai->bus_clk;
-	for (i =3D 1; i < FSL_SAI_MCLK_MAX; i++) {
+	for (i =3D 0; i < FSL_SAI_MCLK_MAX; i++) {
 		sprintf(tmp, "mclk%d", i);
 		sai->mclk_clk[i] =3D devm_clk_get(&pdev->dev, tmp);
 		if (IS_ERR(sai->mclk_clk[i])) {
--=20
2.17.1
