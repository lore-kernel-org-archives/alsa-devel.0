From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 00/22] soundwire: code cleanup
Date: Wed,  1 May 2019 10:57:23 -0500
Message-ID: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SoundWire support will be provided in Linux with the Sound Open
Firmware (SOF) on Intel platforms. Before we start adding the missing
pieces, there are a number of warnings and style issues reported by
checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

Changes since v3:
patch 1,3,4 were merged for 5.2-rc1
No code change, only split patch2 in 21 patches to make Vinod
happy. Each patch only fixes a specific issue. patch 5 is now patch22
and wasn't changed. Not sure why Vinod reported the patch didn't
apply.
Added Takashi's Reviewed-by tag in all patches since the code is
exactly the same as in v3.

Changes since v2:
fixed inversion of devm_kcalloc parameters, detected while rebasing
additional patches.

Changes since v1:
added missing newlines in new patch (suggested by Joe Perches)

Pierre-Louis Bossart (22):
  soundwire: Kconfig: fix help format
  soundwire: fix SPDX license for header files
  soundwire: fix alignment issues in header files
  soundwire: bus: fix alignment issues
  soundwire: bus: fix typos in comments
  soundwire: bus: remove useless parentheses
  soundwire: bus: fix boolean comparisons
  soundwire: bus: remove spurious newline
  soundwire: bus_type: fix alignment issues
  soundwire: mipi_disco: fix alignment issues
  soundwire: mipi_disco: fix boolean comparisons
  soundwire: stream: fix alignment issues
  soundwire: slave: fix alignment issues
  soundwire: intel_init: fix alignment issues
  soundwire: intel: fix alignment issues
  soundwire: intel: protect macro parameters
  soundwire: intel: fix boolean comparison
  soundwire: cadence_master: fix alignment issues
  soundwire: cadence_master: balance parentheses
  soundwire: cadence_master: fix boolean comparisons
  soundwire: cadence_master: remove spurious newline
  soundwire: add missing newlines in dynamic debug logs

 drivers/soundwire/Kconfig          |   2 +-
 drivers/soundwire/bus.c            | 135 ++++++++-------
 drivers/soundwire/bus.h            |  16 +-
 drivers/soundwire/bus_type.c       |   4 +-
 drivers/soundwire/cadence_master.c |  99 +++++------
 drivers/soundwire/cadence_master.h |  22 +--
 drivers/soundwire/intel.c          |  99 ++++++-----
 drivers/soundwire/intel.h          |   4 +-
 drivers/soundwire/intel_init.c     |  12 +-
 drivers/soundwire/mipi_disco.c     | 116 +++++++------
 drivers/soundwire/slave.c          |  10 +-
 drivers/soundwire/stream.c         | 265 +++++++++++++++--------------
 12 files changed, 401 insertions(+), 383 deletions(-)

-- 
2.17.1
