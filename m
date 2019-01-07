From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: micfil: Add bindings for MICFIL DAI" to
	the asoc tree
Date: Mon,  7 Jan 2019 18:57:52 +0000 (GMT)
Message-ID: <20190107185752.BE3021127491@debutante.sirena.org.uk>
References: <1546593445-10509-2-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 64CA4266B63
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:57:53 +0100 (CET)
In-Reply-To: <1546593445-10509-2-git-send-email-cosmin.samoila@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: micfil: Add bindings for MICFIL DAI

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e595da28ecc87e7cec2681c01d5970e31153bddd Mon Sep 17 00:00:00 2001
From: Cosmin Samoila <cosmin.samoila@nxp.com>
Date: Fri, 4 Jan 2019 09:17:37 +0000
Subject: [PATCH] ASoC: micfil: Add bindings for MICFIL DAI

Document the bindings for MICFIL DAI.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/fsl,micfil.txt  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.txt b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
new file mode 100644
index 000000000000..53e227b15277
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
@@ -0,0 +1,32 @@
+NXP MICFIL Digital Audio Interface (MICFIL).
+
+The MICFIL digital interface provides a 16-bit audio signal from a PDM
+microphone bitstream in a configurable output sampling rate.
+
+Required properties:
+
+  - compatible		: Compatible list, contains "fsl,imx8mm-micfil"
+
+  - reg			: Offset and length of the register set for the device.
+
+  - interrupts		: Contains the micfil interrupts.
+
+  - clocks		: Must contain an entry for each entry in clock-names.
+
+  - clock-names		: Must include the "ipg_clk" for register access and
+			  "ipg_clk_app" for internal micfil clock.
+
+  - dmas		: Generic dma devicetree binding as described in
+			  Documentation/devicetree/bindings/dma/dma.txt.
+
+Example:
+micfil: micfil@30080000 {
+	compatible = "fsl,imx8mm-micfil";
+	reg = <0x0 0x30080000 0x0 0x10000>;
+	interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clk IMX8MM_CLK_PDM_IPG>,
+		 <&clk IMX8MM_CLK_PDM_ROOT>;
+	clock-names = "ipg_clk", "ipg_clk_app";
+	dmas = <&sdma2 24 26 0x80000000>;
+};
-- 
2.20.1
