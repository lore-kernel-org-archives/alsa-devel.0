From: Naveen M <naveen.m@intel.com>
Subject: [PATCH v2 0/6] ASoC: Intel: kabylake: Adds
	rt5663+max98927 machine driver
Date: Thu, 11 May 2017 18:02:18 +0530
Message-ID: <1494505944-31378-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CEEB26664F
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 14:32:25 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Convert all machine data to C99 style initialization.
Add support for multiple codecs in acpi matching of sst library using
machine quirk for robust mach driver selection.
Add kabylake machine driver & corresponding driver entry in machine table
for following codecs:
 1. rt5663 for headset configured to ssp1.
 2. max98927 for speakers configured to ssp0.
Changes in V2: Convert all machine data to C99 style. 

Naveen M (6):
  ASoC: Intel: Convert all machine data to C99 style
  ASoC: Intel: Create a helper to search for matching machine
  ASoC: Move quirk to identify correct machine driver
  ASoC: Improve machine driver selection based on quirk data
  ASoC: Intel: Add Kabylake Realtek Maxim machine driver
  ASoC: Intel: Add Kabylake RT5663+MAX98927 machine driver entry

 sound/soc/intel/Kconfig                      |  15 +
 sound/soc/intel/atom/sst/sst_acpi.c          | 211 ++++++--
 sound/soc/intel/boards/Makefile              |   2 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 687 +++++++++++++++++++++++++++
 sound/soc/intel/common/sst-acpi.h            |  23 +
 sound/soc/intel/common/sst-match-acpi.c      |  47 +-
 sound/soc/intel/skylake/skl.c                |  84 +++-
 7 files changed, 1003 insertions(+), 66 deletions(-)
 create mode 100644 sound/soc/intel/boards/kbl_rt5663_max98927.c

-- 
1.9.1
