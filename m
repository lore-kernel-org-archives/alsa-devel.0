From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/3] dt-bindings: sound: Clarify the usage of clocks in SAI
Date: Tue, 28 May 2019 13:21:01 +0000
Message-ID: <20190528132034.3908-3-daniel.baluta@nxp.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528132034.3908-1-daniel.baluta@nxp.com>
Content-Language: en-US
Content-ID: <A5AA31DC66CBBF419C05BB1555E2A511@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

SAI might have up to 4 clock sources selected by an internal
CLK mux.

On imx6/7 mclk0/mclk1 are the same, while on imx8 mclk0 and
mclk1 are coming from different sources.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Document=
ation/devicetree/bindings/sound/fsl-sai.txt
index 2e726b983845..db0497d1920a 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -15,8 +15,9 @@ Required properties:
   - clocks		: Must contain an entry for each entry in clock-names.
=20
   - clock-names		: Must include the "bus" for register access and
-			  "mclk1", "mclk2", "mclk3" for bit clock and frame
-			  clock providing.
+			  "mclk0", "mclk1", "mclk2", "mclk3" the four clock
+			  sources of the SAI clock MUX selecting a clock
+			  for bit clock and frame clock providing.
   - dmas		: Generic dma devicetree binding as described in
 			  Documentation/devicetree/bindings/dma/dma.txt.
=20
--=20
2.17.1
