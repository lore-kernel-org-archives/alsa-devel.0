From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 1/2] ASoC: es7241: add dt-bindings
	documentation for the es7241 adc
Date: Tue,  3 Jul 2018 15:28:44 +0200
Message-ID: <20180703132845.26554-2-jbrunet@baylibre.com>
References: <20180703132845.26554-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF0012673CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 15:28:51 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id f18-v6so1978425wre.10
 for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2018 06:28:51 -0700 (PDT)
In-Reply-To: <20180703132845.26554-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/everest,es7241.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es7241.txt b/Documentation/devicetree/bindings/sound/everest,es7241.txt
new file mode 100644
index 000000000000..28f82cf4959f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7241.txt
@@ -0,0 +1,28 @@
+ES7241 i2s AD converter
+
+Required properties:
+- compatible : "everest,es7241"
+- VDDP-supply: regulator phandle for the VDDA supply
+- VDDA-supply: regulator phandle for the VDDP supply
+- VDDD-supply: regulator phandle for the VDDD supply
+
+Optional properties:
+- reset-gpios: gpio connected to the reset pin
+- m0-gpios   : gpio connected to the m0 pin
+- m1-gpios   : gpio connected to the m1 pin
+- everest,sdout-pull-down:
+   Format used by the serial interface is controlled by pulling
+   the sdout. If the sdout is pulled down, leftj format is used.
+   If this property is not provided, sdout is assumed to pulled
+   up and i2s format is used
+
+Example:
+
+linein: audio-codec@2 {
+	#sound-dai-cells = <0>;
+	compatible = "everest,es7241";
+	VDDA-supply = <&vcc_3v3>;
+	VDDP-supply = <&vcc_3v3>;
+	VDDD-supply = <&vcc_3v3>;
+	reset-gpios = <&gpio GPIOH_42>;
+};
-- 
2.14.4
