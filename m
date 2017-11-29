From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH v2 0/7] Fix Intel audio Kconfig issues
Date: Tue, 28 Nov 2017 19:45:44 -0600
Message-ID: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BEF8267381
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 02:46:06 +0100 (CET)
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

The first patch implements what Linus, Takashi and Mark
requested: a top-level selector defaulting to 'y' to easily filter all
other options and with no impact on code generation. There should be no
functionality change and will avoid breaking audio for people using
make oldnoconfig.

The rest of the patch series does a more in-depth cleanup. It was tested
on Baytrail/Cherrytrail/Skylake platforms with no regressions
observed and no reports of any compilation issues with 0-day or
randconfig.

The 4th patch is really the most important one, there were nested
configs which made no sense to me. I don't know the history which led
to such complicated stuff but simpler is better.

The last 3 patches are just clean-ups of the machine driver configs,
for some reason there is no consistency in the settings so I tried to
apply common sense and use the same rules. At Andy Shevchenko's suggestion,
I also replaced the broken dependency on X86_INTEL_LPSS by MFD_INTEL_LPSS
for Skylake+ machines, which looks ok but needs to be tested further, hence
the RFCv2 status (this change is fine for Chrome, Ubuntu and other distros
but better be cautious with a second set of tests with randconfig and on
Skylake)

Changes since initial RFC:
 Removed default n
 Added help text for HASWELL, BAYTRAIL (legacy) and SKYLAKE options 
 Made top level machine driver selection dependent on INTEL_SST_TOPLEVEL.
 Added help text for PCI and HIFI2 platforms
 Replaced X86_INTEL_LPSS by MFD_INTEL_LPSS for Skylake+ devices
 Fixed a couple of indentation issues
 
Pierre-Louis Bossart (7):
  ASoC: Intel: Fix Kconfig with top-level selector
  ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies
  ASoC: Intel: document what Kconfig options do
  ASoC: Intel: Fix nested/unnecessary Kconfig dependencies
  ASoC: Intel: boards: align Kconfig dependencies for Haswell/Broadwell
  ASoC: Intel: boards: align Kconfig configurations for HiFi2
  ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs

 sound/soc/intel/Kconfig        | 118 +++++++++++++++++++++++--------
 sound/soc/intel/boards/Kconfig | 155 ++++++++++++++++++++++-------------------
 2 files changed, 172 insertions(+), 101 deletions(-)

-- 
2.14.1
