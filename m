From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] ASoC: cs4341: Add DT bindings
	documentation for CS4341 DAC
Date: Thu, 20 Dec 2018 10:37:08 +0300
Message-ID: <20181220073708.12014-1-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp59.i.mail.ru (smtp59.i.mail.ru [217.69.128.39])
 by alsa0.perex.cz (Postfix) with ESMTP id EDE402679E4
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 08:37:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch adds DT bindings documentation for Cirrus Logic
CS4341 DAC.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/sound/cs4341.txt | 22 ++++++++++++++++++++++
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
2.13.0
