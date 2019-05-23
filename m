From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/6] ALSA/HDA: abort probe when DMICs are
	detected
Date: Thu, 23 May 2019 18:39:45 -0500
Message-ID: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86A26F8079B
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 01:40:33 +0200 (CEST)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

This is the second take on same problem of detecting when the HDaudio
legacy driver can be used and when the SST or SOF drivers are
required.

The previous attempt based on a the PCI Class information was a
resounding failure and broke audio on Linus' laptop, so we need
additional information to avoid enabling a DSP-based driver without a
good reason to do so.

This patchset suggests the use of the NHLT information which *in
theory* exposes DMIC endpoints. The legacy HDaudio driver cannot
handle DMICs and will not provide any capture capabilities. Since it's
typically the first one to probe due to the Makefile order, aborting
the probe will let the PCI subsystem look for the next driver which
hopefully will support this capability.

I tested this patch on 5 devices (SKL, KBL, APL, GLK, WHL), three
without DMICs and two with, and the detection seems to work as
planned. I would appreciate it if HDaudio integrators and folks at
Google/Canonical/Endless can give this a try. As usual I expect that
we will have to use quirks and work-arounds, but it'd be a better idea
than a build-time mutual exclusion. We could also make this optional
(Kconfig and/or module parameters) if people prefer to muck with
blacklists.

Feedback and comments welcome!

Pierre-Louis Bossart (6):
  ASoC: Intel: boards: remove unnecessary inclusion of skl.h
  ASoC: Intel: Skylake: move NHLT header to common directory
  ASoC: Intel: common: move parts of NHLT code to new module
  ASoC: Intel: Skylake: use common NHLT module
  ALSA / hda: stop probe if DMICS are detected on Skylake+ platforms
  [HACK] ASoC: Intel: NHLT: handle VENDOR_DEFINED DMIC geometry

 sound/pci/hda/Kconfig                         |   1 +
 sound/pci/hda/hda_intel.c                     |  30 ++++++
 sound/soc/intel/Kconfig                       |   3 +
 sound/soc/intel/boards/glk_rt5682_max98357a.c |   1 -
 sound/soc/intel/boards/kbl_da7219_max98357a.c |   1 -
 sound/soc/intel/boards/kbl_da7219_max98927.c  |   1 -
 sound/soc/intel/boards/skl_hda_dsp_common.c   |   1 -
 sound/soc/intel/common/Makefile               |   3 +
 sound/soc/intel/common/intel-nhlt.c           | 101 ++++++++++++++++++
 .../skl-nhlt.h => common/intel-nhlt.h}        |  28 +++++
 sound/soc/intel/skylake/skl-nhlt.c            |  91 +---------------
 sound/soc/intel/skylake/skl-ssp-clk.c         |   1 +
 sound/soc/intel/skylake/skl-topology.c        |   1 +
 sound/soc/intel/skylake/skl.c                 |  11 +-
 sound/soc/intel/skylake/skl.h                 |   4 -
 15 files changed, 176 insertions(+), 102 deletions(-)
 create mode 100644 sound/soc/intel/common/intel-nhlt.c
 rename sound/soc/intel/{skylake/skl-nhlt.h => common/intel-nhlt.h} (83%)

-- 
2.20.1
