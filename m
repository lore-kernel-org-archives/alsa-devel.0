From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] soundwire: code cleanup
Date: Thu,  4 Apr 2019 13:22:01 -0500
Message-ID: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SoundWire support will be provided in Linux with the Sound Open
Firmware (SOF) on Intel platforms. Before we start adding the missing
pieces, there are a number of warnings and style issues reported by
checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

While I am at it, I could use feedback from maintainers. We are ready
to release a number of required patches that were not provided
earlier, but the initial contributors have either left Intel or moved
on to other domains. While I'd like to give them credit for their
work, I don't think leaving the email addresses as is is a good
solution (email bounces, etc). I also don't think providing a
non-Intel address is correct since the work was funded by Intel. Is
there a recommended practice here?

Pierre-Louis Bossart (3):
  soundwire: fix style issues
  soundwire: bus: remove useless initializations
  soundwire: stream: remove useless initialization of local variable

 drivers/soundwire/Kconfig          |   2 +-
 drivers/soundwire/bus.c            |  89 ++++++++--------
 drivers/soundwire/bus.h            |  16 +--
 drivers/soundwire/bus_type.c       |   4 +-
 drivers/soundwire/cadence_master.c |  87 +++++++--------
 drivers/soundwire/cadence_master.h |  22 ++--
 drivers/soundwire/intel.c          |  89 ++++++++--------
 drivers/soundwire/intel.h          |   4 +-
 drivers/soundwire/intel_init.c     |  12 +--
 drivers/soundwire/mipi_disco.c     | 116 +++++++++++---------
 drivers/soundwire/slave.c          |  10 +-
 drivers/soundwire/stream.c         | 163 +++++++++++++++--------------
 12 files changed, 315 insertions(+), 299 deletions(-)

-- 
2.17.1
