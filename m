From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 0/7] ASoC: Intel: Skylake: Add a clk driver to enable ssp clks early
Date: Mon, 18 Sep 2017 10:26:43 +0530
Message-ID: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, patches.audio@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, harshapriya.n@intel.com, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

For certain platforms clocks (mclk/sclk/fs) are required to be up before
the stream start.  Example: some codecs needs the mclk/sclk/fs to  be
enabled early for a successful clock synchronization. Some patforms
require clock to be enabled at boot and be always ON

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

kabylake machine driver uses the clock interface to enable the clocks early
as it is required by the rt5663 driver for clock synchronization.

set_dma_control API can be used with different payload configuration.
Modify the arguments to take configurable parameters.

v1 -> v2
	- Register parent clocks with skylake device.
	  With the patch "clk: Add support for runtime PM" soon to be merged
	  will help DSP to stay active on call to clock enable.
	  Reference: (https://patchwork.kernel.org/patch/9911741/)

	- Fix the machine driver to enable clocks early for headphone
	  playback path as well to fix a pop noise issue

	- Include the eve machine driver changes as well

Harsha Priya (1):
  ASoC: Intel: kbl: Enable mclk and ssp sclk early

Jaikrishna Nemallapudi (5):
  ASoC: Intel: Skylake: Modify skl_dsp_set_dma_control API arguments
  ASoC: Intel: Skylake: Parse nhlt to populate clock information
  ASoC: Intel: Skylake: Prepare DMA control IPC to enable/disable clock
  ASoC: Intel: Skylake: Register clock device and ops
  ASoC: Intel: Skylake: Add ssp clock driver

Naveen M (1):
  ASoC: Intel: eve: Enable mclk and ssp sclk early

 sound/soc/intel/Kconfig                            |   9 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |  98 ++++++-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |  97 +++++++
 sound/soc/intel/skylake/Makefile                   |   5 +
 sound/soc/intel/skylake/skl-i2s.h                  |  56 ++++
 sound/soc/intel/skylake/skl-messages.c             | 109 +++++++-
 sound/soc/intel/skylake/skl-nhlt.c                 | 148 +++++++++++
 sound/soc/intel/skylake/skl-ssp-clk.c              | 288 +++++++++++++++++++++
 sound/soc/intel/skylake/skl-ssp-clk.h              | 124 +++++++++
 sound/soc/intel/skylake/skl-topology.h             |   4 +-
 sound/soc/intel/skylake/skl.c                      | 235 +++++++++++++++++
 sound/soc/intel/skylake/skl.h                      |  12 +
 12 files changed, 1173 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-i2s.h
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.c
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.h

-- 
1.9.1

