From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 00/15] soundwire: Add a new SoundWire subsystem
Date: Thu, 30 Nov 2017 15:26:55 +0530
Message-ID: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

This patch series adds a new SoundWire subsystem which implements a
new MIPI bus protocol 'SoundWire'.

The SoundWire protocol is a robust, scalable, low complexity, low
power, low latency, two-pin (clock and data) multi-drop bus that
allows for the transfer of multiple audio streams and embedded
control/commands.  SoundWire provides synchronization capabilities
and supports both PCM and PDM, multichannel data, isochronous and
asynchronous modes.

This series adds SoundWire Bus, IO transfers, DisCo (Discovery and
Configuration) sysfs interface, regmap and Documentation summary

This patch series is also available on
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git topic/patch_v3

v2: https://lkml.org/lkml/2017/11/10/216
v1: https://lkml.org/lkml/2017/10/18/1030
RFC: https://lkml.org/lkml/2016/10/21/395

Changes in v3:
- Update the kernel-doc styles and fix included headers for files
- handle dev_pm_domain_attach() for defered probe
- remove OF placeholders
- change regmap license to GPLv2 only

Changes in v2:
- move documentation into driver-api and do rst conversion
- fix documentation comments
- add SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) to all
  source files
- rework the transfer logic and paging logic as commented on v1
- remove dummy sysfs fns
- registration checks and fixes
- remove slave check for regamp as that turned superfluous
- remove depends SoundWire symbol
- make modalias api arg const
- use bitmap for tracking assigned
- add counter for report present tracking
todo: add the dt-bindings

Sanyog Kale (4):
  Documentation: Add SoundWire summary
  soundwire: Add SoundWire MIPI defined registers
  soundwire: Add Slave status handling helpers
  soundwire: cdns: Add sdw_master_ops and IO transfer support

Vinod Koul (11):
  soundwire: Add SoundWire bus type
  soundwire: Add Master registration
  soundwire: Add MIPI DisCo property helpers
  soundwire: Add IO transfer
  regmap: Add SoundWire bus support
  soundwire: Add slave status handling
  soundwire: Add sysfs for SoundWire DisCo properties
  soundwire: cdns: Add cadence library
  soundwire: intel: Add Intel Master driver
  soundwire: intel: Add Intel init module
  MAINTAINERS: Add SoundWire entry

 Documentation/driver-api/index.rst             |    1 +
 Documentation/driver-api/soundwire/index.rst   |   15 +
 Documentation/driver-api/soundwire/summary.rst |  205 +++++
 MAINTAINERS                                    |   10 +
 drivers/Kconfig                                |    2 +
 drivers/Makefile                               |    1 +
 drivers/base/regmap/Kconfig                    |    4 +
 drivers/base/regmap/Makefile                   |    1 +
 drivers/base/regmap/regmap-sdw.c               |  104 +++
 drivers/soundwire/Kconfig                      |   37 +
 drivers/soundwire/Makefile                     |   18 +
 drivers/soundwire/bus.c                        | 1006 ++++++++++++++++++++++++
 drivers/soundwire/bus.h                        |  123 +++
 drivers/soundwire/bus_type.c                   |  241 ++++++
 drivers/soundwire/cadence_master.c             |  797 +++++++++++++++++++
 drivers/soundwire/cadence_master.h             |   95 +++
 drivers/soundwire/intel.c                      |  395 ++++++++++
 drivers/soundwire/intel.h                      |   71 ++
 drivers/soundwire/intel_init.c                 |  246 ++++++
 drivers/soundwire/mipi_disco.c                 |  422 ++++++++++
 drivers/soundwire/slave.c                      |  162 ++++
 drivers/soundwire/sysfs.c                      |  390 +++++++++
 include/linux/mod_devicetable.h                |    6 +
 include/linux/regmap.h                         |   37 +
 include/linux/soundwire/sdw.h                  |  542 +++++++++++++
 include/linux/soundwire/sdw_intel.h            |   71 ++
 include/linux/soundwire/sdw_registers.h        |  242 ++++++
 scripts/mod/devicetable-offsets.c              |    4 +
 scripts/mod/file2alias.c                       |   15 +
 29 files changed, 5263 insertions(+)
 create mode 100644 Documentation/driver-api/soundwire/index.rst
 create mode 100644 Documentation/driver-api/soundwire/summary.rst
 create mode 100644 drivers/base/regmap/regmap-sdw.c
 create mode 100644 drivers/soundwire/Kconfig
 create mode 100644 drivers/soundwire/Makefile
 create mode 100644 drivers/soundwire/bus.c
 create mode 100644 drivers/soundwire/bus.h
 create mode 100644 drivers/soundwire/bus_type.c
 create mode 100644 drivers/soundwire/cadence_master.c
 create mode 100644 drivers/soundwire/cadence_master.h
 create mode 100644 drivers/soundwire/intel.c
 create mode 100644 drivers/soundwire/intel.h
 create mode 100644 drivers/soundwire/intel_init.c
 create mode 100644 drivers/soundwire/mipi_disco.c
 create mode 100644 drivers/soundwire/slave.c
 create mode 100644 drivers/soundwire/sysfs.c
 create mode 100644 include/linux/soundwire/sdw.h
 create mode 100644 include/linux/soundwire/sdw_intel.h
 create mode 100644 include/linux/soundwire/sdw_registers.h

-- 
2.7.4
