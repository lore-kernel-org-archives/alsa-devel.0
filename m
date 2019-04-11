From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/5] soundwire: code cleanup
Date: Wed, 10 Apr 2019 22:16:56 -0500
Message-ID: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SoundWire support will be provided in Linux with the Sound Open
Firmware (SOF) on Intel platforms. Before we start adding the missing
pieces, there are a number of warnings and style issues reported by
checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

Changes since v2:
fixed inversion of devm_kcalloc parameters, detected while rebasing
additional patches.

Changes since v1:
added missing newlines in new patch (suggested by Joe Perches)

Pierre-Louis Bossart (5):
  soundwire: intel: fix inversion in devm_kcalloc parameters
  soundwire: fix style issues
  soundwire: bus: remove useless initializations
  soundwire: stream: remove useless initialization of local variable
  soundwire: add missing newlines in dynamic debug logs

 drivers/soundwire/Kconfig          |   2 +-
 drivers/soundwire/bus.c            | 137 ++++++++-------
 drivers/soundwire/bus.h            |  16 +-
 drivers/soundwire/bus_type.c       |   4 +-
 drivers/soundwire/cadence_master.c |  99 +++++------
 drivers/soundwire/cadence_master.h |  22 +--
 drivers/soundwire/intel.c          | 103 ++++++-----
 drivers/soundwire/intel.h          |   4 +-
 drivers/soundwire/intel_init.c     |  12 +-
 drivers/soundwire/mipi_disco.c     | 116 +++++++------
 drivers/soundwire/slave.c          |  10 +-
 drivers/soundwire/stream.c         | 267 +++++++++++++++--------------
 12 files changed, 404 insertions(+), 388 deletions(-)

-- 
2.17.1
