From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] Fix Sparse warnings on sound/soc/intel
Date: Tue, 24 Jul 2018 16:12:42 -0500
Message-ID: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EE3342676D4
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 23:12:57 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Since we found quite a few issues when checking the SOF code with
Sparse, I figured I'd run a quick check on the rest of the Intel audio
drivers. Some of the issues are trivial but in the end there are a
couple of improvements identified by reducing the volume of warnings,
so it's worth it overall.

If there are concerns about the code readability, I would still
recommend merging the last 3-4 patches that are really the interesting
ones exposed by Sparse checks.

Pierre-Louis Bossart (6):
  ASoC: Intel: boards: cleanup snd_mask_set usage
  ASoC: Intel: Haswell: fix endianness handling
  ASoC: Intel: Skylake: BDL definitions should be __le32
  ASoC: Intel: common: make sst_dma functions static
  ASoC: Intel: Atom: simplify iomem address and casts
  ASoC: Intel: Atom: fix inversion between __iowrite32 and __ioread32

 sound/soc/intel/atom/sst/sst_drv_interface.c       | 29 ++++++------
 sound/soc/intel/atom/sst/sst_loader.c              |  6 +--
 sound/soc/intel/boards/bdw-rt5677.c                |  2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  2 +-
 sound/soc/intel/boards/bxt_rt298.c                 |  2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c      |  2 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |  2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |  6 ++-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |  6 ++-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |  2 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |  2 +-
 sound/soc/intel/boards/skl_rt286.c                 |  2 +-
 sound/soc/intel/common/sst-firmware.c              |  6 +--
 sound/soc/intel/haswell/sst-haswell-dsp.c          | 53 ++++++++++++----------
 sound/soc/intel/skylake/skl-sst-cldma.c            |  8 ++--
 sound/soc/intel/skylake/skl-sst-cldma.h            |  2 +-
 16 files changed, 70 insertions(+), 62 deletions(-)

-- 
2.14.1
