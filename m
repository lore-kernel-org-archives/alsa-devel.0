From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm186x: Add PCM186x binding
	documentation" to the asoc tree
Date: Wed,  6 Dec 2017 13:07:53 +0000 (GMT)
Message-ID: <20171206130753.2BC1544006B@finisterre.ee.mobilebroadband>
References: <20171129185015.5304-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 57880267923
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 14:07:55 +0100 (CET)
In-Reply-To: <20171129185015.5304-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm186x: Add PCM186x binding documentation

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

>From eb2a8168b9fd69f66199d9d7e86d23fecfab4e33 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Tue, 5 Dec 2017 14:52:55 -0600
Subject: [PATCH] ASoC: pcm186x: Add PCM186x binding documentation

Add the dt-binding documentation for the TI PCM186x 2ch and 4ch Audio
ADCs With Universal Front End.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/pcm186x.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm186x.txt

diff --git a/Documentation/devicetree/bindings/sound/pcm186x.txt b/Documentation/devicetree/bindings/sound/pcm186x.txt
new file mode 100644
index 000000000000..1087f4855980
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm186x.txt
@@ -0,0 +1,42 @@
+Texas Instruments PCM186x Universal Audio ADC
+
+These devices support both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+ - compatible : "ti,pcm1862",
+                "ti,pcm1863",
+                "ti,pcm1864",
+                "ti,pcm1865"
+
+ - reg : The I2C address of the device for I2C, the chip select
+         number for SPI.
+
+ - avdd-supply: Analog core power supply (3.3v)
+ - dvdd-supply: Digital core power supply
+ - iovdd-supply: Digital IO power supply
+        See regulator/regulator.txt for more information
+
+CODEC input pins:
+ * VINL1
+ * VINR1
+ * VINL2
+ * VINR2
+ * VINL3
+ * VINR3
+ * VINL4
+ * VINR4
+
+The pins can be used in referring sound node's audio-routing property.
+
+Example:
+
+	pcm186x: audio-codec@4a {
+		compatible = "ti,pcm1865";
+		reg = <0x4a>;
+
+		avdd-supply = <&reg_3v3_analog>;
+		dvdd-supply = <&reg_3v3>;
+		iovdd-supply = <&reg_1v8>;
+	};
-- 
2.15.0
