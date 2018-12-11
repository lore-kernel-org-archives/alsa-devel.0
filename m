From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/4] ASoC: meson: add axg spdif input DT
	binding documentation
Date: Tue, 11 Dec 2018 14:47:11 +0100
Message-ID: <20181211134713.4908-3-jbrunet@baylibre.com>
References: <20181211134713.4908-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1678C26770D
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 14:47:27 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id s14so2292496wmh.1
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 05:47:27 -0800 (PST)
In-Reply-To: <20181211134713.4908-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Add the DT binding documentation for axg's SPDIF input.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifin.txt    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
new file mode 100644
index 000000000000..2e6cb7d9b202
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
@@ -0,0 +1,22 @@
+* Amlogic Audio SPDIF Input
+
+Required properties:
+- compatible: 'amlogic,axg-spdifin'
+- interrupts: interrupt specifier for the spdif input.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk" : peripheral clock.
+  * "refclk" : spdif input reference clock
+- #sound-dai-cells: must be 0.
+
+Example on the A113 SoC:
+
+spdifin: audio-controller@400 {
+	compatible = "amlogic,axg-spdifin";
+	reg = <0x0 0x400 0x0 0x30>;
+	#sound-dai-cells = <0>;
+	interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+		 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+	clock-names = "pclk", "refclk";
+};
-- 
2.19.2
