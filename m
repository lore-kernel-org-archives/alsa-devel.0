From: Mark Brown <broonie@kernel.org>
Subject: Applied "MIPS: VDSO: Fix build error with binutils 2.24 and earlier" to the asoc tree
Date: Tue, 05 Jan 2016 12:33:13 +0000
Message-ID: <E1aGQnZ-0007WR-V6@debutante>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ralf Baechle <ralf@linux-mips.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   MIPS: VDSO: Fix build error with binutils 2.24 and earlier

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

>From 398c7500a1f5f74e207bd2edca1b1721b3cc1f1e Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 23 Dec 2015 21:04:31 -0800
Subject: [PATCH] MIPS: VDSO: Fix build error with binutils 2.24 and earlier

Commit 2a037f310bab ("MIPS: VDSO: Fix build error") tries to fix a build
error seen with binutils 2.24 and earlier. However, the fix does not work,
and again results in the already known build errors if the kernel is built
with an earlier version of binutils.

CC      arch/mips/vdso/gettimeofday.o
/tmp/ccnOVbHT.s: Assembler messages:
/tmp/ccnOVbHT.s:50: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
/tmp/ccnOVbHT.s:374: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
scripts/Makefile.build:258: recipe for target 'arch/mips/vdso/gettimeofday.o' failed
make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1

Fixes: 2a037f310bab ("MIPS: VDSO: Fix build error")
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/11926/
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 018f8c7b94f2..14568900fc1d 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
 # the comments on that file.
 #
 ifndef CONFIG_CPU_MIPSR6
-  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
+  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
     $(warning MIPS VDSO requires binutils >= 2.25)
     obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
     ccflags-vdso += -DDISABLE_MIPS_VDSO
-- 
2.6.2
