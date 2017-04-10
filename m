From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add hi6210-i2s DT bindings" to the asoc
	tree
Date: Mon, 10 Apr 2017 19:42:44 +0100
Message-ID: <E1cxeGy-0003pd-QH@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E628B266CAD
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 20:42:52 +0200 (CEST)
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
To: John Stultz <john.stultz@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add hi6210-i2s DT bindings

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

>From 9e615f63cbafa2147fd302ab495d7b785306bc26 Mon Sep 17 00:00:00 2001
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 31 Mar 2017 15:05:59 -0700
Subject: [PATCH] ASoC: add hi6210-i2s DT bindings

Adds DT bindings documentation for the hi6210-i2s driver.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/hisilicon,hi6210-i2s.txt        | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt b/Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt
new file mode 100644
index 000000000000..680bb03577ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt
@@ -0,0 +1,34 @@
+* Hisilicon 6210 i2s controller
+
+Required properties:
+
+- compatible: should be one of the following:
+   - "hisilicon,hi6210-i2s"
+- reg: physical base address of the i2s controller unit and length of
+   memory mapped region.
+- interrupts: should contain the i2s interrupt.
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: should contain following:
+   - "dacodec"
+   - "i2s-base"
+- dmas: DMA specifiers for tx dma. See the DMA client binding,
+  Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should be "tx" and "rx"
+- hisilicon,sysctrl-syscon: phandle to sysctrl syscon
+- #sound-dai-cells: Should be set to 1 (for multi-dai)
+
+Example for the hi6210 i2s controller:
+
+i2s0: i2s@f7118000{
+	compatible = "hisilicon,hi6210-i2s";
+	reg = <0x0 0xf7118000 0x0 0x8000>; /* i2s unit */
+	interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* 155 "DigACodec_intr"-32 */
+	clocks = <&sys_ctrl HI6220_DACODEC_PCLK>,
+		 <&sys_ctrl HI6220_BBPPLL0_DIV>;
+	clock-names = "dacodec", "i2s-base";
+	dmas = <&dma0 15 &dma0 14>;
+	dma-names = "rx", "tx";
+	hisilicon,sysctrl-syscon = <&sys_ctrl>;
+	#sound-dai-cells = <1>;
+};
-- 
2.11.0
