From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel-classd: DT binding for Class D
	audio amplifier driver" to the asoc tree
Date: Fri, 23 Oct 2015 08:08:55 +0900
Message-ID: <E1ZpOyd-0008I4-7E@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81C78266ABF
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:06 +0200 (CEST)
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

   ASoC: atmel-classd: DT binding for Class D audio amplifier driver

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

>From 391ac3ef50b9ec575c4d5c6f055efe5096ac1957 Mon Sep 17 00:00:00 2001
From: Songjun Wu <songjun.wu@atmel.com>
Date: Thu, 8 Oct 2015 18:13:32 +0800
Subject: [PATCH] ASoC: atmel-classd: DT binding for Class D audio amplifier
 driver

DT binding documentation for this new ASoC driver.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/atmel-classd.txt     | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
new file mode 100644
index 0000000..0018451
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
@@ -0,0 +1,52 @@
+* Atmel ClassD driver under ALSA SoC architecture
+
+Required properties:
+- compatible
+	Should be "atmel,sama5d2-classd".
+- reg
+	Should contain ClassD registers location and length.
+- interrupts
+	Should contain the IRQ line for the ClassD.
+- dmas
+	One DMA specifiers as described in atmel-dma.txt and dma.txt files.
+- dma-names
+	Must be "tx".
+- clock-names
+	Tuple listing input clock names.
+	Required elements: "pclk", "gclk" and "aclk".
+- clocks
+	Please refer to clock-bindings.txt.
+
+Optional properties:
+- pinctrl-names, pinctrl-0
+	Please refer to pinctrl-bindings.txt.
+- atmel,model
+	The user-visible name of this sound complex.
+	The default value is "CLASSD".
+- atmel,pwm-type
+	PWM modulation type, "single" or "diff".
+	The default value is "single".
+- atmel,non-overlap-time
+	Set non-overlapping time, the unit is nanosecond(ns).
+	There are four values,
+	<5>, <10>, <15>, <20>, the default value is <10>.
+	Non-overlapping will be disabled if not specified.
+
+Example:
+classd: classd@fc048000 {
+		compatible = "atmel,sama5d2-classd";
+		reg = <0xfc048000 0x100>;
+		interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(47))>;
+		dma-names = "tx";
+		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
+		clock-names = "pclk", "gclk", "aclk";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_classd_default>;
+		atmel,model = "classd @ SAMA5D2-Xplained";
+		atmel,pwm-type = "diff";
+		atmel,non-overlap-time = <10>;
+};
-- 
2.6.1
