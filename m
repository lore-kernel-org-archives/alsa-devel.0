From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lochnagar: Add device tree binding
	document" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:37 +0000 (GMT)
Message-ID: <20190321150637.5E7FB11288EC@debutante.sirena.org.uk>
References: <20190320173732.8067-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1039F89718
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:48 +0100 (CET)
In-Reply-To: <20190320173732.8067-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: lochnagar: Add device tree binding document

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d9b27d50340c4c90637ebf24106c9064992e2f2a Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 20 Mar 2019 17:37:31 +0000
Subject: [PATCH] ASoC: lochnagar: Add device tree binding document

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/cirrus,lochnagar.txt       | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
new file mode 100644
index 000000000000..41ae2699f07a
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
+      "mclk" Master clock source for the sound card, should normally
+      be set to LOCHNAGAR_SOUNDCARD_MCLK provided by the Lochnagar
+      clock driver.
+
+Example:
+
+lochnagar-sc {
+	compatible = "cirrus,lochnagar2-soundcard";
+
+	#sound-dai-cells = <1>;
+
+	clocks = <&lochnagar_clk LOCHNAGAR_SOUNDCARD_MCLK>;
+	clock-names = "mclk";
+};
-- 
2.20.1
