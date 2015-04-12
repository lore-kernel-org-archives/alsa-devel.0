From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 00/11] ASoC: hda - Add ASoC Skylake HD audio
	driver
Date: Sun, 12 Apr 2015 18:06:07 +0530
Message-ID: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C69F260579
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 15:05:45 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This series of 11 patches adds support for ASoC Skylake HD Audio driver.

Modified the hda core bus  framework to support id_table match for
ASoC DEV type instead of adding new wrapper. So dropped below RFC
[RFC 3/3] ALSA: hda - add soc hda bus wrapper from the series  [RFC 0/3]
ALSA: Add soc hda bus support

Jeeja KP (11):
  ALSA: hda - add id table support for hdac device/driver
  ALSA: hda - Add generic helper function to register/unregister driver
  ALSA: hda - add generic function to unregister all devices on bus
  ALSA: hda: corrected snd_hdac_stream_init() declaration
  ALSA: hda - exported link_reset enter/exit
  ALSA: hda - moved alloc/free stream pages function to controller
    library
  ALSA: hda - add generic functions to set hdac stream params
  ASoC: hda - add Skylake platform driver
  ALSA: hda - moved interrupt handler to controller library
  ASoC: hda - add Skylake HD audio driver
  ASoC: hda - enable ASoC Skylake HD audio driver

 include/sound/hdaudio.h     |  43 ++-
 sound/hda/hda_bus_type.c    |   2 +
 sound/hda/hdac_bus.c        |  55 +++
 sound/hda/hdac_controller.c |  78 ++++-
 sound/hda/hdac_stream.c     |  29 ++
 sound/soc/Kconfig           |   3 +-
 sound/soc/Makefile          |   1 +
 sound/soc/hda/Kconfig       |  29 ++
 sound/soc/hda/Makefile      |   6 +
 sound/soc/hda/hda_skl.c     | 829 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/hda/hda_skl.h     |  49 +++
 sound/soc/hda/hda_skl_pcm.c | 501 ++++++++++++++++++++++++++
 12 files changed, 1619 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/hda/Kconfig
 create mode 100644 sound/soc/hda/Makefile
 create mode 100644 sound/soc/hda/hda_skl.c
 create mode 100644 sound/soc/hda/hda_skl.h
 create mode 100644 sound/soc/hda/hda_skl_pcm.c

-- 
1.9.0
