From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/3] Add mclk0 clock source for SAI
Date: Tue, 28 May 2019 13:20:46 +0000
Message-ID: <20190528132034.3908-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <27ECECFB133A6741B1718F4D42309625@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

This patch series brings together patches [1] and [2] which
introduce mclk0 clock source via DT.

mclk0..3 are the four clock sources options
of SAI's clock MUX.=20

mclk0 option selects:
 - Bus Clock on i.MX8
 - MCLK1 on i.MX6/7

Finally we also update the DT binding information for SAI clocks.

In [1] and [2] Nicolin had a very good point on the fact that
mclk0 might not be needed in the DT. Anyhow, there are two reasons
for which I think mlck0 should be added to DT:

1) SAI clock source select MUX is really part of the hardware
2) flexibility! We let DT tell us which is the option for MUX
option 0.


[1] lkml.org/lkml/2019/4/20/141
[2] lkml.org/lkml/2019/4/20/56

Daniel Baluta (2):
  dt-bindings: sound: Clarify the usage of clocks in SAI
  ASoC: fsl_sai: Read SAI clock source 0 from DT

Shengjiu Wang (1):
  ARM: dts: imx: Add mclk0 clock for SAI

 Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++--
 arch/arm/boot/dts/imx6sx.dtsi                       | 6 ++++--
 arch/arm/boot/dts/imx6ul.dtsi                       | 9 ++++++---
 arch/arm/boot/dts/imx7s.dtsi                        | 9 ++++++---
 sound/soc/fsl/fsl_sai.c                             | 3 +--
 5 files changed, 20 insertions(+), 12 deletions(-)

--=20
2.17.1
