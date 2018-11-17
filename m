From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] Intel SST fixes for Chromebooks/HDaudio
	platorms
Date: Fri, 16 Nov 2018 18:47:03 -0600
Message-ID: <20181117004706.15911-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id DC35E267947
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2018 01:47:15 +0100 (CET)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

While testing Mark's for-next branch on Chromebooks, 3 problems were
exposed

a. the search loop for ACPI IDs is broken on SKL/KBL which are the
most advanced users of quirks. This is embarrassing since it's been
broken for a very very long time and those platforms have been stuck
in time with 3.18 and 4.4 kernels.

b. the change I personally made to use a common interface for machine
driver didn't work either for all the Chromebooks using information on
dmic number. My bad.

c. the change to use the common interface also missed the fact that
the Skylake driver passed the information using drv_data instead of
platform_data as done by the Atom and SOF drivers. The third patch
aligns the Skylake driver with the two others. We should now have no
dependencies between machine and platform drivers, which will help
reuse the same code.

These patches were tested on HDaudio platforms (ApolloLake and Whisky
Lake) as well as Chell (SKL) and Soraka (KBL) Chromebooks - for the
latter case we are still investigating DSP IPC errors that are
unrelated to these changes


Keyon Jie (1):
  ASoC: acpi: fix: continue searching when machine is ignored

Pierre-Louis Bossart (2):
  ASoC: Intel: fix interface for Chromebook machine drivers
  ASoC: Intel: use platform_data for machine drivers

 include/sound/soc-acpi.h                          |  1 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c      | 10 +++++-----
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 10 +++++-----
 sound/soc/intel/boards/skl_hda_dsp_generic.c      |  2 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c   | 10 +++++-----
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c     | 10 +++++-----
 sound/soc/intel/skylake/skl.c                     | 15 +++++++++++----
 sound/soc/intel/skylake/skl.h                     |  3 ---
 sound/soc/soc-acpi.c                              | 10 ++++++++--
 9 files changed, 41 insertions(+), 30 deletions(-)

-- 
2.17.1
