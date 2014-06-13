From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/19]: add mrfld DSP support
Date: Fri, 13 Jun 2014 18:03:49 +0530
Message-ID: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 089AB261629
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:32:50 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Here is the split patch series for adding DSP support for Intel's merrfield
platform. 

The last patch si mxer update patch which we have been discussing over the list.
This is only for discussion and sake of complteness. For that patch we need the
dapm_kcontrol_get/set series to do merged OR patch to be reworked after
compenent series

Vinod Koul (19):
  ASoC: Intel: add COMPILE_TEST to mfld machine
  ASoC: Intel: mfld_pcm: move stream handling to dai_ops
  ASoC: Intel: mfld-pcm rename period callback arg
  ASoc: Intel: mfld-pcm: report pcm delay
  ASoC: Intel: add the mrfld fw IPC definations
  ASoC: Intel: mfld-pcm: modularize stream allocation code
  ASoC: Intel: add mrfld pipelines
  ASoC: Intel: use common stream allocation method for compressed stream
  ASoC: Intel: mfld-pcm: add FE and BE ops
  ASoC: Intel: add mrfld DSP registers
  ASoC: intel: mfld-pcm: don't call trigger ops to DSP for internal streams
  ASoC: Intel: add generic parameter set interface
  ASoC: Intel: mrfld: add bytes control for modules
  ASoC: Intel: mrfld: add the gain controls
  ASoC: Intel: mfld-pcm: add control for powering up/down dsp
  ASoC: Intel: mrfld: add DSP core controls
  ASoC: Intel; mrfld: add the DSP DAPM widgets
  ASoC: Intel: mfld-pcm: add the fe & be dai ops
  ASoC: Intel: mrfld: add the DSP mixers

 arch/x86/include/asm/platform_sst_audio.h    |   78 ++
 sound/soc/intel/Kconfig                      |    2 +-
 sound/soc/intel/Makefile                     |    3 +-
 sound/soc/intel/sst-atom-controls.c          | 1386 ++++++++++++++++++++++++++
 sound/soc/intel/sst-atom-controls.h          |  906 +++++++++++++++++
 sound/soc/intel/sst-mfld-dsp.h               |  414 ++++++++-
 sound/soc/intel/sst-mfld-platform-compress.c |   11 +-
 sound/soc/intel/sst-mfld-platform-pcm.c      |  492 +++++++---
 sound/soc/intel/sst-mfld-platform.h          |   47 +-
 9 files changed, 3199 insertions(+), 140 deletions(-)
 create mode 100644 arch/x86/include/asm/platform_sst_audio.h
 create mode 100644 sound/soc/intel/sst-atom-controls.c
 create mode 100644 sound/soc/intel/sst-atom-controls.h
