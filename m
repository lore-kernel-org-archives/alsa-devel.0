From: Naveen M <naveen.m@intel.com>
Subject: [PATCH 0/6] ASoC: Intel: kabylake: Adds
	rt5663+max98927 machine driver
Date: Mon,  8 May 2017 14:48:54 +0530
Message-ID: <1494235140-29369-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A910C2668F0
 for <alsa-devel@alsa-project.org>; Mon,  8 May 2017 11:19:26 +0200 (CEST)
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Add support for multiple codecs in acpi matching of sst library using 
machine quirk for robust mach driver selection.
Add kabylake machine driver & corresponding driver entry in machine table
for following codecs:
 1. rt5663 for headset configured to ssp1.
 2. max98927 for speakers configured to ssp0. 

Naveen M (6):
  ASoC: Intel: Create a helper to search for matching machine
  ASoC: Move quirk to identify correct machine driver
  ASoC: Add quirk data to support multiple codecs
  ASoC: Improve machine driver selection based on quirk data
  ASoC: Intel: Add Kabylake Realtek Maxim machine driver
  ASoC: Intel: Add Kabylake RT5663+MAX98927 machine driver entry

 sound/soc/intel/Kconfig                      |  15 +
 sound/soc/intel/atom/sst/sst_acpi.c          |  48 +-
 sound/soc/intel/boards/Makefile              |   2 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 687 +++++++++++++++++++++++++++
 sound/soc/intel/common/sst-acpi.h            |  23 +
 sound/soc/intel/common/sst-match-acpi.c      |  47 +-
 sound/soc/intel/skylake/skl.c                |  41 +-
 7 files changed, 821 insertions(+), 42 deletions(-)
 create mode 100644 sound/soc/intel/boards/kbl_rt5663_max98927.c

-- 
1.9.1
