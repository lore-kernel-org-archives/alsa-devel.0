From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img: Add binding document for I2S input
	controller" to the asoc tree
Date: Wed, 04 Nov 2015 14:59:38 +0000
Message-ID: <E1ZtzXG-0003WU-VD@finisterre>
References: <1446648057-373-2-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73F052657F3
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:59:51 +0100 (CET)
In-Reply-To: <1446648057-373-2-git-send-email-Damien.Horsley@imgtec.com>
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

   ASoC: img: Add binding document for I2S input controller

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

>From b01f1b06c2da93bd7c58fda432f57d47c166d79a Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Wed, 4 Nov 2015 14:40:47 +0000
Subject: [PATCH] ASoC: img: Add binding document for I2S input controller

Add a binding document for Imagination Technologies I2S input
controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/img,i2s-in.txt       | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-in.txt

diff --git a/Documentation/devicetree/bindings/sound/img,i2s-in.txt b/Documentation/devicetree/bindings/sound/img,i2s-in.txt
new file mode 100644
index 0000000..423265c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,i2s-in.txt
@@ -0,0 +1,47 @@
+Imagination Technologies I2S Input Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,i2s-in"
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device
+
+  - clocks : Contains an entry for each entry in clock-names
+
+  - clock-names : Must include the following entry:
+	"sys"	The system clock
+
+  - dmas: Contains an entry for each entry in dma-names.
+
+  - dma-names: Must include the following entry:
+	"rx"	Single DMA channel used by all active I2S channels
+
+  - img,i2s-channels : Number of I2S channels instantiated in the I2S in block
+
+Optional Properties:
+
+  - interrupts : Contains the I2S in interrupts. Depending on
+	the configuration, there may be no interrupts, one interrupt,
+	or an interrupt per I2S channel. For the case where there is
+	one interrupt per channel, the interrupts should be listed
+	in ascending channel order
+
+  - resets: Contains a phandle to the I2S in reset signal
+
+  - reset-names: Contains the reset signal name "rst"
+
+Example:
+
+i2s_in: i2s-in@18100800 {
+	compatible = "img,i2s-in";
+	reg = <0x18100800 0x200>;
+	interrupts = <GIC_SHARED 7 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 30 0xffffffff 0>;
+	dma-names = "rx";
+	clocks = <&cr_periph SYS_CLK_I2S_IN>;
+	clock-names = "sys";
+	img,i2s-channels = <6>;
+	#sound-dai-cells = <0>;
+};
-- 
2.6.1
