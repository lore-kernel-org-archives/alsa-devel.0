From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 00/14] SoundWire bus driver
Date: Fri, 21 Oct 2016 18:10:58 +0530
Message-ID: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>
List-Id: alsa-devel@alsa-project.org

Following RFC series adds SoundWire bus driver interface based on the
MIPI SoundWire specification 1.1

The SoundWire protocol is a robust, scalable, low complexity, low power,
low latency, two-pin (clock and data) multi-drop bus that allows for the
transfer of multiple audio streams and embedded control/commands.
SoundWire provides synchronization capabilities and supports both PCM
and PDM, multichannel data, isochronous and asynchronous modes.

SoundWire does borrow a number of concepts from existing interfaces such
as HDAudio, AC97, SLIMbus, which already provide control/audio on the
same wires, or legacy interfaces such as I2C/I2S, TDM, PDM.

The capabilities of SoundWire make it unique however in that it can be
implemented in peripherals such as microphones or amplifiers, mix PCM
and PDM formats and enable clock scaling to reduce power consumption.

More details about the SoundWire protocol can be obtained from MIPI
website as listed below (accessible to members only).

1. http://mipi.org/learning-center/webinars
2. https://members.mipi.org/wg/All-Members/document/download/65078
3. https://members.mipi.org/wg/Contributors/document/70055

Hardik Shah (12):
  SoundWire: Add SoundWire bus driver documentation
  SoundWire: Add SoundWire stream documentation
  SoundWire: Add error handling and locking documentation
  SoundWire: Add device_id table for SoundWire bus
  SoundWire: Add SoundWire bus driver interfaces
  SoundWire: Add register/unregister APIs
  SoundWire: Add SoundWire Slaves register definitions
  SoundWire: Add API for Slave registers read/write
  SoundWire: Add support to handle Slave status change
  SoundWire: Add support for clock stop
  SoundWire: Add tracing for Slave register read/write
  regmap: SoundWire: Add regmap support for SoundWire bus

Sanyog Kale (2):
  SoundWire: Add stream and port configuration
  SoundWire: Add support for SoundWire stream management

 Documentation/sound/alsa/sdw/error_handling.txt |   71 +
 Documentation/sound/alsa/sdw/locking.txt        |   64 +
 Documentation/sound/alsa/sdw/stream.txt         |  346 +++
 Documentation/sound/alsa/sdw/summary.txt        |  253 ++
 MAINTAINERS                                     |   12 +
 drivers/base/regmap/Kconfig                     |    3 +
 drivers/base/regmap/Makefile                    |    1 +
 drivers/base/regmap/regmap-sdw.c                |  240 ++
 include/linux/mod_devicetable.h                 |   13 +
 include/linux/regmap.h                          |   37 +
 include/sound/sdw/sdw_registers.h               |  277 ++
 include/sound/sdw_bus.h                         |  905 ++++++
 include/sound/sdw_master.h                      |  627 ++++
 include/sound/sdw_slave.h                       |  563 ++++
 include/trace/events/sdw.h                      |  209 ++
 sound/Kconfig                                   |    2 +
 sound/Makefile                                  |    1 +
 sound/sdw/Kconfig                               |    6 +
 sound/sdw/Makefile                              |    1 +
 sound/sdw/sdw.c                                 | 3749 +++++++++++++++++++++++
 sound/sdw/sdw_priv.h                            |  811 +++++
 sound/sdw/sdw_runtime.c                         | 2807 +++++++++++++++++
 22 files changed, 10998 insertions(+)
 create mode 100644 Documentation/sound/alsa/sdw/error_handling.txt
 create mode 100644 Documentation/sound/alsa/sdw/locking.txt
 create mode 100644 Documentation/sound/alsa/sdw/stream.txt
 create mode 100644 Documentation/sound/alsa/sdw/summary.txt
 create mode 100644 drivers/base/regmap/regmap-sdw.c
 create mode 100644 include/sound/sdw/sdw_registers.h
 create mode 100644 include/sound/sdw_bus.h
 create mode 100644 include/sound/sdw_master.h
 create mode 100644 include/sound/sdw_slave.h
 create mode 100644 include/trace/events/sdw.h
 create mode 100644 sound/sdw/Kconfig
 create mode 100644 sound/sdw/Makefile
 create mode 100644 sound/sdw/sdw.c
 create mode 100644 sound/sdw/sdw_priv.h
 create mode 100644 sound/sdw/sdw_runtime.c

-- 
1.7.9.5
