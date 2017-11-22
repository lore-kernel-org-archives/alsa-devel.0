From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [alsa-devel] [PATCH v3 0/7] ASoC: Intel: Skylake: Add a clk driver to enable ssp clks early
Date: Wed, 22 Nov 2017 16:11:12 +0530
Message-ID: <1511347279-26989-1-git-send-email-sriramx.periyasamy@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, Sriram Periyasamy <sriramx.periyasamy@intel.com>
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
Skylake driver creates a platform driver with the clock information and
register the clk ops callback.

Kabylake machine driver uses the clock interface to enable the clocks early
as it is required by the rt5663 driver for clock synchronization.

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

Sriram Periyasamy (3):
  ASoC: Intel: Skylake: Parse nhlt and register clock device
  ASoC: Intel: Skylake: Add ssp clock driver
  ASoC: Intel: Skylake: Add extended I2S config blob support in Clock
    driver

Subhransu S. Prusty (2):
  ASoC: Intel: Skylake: Make DSP replies more human readable
  ASoC: Intel: Skylake: Add FW reply for MCLK/SCLK IPC

 sound/soc/intel/Kconfig                            |   3 +
 sound/soc/intel/boards/Kconfig                     |   2 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c       | 101 ++++-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 100 +++++
 sound/soc/intel/skylake/Makefile                   |   5 +
 sound/soc/intel/skylake/skl-i2s.h                  |  95 +++++
 sound/soc/intel/skylake/skl-messages.c             |   1 +
 sound/soc/intel/skylake/skl-nhlt.c                 | 172 ++++++++
 sound/soc/intel/skylake/skl-ssp-clk.c              | 470 +++++++++++++++++++++
 sound/soc/intel/skylake/skl-ssp-clk.h              | 117 +++++
 sound/soc/intel/skylake/skl-sst-ipc.c              |  50 ++-
 sound/soc/intel/skylake/skl.c                      |  93 ++++
 sound/soc/intel/skylake/skl.h                      |  10 +
 13 files changed, 1207 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-i2s.h
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.c
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.h

-- 
2.7.4

