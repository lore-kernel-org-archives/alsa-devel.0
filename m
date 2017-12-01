From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC 0/6] Enable HDA Codec support on Intel Platforms
	(Series1)
Date: Fri,  1 Dec 2017 14:43:16 +0530
Message-ID: <1512119602-2416-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 460AD267BA7
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 10:08:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Enhanced HD Audio capabilities introduced in HD Audio controllers are
added in backward compatible way i.e. it does not change the behavior
of the controller with respect to HDA Bus and HDA devices.

Since there is no change in the hardware with respect to the HDA bus and
HDA device it is more appropriate to represent the same in software as
well.

In order to align software representation with hardware it makes more
sense to have common data structures across device, bus and driver for both
enhanced HDA controllers and legacy HDA controllers.

This patch series removes the hdac_ext_device structure, hdac_ext_bus and
hdac_ext_driver data structures so that legacy and enhanced HDaudio
capabilities can be handled in a backwards-compatible way without
separate definitions.

Once this clean-up is complete, additional patches will allow for
HDaudio codec support in an ASoC framework without the need to develop
new codec drivers, thereby enabling the use of the Intel DSP on more
platforms (currently limited to hdmi).

Rakesh Ughreja (6):
  ASoC: hdac_hdmi: introduce macro to access HDMI private data
  ASoC: hdac_hdmi: clean up hdac_ext_device variable names
  ASoC: hdac_hdmi: clean up hdac_device variable names
  ALSA: hdac: Replace struct hdac_ext_device with struct hdac_device
  ALSA: hdac: Remove usage of struct hdac_ext_bus and use hdac_bus
    instead
  ALSA: hdac: Remove usage of struct hdac_ext_driver, use hdac_driver
    instead

 include/sound/hdaudio.h                |  21 ++
 include/sound/hdaudio_ext.h            | 119 ++------
 sound/hda/ext/hdac_ext_bus.c           |  76 +++--
 sound/hda/ext/hdac_ext_controller.c    |  55 ++--
 sound/hda/ext/hdac_ext_stream.c        | 104 +++----
 sound/soc/codecs/hdac_hdmi.c           | 519 ++++++++++++++++-----------------
 sound/soc/intel/skylake/skl-messages.c |  50 ++--
 sound/soc/intel/skylake/skl-nhlt.c     |   8 +-
 sound/soc/intel/skylake/skl-pcm.c      | 112 ++++---
 sound/soc/intel/skylake/skl-topology.c |  18 +-
 sound/soc/intel/skylake/skl-topology.h |   6 +-
 sound/soc/intel/skylake/skl.c          | 176 +++++------
 sound/soc/intel/skylake/skl.h          |   7 +-
 13 files changed, 571 insertions(+), 700 deletions(-)

-- 
2.7.4
