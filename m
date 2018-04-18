From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 00/13] soundwire: Add stream support
Date: Wed, 18 Apr 2018 16:28:53 +0530
Message-ID: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FEFB267608
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 12:54:36 +0200 (CEST)
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

Updates in v4:
 - Add more comments for sdw_release_master_stream()
 - Make sure ports are freed upon sdw_stream_remove_slave()
 - Clarify snd_soc_dai_set_sdw_stream() and setting of NULL upon release.

Updates in v3:
 - Remove stream state transition checks and redefine stream states
 - Update bansk switch routines
 - Other nitpicks pointed out by Pierre.

Updates in v2:
  - Make ASoC API inlined
  - Make stream states as states and not action
  - Update the direction enum
  - Fix some typos and comment updates

Sanyog Kale (7):
  Documentation: soundwire: Add more documentation
  soundwire: Add support for SoundWire stream management
  soundwire: Add support for port management
  soundwire: Add Master and Slave port programming
  soundwire: Add helpers for ports operations
  soundwire: Add bank switch routine
  soundwire: Add stream configuration APIs

Shreyas NC (2):
  ASoC: Add SoundWire stream programming interface
  soundwire: Remove cdns_master_ops

Vinod Koul (4):
  soundwire: cdns: Add port routines
  soundwire: cdns: Add stream routines
  soundwire: intel: Add stream initialization
  soundwire: intel: Add audio DAI ops

 .../driver-api/soundwire/error_handling.rst        |   65 +
 Documentation/driver-api/soundwire/index.rst       |    3 +
 Documentation/driver-api/soundwire/locking.rst     |  106 ++
 Documentation/driver-api/soundwire/stream.rst      |  372 +++++
 drivers/soundwire/Kconfig                          |    2 +-
 drivers/soundwire/Makefile                         |    2 +-
 drivers/soundwire/bus.c                            |   43 +
 drivers/soundwire/bus.h                            |   72 +
 drivers/soundwire/cadence_master.c                 |  453 +++++-
 drivers/soundwire/cadence_master.h                 |  151 ++
 drivers/soundwire/intel.c                          |  528 ++++++-
 drivers/soundwire/intel.h                          |    4 +
 drivers/soundwire/intel_init.c                     |    3 +
 drivers/soundwire/stream.c                         | 1480 ++++++++++++++++++++
 include/linux/soundwire/sdw.h                      |  332 ++++-
 include/linux/soundwire/sdw_intel.h                |   14 +
 include/sound/soc-dai.h                            |   23 +
 17 files changed, 3639 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/driver-api/soundwire/error_handling.rst
 create mode 100644 Documentation/driver-api/soundwire/locking.rst
 create mode 100644 Documentation/driver-api/soundwire/stream.rst
 create mode 100644 drivers/soundwire/stream.c

-- 
2.7.4
