From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img: Add binding document for parallel
	output controller" to the asoc tree
Date: Wed, 04 Nov 2015 14:59:25 +0000
Message-ID: <E1ZtzX3-0003UX-Ux@finisterre>
References: <1443625696-29296-6-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C7A265745
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:59:38 +0100 (CET)
In-Reply-To: <1443625696-29296-6-git-send-email-Damien.Horsley@imgtec.com>
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

   ASoC: img: Add binding document for parallel output controller

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

>From 20959eede6da7d9175f216b2f86e77a6e5b1ef2f Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Wed, 4 Nov 2015 14:40:51 +0000
Subject: [PATCH] ASoC: img: Add binding document for parallel output
 controller

Add binding document for Imagination Technologies parallel
output controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/img,parallel-out.txt | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,parallel-out.txt

diff --git a/Documentation/devicetree/bindings/sound/img,parallel-out.txt b/Documentation/devicetree/bindings/sound/img,parallel-out.txt
new file mode 100644
index 0000000..a3015d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,parallel-out.txt
@@ -0,0 +1,44 @@
+Imagination Technologies Parallel Output Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,parallel-out".
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device.
+
+  - dmas: Contains an entry for each entry in dma-names.
+
+  - dma-names: Must include the following entry:
+	"tx"
+
+  - clocks : Contains an entry for each entry in clock-names.
+
+  - clock-names : Includes the following entries:
+	"sys"	The system clock
+	"ref"	The reference clock
+
+  - resets: Contains a phandle to the parallel out reset signal
+
+  - reset-names: Contains the reset signal name "rst"
+
+Optional Properties:
+
+  - interrupts : Contains the parallel out interrupt, if present
+
+Example:
+
+parallel_out: parallel-out@18100C00 {
+	compatible = "img,parallel-out";
+	reg = <0x18100C00 0x100>;
+	interrupts = <GIC_SHARED 19 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 16 0xffffffff 0>;
+	dma-names = "tx";
+	clocks = <&cr_periph SYS_CLK_PAUD_OUT>,
+		 <&clk_core CLK_AUDIO_DAC>;
+	clock-names = "sys", "ref";
+	resets = <&pistachio_reset PISTACHIO_RESET_PRL_OUT>;
+	reset-names = "rst";
+	#sound-dai-cells = <0>;
+};
-- 
2.6.1
