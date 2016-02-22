From: Mark Brown <broonie@kernel.org>
Subject: Applied "MIPS: dt: Explicitly specify native endian
	behaviour for syscon" to the asoc tree
Date: Mon, 22 Feb 2016 12:15:19 +0900
Message-ID: <E1aXgxz-0005vE-WB@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 320B0265958
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 04:15:43 +0100 (CET)
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
To: Johannes Berg <johannes@sipsolutions.net>, Mark Brown <broonie@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   MIPS: dt: Explicitly specify native endian behaviour for syscon

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

>From 25d6463e48ea41149c88dc40648a888699e77158 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Tue, 26 Jan 2016 18:08:06 +0000
Subject: [PATCH] MIPS: dt: Explicitly specify native endian behaviour for
 syscon

On many MIPS systems the endianness of IP blocks is kept the same as
that of the CPU by the hardware.  This includes the system controllers
on these systems which are controlled via syscon which uses the regmap
API which used readl() and writel() to interact with the hardware,
meaning that all writes are converted to little endian when writing to
the hardware.  This caused a bad interaction with the regmap core in big
endian mode since it was not aware of the byte swapping and so ended up
performing little endian writes.

Unfortunately when this issue was noticed it was addressed by updating
the DT for the affected devices to specify them as little endian.  This
happened to work since it resulted in two endianness swaps which
cancelled each other out and gave little endian behaviour but meant that
the DT was clearly not accurately describing the hardware.

The intention of commit 29bb45f25ff305 (regmap-mmio: Use native
endianness for read/write) was to fix this by making regmap default to
native endianness but this breaks most other MMIO users where the
hardware has a fixed endianness and the implementation uses the __raw
accessors which are not intended to be used outside of architecture
code.  Instead use the newly added native-endian DT property to say
exactly what we want for these systems.

Fixes: 29bb45f25ff305 (regmap-mmio: Use native endianness for read/write)
Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/boot/dts/brcm/bcm6328.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm6368.dtsi | 2 +-
 arch/mips/boot/dts/brcm/bcm7125.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7358.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7360.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7420.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 1 +
 10 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
index 459b9b2..9d19236 100644
--- a/arch/mips/boot/dts/brcm/bcm6328.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -74,6 +74,7 @@
 		timer: timer@10000040 {
 			compatible = "syscon";
 			reg = <0x10000040 0x2c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi b/arch/mips/boot/dts/brcm/bcm6368.dtsi
index 9c8d3fe2..1f6b9b5 100644
--- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
@@ -54,7 +54,7 @@
 		periph_cntl: syscon@10000000 {
 			compatible = "syscon";
 			reg = <0x10000000 0x14>;
-			little-endian;
+			native-endian;
 		};
 
 		reboot: syscon-reboot@10000008 {
diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index 4fc7ece..3ae1605 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -98,6 +98,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7125-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x60c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index a3039bb..be79919 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -118,6 +118,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7346-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 4274ff4..060805b 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -112,6 +112,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7358-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 0dcc9163..bcdb09b 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -112,6 +112,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7360-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 2f3f9fc..d3b1b76 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -118,6 +118,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7362-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index bee221b..3302a1b 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -99,6 +99,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7420-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x60c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 571f30f..15b27aa 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -100,6 +100,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7425-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 614ee21..adb33e3 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -114,6 +114,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7425-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
-- 
2.7.0
