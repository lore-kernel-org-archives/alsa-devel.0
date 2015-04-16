From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/16] HD-audio core controller split
Date: Thu, 16 Apr 2015 18:14:14 +0200
Message-ID: <1429200870-5288-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 56D1E26155E
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 18:14:38 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patch series for splitting the existing HD-audio controller
code to a core library.  The purose of this split is to help writing
other HD-audio controller codes more easily.  With these library
codes, a controller driver can be written up with small skeleton
codes.  I have done quick tests, and no obvious regression found, so
submitted here for reviews.

The patches are found in topic/hda branch of sound git tree.

Note that this series isn't targeted for 4.1 but for 4.2.


Takashi

===

Jeeja KP (1):
  ALSA: hda - moved alloc/free stream pages function to controller
    library

Takashi Iwai (15):
  ALSA: hda - Handle error from get_response bus ops directly
  ALSA: hda - Add the controller helper codes to hda-core module
  ALSA: hda - Add DSP loader to core library code
  ALSA: hda - Merge codec and controller helpers
  ALSA: hda - Move send_cmd / get_response to hdac_bus_ops
  ALSA: hda - Pass bus io_ops directly from the top-level driver
  ALSA: hda - Migrate hdac_stream into legacy driver
  ALSA: hda - Migrate more hdac_stream codes
  ALSA: hda - Embed bus into controller object
  ALSA: hda - Minor refactoring
  ALSA: hda - Move PCM format and rate handling code to core library
  ALSA: hda - Add missing inclusion of <linux/clocksource.h>
  ALSA: hda - Reenable tracepoints for controller
  ALSA: hda/tegra - Fix build error and warning
  ALSA: hda - Drop azx_sd_read*/write*() macros

 include/sound/hda_register.h    |  152 +++++
 include/sound/hdaudio.h         |  282 ++++++++-
 sound/hda/Kconfig               |    3 +
 sound/hda/Makefile              |    2 +-
 sound/hda/hdac_bus.c            |   20 +-
 sound/hda/hdac_controller.c     |  507 +++++++++++++++
 sound/hda/hdac_device.c         |  300 +++++++++
 sound/hda/hdac_stream.c         |  648 ++++++++++++++++++++
 sound/pci/hda/Kconfig           |    3 -
 sound/pci/hda/Makefile          |    3 +-
 sound/pci/hda/hda_codec.c       |  409 +------------
 sound/pci/hda/hda_codec.h       |   31 +-
 sound/pci/hda/hda_controller.c  | 1295 ++++++++-------------------------------
 sound/pci/hda/hda_controller.h  |  269 +-------
 sound/pci/hda/hda_intel.c       |  234 +++----
 sound/pci/hda/hda_intel.h       |    1 +
 sound/pci/hda/hda_intel_trace.h |    4 +-
 sound/pci/hda/hda_tegra.c       |   76 +--
 sound/pci/hda/patch_ca0132.c    |    7 +-
 19 files changed, 2395 insertions(+), 1851 deletions(-)
 create mode 100644 include/sound/hda_register.h
 create mode 100644 sound/hda/hdac_controller.c
 create mode 100644 sound/hda/hdac_stream.c

-- 
2.3.5
