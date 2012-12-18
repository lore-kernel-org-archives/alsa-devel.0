From: Ricardo Neri <rneri@dextratech.com>
Subject: [PATCH v3 0/5] ARM: OMAP4+: HDMI: Update platform devices for audio
Date: Mon, 17 Dec 2012 19:30:38 -0600
Message-ID: <1355794243-32345-1-git-send-email-rneri@dextratech.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, tony@atomide.com
Cc: peter.ujfalusi@ti.com, dzuniga@dextratech.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <rneri@dextratech.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Tomi, Liam, Tony,

This set aims to be the version 3 of my previous submission[1] and aims to
address the comments that Mark and Tomi kindly provided on such submission.

The creation of the platform device for the HDMI audio interface from within the
OMAPDSS HDMI driver that was previously submitted[2] is resubmitted to be
complemented with code to relocate to arch/arm/mach-omap2/display.c the
creation of the platform devices for the HDMI ASoC codec and card drivers. This
series does not break the HDMI audio functionality in any patch.

Also, the names of the platform devices are changed to give them more logical
and more descriptive names.

As the commit

commit 14840b9a83c6a56629db2ba0ec247503e975f143
Author: Ricardo Neri <ricardo.n...@ti.com>
Date:   Tue Nov 6 00:19:17 2012 -0600

    OMAPDSS: HDMI: Create platform device for audio support

is reverted in Tomi's git://gitorious.org/linux-omap-dss2/linux.git master
branch, this series applies cleanly.

Changes from v1:
*Put in a single series all the patches related to platform device updates.
*Now HDMI audio works correctly in every patch.
*Remove reference to the TPD12S015 HDMI companion chip as the ASoC drivers
 are not aware of this and other chips could be used in the future.

 Changes from v2:
*Split in two patches the renaming and the relocation of the platform devices.
*Create a separate patch to pass only the address offset of the DMA data port
 to the audio interface platform device.
*Keep the name hdmi-audio-codec to not refer to explicitly to OMAP. The codec
 can be made generic in a different patch series submitted to alsa-devel.

 BR,

 Ricardo


[1]. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg80785.html
[2]. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg79795.html

Ricardo Neri (5):
  ARM: OMAP4+: HDMI: Rename platform devices for ASoC drivers
  ARM: OMAP4: Assign IDs to DSS HDMI devices
  ARM4: OMAP4+: HDMI: Relocate devices for audio codec and card
  ARM: OMAP4+: HDMI: Relocate the device for audio interface
  ARM: OMAP4+: HDMI: Refine the DMA port resource for audio

 arch/arm/mach-omap2/board-4430sdp.c    |    9 ++---
 arch/arm/mach-omap2/board-omap4panda.c |    9 ++---
 arch/arm/mach-omap2/devices.c          |   31 ----------------
 arch/arm/mach-omap2/display.c          |   31 ++++++++++++++++
 drivers/video/omap2/dss/hdmi.c         |   62 ++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-hdmi-card.c        |    4 +--
 sound/soc/omap/omap-hdmi.c             |    5 ++-
 sound/soc/omap/omap-hdmi.h             |    2 --
 8 files changed, 103 insertions(+), 50 deletions(-)

--
1.7.10.4

