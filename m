From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 00/10] ASoC: Intel: Kconfig+acpi fixes
Date: Thu,  4 Jan 2018 16:35:51 -0600
Message-ID: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 31862267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 23:36:10 +0100 (CET)
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
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

The first patch solves issues reported by 0day with non-ACPI platforms

The second patch implements what Linus, Takashi and Mark
requested: a top-level selector defaulting to 'y' to easily filter all
other options and with no impact on code generation. There should be no
functionality change and will avoid breaking audio for people using
make oldnoconfig.

The rest of the patch series does a more in-depth cleanup. It was tested
on Baytrail/Cherrytrail/Skylake platforms with no regressions
observed and no reports of any compilation issues with 0-day or
randconfig.

The 5th patch is really the most important one, there were nested
configs which made no sense to me. I don't know the history which led
to such complicated stuff but simpler is better.

Patches 6..7 are just clean-ups of the machine driver configs,
for some reason there is no consistency in the settings so I tried to
apply common sense and use the same rules. At Andy Shevchenko's suggestion,
I also replaced the broken dependency on X86_INTEL_LPSS by MFD_INTEL_LPSS
for Skylake+ machines. No regressions were identified with this change.

Patches 9..10 are new in this series and are just cosmetic changes (comments
and text simplification).

Thanks to Vinod Koul for his contributions and comments, as well as
Andy Shevchecko and Randy Dunlap for the reviews.

Changes since v2:
 addressed nit-picks from Andy (removed duplicate platforms, moved IOSF_MBI
  last, moved SPI dependency for KBL on separate line)
 fixed Medfield name
 added Andy's Reviewed-by tag
 unsquashed patches from Vinod
 clarified commit message (Randy's feedback on misleading if/endif wording)
 
Changes since v1:
 fixed more 0-day warnings for e.g. s390 non-ACPI compilation
 fixed use of depends
 fixed use of CONFIG_
 fixed indentations as needed
 simplified text and comments
 
Changes since RFCv2:
 Moved machine drivers to submenu
 Dropped SND_SOC_INTEL_COMMON since it was not needed
 Added more comments for if/endif
 Simplified text for options (dropped "ASoC Intel driver....")
 Fixed one 0-day warning
 
Changes since initial RFC:
 Removed default n
 Added help text for HASWELL, BAYTRAIL (legacy) and SKYLAKE options 
 Made top level machine driver selection dependent on INTEL_SST_TOPLEVEL.
 Added help text for PCI and HIFI2 platforms
 Replaced X86_INTEL_LPSS by MFD_INTEL_LPSS for Skylake+ devices
 Fixed a couple of indentation issues
 
Pierre-Louis Bossart (8):
  ASoC: acpi: add missing includes for non-ACPI platforms
  ASoC: Intel: Fix Kconfig with top-level selector
  ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies
  ASoC: Intel: document what Kconfig options do
  ASoC: Intel: Fix nested/unnecessary Kconfig dependencies
  ASoC: Intel: boards: align Kconfig dependencies for Haswell/Broadwell
  ASoC: Intel: boards: align Kconfig configurations for HiFi2
  ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs

Vinod Koul (2):
  ASoC: Intel: kconfig: add some comments for if symbols
  ASoC: Intel: kconfig: drop boiler plate text from config items

 include/sound/soc-acpi-intel-match.h |   1 +
 include/sound/soc-acpi.h             |   1 +
 sound/soc/intel/Kconfig              | 116 +++++++++++++++------
 sound/soc/intel/Makefile             |   2 +-
 sound/soc/intel/boards/Kconfig       | 192 ++++++++++++++++++-----------------
 5 files changed, 187 insertions(+), 125 deletions(-)

-- 
2.14.1
