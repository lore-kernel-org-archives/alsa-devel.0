From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v4 00/12] Add mrfld DSP topology and widgets
Date: Mon,  4 Aug 2014 15:15:51 +0530
Message-ID: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DC75726087E
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 12:07:23 +0200 (CEST)
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

Changes in v4:
	Removed print messages for kzalloc failure as per review comments from
	Takashi.
	
Subhransu S. Prusty (2):
  ASoC: Intel: mrfld: set private data for cpu-dai
  ASoC: Export dapm_kcontrol_get_value

Vinod Koul (10):
  ASoC: Intel: mfld-pcm: add FE and BE ops
  ASoC: intel: mfld-pcm: don't call trigger ops to DSP for internal
    streams
  ASoC: Intel: add mrfld DSP defines
  ASoC: Intel: mrfld: add bytes control for modules
  ASoC: Intel: mrfld: add the gain controls
  ASoC: Intel: mfld-pcm: add control for powering up/down dsp
  ASoC: Intel: mrfld: add DSP core controls
  ASoC: Intel: mrfld: add the DSP DAPM widgets
  ASoC: Intel: mfld-pcm: add the fe & be dai ops
  ASoC: Intel: mrfld: add the DSP mixers

 include/sound/soc-dapm.h                |    1 +
 sound/soc/intel/Makefile                |    3 +-
 sound/soc/intel/sst-atom-controls.c     | 1256 +++++++++++++++++++++++++++++++
 sound/soc/intel/sst-atom-controls.h     |  844 ++++++++++++++++++++-
 sound/soc/intel/sst-mfld-platform-pcm.c |  192 ++++-
 sound/soc/intel/sst-mfld-platform.h     |    8 +
 sound/soc/soc-dapm.c                    |    3 +-
 7 files changed, 2269 insertions(+), 38 deletions(-)
 create mode 100644 sound/soc/intel/sst-atom-controls.c

-- 
1.9.0
