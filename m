From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img: Add binding document for SPDIF
	input controller" to the asoc tree
Date: Wed, 04 Nov 2015 14:59:22 +0000
Message-ID: <E1ZtzX0-0003Ta-GY@finisterre>
References: <1443625696-29296-8-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ED7E2655DB
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:59:35 +0100 (CET)
In-Reply-To: <1443625696-29296-8-git-send-email-Damien.Horsley@imgtec.com>
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

   ASoC: img: Add binding document for SPDIF input controller

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

>From 6ef44cda2506d82b35c16e7b22299c7c2ab12df0 Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Wed, 4 Nov 2015 14:40:53 +0000
Subject: [PATCH] ASoC: img: Add binding document for SPDIF input controller

Add binding document for Imagination Technologies SPDIF
input controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/img,spdif-in.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.txt

diff --git a/Documentation/devicetree/bindings/sound/img,spdif-in.txt b/Documentation/devicetree/bindings/sound/img,spdif-in.txt
new file mode 100644
index 0000000..aab9a81
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,spdif-in.txt
@@ -0,0 +1,41 @@
+Imagination Technologies SPDIF Input Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,spdif-in"
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device
+
+  - dmas: Contains an entry for each entry in dma-names.
+
+  - dma-names: Must include the following entry:
+	"rx"
+
+  - clocks : Contains an entry for each entry in clock-names
+
+  - clock-names : Includes the following entries:
+	"sys"	The system clock
+
+Optional Properties:
+
+  - resets: Should contain a phandle to the spdif in reset signal, if any
+
+  - reset-names: Should contain the reset signal name "rst", if a
+	reset phandle is given
+
+  - interrupts : Contains the spdif in interrupt, if present
+
+Example:
+
+spdif_in: spdif-in@18100E00 {
+	compatible = "img,spdif-in";
+	reg = <0x18100E00 0x100>;
+	interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 15 0xffffffff 0>;
+	dma-names = "rx";
+	clocks = <&cr_periph SYS_CLK_SPDIF_IN>;
+	clock-names = "sys";
+	#sound-dai-cells = <0>;
+};
-- 
2.6.1
