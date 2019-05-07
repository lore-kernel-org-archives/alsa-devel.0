From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sound/soc/sof/: fix kconfig dependency warning" to the asoc tree
Date: Tue,  7 May 2019 03:30:32 +0100 (BST)
Message-ID: <20190507023032.86EF7440034@finisterre.sirena.org.uk>
References: <418abbd5-f01c-19ef-c9f2-7de5662f10a2@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <418abbd5-f01c-19ef-c9f2-7de5662f10a2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>moderated for non-subscribers <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sound/soc/sof/: fix kconfig dependency warning

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 4c88519133bdd802fb0df4707b5a8c066af7154d Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 6 May 2019 12:01:40 -0700
Subject: [PATCH] ASoC: sound/soc/sof/: fix kconfig dependency warning

Fix kconfig warning for unmet dependency for IOSF_MBI when
PCI is not set/enabled.  Fixes this warning:

WARNING: unmet direct dependencies detected for IOSF_MBI
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - SND_SOC_SOF_ACPI [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_SOF_TOPLEVEL [=y] && (ACPI [=y] || COMPILE_TEST [=n]) && X86 [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index a1a9ffe605dc..b204c65698f9 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -28,7 +28,7 @@ config SND_SOC_SOF_ACPI
 	select SND_SOC_ACPI if ACPI
 	select SND_SOC_SOF_OPTIONS
 	select SND_SOC_SOF_INTEL_ACPI if SND_SOC_SOF_INTEL_TOPLEVEL
-	select IOSF_MBI if X86
+	select IOSF_MBI if X86 && PCI
 	help
 	  This adds support for ACPI enumeration. This option is required
 	  to enable Intel Haswell/Broadwell/Baytrail/Cherrytrail devices
-- 
2.20.1
