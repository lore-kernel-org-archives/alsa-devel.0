From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [alsa-devel] [PATCH v6 0/6] ASoC: Intel: Skylake: Add a clk driver to enable ssp clks early
Date: Tue, 26 Dec 2017 22:14:50 +0530
Message-ID: <1514306696-7062-1-git-send-email-sriramx.periyasamy@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audi o <patches.audio@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, Sriram Periyasamy <sriramx.periyasamy@intel.com>
List-Id: alsa-devel@alsa-project.org

For certain platforms, clocks (mclk/sclk/fs) are required to be up before
the stream start. Example: some codecs needs the mclk/sclk/fs to be
enabled early for a successful clock synchronization. Some platforms
require clock to be enabled at boot and be always ON.

By sending set_dma_control IPC (with the i2s blobs queried from NHLT),
these clocks can be enabled early after the firmware is downloaded.

With this series, a virtual clock driver is created which provides
interface to send the required IPCs from machine driver to enable the
clocks. NHLT is parsed during probe and the clock information is populated.
The pointer to blob is cached and sent along with the set_dma_control IPC
structure during the clk prepare/unprepare callback. Clocks are created for
a ssp if the nhlt table has endpoint configuration for that particular ssp.

Kabylake machine driver uses the clock interface to enable the clocks early
as it is required by the rt5663 driver for clock synchronization.

v5 -> v6
	- Remove unwanted checks from clk ops

	- Modify recalc_rate to return just the cached rate and remove the 
	  rate calculations

	- Add license based on SPDX	

v4 -> v5
	- Remove checks for clock enable status from machine driver since
	  taken care in the framework already

	- Add check in the skl_clk_set_rate to avoid different rates when
	  clock is enabled already

v3 -> v4
	- Add missing signed-offs

v2 -> v3
	- Moved the clk ops and IPCs from Skylake driver to clk driver and
	  reordered commits accordingly

	- Add the support for extended I2S blob config which supports
	  multiple mclk dividers in NHLT

	- Enable the clocks as well in DAPM PMU event instead of hw_params
	  in machine drivers as confirmed by codec vendor

	- Do not register the clk if there is no valid clock source is
	  avail in the I2S blob

	- Take care of error return in the clk driver

	- Address rest of the review comments and more optimization added

	- Fix the warning
		sound/soc/intel/skylake/skl.c:724:1-3:
		WARNING: PTR_ERR_OR_ZERO can be used
	  reported by scripts/coccinelle/api/ptr_ret.cocci

	- Modified DSP replies as human readable to ease the debugging

	- Add firmware replies for MCLK/SCLK clocks if they are running
	  already

v1 -> v2
	- Register parent clocks with skylake device.
	  With the patch "clk: Add support for runtime PM" soon to be merged
	  will help DSP to stay active on call to clock enable.
	  Reference: (https://patchwork.kernel.org/patch/9911741/)

	- Fix the machine driver to enable clocks early for headphone
	  playback path as well to fix a pop noise issue

Harsha Priya (1):
  ASoC: Intel: kbl: Enable mclk and ssp sclk early

Naveen M (1):
  ASoC: Intel: eve: Enable mclk and ssp sclk early

Sriram Periyasamy (2):
  ASoC: Intel: Skylake: Add ssp clock driver
  ASoC: Intel: Skylake: Add extended I2S config blob support in Clock
    driver

Subhransu S. Prusty (2):
  ASoC: Intel: Skylake: Make DSP replies more human readable
  ASoC: Intel: Skylake: Add FW reply for MCLK/SCLK IPC

 sound/soc/intel/Kconfig                            |   3 +
 sound/soc/intel/boards/Kconfig                     |   2 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |  95 ++++-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |  94 +++++
 sound/soc/intel/skylake/Makefile                   |   5 +
 sound/soc/intel/skylake/skl-i2s.h                  |  31 ++
 sound/soc/intel/skylake/skl-messages.c             |   1 +
 sound/soc/intel/skylake/skl-nhlt.c                 |  41 +-
 sound/soc/intel/skylake/skl-ssp-clk.c              | 432 +++++++++++++++++++++
 sound/soc/intel/skylake/skl-ssp-clk.h              |  38 ++
 sound/soc/intel/skylake/skl-sst-ipc.c              |  50 ++-
 sound/soc/intel/skylake/skl.h                      |   6 +
 12 files changed, 774 insertions(+), 24 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.c

-- 
2.7.4

