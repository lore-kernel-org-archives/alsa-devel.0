From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/9] ASoC: Intel: fix Coccinelle and Sparse
	warnings
Date: Sun, 16 Dec 2018 16:49:01 -0600
Message-ID: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C8E2677E4
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 23:49:15 +0100 (CET)
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Make minor warnings go away to make sure Intel/SOF CI checks don't
fail and new issues are detected.

Sparse checks are not complete, the legacy stuff is just too messy to
fix, we only check for soc/sof/intel/boards since it's the only part
reused by SOF.

Pierre-Louis Bossart (9):
  ASoC: Intel: Skylake: remove useless cast
  ASoC: Intel: Skylake: simplify boolean tests
  ASoC: Intel: Haswell: remove unneeded semicolon
  ASoC: Intel: Haswell: assign booleans to true/false
  ASoC: Intel: Baytrail: remove unneeded variable
  ASoC: Intel: Baytrail: simplify boolean test
  ASoC: Intel: Atom: simplify boolean tests
  ASoC: Intel: Atom: work-around Coccinelle false-alarm
  ASoC: Intel: boards: use snd_mask_set_format in all machine drivers

 sound/soc/intel/atom/sst-atom-controls.c      | 4 ++--
 sound/soc/intel/atom/sst-mfld-platform-pcm.c  | 2 +-
 sound/soc/intel/atom/sst/sst_acpi.c           | 2 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c  | 2 +-
 sound/soc/intel/atom/sst/sst_loader.c         | 2 +-
 sound/soc/intel/baytrail/sst-baytrail-ipc.c   | 3 +--
 sound/soc/intel/baytrail/sst-baytrail-pcm.c   | 2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 2 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c  | 4 ++--
 sound/soc/intel/haswell/sst-haswell-ipc.c     | 2 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c     | 4 ++--
 sound/soc/intel/skylake/skl-messages.c        | 2 +-
 sound/soc/intel/skylake/skl-pcm.c             | 2 +-
 sound/soc/intel/skylake/skl-topology.c        | 2 +-
 14 files changed, 17 insertions(+), 18 deletions(-)


base-commit: ba26f635bf7253b42b08135152b18a2c8082abb7
-- 
2.17.1
