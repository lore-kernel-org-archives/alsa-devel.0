From: Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 0/2] ASoC: Intel: Add Cometlake PCI IDs
Date: Tue,  7 May 2019 14:53:57 -0700
Message-ID: <20190507215359.113378-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Naveen M <naveen.m@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Ben Zhang <benzh@chromium.org>, Rajat Jain <rajatja@chromium.org>, Evan Green <evgreen@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


This small series adds PCI IDs for Cometlake platforms, for a
dazzling audio experience.

Changes in v2:
- Add CML-H ID 0x06c8 (Pierre-Louis)
- Add 0x06c8 for CML-H (Pierre-Louis)

Evan Green (2):
  ASoC: SOF: Add Comet Lake PCI IDs
  ASoC: Intel: Skylake: Add Cometlake PCI IDs

 sound/soc/intel/Kconfig                | 18 +++++++++++++++
 sound/soc/intel/skylake/skl-messages.c | 16 +++++++++++++
 sound/soc/intel/skylake/skl.c          | 10 ++++++++
 sound/soc/sof/intel/Kconfig            | 32 ++++++++++++++++++++++++++
 sound/soc/sof/sof-pci-dev.c            |  8 +++++++
 5 files changed, 84 insertions(+)

-- 
2.20.1
