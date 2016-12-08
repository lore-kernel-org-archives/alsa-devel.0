From: jeeja.kp@intel.com
Subject: [PATCH v3 00/13] ASoC: Intel: Skylake: Driver updates
Date: Thu,  8 Dec 2016 13:41:11 +0530
Message-ID: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 58FBE266917
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 09:01:15 +0100 (CET)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch series includes driver updates for the handling scenarios 
during System S0/S3 transitions when audio stream is stopped during
system.
o move DMA configuration in DSP Gateway Module widget event handler to
ensure DMA is configured after resume. 
o Enable SSP MLCK using Supply widget. This will ensure the MCLK is
enabled when the widget is power on.
o Check DMA decouple register state before coupling/decoupling the DMA.
o In case of HDMI pass-through pipe, reset only the FE Pipe when stream
in in XRUN state.
o Resume the stream from HW renderer position.
o HDMI Codec pin and converter state need to be restored when stream
is resumed.

Changes in v2:
 - Addressed Mark's comment on patch 1, split this into 2 as this had
additional changes other than configuring the DMA.
 - Addressed Takashi's comment on the usage of snd_hdac_updatel() 

Changes in v3:
 - Addressed Takashi's comment on superfluous shit used in reading the
value of PPCTL register and also cleaned the condition for updating
the reg value.

Jeeja KP (13):
  ASoC: Intel: Skylake: Update link_index and format in pipe params
  ASoC: Intel: Skylake: Add helper function to setup host/link dma
  ASoC: Intel: Skylake: Configure DMA in PRE_PMD handler of Mixer
  ASoC: Intel: Skylake: Removed unused skl_get_format()
  ALSA: hda: check stream decoupled register state
  ASoC: Intel: Skylake: Add set_tristate DAI ops to enable SSP MCLK
  ASoC: Intel: Skylake: Remove unused SSP BE prepare DAI ops
  ASoC: Intel: Skylake: Add supply widget as non DSP widget
  ASoC: Intel: Skylake: Add supply widget in skl_nau_max machine
  ASoC: Intel: Skylake: Add supply widget in bxt_da_max machine
  ASoC: Intel: Skylake: Don't reset pass-through pipe in BE prepare
  ASoC: Intel: Skylake: set the resume point to LPIB
  ASoC: hdac_hdmi: Enable pin and converter in prepare

 sound/hda/ext/hdac_ext_stream.c                 |  15 +-
 sound/soc/codecs/hdac_hdmi.c                    |  28 ++--
 sound/soc/intel/boards/bxt_da7219_max98357a.c   |  34 ++++
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |  34 ++++
 sound/soc/intel/skylake/skl-pcm.c               | 210 +++++++++++++-----------
 sound/soc/intel/skylake/skl-topology.c          |  27 ++-
 sound/soc/intel/skylake/skl-topology.h          |   6 +
 7 files changed, 240 insertions(+), 114 deletions(-)

-- 
2.5.0
