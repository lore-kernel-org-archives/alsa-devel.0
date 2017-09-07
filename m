From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/6] ASoC: Intel: Skylake: Add a clk driver to enable ssp clks early
Date: Thu,  7 Sep 2017 19:59:19 +0530
Message-ID: <1504794565-19168-1-git-send-email-subhransu.s.prusty@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, patches.audio@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, harshapriya.n@intel.com, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

For certain platforms we require to start the clocks (mclk/sclk/fs) before
the stream start. Example: for few systems, codec needs the mclk/sclk/fs to
be enabled early for a successful clock synchronization and for some
others, clock need to be enabled at boot and should be ON always.

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

Harsha Priya (1):
  ASoC: Intel: kbl: Enable mclk and ssp sclk early

Jaikrishna Nemallapudi (5):
  ASoC: Intel: Skylake: Modify skl_dsp_set_dma_control API arguments
  ASoC: Intel: Skylake: Parse nhlt to populate clock information
  ASoC: Intel: Skylake: Prepare DMA control IPC to enable/disable clock
  ASoC: Intel: Skylake: Register clock device and ops
  ASoC: Intel: Skylake: Add ssp clock driver

 sound/soc/intel/Kconfig                      |   8 +
 sound/soc/intel/boards/kbl_rt5663_max98927.c |  94 ++++++++-
 sound/soc/intel/skylake/Makefile             |   5 +
 sound/soc/intel/skylake/skl-i2s.h            |  56 ++++++
 sound/soc/intel/skylake/skl-messages.c       | 109 +++++++++-
 sound/soc/intel/skylake/skl-nhlt.c           | 148 ++++++++++++++
 sound/soc/intel/skylake/skl-ssp-clk.c        | 287 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-ssp-clk.h        | 124 ++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |   4 +-
 sound/soc/intel/skylake/skl.c                | 235 ++++++++++++++++++++++
 sound/soc/intel/skylake/skl.h                |  12 ++
 11 files changed, 1070 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/intel/skylake/skl-i2s.h
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.c
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.h

-- 
1.9.1

