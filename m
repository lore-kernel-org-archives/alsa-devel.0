From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/4] ASoC: Intel: ACPI-related fixes
Date: Fri,  5 Jan 2018 14:55:32 -0600
Message-ID: <20180105205536.10366-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 158BA267AA9
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 21:55:45 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jeremy@jcline.org, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The first 3 patches were provided earlier on the mailing list or
in Bugzilla entries, I rebased and ported them on top of the latest
ACPI/KConfig fixes.
The last patch is a suggestion from Andy Shevchenko to remove
a hard-coded array size

Changes since v1:
 cleaned-up quirk handling, fixed merge mistake
 added Andy's Reviewed-by tag on patch 2
 added 4th patch to add new constant dependent on ACPI_ID_LEN

Jeremy Cline (1):
  ASoC: Replace snd_soc_acpi_check_hid with acpi_dev_present

Pierre-Louis Bossart (3):
  ASoC: acpi: fix machine driver selection based on quirk
  ASoC: Intel: bytcht_es8316: fix HID handling
  ASoC: acpi: remove hard-coded i2c-device name length

 include/sound/soc-acpi.h                |  6 ++---
 sound/soc/intel/boards/Kconfig          |  1 +
 sound/soc/intel/boards/bytcht_da7213.c  |  2 +-
 sound/soc/intel/boards/bytcht_es8316.c  | 26 ++++++++++++++++++++-
 sound/soc/intel/boards/bytcr_rt5640.c   |  2 +-
 sound/soc/intel/boards/bytcr_rt5651.c   |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c |  4 ++--
 sound/soc/intel/boards/cht_bsw_rt5672.c |  2 +-
 sound/soc/soc-acpi.c                    | 40 +++++----------------------------
 9 files changed, 40 insertions(+), 45 deletions(-)

-- 
2.14.1
