From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] Support for CherryTrail devices
Date: Thu,  3 Mar 2016 21:36:32 -0600
Message-ID: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BB68260506
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 04:36:47 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Fix dependency on DW_DMAC_CORE
Fix BIOS issues with better ACPI filtering for active devices
Change codec name based on filtered HID
Re-use bytcr-rt5640 driver

Tested on Tronsmart Ara x5 (CHT, headset only) and Asus T100TA (BYT)
to make sure nothing was broken

Thanks to Mika Westerberg for his support on ACPI

Pierre-Louis Bossart (6):
  ASoC: Intel: allow for DW_DMAC_CORE as module
  ASoC: Intel: common: filter ACPI devices with _STA return value
  ASoC: Intel: common: add translation from HID to codec-name
  ASoC: Intel: bytcr_rt5640: change quirk position
  ASoC: Intel: bytcr_rt5640: use HID translation util
  ASoC: Intel: Atom: add support for CHT w/ RT5640

 sound/soc/intel/Kconfig                 |  4 +--
 sound/soc/intel/atom/sst/sst_acpi.c     |  4 +++
 sound/soc/intel/boards/bytcr_rt5640.c   | 50 +++++++++++++++++++++----------
 sound/soc/intel/common/sst-acpi.h       |  3 ++
 sound/soc/intel/common/sst-match-acpi.c | 53 +++++++++++++++++++++++++++++++--
 5 files changed, 94 insertions(+), 20 deletions(-)

-- 
1.9.1
