From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH][RESEND] ASoC: Intel: atom: fix ACPI/PCI Kconfig
Date: Mon,  2 Apr 2018 12:06:14 -0500
Message-ID: <20180402170614.5599-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B31F2673C9
 for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2018 19:06:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com, Harsha Priya N <harshapriya.n@intel.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

The split between ACPI and PCI platforms generated issues with randconfig:

with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:

ERROR: "sst_context_init"
[sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

ERROR: "sst_context_cleanup"
[sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

ERROR: "sst_alloc_drv_context"
[sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko]
undefined!

ERROR: "sst_configure_runtime_pm"
[sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

To keep things simple, let's expose two configs for
SND_SST_ATOM_HIFI2_PLATFORM_PCI and SND_SST_ATOM_HIFI2_PLATFORM_ACPI,
which select a common SND_SST_ATOM_HIFI2_PLATFORM option. To avoid
breaking existing solutions with the semantics change,
SND_SST_ATOM_HIFI2_PLATFORM_ACPI uses "default ACPI" so that "make
oldnoconfig" and "make olddefconfig" still work as expected.

Also remove mentions of Medfield while we are at it since it was
removed recently.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4772c16ede52 ("ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI
dependencies")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
already sent on January 23 but apparently missed


 sound/soc/intel/Kconfig | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ceb105cbd461..addac2a8e52a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -72,24 +72,28 @@ config SND_SOC_INTEL_BAYTRAIL
 	  for Baytrail Chromebooks but this option is now deprecated and is
 	  not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
 
+config SND_SST_ATOM_HIFI2_PLATFORM
+	tristate
+	select SND_SOC_COMPRESS
+
 config SND_SST_ATOM_HIFI2_PLATFORM_PCI
-	tristate "PCI HiFi2 (Medfield, Merrifield) Platforms"
+	tristate "PCI HiFi2 (Merrifield) Platforms"
 	depends on X86 && PCI
 	select SND_SST_IPC_PCI
-	select SND_SOC_COMPRESS
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	help
-	  If you have a Intel Medfield or Merrifield/Edison platform, then
+	  If you have a Intel Merrifield/Edison platform, then
 	  enable this option by saying Y or m. Distros will typically not
-	  enable this option: Medfield devices are not available to
-	  developers and while Merrifield/Edison can run a mainline kernel with
-	  limited functionality it will require a firmware file which
-	  is not in the standard firmware tree
+	  enable this option: while Merrifield/Edison can run a mainline
+	  kernel with limited functionality it will require a firmware file
+	  which is not in the standard firmware tree
 
-config SND_SST_ATOM_HIFI2_PLATFORM
+config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
+	default ACPI
 	depends on X86 && ACPI
 	select SND_SST_IPC_ACPI
-	select SND_SOC_COMPRESS
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SOC_ACPI_INTEL_MATCH
 	select IOSF_MBI
 	help
-- 
2.14.1
