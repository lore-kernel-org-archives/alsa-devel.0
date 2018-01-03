From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] ASoC: Intel: ACPI-related fixes
Date: Wed,  3 Jan 2018 11:02:39 -0600
Message-ID: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B25E62676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 18:02:49 +0100 (CET)
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

Here are 3 patches that were provided earlier on the mailing list or
in Bugzilla entries, I rebased and ported them on top of the latest
ACPI/KConfig fixes.

Jeremy Cline (1):
  ASoC: Replace snd_soc_acpi_check_hid with acpi_dev_present

Pierre-Louis Bossart (2):
  ASoC: acpi: fix machine driver selection based on quirk
  ASoC: Intel: bytcht_es8316: fix HID handling

 include/sound/soc-acpi.h               |  3 ---
 sound/soc/intel/boards/Kconfig         |  1 +
 sound/soc/intel/boards/bytcht_es8316.c | 26 ++++++++++++++++++++++-
 sound/soc/soc-acpi.c                   | 38 ++++------------------------------
 4 files changed, 30 insertions(+), 38 deletions(-)

-- 
2.14.1
