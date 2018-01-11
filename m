From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/2] ASoC: Intel: ACPI-related fixes
Date: Thu, 11 Jan 2018 13:52:07 -0600
Message-ID: <20180111195209.5809-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 44FF5266E62
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 20:52:36 +0100 (CET)
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

The first two patches in the v2 series were merged, but these last
two were not.

As agreed with Andy and Vinod, there will be a follow-up patch
to replace snd_soc_acpi_find_name_from_hid() with
acpi_dev_get_dev_name(), as well as the introduction of a helper
for the search loops.

Changes since v2:
 rename constant per Vinod's suggestion
 removed redundant comment on name

Changes since v1:
 cleaned-up quirk handling, fixed merge mistake
 added Andy's Reviewed-by tag on patch 2
 added 4th patch to add new constant dependent on ACPI_ID_LEN

Pierre-Louis Bossart (2):
  ASoC: Intel: bytcht_es8316: fix HID handling
  ASoC: acpi: remove hard-coded i2c-device name length

 include/sound/soc-acpi.h                |  3 +++
 sound/soc/intel/boards/Kconfig          |  1 +
 sound/soc/intel/boards/bytcht_da7213.c  |  2 +-
 sound/soc/intel/boards/bytcht_es8316.c  | 26 +++++++++++++++++++++++++-
 sound/soc/intel/boards/bytcr_rt5640.c   |  2 +-
 sound/soc/intel/boards/bytcr_rt5651.c   |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c |  4 ++--
 sound/soc/intel/boards/cht_bsw_rt5672.c |  2 +-
 8 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.14.1
