From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/13] soundwire: Add stream support
Date: Wed, 28 Mar 2018 15:08:25 +0530
Message-ID: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AC6F266E07
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 11:34:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


This series adds support in SoundWire subsystem for:
 - Documentation for stream support
 - stream management
 - data port management
 - DAI ops in cadence and Intel drivers
 - ASoC API to propagate SDW stream

Sanyog Kale (5):
  soundwire: Add more documentation
  soundwire: Add support for SoundWire stream management
  soundwire: Add Master and Slave port programming
  soundwire: Add helpers for ports operations
  soundwire: Add bank switch routine

Shreyas NC (2):
  ASoC: Add SoundWire stream programming interface
  soundwire: Remove cdns_master_ops

Vinod Koul (6):
  soundwire: Add support for port management
  soundwire: Add stream configuration APIs
  soundwire: cdns: Add port routines
  soundwire: cdns: Add stream routines
  soundwire: intel: Add stream initialization
  soundwire: intel: Add audio DAI ops

 .../driver-api/soundwire/error_handling.rst        |  65 ++
 Documentation/driver-api/soundwire/index.rst       |   3 +
 Documentation/driver-api/soundwire/locking.rst     | 106 +++
 Documentation/driver-api/soundwire/stream.rst      | 369 +++++++++
 drivers/soundwire/Kconfig                          |   2 +-
 drivers/soundwire/Makefile                         |   3 +-
 drivers/soundwire/bus.c                            |  44 +
 drivers/soundwire/bus.h                            |  81 ++
 drivers/soundwire/cadence_master.c                 | 449 +++++++++-
 drivers/soundwire/cadence_master.h                 | 151 ++++
 drivers/soundwire/intel.c                          | 589 ++++++++++++-
 drivers/soundwire/intel.h                          |   4 +
 drivers/soundwire/intel_init.c                     |   3 +
 drivers/soundwire/runtime.c                        | 907 +++++++++++++++++++++
 drivers/soundwire/stream.c                         | 678 +++++++++++++++
 include/linux/soundwire/sdw.h                      | 337 +++++++-
 include/linux/soundwire/sdw_intel.h                |  14 +
 include/sound/soc-dai.h                            |   5 +
 sound/soc/soc-core.c                               |  20 +
 19 files changed, 3816 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/driver-api/soundwire/error_handling.rst
 create mode 100644 Documentation/driver-api/soundwire/locking.rst
 create mode 100644 Documentation/driver-api/soundwire/stream.rst
 create mode 100644 drivers/soundwire/runtime.c
 create mode 100644 drivers/soundwire/stream.c

-- 
2.7.4
