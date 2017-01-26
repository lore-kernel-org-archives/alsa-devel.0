From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/17] Baytrail/Cherrytrail audio fixes
Date: Thu, 26 Jan 2017 14:09:28 -0600
Message-ID: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D2CCC267774
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:19 +0100 (CET)
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

Set of patches to correct issues with machine drivers (suspend, DAI
configuration), add missing HID reported in Bugzilla and add playback
support for Asus T100HA and Asus X205TA based on RT5645 (capture and
jack detection still work-in-progress)

Alexandrov Stansilav (2):
  ASoC: rt5640: Add "10EC3276" ACPI ID
  ASoC: Intel: Atom: Add HP Pavilion x2 10-p000 machine entry

Pierre-Louis Bossart (15):
  ASoC: Intel: atom: fix frame polarity
  ASoC: Intel: boards: remove .pm_ops in all Atom/DPCM machine drivers
  ASoC: Intel: add support for Realtek 5651 on Cherrytrail
  ASoC: codecs: rt5670: add quirk for Lenovo Thinkpad 10
  ASoC: Intel: Baytrail: add quirk for Lenovo Thinkpad 10
  ASoC: rt5645: add support for RT5648
  ASoc: rt5645: add ACPI ID 10EC3270
  ASoC: Intel: cht_bsw_rt5645: add Baytrail MCLK support
  ASoC: Intel: Atom: add machine driver for baytrail-rt5645 hardware
  ASoC: Intel: add support for ALC3270 codec
  ASoC: Intel: cht_bsw_rt5645: harden ACPI device detection
  ASoC: rt5645: fix error handling for gpio detection
  ASoC: Intel: cht-bsw-rt5645: add quirks for SSP0/AIF1/AIF2 routing
  ASoC: Intel: cht-bsw-rt5645: select ASRC source based on routing quirk
  ASoC: Intel: cht-bsw-rt5645: fix DAI formats

 sound/soc/codecs/rt5640.c                |   1 +
 sound/soc/codecs/rt5645.c                |   5 +-
 sound/soc/codecs/rt5670.c                |   1 +
 sound/soc/intel/atom/sst-atom-controls.c |   6 +-
 sound/soc/intel/atom/sst/sst_acpi.c      |  52 +++-
 sound/soc/intel/boards/bytcr_rt5640.c    |   5 +-
 sound/soc/intel/boards/bytcr_rt5651.c    |   3 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c  | 396 +++++++++++++++++++++++++++----
 8 files changed, 409 insertions(+), 60 deletions(-)

-- 
2.7.4
