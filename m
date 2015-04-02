From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 0/5] Intel SST driver restructure
Date: Thu,  2 Apr 2015 15:36:59 +0800
Message-ID: <1427960224-3528-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 75CF5261A64
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 09:34:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

In order to prepare for the upstreaming of Skylake drivers and to
allow reuse of code between different Intel audio DSP products,
this patch series restructures the Intel directory as follows:

1. Create "common" directory. Move common files into this directory.

2. Create "boards" directory. Move all machine drivers into this directory.

3. Create "haswell" directory. Move all remaining hsw/bdw code into this directory.

4. Create "baytrail" directory. Move remaining baytrail driver to this directory.

5. Create "atom" directory. Move all MCG platform drivers(including sst/ folder)
to this directory.

Changes in v3:
Fix ATT43256.config 0day build issue.

Changes in v2:
Add "Reviewed-by" and "Acked-by" items from each platforms' maintainer.

Todo next step:
1. Change and move atom related codes(in atom/sst/) to corresponding and try
share as many as possible codes(e.g. sst_acpi.c).
2. Share more common codes about IPC for different platforms, e.g. The methods for
queueing and sending/reciving Tx/Rx messages, The methods for mailbox IO, The IPC
error return codes, etc.

Jie Yang (5):
  ASoC: Intel: create common folder and move common files in
  ASoC: Intel: create haswell folder and move haswell platform files in
  ASoC: Intel: create boards folder and move sst boards files in
  ASoC: Intel: create baytrail folder and move baytrail platform files
    in
  ASoC: Intel: create atom folder and move atom platform files in

 sound/soc/intel/Makefile                           | 42 +++-------------------
 sound/soc/intel/atom/Makefile                      |  7 ++++
 sound/soc/intel/{ => atom}/sst-atom-controls.c     |  0
 sound/soc/intel/{ => atom}/sst-atom-controls.h     |  0
 sound/soc/intel/{ => atom}/sst-mfld-dsp.h          |  0
 .../intel/{ => atom}/sst-mfld-platform-compress.c  |  0
 sound/soc/intel/{ => atom}/sst-mfld-platform-pcm.c |  0
 sound/soc/intel/{ => atom}/sst-mfld-platform.h     |  0
 sound/soc/intel/{ => atom}/sst/Makefile            |  0
 sound/soc/intel/{ => atom}/sst/sst.c               |  2 +-
 sound/soc/intel/{ => atom}/sst/sst.h               |  0
 sound/soc/intel/{ => atom}/sst/sst_acpi.c          |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_drv_interface.c |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_ipc.c           |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_loader.c        |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_pci.c           |  0
 sound/soc/intel/{ => atom}/sst/sst_pvt.c           |  2 +-
 sound/soc/intel/{ => atom}/sst/sst_stream.c        |  2 +-
 sound/soc/intel/baytrail/Makefile                  |  4 +++
 sound/soc/intel/{ => baytrail}/sst-baytrail-dsp.c  |  4 +--
 sound/soc/intel/{ => baytrail}/sst-baytrail-ipc.c  |  4 +--
 sound/soc/intel/{ => baytrail}/sst-baytrail-ipc.h  |  0
 sound/soc/intel/{ => baytrail}/sst-baytrail-pcm.c  |  4 +--
 sound/soc/intel/boards/Makefile                    | 15 ++++++++
 sound/soc/intel/{ => boards}/broadwell.c           |  6 ++--
 sound/soc/intel/{ => boards}/byt-max98090.c        |  2 +-
 sound/soc/intel/{ => boards}/byt-rt5640.c          |  4 +--
 .../{bytcr_dpcm_rt5640.c => boards/bytcr_rt5640.c} |  4 +--
 sound/soc/intel/{ => boards}/cht_bsw_rt5645.c      |  4 +--
 sound/soc/intel/{ => boards}/cht_bsw_rt5672.c      |  4 +--
 sound/soc/intel/{ => boards}/haswell.c             |  6 ++--
 sound/soc/intel/{ => boards}/mfld_machine.c        |  0
 sound/soc/intel/common/Makefile                    |  6 ++++
 sound/soc/intel/{ => common}/sst-acpi.c            |  0
 sound/soc/intel/{ => common}/sst-dsp-priv.h        |  0
 sound/soc/intel/{ => common}/sst-dsp.c             |  0
 sound/soc/intel/{ => common}/sst-dsp.h             |  0
 sound/soc/intel/{ => common}/sst-firmware.c        |  0
 sound/soc/intel/haswell/Makefile                   |  4 +++
 sound/soc/intel/{ => haswell}/sst-haswell-dsp.c    |  6 ++--
 sound/soc/intel/{ => haswell}/sst-haswell-ipc.c    |  4 +--
 sound/soc/intel/{ => haswell}/sst-haswell-ipc.h    |  0
 sound/soc/intel/{ => haswell}/sst-haswell-pcm.c    |  6 ++--
 43 files changed, 77 insertions(+), 73 deletions(-)
 create mode 100644 sound/soc/intel/atom/Makefile
 rename sound/soc/intel/{ => atom}/sst-atom-controls.c (100%)
 rename sound/soc/intel/{ => atom}/sst-atom-controls.h (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-dsp.h (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform-compress.c (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform-pcm.c (100%)
 rename sound/soc/intel/{ => atom}/sst-mfld-platform.h (100%)
 rename sound/soc/intel/{ => atom}/sst/Makefile (100%)
 rename sound/soc/intel/{ => atom}/sst/sst.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst.h (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_acpi.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_drv_interface.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_ipc.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_loader.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_pci.c (100%)
 rename sound/soc/intel/{ => atom}/sst/sst_pvt.c (99%)
 rename sound/soc/intel/{ => atom}/sst/sst_stream.c (99%)
 create mode 100644 sound/soc/intel/baytrail/Makefile
 rename sound/soc/intel/{ => baytrail}/sst-baytrail-dsp.c (99%)
 rename sound/soc/intel/{ => baytrail}/sst-baytrail-ipc.c (99%)
 rename sound/soc/intel/{ => baytrail}/sst-baytrail-ipc.h (100%)
 rename sound/soc/intel/{ => baytrail}/sst-baytrail-pcm.c (99%)
 create mode 100644 sound/soc/intel/boards/Makefile
 rename sound/soc/intel/{ => boards}/broadwell.c (98%)
 rename sound/soc/intel/{ => boards}/byt-max98090.c (99%)
 rename sound/soc/intel/{ => boards}/byt-rt5640.c (98%)
 rename sound/soc/intel/{bytcr_dpcm_rt5640.c => boards/bytcr_rt5640.c} (98%)
 rename sound/soc/intel/{ => boards}/cht_bsw_rt5645.c (99%)
 rename sound/soc/intel/{ => boards}/cht_bsw_rt5672.c (99%)
 rename sound/soc/intel/{ => boards}/haswell.c (98%)
 rename sound/soc/intel/{ => boards}/mfld_machine.c (100%)
 create mode 100644 sound/soc/intel/common/Makefile
 rename sound/soc/intel/{ => common}/sst-acpi.c (100%)
 rename sound/soc/intel/{ => common}/sst-dsp-priv.h (100%)
 rename sound/soc/intel/{ => common}/sst-dsp.c (100%)
 rename sound/soc/intel/{ => common}/sst-dsp.h (100%)
 rename sound/soc/intel/{ => common}/sst-firmware.c (100%)
 create mode 100644 sound/soc/intel/haswell/Makefile
 rename sound/soc/intel/{ => haswell}/sst-haswell-dsp.c (99%)
 rename sound/soc/intel/{ => haswell}/sst-haswell-ipc.c (99%)
 rename sound/soc/intel/{ => haswell}/sst-haswell-ipc.h (100%)
 rename sound/soc/intel/{ => haswell}/sst-haswell-pcm.c (99%)

-- 
1.9.1
