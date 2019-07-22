From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/21] ASoC: SOF: updates for 5.4
Date: Mon, 22 Jul 2019 09:13:41 -0500
Message-ID: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33BE7F800E8
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:10 +0200 (CEST)
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

Core updates for runtime-pm, loader extensions for i.MX support,
increased timeouts for QEMU tests and state machine fixes to make
PulseAudio happy.

I included in the same set Intel HDaudio patches, mostly about code
refactoring, jack detection and robustness improvements for IPC/DMA
handling. If Mark/Takashi prefer separate patchsets for core and Intel
stuff I can split the two.

This is a rather large set mostly due to Summer vacations and a peak
of product validation earlier in Q2, I expect more frequent/smaller
updates moving forward. We also have quite a few SoundWire-related
patches but they aren't strictly related to SOF.

Comments and feedback welcome!

Daniel Baluta (3):
  ASoC: SOF: Introduce snd_sof_dsp_get_bar_index ops
  ASoC: SOF: loader: Use the BAR provided by FW
  ASoC: SOF: loader: Don't ignore SRAM block types

Fred Oh (1):
  ASoC: SOF: remove unused state variable in suspend function

Guennadi Liakhovetski (1):
  ASoC: SOF: Intel: hda: add a parameter to disable MSI

Janusz Jankowski (1):
  ASoC: SOF: Intel: ssp: BCLK delay parameter

Kai Vehmanen (6):
  ASoC: SOF: reset DMA state in prepare
  ASoC: SOF: use common code to send PCM_FREE IPC
  ASoC: SOF: ipc: use timeout configured at probe
  ASoC: SOF: core: increase default IPC timeouts
  ASoC: SOF: Intel: hda: reset link DMA state in prepare
  ASoC: SOF: Intel: hda: remove misleading error trace from IRQ thread

Keyon Jie (1):
  ASoC: SOF: Intel: hda: correct ROM state mask

Pan Xiuli (1):
  ASoC: SOF: pci: mark last_busy value at runtime PM init

Rander Wang (4):
  ASoC: SOF: Intel: hda: reduce ifdef usage for hda
  ASoC: SOF: Intel: hda: Enable jack detection
  ASoC: SOF: Intel: hda: fix link DMA config
  ASoC: SOF: Intel: hda: fix stream id setting

Zhu Yingjiang (3):
  ASoC: SOF: Intel: hda: set position buffer in init chip
  ASoC: SOF: Intel: hda: use SOF defined init chip in resume
  ASoC: SOF: Intel: hda: remove duplicated clear WAKESTS

 include/sound/sof/dai-intel.h   |   3 +
 include/uapi/sound/sof/abi.h    |   2 +-
 include/uapi/sound/sof/tokens.h |   1 +
 sound/soc/sof/core.c            |   4 +-
 sound/soc/sof/intel/cnl.c       |   4 +-
 sound/soc/sof/intel/hda-codec.c |  44 +++++++++++++-
 sound/soc/sof/intel/hda-ctrl.c  |  21 ++++---
 sound/soc/sof/intel/hda-dai.c   |  38 +++++++-----
 sound/soc/sof/intel/hda-dsp.c   | 100 +++++++++++---------------------
 sound/soc/sof/intel/hda-ipc.c   |   4 +-
 sound/soc/sof/intel/hda.c       |  28 +++++----
 sound/soc/sof/intel/hda.h       |   9 +--
 sound/soc/sof/ipc.c             |   8 +--
 sound/soc/sof/loader.c          |  14 ++++-
 sound/soc/sof/ops.h             |  28 +++++++--
 sound/soc/sof/pcm.c             |  63 ++++++++++----------
 sound/soc/sof/pm.c              |   6 +-
 sound/soc/sof/sof-pci-dev.c     |   3 +
 sound/soc/sof/sof-priv.h        |  12 ++--
 sound/soc/sof/topology.c        |   3 +
 20 files changed, 229 insertions(+), 166 deletions(-)

-- 
2.20.1
