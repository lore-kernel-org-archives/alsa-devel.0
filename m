From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/21] HD-audio controller driver split
Date: Fri, 24 Apr 2015 14:38:32 +0200
Message-ID: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2874B26058F
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4E495AB1C
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:39:00 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

here is a patch series to split HD-audio controller driver code to
snd-hda-core helper module.  It's not targeted for 4.1 but rather for
4.2 together with ASoC HD-audio.

There is no real changes from the functionality POV.  It's mostly code
splits and cleanups.

The latest patches are found in topic/hda branch of sound git tree.


Takashi

===

Jeeja KP (2):
  ALSA: hda - moved alloc/free stream pages function to controller
    library
  ALSA: hda - add generic functions to set hdac stream params

Ramesh Babu (1):
  ALSA: hda - add ASoC device type for hda core

Takashi Iwai (18):
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
  ALSA: hda - Replace hda_bus_ops with static binding
  ALSA: hda - Move prepared flag into struct hdac_stream
  ALSA: hda - Replace open codes with snd_hdac_stream_set_params()

 include/sound/hda_register.h    |  152 +++++
 include/sound/hdaudio.h         |  286 ++++++++-
 sound/hda/Kconfig               |    3 +
 sound/hda/Makefile              |    2 +-
 sound/hda/hdac_bus.c            |   20 +-
 sound/hda/hdac_controller.c     |  507 +++++++++++++++
 sound/hda/hdac_device.c         |  300 +++++++++
 sound/hda/hdac_stream.c         |  686 ++++++++++++++++++++
 sound/pci/hda/Kconfig           |    3 -
 sound/pci/hda/Makefile          |    3 +-
 sound/pci/hda/hda_codec.c       |  421 +------------
 sound/pci/hda/hda_codec.h       |   80 +--
 sound/pci/hda/hda_controller.c  | 1330 ++++++++-------------------------------
 sound/pci/hda/hda_controller.h  |  270 +-------
 sound/pci/hda/hda_intel.c       |  234 ++++---
 sound/pci/hda/hda_intel.h       |    1 +
 sound/pci/hda/hda_intel_trace.h |    4 +-
 sound/pci/hda/hda_tegra.c       |   76 +--
 sound/pci/hda/patch_ca0132.c    |    7 +-
 19 files changed, 2457 insertions(+), 1928 deletions(-)
 create mode 100644 include/sound/hda_register.h
 create mode 100644 sound/hda/hdac_controller.c
 create mode 100644 sound/hda/hdac_stream.c

-- 
2.3.5
