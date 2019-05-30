From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: Add COMPILE_TEST for new
	machine drivers" to the asoc tree
Date: Thu, 30 May 2019 17:33:10 +0100 (BST)
Message-ID: <20190530163311.06C9E440046@finisterre.sirena.org.uk>
References: <20190530115015.5677-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE66FF8972D
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 18:33:22 +0200 (CEST)
In-Reply-To: <20190530115015.5677-5-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: Add COMPILE_TEST for new machine drivers

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

>From 8fe751d8fd5cbf19e9d7852c5b7d8ed818be1934 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 30 May 2019 06:50:14 -0500
Subject: [PATCH] ASoC: Intel: boards: Add COMPILE_TEST for new machine drivers

We recently added COMPILE_TEST but new machine drivers were not
updated. Fix.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 317ee1e8c8c6..41649dc1c5e0 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -157,7 +157,8 @@ config SND_SOC_INTEL_CHT_BSW_NAU8824_MACH
 
 config SND_SOC_INTEL_BYT_CHT_CX2072X_MACH
 	tristate "Baytrail & Cherrytrail with CX2072X codec"
-	depends on X86_INTEL_LPSS && I2C && ACPI
+	depends on I2C && ACPI
+	depends on X86_INTEL_LPSS || COMPILE_TEST
 	select SND_SOC_ACPI
 	select SND_SOC_CX2072X
 	help
@@ -398,8 +399,8 @@ if SND_SOC_SOF_HDA_COMMON || SND_SOC_SOF_BAYTRAIL
 config SND_SOC_INTEL_SOF_RT5682_MACH
 	tristate "SOF with rt5682 codec in I2S Mode"
 	depends on I2C && ACPI
-	depends on (SND_SOC_SOF_HDA_COMMON && MFD_INTEL_LPSS) ||\
-		   (SND_SOC_SOF_BAYTRAIL && X86_INTEL_LPSS)
+	depends on (SND_SOC_SOF_HDA_COMMON && (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
+		   (SND_SOC_SOF_BAYTRAIL && (X86_INTEL_LPSS || COMPILE_TEST))
 	select SND_SOC_RT5682
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
-- 
2.20.1
