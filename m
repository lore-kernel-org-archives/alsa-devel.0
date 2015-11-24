From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH 1/2] ASoC: pcm3168a: Add binding document for
	pcm3168a codec
Date: Tue, 24 Nov 2015 14:43:43 +0000
Message-ID: <1448376224-23964-2-git-send-email-Damien.Horsley@imgtec.com>
References: <1448376224-23964-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE7D265ADB
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 15:43:58 +0100 (CET)
In-Reply-To: <1448376224-23964-1-git-send-email-Damien.Horsley@imgtec.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, "Maciej S.
 Szmigiero" <mail@maciej.szmigiero.name>, Bard Liao <bardliao@realtek.com>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Charles Keepax <ckeepax@gmail.com>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, James Hartley <james.hartley@imgtec.com>, Thomas Niederprum <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add binding document for Texas Instruments pcm3168a codec

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
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
2.1.4
