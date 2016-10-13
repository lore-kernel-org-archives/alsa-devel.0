From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l34: Add device tree bindings file
	for cs35l34" to the asoc tree
Date: Thu, 13 Oct 2016 09:40:12 +0200
Message-ID: <E1buace-000259-5L@finisterre>
References: <9581bbdd-b3b1-4230-8321-46942f3dfd09@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C362265119
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 09:40:35 +0200 (CEST)
In-Reply-To: <9581bbdd-b3b1-4230-8321-46942f3dfd09@EX3.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Handrigan <Paul.Handrigan@cirrus.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, brian.austin@cirrus.com, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l34: Add device tree bindings file for cs35l34

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 41f8bf322da58162f67d9a9119fd3c86ff8cee2f Mon Sep 17 00:00:00 2001
From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Date: Wed, 12 Oct 2016 13:53:29 -0500
Subject: [PATCH] ASoC: cs35l34: Add device tree bindings file for cs35l34

Add device tree bindings file for the cs35l34 8V boosted
class D amplifier.

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cs35l34.txt          | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l34.txt

diff --git a/Documentation/devicetree/bindings/sound/cs35l34.txt b/Documentation/devicetree/bindings/sound/cs35l34.txt
new file mode 100644
index 000000000000..b218ead2e68e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs35l34.txt
@@ -0,0 +1,64 @@
+CS35L34 Speaker Amplifier
+
+Required properties:
+
+  - compatible : "cirrus,cs35l34"
+
+  - reg : the I2C address of the device for I2C.
+
+  - VA-supply, VP-supply : power supplies for the device,
+    as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt.
+
+  - cirrus,boost-vtge-millivolt : Boost Voltage Value.  Configures the boost
+    converter's output voltage in mV. The range is from VP to 8V with
+    increments of 100mV.
+
+  - cirrus,boost-nanohenry: Inductor value for boost converter. The value is
+    in nH and they can be values of 1000nH, 1100nH, 1200nH, 1500nH, and 2200nH.
+
+Optional properties:
+
+  - reset-gpios: GPIO used to reset the amplifier.
+
+  - interrupt-parent : Specifies the phandle of the interrupt controller to
+    which the IRQs from CS35L34 are delivered to.
+  - interrupts : IRQ line info CS35L34.
+    (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+    for further information relating to interrupt properties)
+
+  - cirrus,boost-peak-milliamp : Boost converter peak current limit in mA. The
+    range starts at 1200mA and goes to a maximum of 3840mA with increments of
+    80mA. The default value is 2480mA.
+
+  - cirrus,i2s-sdinloc : ADSP SDIN I2S channel location. Indicates whether the
+    received mono data is in the left or right portion of the I2S frame
+    according to the AD0 pin or directly via this configuration.
+    0x0 (Default) = Selected by AD0 input (if AD0 = LOW, use left channel),
+    0x2 = Left,
+    0x1 = Selected by the inversion of the AD0 input (if AD0 = LOW, use right
+    channel),
+    0x3 = Right.
+
+  - cirrus,gain-zc-disable: Boolean property. If set, the gain change will take
+    effect without waiting for a zero cross.
+
+  - cirrus,tdm-rising-edge: Boolean property. If set, data is on the rising edge of
+    SCLK. Otherwise, data is on the falling edge of SCLK.
+
+
+Example:
+
+cs35l34: cs35l34@40 {
+	compatible = "cirrus,cs35l34";
+	reg = <0x40>;
+
+	interrupt-parent = <&gpio8>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+	reset-gpios = <&gpio 10 0>;
+
+	cirrus,boost-vtge-milltvolt = <8000>; /* 8V */
+	cirrus,boost-ind-nanohenry = <1000>; /* 1uH */
+	cirrus,boost-peak-milliamp = <3000>; /* 3A */
+};
-- 
2.9.3
