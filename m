From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 00/15] soundwire: corrections to ACPI/DisCo/Intel support
Date: Wed, 22 May 2019 14:47:16 -0500
Message-ID: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Now that we are done with cleanups, we can start fixing the code with
actual semantic or functional changes.

This patchset corrects issues with Intel BIOS and hardware properties
that prevented a successful init, aligns the code with the MIPI DisCo
spec, adds rate-limiting for frequent errors and adds checks on number
of links and PDIs.

With all these changes, the hardware can be initialized correctly and
modules can be added/removed without issues on WhiskyLake and
IceLake.

Parts of this code was initially written by my Intel colleagues Vinod
Koul, Sanyog Kale, Shreyas Nc and Hardik Shah, who are either no
longer with Intel or no longer involved in SoundWire development. When
relevant, I explictly added a note in commit messages to give them
credit for their hard work, but I removed their signed-off-by tags to
avoid email bounces and avoid spamming them forever with SoundWire
patches.

Changes since v2:
Feedback from Vinod:
1. improve the SoundWire controller search without magic values
2. split patches as needed
Other additions
rate-limiting to avoid flooding dmesg logs
provide better Slave status on errors
more checks on links and PDIs

Pierre-Louis Bossart (15):
  soundwire: intel: filter SoundWire controller device search
  soundwire: mipi_disco: fix master/link error
  soundwire: add port-related definitions
  soundwire: remove master data port properties
  soundwire: mipi-disco: remove master_count property for masters
  soundwire: rename 'freq' fields
  soundwire: mipi-disco: fix clock stop modes
  soundwire: clarify comment
  soundwire: rename/clarify MIPI DisCo properties
  soundwire: cadence_master: use rate_limited dynamic debug
  soundwire: cadence_master: log Slave status mask on errors
  soundwire: cadence_master: check the number of bidir PDIs
  soundwire: Intel: add log for number of PCM and PDM PDIs
  soundwire: fix typo in comments
  soundwire: intel_init: add checks on link numbers

 drivers/soundwire/bus.c            |  6 +-
 drivers/soundwire/cadence_master.c | 29 +++++-----
 drivers/soundwire/intel.c          | 17 ++++--
 drivers/soundwire/intel.h          |  2 +-
 drivers/soundwire/intel_init.c     | 25 ++++++++-
 drivers/soundwire/mipi_disco.c     | 35 ++++++------
 drivers/soundwire/stream.c         |  8 +--
 include/linux/soundwire/sdw.h      | 88 +++++++++++++++++++++++-------
 8 files changed, 147 insertions(+), 63 deletions(-)

-- 
2.20.1
