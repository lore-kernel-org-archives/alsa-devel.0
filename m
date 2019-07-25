From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 00/40] soundwire: updates for 5.4
Date: Thu, 25 Jul 2019 18:39:52 -0500
Message-ID: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The existing upstream code allows for SoundWire devices to be
enumerated and managed by the bus, but streaming is not currently
supported.

Bard Liao, Rander Wang and I did quite a bit of integration/validation
work to close this gap and we now have SoundWire streaming + basic
power managemement on Intel CometLake and IceLake reference
boards. These changes are still preliminary and should not be merged
as is, but it's time to start reviews. While the number of patches is
quite large, each of the changes is quite small.

SOF driver changes will be submitted shortly as well but are still
being validated.

ClockStop modes and synchronized playback on
multiple links are not supported for now and will likely be part of
the next cycle (dependencies on codec drivers and multi-cpu DAI
support).

Acknowledgements: This work would not have been possible without the
support of Slawomir Blauciak and Tomasz Lauda on the SOF side,
currently being reviewed, see
https://github.com/thesofproject/sof/pull/1638

Comments and feedback welcome!

Bard liao (1):
  soundwire: include mod_devicetable.h to avoid compiling warnings

Pierre-Louis Bossart (38):
  soundwire: add debugfs support
  soundwire: cadence_master: add debugfs register dump
  soundwire: cadence_master: align debugfs to 8 digits
  soundwire: intel: add debugfs register dump
  soundwire: intel: move interrupt enable after interrupt handler
    registration
  soundwire: intel: prevent possible dereference in hw_params
  soundwire: intel: fix channel number reported by hardware
  soundwire: intel: remove BIOS work-arounds
  soundwire: cadence_master: fix usage of CONFIG_UPDATE
  soundwire: cadence_master: remove useless wrapper
  soundwire: cadence_master: simplify bus clash interrupt clear
  soundwire: cadence_master: revisit interrupt settings
  soundwire: cadence_master: fix register definition for SLAVE_STATE
  soundwire: cadence_master: fix definitions for INTSTAT0/1
  soundwire: cadence_master: handle multiple status reports per Slave
  soundwire: cadence_master: improve startup sequence with link hw_reset
  soundwire: bus: use runtime_pm_get_sync/pm when enabled
  soundwire: bus: split handling of Device0 events
  soundwire: bus: improve dynamic debug comments for enumeration
  soundwire: prototypes for suspend/resume
  soundwire: export helpers to find row and column values
  soundwire: stream: fix disable sequence
  soundwire: cadence_master: use BIOS defaults for frame shape
  soundwire: intel: use BIOS information to set clock dividers
  soundwire: Add Intel resource management algorithm
  soundwire: intel: handle disabled links
  soundwire: intel_init: add kernel module parameter to filter out links
  soundwire: cadence_master: add kernel parameter to override interrupt
    mask
  soundwire: intel: move shutdown() callback and don't export symbol
  soundwire: intel: add helper for initialization
  soundwire: intel: Add basic power management support
  soundwire: intel: ignore disabled links for suspend/resume
  soundwire: intel: export helper to exit reset
  soundwire: intel: disable interrupts on suspend
  soundwire: cadence_master: add hw_reset capability in debugfs
  soundwire: cadence_master: make clock stop exit configurable on init
  soundwire: intel: add pm_runtime support
  soundwire: intel: add delay on restart for enumeration

Rander Wang (1):
  soundwire: cadence_master: fix divider setting in clock register

 drivers/soundwire/Makefile                  |   4 +-
 drivers/soundwire/algo_dynamic_allocation.c | 403 ++++++++++++++++++++
 drivers/soundwire/bus.c                     |  44 ++-
 drivers/soundwire/bus.h                     |  77 +++-
 drivers/soundwire/bus_type.c                |   3 +
 drivers/soundwire/cadence_master.c          | 365 ++++++++++++++----
 drivers/soundwire/cadence_master.h          |  12 +-
 drivers/soundwire/debugfs.c                 | 156 ++++++++
 drivers/soundwire/intel.c                   | 381 +++++++++++++++++-
 drivers/soundwire/intel_init.c              |  14 +
 drivers/soundwire/slave.c                   |   1 +
 drivers/soundwire/stream.c                  |  53 ++-
 include/linux/soundwire/sdw.h               |  15 +
 13 files changed, 1414 insertions(+), 114 deletions(-)
 create mode 100644 drivers/soundwire/algo_dynamic_allocation.c
 create mode 100644 drivers/soundwire/debugfs.c

-- 
2.20.1
