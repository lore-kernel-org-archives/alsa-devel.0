From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img: Add binding document for SPDIF
	output controller" to the asoc tree
Date: Wed, 04 Nov 2015 14:59:16 +0000
Message-ID: <E1ZtzWu-0003S9-PO@finisterre>
References: <1443625696-29296-10-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A04022604DD
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:59:28 +0100 (CET)
In-Reply-To: <1443625696-29296-10-git-send-email-Damien.Horsley@imgtec.com>
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

   ASoC: img: Add binding document for SPDIF output controller

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

>From 65189dbb82fe666e1dbdf06734e89d0d975ad487 Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Wed, 4 Nov 2015 14:40:56 +0000
Subject: [PATCH] ASoC: img: Add binding document for SPDIF output controller

Add binding document for Imagination Technologies SPDIF
ouput controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/img,spdif-out.txt    | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-out.txt

diff --git a/Documentation/devicetree/bindings/sound/img,spdif-out.txt b/Documentation/devicetree/bindings/sound/img,spdif-out.txt
new file mode 100644
index 0000000..470a519
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,spdif-out.txt
@@ -0,0 +1,44 @@
+Imagination Technologies SPDIF Output Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,spdif-out"
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device
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
+  - resets: Contains a phandle to the spdif out reset signal
+
+  - reset-names: Contains the reset signal name "rst"
+
+Optional Properties:
+
+  - interrupts : Contains the parallel out interrupt, if present
+
+Example:
+
+spdif_out: spdif-out@18100D00 {
+	compatible = "img,spdif-out";
+	reg = <0x18100D00 0x100>;
+	interrupts = <GIC_SHARED 21 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 14 0xffffffff 0>;
+	dma-names = "tx";
+	clocks = <&cr_periph SYS_CLK_SPDIF_OUT>,
+		 <&clk_core CLK_SPDIF>;
+	clock-names = "sys", "ref";
+	resets = <&pistachio_reset PISTACHIO_RESET_SPDIF_OUT>;
+	reset-names = "rst";
+	#sound-dai-cells = <0>;
+};
-- 
2.6.1
