From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v6 00/10] soundwire: Add multi link support
Date: Tue, 17 Jul 2018 00:17:03 +0530
Message-ID: <20180716184713.13356-1-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 382FC267600
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 20:46:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, shreyas.nc@intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

Currently, in the SoundWire subsystem, the concept of stream is limited
to a Master and one or more Slaves(Codecs). This series aims to add
support for multiple Master(s) sharing the same reference clock and
synchronized in the hardware.

This patch series adds:
 - Fix to avoid duplicate stream state assignment
 - Avoid incorrect stream release after configuring Master
 - Helpers to lock bus instances part of the stream
 - Boiler plate conversion of code to support a list of Master runtime
 - Support multi link bank switch to support synchronization between
   multiple masters
 - Add Intel platform ops for pre/post bank switch
 - Fix to avoid bus lock acquired twice

changes in v6:
 - Add patch to fix acquiring bus lock twice during master release
 - In sdw_stream_add_master(), perform multi link check at start of
   function as suggested by Pierre
 - Minor comment fixes

changes in v5:
 - Add patch to fix duplicate stream state assignment
 - fix incorrect exit which was releasing the stream after configuring master
 - In sdw_release_bus_lock(), release the mutex in reverse order as
   suggested by Takashi

changes in v4:
 - Added changes in sdw_stream_runtime structure to track Masters
   added to stream
 - Add changes to support ml_bankswitch only if both the hardware supports
   and the stream is handled by multiple masters

Sanyog Kale (3):
  Documentation: soundwire: Add documentation for multi link
  soundwire: Add support to lock across bus instances
  soundwire: Fix acquiring bus lock twice during master release

Shreyas NC (6):
  soundwire: Initialize completion for defer messages
  soundwire: Fix duplicate stream state assignment
  soundwire: fix incorrect exit after configuring stream
  soundwire: keep track of Masters in a stream
  soundwire: Add support for multi link bank switch
  soundwire: intel: Add pre/post bank switch ops

Vinod Koul (1):
  soundwire: Handle multiple master instances in a stream

 Documentation/driver-api/soundwire/stream.rst |  28 ++
 drivers/soundwire/bus.c                       |   6 +
 drivers/soundwire/bus.h                       |   4 +
 drivers/soundwire/intel.c                     |  65 ++++
 drivers/soundwire/stream.c                    | 511 +++++++++++++++++++-------
 include/linux/soundwire/sdw.h                 |  12 +-
 6 files changed, 489 insertions(+), 137 deletions(-)

-- 
2.13.0
