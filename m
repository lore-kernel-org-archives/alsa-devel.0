From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: Add synchronization to SAI bindings" to the asoc tree
Date: Sat, 21 Oct 2017 11:31:55 +0100 (BST)
Message-ID: <20171021103155.124BC440057@finisterre.ee.mobilebroadband>
References: <1508418203-16840-2-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508418203-16840-2-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: Add synchronization to SAI bindings

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

>From 14f0e5f8d97e632695d92f41f2e91d10d8005d47 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 19 Oct 2017 15:03:17 +0200
Subject: [PATCH] ASoC: stm32: Add synchronization to SAI bindings

Add synchronization configuration to STM32 SAI bindings.
This patch also adds peripheral clock which is required
to access synchronization register.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index f1c5ae59e7c9..1f9cd7095337 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -10,13 +10,21 @@ Required properties:
   - reg: Base address and size of SAI common register set.
   - clocks: Must contain phandle and clock specifier pairs for each entry
 	in clock-names.
-  - clock-names: Must contain "x8k" and "x11k"
+  - clock-names: Must contain "pclk" "x8k" and "x11k"
+	"pclk": Clock which feeds the peripheral bus interface.
+	        Mandatory for "st,stm32h7-sai" compatible.
+	        Not used for "st,stm32f4-sai" compatible.
 	"x8k": SAI parent clock for sampling rates multiple of 8kHz.
 	"x11k": SAI parent clock for sampling rates multiple of 11.025kHz.
   - interrupts: cpu DAI interrupt line shared by SAI sub-blocks
 
 Optional properties:
   - resets: Reference to a reset controller asserting the SAI
+  - st,sync: specify synchronization mode.
+	By default SAI sub-block is in asynchronous mode.
+	This property sets SAI sub-block as slave of another SAI sub-block.
+	Must contain the phandle and index of the sai sub-block providing
+	the synchronization.
 
 SAI subnodes:
 Two subnodes corresponding to SAI sub-block instances A et B can be defined.
@@ -52,8 +60,8 @@ sai1: sai1@40015800 {
 	#size-cells = <1>;
 	ranges = <0 0x40015800 0x400>;
 	reg = <0x40015800 0x4>;
-	clocks = <&rcc PLL1_Q>, <&rcc PLL2_P>;
-	clock-names = "x8k", "x11k";
+	clocks = <&rcc SAI1_CK>, <&rcc PLL1_Q>, <&rcc PLL2_P>;
+	clock-names = "pclk", "x8k", "x11k";
 	interrupts = <87>;
 
 	sai1a: audio-controller@40015804 {
-- 
2.14.1
