From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 0/5] ALSA/HDA: abort probe when DMICs are
	detected
Date: Mon, 29 Jul 2019 10:51:46 -0500
Message-ID: <20190729155151.14055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE19DF800BF
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 17:51:58 +0200 (CEST)
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
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
planned. Additional testing by Canonical and Endless folks did not
expose any issues.

Changes since v3 (Feedback from Cezary)
Code cleanups (spaces and unnecessary inits)
Flipped test statement to return on errors and reduce indentation
Removed ACPI leak by adding missing ACPI_FREE()

Changes since v2 (Feedback from Takahi and Cezary)
Added comment in Kconfig to alert the user to the dependency on ACPI

Changes since v1 (Feedback from Takashi):
Squashed patch3 in patch2
Changed log to dbg_info
Fixed module parameter handling

Changes since RFC:
Cosmetic code improvements
Moved intel-nhlt.h to include/sound
Moved intel-nhlt.c to sound/hda
Removed SOC prefixes
Added full-support for vendor-defined geometries
Added Kconfig and kernel module parameter to opt-in

Pierre-Louis Bossart (5):
  ASoC: Intel: Skylake: move NHLT header to common directory
  ALSA: hda: move parts of NHLT code to new module
  ALSA: hda: intel-nhlt: handle NHLT VENDOR_DEFINED DMIC geometry
  ASoC: Intel: Skylake: use common NHLT module
  ALSA: hda/intel: stop probe if DMICS are detected on Skylake+
    platforms

 .../skl-nhlt.h => include/sound/intel-nhlt.h  |  51 +++++++--
 sound/hda/Kconfig                             |   5 +
 sound/hda/Makefile                            |   3 +
 sound/hda/intel-nhlt.c                        | 107 ++++++++++++++++++
 sound/pci/hda/Kconfig                         |  10 ++
 sound/pci/hda/hda_intel.c                     |  34 ++++++
 sound/soc/intel/Kconfig                       |   1 +
 sound/soc/intel/skylake/skl-nhlt.c            |  91 +--------------
 sound/soc/intel/skylake/skl-ssp-clk.c         |   1 +
 sound/soc/intel/skylake/skl-topology.c        |   1 +
 sound/soc/intel/skylake/skl.c                 |  12 +-
 sound/soc/intel/skylake/skl.h                 |   4 -
 12 files changed, 212 insertions(+), 108 deletions(-)
 rename sound/soc/intel/skylake/skl-nhlt.h => include/sound/intel-nhlt.h (65%)
 create mode 100644 sound/hda/intel-nhlt.c

-- 
2.20.1
