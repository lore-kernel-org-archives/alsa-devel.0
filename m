From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v3 0/6] soundwire: Add multi link support
Date: Thu, 14 Jun 2018 17:01:57 +0530
Message-ID: <1528975923-15141-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id CD1E02675FA
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 13:33:41 +0200 (CEST)
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
 - Helpers to lock bus instances part of the stream
 - Boiler plate conversion of code to support a list of
   Master runtime
 - Support multi link bank switch to support synchronization
   between multiple masters
 - Add Intel platform ops for pre/post bank switch

changes in v3:
 - Added comments to explain the trigger for multi link
   bank switch
 - Added comments in the intel_post_bank_switch ops to explain
   how synchronous trigger of bank switch is handled.

Sanyog Kale (2):
  Documentation: soundwire: Add documentation for multi link
  soundwire: Add support to lock across bus instances

Shreyas NC (3):
  soundwire: Initialize completion for defer messages
  soundwire: Add support for multi link bank switch
  soundwire: intel: Add pre/post bank switch ops

Vinod Koul (1):
  soundwire: Handle multiple master instances in a stream

 Documentation/driver-api/soundwire/stream.rst |  29 +-
 drivers/soundwire/bus.c                       |   1 +
 drivers/soundwire/bus.h                       |   4 +
 drivers/soundwire/intel.c                     |  65 ++++
 drivers/soundwire/stream.c                    | 456 ++++++++++++++++++--------
 include/linux/soundwire/sdw.h                 |   8 +-
 6 files changed, 432 insertions(+), 131 deletions(-)

-- 
2.7.4
