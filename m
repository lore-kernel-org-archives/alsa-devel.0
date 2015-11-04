From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img: Add binding document for I2S
	output controller" to the asoc tree
Date: Wed, 04 Nov 2015 14:59:34 +0000
Message-ID: <E1ZtzXC-0003VY-Qz@finisterre>
References: <1446648057-373-4-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DCF2326575E
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:59:46 +0100 (CET)
In-Reply-To: <1446648057-373-4-git-send-email-Damien.Horsley@imgtec.com>
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

   ASoC: img: Add binding document for I2S output controller

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

>From d162a3f009ddbe26eb208676690ee53f19b244cd Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Wed, 4 Nov 2015 14:40:49 +0000
Subject: [PATCH] ASoC: img: Add binding document for I2S output controller

Add binding document for Imagination Technologies I2S output
controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/img,i2s-out.txt      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-out.txt

diff --git a/Documentation/devicetree/bindings/sound/img,i2s-out.txt b/Documentation/devicetree/bindings/sound/img,i2s-out.txt
new file mode 100644
index 0000000..0159415
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,i2s-out.txt
@@ -0,0 +1,51 @@
+Imagination Technologies I2S Output Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,i2s-out"
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device
+
+  - clocks : Contains an entry for each entry in clock-names
+
+  - clock-names : Must include the following entries:
+	"sys"	The system clock
+	"ref"	The reference clock
+
+  - dmas: Contains an entry for each entry in dma-names.
+
+  - dma-names: Must include the following entry:
+	"tx"	Single DMA channel used by all active I2S channels
+
+  - img,i2s-channels : Number of I2S channels instantiated in the I2S out block
+
+  - resets: Contains a phandle to the I2S out reset signal
+
+  - reset-names: Contains the reset signal name "rst"
+
+Optional Properties:
+
+  - interrupts : Contains the I2S out interrupts. Depending on
+	the configuration, there may be no interrupts, one interrupt,
+	or an interrupt per I2S channel. For the case where there is
+	one interrupt per channel, the interrupts should be listed
+	in ascending channel order
+
+Example:
+
+i2s_out: i2s-out@18100A00 {
+	compatible = "img,i2s-out";
+	reg = <0x18100A00 0x200>;
+	interrupts = <GIC_SHARED 13 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 23 0xffffffff 0>;
+	dma-names = "tx";
+	clocks = <&cr_periph SYS_CLK_I2S_OUT>,
+		 <&clk_core CLK_I2S>;
+	clock-names = "sys", "ref";
+	img,i2s-channels = <6>;
+	resets = <&pistachio_reset PISTACHIO_RESET_I2S_OUT>;
+	reset-names = "rst";
+	#sound-dai-cells = <0>;
+};
-- 
2.6.1
