From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: Add binding document for
	pcm3168a codec" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:35 +0000
Message-ID: <E1a7tGJ-0002gC-RH@finisterre>
References: <1448376224-23964-2-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F12F265804
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:43 +0100 (CET)
In-Reply-To: <1448376224-23964-2-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Damien.Horsley" <Damien.Horsley@imgtec.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: Add binding document for pcm3168a codec

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

>From ccfa2bef0f3bb024fc6efb1501177dddbb003c06 Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Tue, 8 Dec 2015 15:58:59 +0000
Subject: [PATCH] ASoC: pcm3168a: Add binding document for pcm3168a codec

Add binding document for Texas Instruments pcm3168a codec

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/ti,pcm3168a.txt      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm3168a.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt b/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
new file mode 100644
index 0000000..5d9cb84
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
@@ -0,0 +1,48 @@
+Texas Instruments pcm3168a DT bindings
+
+This driver supports both SPI and I2C bus access for this codec
+
+Required properties:
+
+  - compatible: "ti,pcm3168a"
+
+  - clocks : Contains an entry for each entry in clock-names
+
+  - clock-names : Includes the following entries:
+	"scki"	The system clock
+
+  - VDD1-supply : Digital power supply regulator 1 (+3.3V)
+
+  - VDD2-supply : Digital power supply regulator 2 (+3.3V)
+
+  - VCCAD1-supply : ADC power supply regulator 1 (+5V)
+
+  - VCCAD2-supply : ADC power supply regulator 2 (+5V)
+
+  - VCCDA1-supply : DAC power supply regulator 1 (+5V)
+
+  - VCCDA2-supply : DAC power supply regulator 2 (+5V)
+
+For required properties on SPI/I2C, consult SPI/I2C device tree documentation
+
+Examples:
+
+i2c0: i2c0@0 {
+
+	...
+
+	pcm3168a: audio-codec@44 {
+		compatible = "ti,pcm3168a";
+		reg = <0x44>;
+		clocks = <&clk_core CLK_AUDIO>;
+		clock-names = "scki";
+		VDD1-supply = <&supply3v3>;
+		VDD2-supply = <&supply3v3>;
+		VCCAD1-supply = <&supply5v0>;
+		VCCAD2-supply = <&supply5v0>;
+		VCCDA1-supply = <&supply5v0>;
+		VCCDA2-supply = <&supply5v0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dac_clk_pin>;
+	};
+};
-- 
2.6.4
