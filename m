From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v6 00/10] Add mrfld DSP topology and widgets
Date: Tue,  9 Sep 2014 15:11:23 +0530
Message-ID: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A3509265177
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 12:04:39 +0200 (CEST)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch series adds DPCM and DAPM widgets to handle DSP topology in the
SST platform driver for merrifield.

Changes in v6:
	Removed the init callback as per review comments from Takashi.

Subhransu S. Prusty (2):
  ASoC: Export dapm_kcontrol_get_value
  ASoC: Intel: mrfld: Use snd_soc_dai_get_drvdata to derive drv data

Vinod Koul (8):
  ASoC: Intel: mfld-pcm: don't call trigger ops to DSP for internal
    streams
  ASoC: Intel: mrfld: add bytes control for modules
  ASoC: Intel: mrfld: add the gain controls
  ASoC: Intel: mfld-pcm: add control for powering up/down dsp
  ASoC: Intel: mrfld: add DSP core controls
  ASoC: Intel: mrfld: add the DSP DAPM widgets
  ASoC: Intel: mfld-pcm: add FE and BE ops
  ASoC: Intel: mrfld: add the DSP mixers

 include/sound/soc-dapm.h                |    1 +
 sound/soc/intel/sst-atom-controls.c     | 1259 ++++++++++++++++++++++++++++++-
 sound/soc/intel/sst-atom-controls.h     |  558 ++++++++++++++
 sound/soc/intel/sst-mfld-platform-pcm.c |  179 ++++-
 sound/soc/intel/sst-mfld-platform.h     |    7 +-
 sound/soc/soc-dapm.c                    |    3 +-
 6 files changed, 1970 insertions(+), 37 deletions(-)

-- 
1.9.0
