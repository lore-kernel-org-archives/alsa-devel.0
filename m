From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4341: Add DT bindings documentation
	for CS4341 DAC" to the asoc tree
Date: Mon,  7 Jan 2019 12:32:02 +0000 (GMT)
Message-ID: <20190107123202.E5BC31127490@debutante.sirena.org.uk>
References: <20181220073708.12014-1-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2584C267CE4
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:32:06 +0100 (CET)
In-Reply-To: <20181220073708.12014-1-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4341: Add DT bindings documentation for CS4341 DAC

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

>From 0ddb46080a465fad99cff838682744f1f4848a4b Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work@mail.ru>
Date: Thu, 20 Dec 2018 10:37:08 +0300
Subject: [PATCH] ASoC: cs4341: Add DT bindings documentation for CS4341 DAC

This patch adds DT bindings documentation for Cirrus Logic
CS4341 DAC.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cs4341.txt      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4341.txt

diff --git a/Documentation/devicetree/bindings/sound/cs4341.txt b/Documentation/devicetree/bindings/sound/cs4341.txt
new file mode 100644
index 000000000000..12b4aa8ef0db
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs4341.txt
@@ -0,0 +1,22 @@
+Cirrus Logic CS4341 audio DAC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+  - compatible: "cirrus,cs4341a"
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+For required properties on I2C-bus, please consult
+Documentation/devicetree/bindings/i2c/i2c.txt
+For required properties on SPI-bus, please consult
+Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+	codec: cs4341@0 {
+		#sound-dai-cells = <0>;
+		compatible = "cirrus,cs4341a";
+		reg = <0>;
+		spi-max-frequency = <6000000>;
+	};
-- 
2.20.1
