From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: fix
	sound/soc/intel/skylake/slk-ssp-clk.c build error on IA64" to
	the asoc tree
Date: Thu, 30 May 2019 17:33:12 +0100 (BST)
Message-ID: <20190530163312.3C8BB440046@finisterre.sirena.org.uk>
References: <20190530115015.5677-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8ABAF8972A
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 18:33:18 +0200 (CEST)
In-Reply-To: <20190530115015.5677-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>, tiwai@suse.de, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: fix sound/soc/intel/skylake/slk-ssp-clk.c build error on IA64

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 2c79eeb1aaf2bf0a6d9bb4732596f7dc147cab4d Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 30 May 2019 06:50:12 -0500
Subject: [PATCH] ASoc: fix sound/soc/intel/skylake/slk-ssp-clk.c build error
 on IA64

skl-ssp-clk.c does not build on IA64 because the driver
uses the common clock interface, so make the driver depend
on COMMON_CLK.

Fixes this build error:
../sound/soc/intel/skylake/skl-ssp-clk.c:26:16: error: field 'hw' has incomplete type
  struct clk_hw hw;
                ^~
[Corrections for SKL support by Pierre Bossart]

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b089ed3bf77f..a3cf47d09816 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -104,6 +104,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 config SND_SOC_INTEL_SKYLAKE
 	tristate "All Skylake/SST Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKL
 	select SND_SOC_INTEL_APL
 	select SND_SOC_INTEL_KBL
@@ -120,6 +121,7 @@ config SND_SOC_INTEL_SKYLAKE
 config SND_SOC_INTEL_SKL
 	tristate "Skylake Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel Skylake platform with the DSP enabled
@@ -128,6 +130,7 @@ config SND_SOC_INTEL_SKL
 config SND_SOC_INTEL_APL
 	tristate "Broxton/ApolloLake Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel Broxton/ApolloLake platform with the DSP
@@ -136,6 +139,7 @@ config SND_SOC_INTEL_APL
 config SND_SOC_INTEL_KBL
 	tristate "Kabylake Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel Kabylake platform with the DSP
@@ -144,6 +148,7 @@ config SND_SOC_INTEL_KBL
 config SND_SOC_INTEL_GLK
 	tristate "GeminiLake Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel GeminiLake platform with the DSP
@@ -152,6 +157,7 @@ config SND_SOC_INTEL_GLK
 config SND_SOC_INTEL_CNL
 	tristate "CannonLake/WhiskyLake Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel CNL/WHL platform with the DSP
@@ -160,6 +166,7 @@ config SND_SOC_INTEL_CNL
 config SND_SOC_INTEL_CFL
 	tristate "CoffeeLake Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel CoffeeLake platform with the DSP
@@ -168,6 +175,7 @@ config SND_SOC_INTEL_CFL
 config SND_SOC_INTEL_CML_H
 	tristate "CometLake-H Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel CometLake-H platform with the DSP
@@ -176,6 +184,7 @@ config SND_SOC_INTEL_CML_H
 config SND_SOC_INTEL_CML_LP
 	tristate "CometLake-LP Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel CometLake-LP platform with the DSP
-- 
2.20.1
