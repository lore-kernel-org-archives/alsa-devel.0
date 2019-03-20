From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: lochnagar: Add device tree binding
	document
Date: Wed, 20 Mar 2019 14:28:12 +0000
Message-ID: <20190320142813.12745-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 298CFF80791
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 15:28:17 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 .../devicetree/bindings/sound/cirrus,lochnagar.txt | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
new file mode 100644
index 0000000000000..fba5fb53a2f90
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
@@ -0,0 +1,39 @@
+Cirrus Logic Lochnagar Audio Development Board
+
+Lochnagar is an evaluation and development board for Cirrus Logic
+Smart CODEC and Amp devices. It allows the connection of most Cirrus
+Logic devices on mini-cards, as well as allowing connection of
+various application processor systems to provide a full evaluation
+platform.  Audio system topology, clocking and power can all be
+controlled through the Lochnagar, allowing the device under test
+to be used in a variety of possible use cases.
+
+This binding document describes the binding for the audio portion
+of the driver.
+
+This binding must be part of the Lochnagar MFD binding:
+  [4] ../mfd/cirrus,lochnagar.txt
+
+Required properties:
+
+  - compatible : One of the following strings:
+                 "cirrus,lochnagar2-soundcard"
+
+  - #sound-dai-cells : Must be set to 1.
+
+  - clocks : Contains an entry for each entry in clock-names.
+  - clock-names : Must include the following clocks:
+      "ln-sound-mclk" Master clock source for the sound card, should
+      normally be set to LOCHNAGAR_SOUNDCARD_MCLK provided by the
+      Lochnagar clock driver.
+
+Example:
+
+lochnagar-sc {
+	compatible = "cirrus,lochnagar2-soundcard";
+
+	#sound-dai-cells = <1>;
+
+	clocks = <&lochnagar_clk LOCHNAGAR_SOUNDCARD_MCLK>;
+	clock-names = "ln-soundcard-mclk";
+};
-- 
2.11.0
