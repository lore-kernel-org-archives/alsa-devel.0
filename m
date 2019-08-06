From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/17] soundwire: fixes for 5.4
Date: Mon,  5 Aug 2019 19:55:05 -0500
Message-ID: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This series provides an update on the initial RFC. Debugfs and Intel
updates will be provided in follow-up patches. The order of patches
was changed since the RFC so detailed change logs are provided below.

Changes since RFC:

patch1: feedback from Vinod and Cezary
use local variable to reduce number of de-references
document that first argument is mandatory

patch2: feedback from Vinod
document that the work-around is required for all existing controllers

patch 3: feedback from Vinod
clarify comment that MCP_INT_IRQ ungates all other settings.
use MCP_INT_SLAVE_MASK instead of all individual settings ORed.

Patch 4: feedback from Vinod:
demote dynamic debug log to dev_dbg (was dev_err)

patch5:
clarify commit message that the helpers will be used in the Cadence
parts as well.

patch 6: feedback from Vinod
s/BIOS/firmware
remove magic numbers, introduce macros

patch 7:
add kbuild warning message in commit message

patch 8:
no change

patch 9: feedback from Guennadi
remove unnecessary initializations

patch 10/11/12: feedback from Vinod
split initial patch in 3 (prototype, Intel, Cadence)
add explanations on what mclk_freq is in commit messages
remove pr_err logs missed in RFC

patch 13: feedback from Bard
remove unecessary reads before update

patch 14:
no change

patch 15:
update commit message

patch 16:
update commit message
remove unnecessary dynamic debug log

patch 17:
no change

Bard liao (1):
  soundwire: include mod_devicetable.h to avoid compiling warnings

Pierre-Louis Bossart (15):
  soundwire: intel: prevent possible dereference in hw_params
  soundwire: intel: fix channel number reported by hardware
  soundwire: cadence_master: revisit interrupt settings
  soundwire: bus: improve dynamic debug comments for enumeration
  soundwire: export helpers to find row and column values
  soundwire: cadence_master: use firmware defaults for frame shape
  soundwire: stream: fix disable sequence
  soundwire: stream: remove unnecessary variable initializations
  soundwire: add new mclk_freq field for properties
  soundwire: intel: read mclk_freq property from firmware
  soundwire: cadence_master: make use of mclk_freq property
  soundwire: intel: handle disabled links
  soundwire: intel_init: add kernel module parameter to filter out links
  soundwire: cadence_master: add kernel parameter to override interrupt
    mask
  soundwire: intel: move shutdown() callback and don't export symbol

Rander Wang (1):
  soundwire: cadence_master: fix divider setting in clock register

 drivers/soundwire/bus.c             |   5 +-
 drivers/soundwire/bus.h             |   7 +-
 drivers/soundwire/cadence_master.c  | 102 +++++++++++++++++++---------
 drivers/soundwire/cadence_master.h  |   2 -
 drivers/soundwire/intel.c           |  83 ++++++++++++++++++++--
 drivers/soundwire/intel_init.c      |  11 +++
 drivers/soundwire/stream.c          |  93 ++++++++++++++++---------
 include/linux/soundwire/sdw.h       |   6 ++
 include/linux/soundwire/sdw_intel.h |   1 +
 9 files changed, 236 insertions(+), 74 deletions(-)

-- 
2.20.1
