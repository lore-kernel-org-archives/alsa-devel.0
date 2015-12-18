From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel-classd: DT binding for PDMIC
	driver" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:39 +0000
Message-ID: <E1a9twh-0006CA-T3@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AC3026659E
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:48 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Songjun Wu <songjun.wu@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel-classd: DT binding for PDMIC driver

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

>From 4bc5145cec89b3df719d87d0a6876aa00941d66c Mon Sep 17 00:00:00 2001
From: Songjun Wu <songjun.wu@atmel.com>
Date: Thu, 17 Dec 2015 17:50:00 +0800
Subject: [PATCH] ASoC: atmel-classd: DT binding for PDMIC driver

DT binding documentation for this new ASoC driver.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/atmel-pdmic.txt      | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-pdmic.txt b/Documentation/devicetree/bindings/sound/atmel-pdmic.txt
new file mode 100644
index 000000000000..e0875f17c229
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-pdmic.txt
@@ -0,0 +1,55 @@
+* Atmel PDMIC driver under ALSA SoC architecture
+
+Required properties:
+- compatible
+	Should be "atmel,sama5d2-pdmic".
+- reg
+	Should contain PDMIC registers location and length.
+- interrupts
+	Should contain the IRQ line for the PDMIC.
+- dmas
+	One DMA specifiers as described in atmel-dma.txt and dma.txt files.
+- dma-names
+	Must be "rx".
+- clock-names
+	Required elements:
+	- "pclk"	peripheral clock
+	- "gclk"	generated clock
+- clocks
+	Must contain an entry for each required entry in clock-names.
+	Please refer to clock-bindings.txt.
+- atmel,mic-min-freq
+	The minimal frequency that the micphone supports.
+- atmel,mic-max-freq
+	The maximal frequency that the micphone supports.
+
+Optional properties:
+- pinctrl-names, pinctrl-0
+	Please refer to pinctrl-bindings.txt.
+- atmel,model
+	The user-visible name of this sound card.
+	The default value is "PDMIC".
+- atmel,mic-offset
+	The offset that should be added.
+	The range is from -32768 to 32767.
+	The default value is 0.
+
+Example:
+	pdmic@f8018000 {
+				compatible = "atmel,sama5d2-pdmic";
+				reg = <0xf8018000 0x124>;
+				interrupts = <48 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(50))>;
+				dma-names = "rx";
+				clocks = <&pdmic_clk>, <&pdmic_gclk>;
+				clock-names = "pclk", "gclk";
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pdmic_default>;
+				atmel,model = "PDMIC @ sama5d2_xplained";
+				atmel,mic-min-freq = <1000000>;
+				atmel,mic-max-freq = <3246000>;
+				atmel,mic-offset = <0x0>;
+	};
-- 
2.6.2
