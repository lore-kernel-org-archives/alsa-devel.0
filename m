From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 1/2] ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for I2S
 Multi-Channel Controller
Date: Tue, 5 Mar 2019 11:26:42 +0000
Message-ID: <20190305112610.9641-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org, robh+dt@kernel.org, Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, alexandre.belloni@bootlin.com, Cristian.Birsan@microchip.com, Codrin.Ciubotariu@microchip.com
List-Id: alsa-devel@alsa-project.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

This patch adds DT bindings for the new Microchip I2S Multi-Channel
controller embedded inside sam9x60 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 .../bindings/sound/mchp-i2s-mcc.txt           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.tx=
t

diff --git a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt b/Doc=
umentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
new file mode 100644
index 000000000000..91ec83a6faed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
@@ -0,0 +1,43 @@
+* Microchip I2S Multi-Channel Controller
+
+Required properties:
+- compatible:     Should be "microchip,sam9x60-i2smcc".
+- reg:            Should be the physical base address of the controller an=
d the
+                  length of memory mapped region.
+- interrupts:     Should contain the interrupt for the controller.
+- dmas:           Should be one per channel name listed in the dma-names p=
roperty,
+                  as described in atmel-dma.txt and dma.txt files.
+- dma-names:      Identifier string for each DMA request line in the dmas =
property.
+		  Two dmas have to be defined, "tx" and "rx".
+- clocks:         Must contain an entry for each entry in clock-names.
+                  Please refer to clock-bindings.txt.
+- clock-names:    Should be one of each entry matching the clocks phandles=
 list:
+                  - "pclk" (peripheral clock) Required.
+                  - "gclk" (generated clock) Optional (1).
+
+Optional properties:
+- pinctrl-0:      Should specify pin control groups used for this controll=
er.
+- princtrl-names: Should contain only one value - "default".
+
+
+(1) : Only the peripheral clock is required. The generated clock is option=
al
+      and should be set mostly when Master Mode is required.
+
+Example:
+
+	i2s@f001c000 {
+		compatible =3D "microchip,sam9x60-i2smcc";
+		reg =3D <0xf001c000 0x100>;
+		interrupts =3D <34 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas =3D <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(36))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(37))>;
+		dma-names =3D "tx", "rx";
+		clocks =3D <&i2s_clk>, <&i2s_gclk>;
+		clock-names =3D "pclk", "gclk";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_i2s_default>;
+	};
--=20
2.17.1
