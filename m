From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v5 0/9] soundwire: Add multi link support
Date: Thu,  5 Jul 2018 17:16:27 +0530
Message-ID: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 3093A267214
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 13:48:11 +0200 (CEST)
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
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, Shreyas NC <shreyas.nc@intel.com>, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

Currently, in the SoundWire subsystem, the concept of stream is
limited to a Master and one or more Slaves(Codecs). This series
aims to add support for multiple Master(s) sharing the same
reference clock and synchronized in the hardware.

This patch series adds:
 - Fix to avoid duplicate stream state assignment
 - Avoid incorrect stream release after configuring Master
 - Helpers to lock bus instances part of the stream
 - Boiler plate conversion of code to support a list of
   Master runtime
 - Support multi link bank switch to support synchronization
   between multiple masters
 - Add Intel platform ops for pre/post bank switch

changes in v5:
 - Add patch to fix duplicate stream state assignment
 - fix incorrect exit which was releasing the stream after
   configuring master
 - In sdw_release_bus_lock(), release the mutex in reverse order
   as suggested by Takashi

changes in v4:
 - Added changes in sdw_stream_runtime structure to track Masters
   added to stream
 - Add changes to support ml_bankswitch only if both the hardware
   supports and the stream is handled by multiple masters

Sanyog Kale (2):
  Documentation: soundwire: Add documentation for multi link
  soundwire: Add support to lock across bus instances

Shreyas NC (6):
  soundwire: Fix duplicate stream state assignment
  soundwire: fix incorrect exit after configuring stream
  soundwire: Initialize completion for defer messages
  soundwire: keep track of Masters in a stream
  soundwire: Add support for multi link bank switch
  soundwire: intel: Add pre/post bank switch ops

Vinod Koul (1):
  soundwire: Handle multiple master instances in a stream

 Documentation/driver-api/soundwire/stream.rst |  28 ++
 drivers/soundwire/bus.c                       |   6 +
 drivers/soundwire/bus.h                       |   4 +
 drivers/soundwire/intel.c                     |  65 ++++
 drivers/soundwire/stream.c                    | 502 +++++++++++++++++++-------
 include/linux/soundwire/sdw.h                 |  12 +-
 6 files changed, 483 insertions(+), 134 deletions(-)

-- 
2.7.4
