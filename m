From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: hda: bus cleanup
Date: Thu,  8 Aug 2019 11:57:12 +0200
Message-ID: <20190808095715.29713-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1004F803F3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 11:57:19 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a few patches to simplify and cleanup the HD-audio bus ops.

The first two patches translate the indirect calls of DMA page
allocation and MMIO accesses with the direct ones, as well as
eliminating the whole bus->io_ops.

The last one is SOF-specific, and fixes/cleans up by calling the
proper hdaudio bus init function, as formerly discussed.


Takashi

===

Takashi Iwai (3):
  ALSA: hda: Remove page allocation redirection
  ALSA: hda: Direct MMIO accesses
  ASoC: SOF: Intel: Initialize hdaudio bus properly

 include/sound/hdaudio.h                | 69 +++++++++++++--------------
 include/sound/hdaudio_ext.h            |  1 -
 sound/hda/Kconfig                      |  3 ++
 sound/hda/ext/hdac_ext_bus.c           | 60 +-----------------------
 sound/hda/hdac_bus.c                   | 36 ++++++++++++--
 sound/hda/hdac_controller.c            | 18 +++----
 sound/hda/hdac_stream.c                |  8 ++--
 sound/pci/hda/Kconfig                  |  1 +
 sound/pci/hda/hda_controller.c         |  6 +--
 sound/pci/hda/hda_controller.h         |  3 +-
 sound/pci/hda/hda_intel.c              | 71 ++--------------------------
 sound/pci/hda/hda_tegra.c              | 84 +--------------------------------
 sound/soc/intel/skylake/skl-messages.c | 15 +-----
 sound/soc/intel/skylake/skl.c          |  7 ++-
 sound/soc/sof/intel/hda-bus.c          | 85 ++++------------------------------
 sound/soc/sof/intel/hda-dsp.c          |  2 +-
 sound/soc/sof/intel/hda.c              |  6 +--
 sound/soc/sof/intel/hda.h              |  3 +-
 18 files changed, 107 insertions(+), 371 deletions(-)

-- 
2.16.4
