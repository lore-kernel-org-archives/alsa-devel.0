From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/14] soundwire: Add a new SoundWire subsystem
Date: Thu, 19 Oct 2017 08:33:16 +0530
Message-ID: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 28DE2267503
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 04:59:17 +0200 (CEST)
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

So today we celebrate Diwali, the festival of lights in this part of
the world. On this occasion I would like to add a new Linux subsystem.

This patch series adds a new SoundWire subsystem which implements a
new MIPI bus protocol 'SoundWire'.

The SoundWire protocol is a robust, scalable, low complexity, low
power, low latency, two-pin (clock and data) multi-drop bus that
allows for the transfer of multiple audio streams and embedded
control/commands.  SoundWire provides synchronization capabilities and
supports both PCM and PDM, multichannel data, isochronous and
asynchronous modes.

This series adds SoundWire Bus, IO transfers, DisCo (Discovery and
Configuration) sysfs interface, regmap and Documentation summary

This patch series is also available on
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git
topic/patch_v1

This is first version of the patch which incorporates lots of changes
based on the RFC series posted last year
https://lkml.org/lkml/2016/10/21/395


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
  soundwire: cdns: Add cadence module
  soundwire: intel: Add Intel Master driver
  soundwire: intel: Add Intel init module

 Documentation/soundwire/summary.txt     | 192 +++++++
 drivers/Kconfig                         |   2 +
 drivers/Makefile                        |   1 +
 drivers/base/regmap/Kconfig             |   4 +
 drivers/base/regmap/Makefile            |   1 +
 drivers/base/regmap/regmap-sdw.c        | 146 +++++
 drivers/soundwire/Kconfig               |  37 ++
 drivers/soundwire/Makefile              |  18 +
 drivers/soundwire/bus.c                 | 983 ++++++++++++++++++++++++++++++++
 drivers/soundwire/bus.h                 | 119 ++++
 drivers/soundwire/bus_type.c            | 245 ++++++++
 drivers/soundwire/cadence_master.c      | 793 ++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h      |  94 +++
 drivers/soundwire/intel.c               | 395 +++++++++++++
 drivers/soundwire/intel.h               |  70 +++
 drivers/soundwire/intel_init.c          | 230 ++++++++
 drivers/soundwire/mipi_disco.c          | 421 ++++++++++++++
 drivers/soundwire/slave.c               | 173 ++++++
 drivers/soundwire/sysfs.c               | 396 +++++++++++++
 include/linux/mod_devicetable.h         |   7 +
 include/linux/regmap.h                  |  37 ++
 include/linux/soundwire/sdw.h           | 564 ++++++++++++++++++
 include/linux/soundwire/sdw_intel.h     |  72 +++
 include/linux/soundwire/sdw_registers.h | 238 ++++++++
 scripts/mod/devicetable-offsets.c       |   5 +
 scripts/mod/file2alias.c                |  16 +
 26 files changed, 5259 insertions(+)
 create mode 100644 Documentation/soundwire/summary.txt
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
