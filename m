From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 00/14] soundwire: Add a new SoundWire
	subsystem
Date: Fri, 10 Nov 2017 17:19:02 +0530
Message-ID: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BD434266A73
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 12:46:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
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
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git topic/patch_v2

v1: https://lkml.org/lkml/2017/10/18/1030
RFC: https://lkml.org/lkml/2016/10/21/395

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

Vinod Koul (10):
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

 Documentation/driver-api/index.rst             |    1 +
 Documentation/driver-api/soundwire/index.rst   |   15 +
 Documentation/driver-api/soundwire/summary.rst |  205 +++++
 drivers/Kconfig                                |    2 +
 drivers/Makefile                               |    1 +
 drivers/base/regmap/Kconfig                    |    4 +
 drivers/base/regmap/Makefile                   |    1 +
 drivers/base/regmap/regmap-sdw.c               |  140 ++++
 drivers/soundwire/Kconfig                      |   36 +
 drivers/soundwire/Makefile                     |   18 +
 drivers/soundwire/bus.c                        | 1013 ++++++++++++++++++++++++
 drivers/soundwire/bus.h                        |  126 +++
 drivers/soundwire/bus_type.c                   |  245 ++++++
 drivers/soundwire/cadence_master.c             |  791 ++++++++++++++++++
 drivers/soundwire/cadence_master.h             |   96 +++
 drivers/soundwire/intel.c                      |  391 +++++++++
 drivers/soundwire/intel.h                      |   72 ++
 drivers/soundwire/intel_init.c                 |  232 ++++++
 drivers/soundwire/mipi_disco.c                 |  422 ++++++++++
 drivers/soundwire/slave.c                      |  173 ++++
 drivers/soundwire/sysfs.c                      |  388 +++++++++
 include/linux/mod_devicetable.h                |    6 +
 include/linux/regmap.h                         |   37 +
 include/linux/soundwire/sdw.h                  |  563 +++++++++++++
 include/linux/soundwire/sdw_intel.h            |   74 ++
 include/linux/soundwire/sdw_registers.h        |  242 ++++++
 scripts/mod/devicetable-offsets.c              |    4 +
 scripts/mod/file2alias.c                       |   15 +
 28 files changed, 5313 insertions(+)
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
