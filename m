From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 00/13] Add mrfld DSP topology and widgets
Date: Wed, 30 Jul 2014 18:32:17 +0530
Message-ID: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B44C1261615
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 15:23:50 +0200 (CEST)
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

Changes in V3:
Addressed some review comments:
	- Using snd_soc_kcontrol_platform
	- Added lock for put handlersa
	- Fix to use send_byte_stream ops instead of generic_params ioctl

Subhransu S. Prusty (2):
  ASoC: Intel: mrfld: set private data for cpu-dai
  ASoC: Export dapm_kcontrol_get_value

Vinod Koul (11):
  ASoC: Intel: mfld-pcm: add FE and BE ops
  ASoC: intel: mfld-pcm: don't call trigger ops to DSP for internal
    streams
  ASoC: Intel: Fix to use byte control interface
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
 sound/soc/intel/sst-atom-controls.c     | 1263 +++++++++++++++++++++++++++++++
 sound/soc/intel/sst-atom-controls.h     |  844 ++++++++++++++++++++-
 sound/soc/intel/sst-mfld-platform-pcm.c |  192 ++++-
 sound/soc/intel/sst-mfld-platform.h     |   12 +-
 sound/soc/soc-dapm.c                    |    3 +-
 7 files changed, 2279 insertions(+), 39 deletions(-)
 create mode 100644 sound/soc/intel/sst-atom-controls.c

-- 
1.9.0
