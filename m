From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 0/4] ASoC: Intel: Skylake: Skylake driver
	updates
Date: Tue, 28 Nov 2017 16:40:17 +0530
Message-ID: <20171128111021.11830-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 663B7266B0F
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 12:10:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

This series includes fixes for HDMI widgets sysfs not updating, shim read
optimization and feature to configure DSP clock source.

Pradeep Tewani (2):
  ASoC: Intel: Skylake: Parse vendor tokens to build A-State table
  ASoC: Intel: Skylake: Configure DSP clock source

Puneeth Prabhu (1):
  ASoC: hdac_hdmi: Refresh sysfs during hdmi device probe

Subhransu S. Prusty (1):
  ASoC: Intel: Skylake: Remove second shim read in register_poll

 include/uapi/sound/snd_sst_tokens.h    | 17 ++++++++++++-
 sound/soc/codecs/hdac_hdmi.c           |  1 +
 sound/soc/intel/common/sst-dsp.c       |  4 +---
 sound/soc/intel/skylake/skl-messages.c | 18 ++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c      |  6 +++++
 sound/soc/intel/skylake/skl-sst-dsp.h  |  3 +++
 sound/soc/intel/skylake/skl-topology.c | 44 +++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl.h          | 17 +++++++++++++
 8 files changed, 105 insertions(+), 5 deletions(-)

-- 
2.15.0
