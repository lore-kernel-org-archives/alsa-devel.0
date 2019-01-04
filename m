From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: Document support for ak4497
Date: Fri, 4 Jan 2019 16:27:04 +0000
Message-ID: <20190104162649.13103-3-daniel.baluta@nxp.com>
References: <20190104162649.13103-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104162649.13103-1-daniel.baluta@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Cosmin Samoila <cosmin.samoila@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
List-Id: alsa-devel@alsa-project.org

ak4458 driver supports also ak4497 codec.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documenta=
tion/devicetree/bindings/sound/ak4458.txt
index 7839be78448d..e5820235e0d5 100644
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -4,7 +4,7 @@ This device supports I2C mode.
=20
 Required properties:
=20
-- compatible : "asahi-kasei,ak4458"
+- compatible : "asahi-kasei,ak4458" or "asahi-kasei,ak4497"
 - reg : The I2C address of the device for I2C
=20
 Optional properties:
--=20
2.17.1
