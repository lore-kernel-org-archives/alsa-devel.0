From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 0/6] Small fixes
Date: Tue, 27 Aug 2019 16:17:06 +0200
Message-ID: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Series of small fixes:
* fixes few issues found during checking code with static checkers
* fix few prints
* define function in header, like it should be
* release topology when done with it

Amadeusz Sławiński (6):
  ASoC: Intel: Skylake: Use correct function to access iomem space
  ASoC: Intel: Fix use of potentially uninitialized variable
  ASoC: dapm: Expose snd_soc_dapm_new_control_unlocked properly
  ASoC: Intel: Skylake: Print module type instead of id
  ASoC: Intel: Skylake: Release topology when we are done with it
  ASoC: Intel: NHLT: Fix debug print format

 include/sound/soc-dapm.h               |  3 +++
 sound/soc/intel/common/sst-ipc.c       |  2 ++
 sound/soc/intel/skylake/skl-debug.c    |  2 +-
 sound/soc/intel/skylake/skl-messages.c |  5 +++--
 sound/soc/intel/skylake/skl-nhlt.c     |  2 +-
 sound/soc/intel/skylake/skl-topology.c | 20 ++++++++++----------
 sound/soc/intel/skylake/skl.h          |  1 -
 sound/soc/soc-topology.c               |  6 ------
 8 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.17.1
