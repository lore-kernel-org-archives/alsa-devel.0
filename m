From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/15] ASoC: SOF: Intel: HDaudio fixes and
	improvements
Date: Wed, 12 Jun 2019 12:23:32 -0500
Message-ID: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7802BF806F5
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:23:53 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This is unfortunately a rather large patchset tied to hardware
enablement. While productizing HDAudio+DMIC-based platforms, which is
a common design starting with CoffeLake platforms, the SOF team
encountered a combination of issues with host/link DMA coupling,
interrupt handling and other bits not getting properly cleared. The
patches in this series provide significant reliability and usage
improvements. They are viewed as mandatory for any product based on
HDaudio.

There will be a smaller series to fix HDaudio wake. It's almost ready
but didn't make the cut for this week and there's no reason to delay
reviews on the main changes further.

The remaining topics to complete are autodetection of the number of
microphones, for which an ACPI-based solution exists, and
autodetection of which platforms need to rely on a signed firmware,
for which DMI quirks will be required. This will be provided later in
July (after travel+vacation break for a number of contributors).

Keyon Jie (1):
  ASoC: SOF: Intel: hda-stream: fix a deadlock with bus->reg_lock

Ranjani Sridharan (9):
  ASoC: SOF: Intel: hda: save handle to sdev in sof_intel_hda_stream
  ASoC: SOF: Intel: hda: add new macro hstream_to_sof_hda_stream()
  ASoC: SOF: topology: add cpu_dai_name for DAIs
  ASoC: SOF: Intel: hda: assign link DMA channel at run-time
  ASoC: SOF: Intel: hda: reserve host DMA channel for hostless streams
  ASoC: SOF: Intel: hda: release link DMA for paused streams during
    suspend
  ASoC: SOF: Intel: hda: couple host and link DMA during FE hw_free
  ASoC: SOF: Intel: hda: modify stream interrupt handler
  ASoC: SOF: Intel: hda: clear stream status and wakests properly

Zhu Yingjiang (5):
  ASoC: SOF: Intel: hda: use the SOF defined ppcap functions
  ASoC: SOF: Intel: hda: add function for hda stop chip
  ASoC: SOF: Intel: hda: use the defined stop chip in suspend
  ASoC: SOF: Intel: hda: make sure DMA is start/stop by read the RUN bit
  ASoC: SOF: Intel: hda: make sure RUN bit setting to 0 during clear
    stream status

 sound/soc/sof/intel/apl.c        |   1 +
 sound/soc/sof/intel/cnl.c        |   1 +
 sound/soc/sof/intel/hda-ctrl.c   |  77 +++++++-
 sound/soc/sof/intel/hda-dai.c    | 293 ++++++++++++++++++++-----------
 sound/soc/sof/intel/hda-dsp.c    |  50 ++++--
 sound/soc/sof/intel/hda-stream.c | 157 ++++++++++++++---
 sound/soc/sof/intel/hda.h        |  17 +-
 sound/soc/sof/ops.h              |  16 +-
 sound/soc/sof/pcm.c              |   7 +
 sound/soc/sof/pm.c               |  24 ++-
 sound/soc/sof/sof-priv.h         |   9 +-
 sound/soc/sof/topology.c         |  56 +-----
 12 files changed, 495 insertions(+), 213 deletions(-)

-- 
2.20.1
