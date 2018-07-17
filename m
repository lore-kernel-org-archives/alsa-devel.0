From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 05/15] ASoC: meson: add axg spdif output DT
	binding documentation
Date: Tue, 17 Jul 2018 17:36:29 +0200
Message-ID: <20180717153643.8806-6-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 3110F2677D6
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 17:36:52 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so1976425wmc.0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 08:36:52 -0700 (PDT)
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Add the DT binding documentation for axg's SPDIF output.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifout.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
new file mode 100644
index 000000000000..521c38ad89e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
@@ -0,0 +1,20 @@
+* Amlogic Audio SPDIF Output
+
+Required properties:
+- compatible: 'amlogic,axg-spdifout'
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk" : peripheral clock.
+  * "mclk" : master clock
+- #sound-dai-cells: must be 0.
+
+Example on the A113 SoC:
+
+spdifout: audio-controller@480 {
+	compatible = "amlogic,axg-spdifout";
+	reg = <0x0 0x480 0x0 0x50>;
+	#sound-dai-cells = <0>;
+	clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+		 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+	clock-names = "pclk", "mclk";
+};
-- 
2.14.4
