From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/8] ASoC: Intel: rework the mfld platform
	driver
Date: Mon,  5 May 2014 22:19:17 +0530
Message-ID: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 49EB72610D4
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 19:02:50 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch series reworks and reformats the existing platform driver we use.
This is stepping support for seconds series of patches which will support
Merrifield platform with DPCM based implementation

Not much logical changes in code except adding drain support for compressed
audio. Most is mere modularization of the existing code

Fixes in v2:
- add two more patches
- fix makefile addition is 4th patch
- dropped name change in platform ops patch

Vinod Koul (8):
  ASoC: Intel: remove FSF snail mail address
  ASoc: Intel: rename sst-mfld-platform.c
  ASoC: Intel: mark sst_set_stream_status as non static
  ASoC: Intel: split the pcm and compress to different files
  ASoC: Intel: remove unused sst-mfld platform dais
  ASoC: Intel: add drain_notify support
  ASoC: Intel: remove codec memeber from codec structs
  ASoC: Intel: move component registration blob

 sound/soc/intel/Makefile                           |   14 +-
 sound/soc/intel/sst-mfld-dsp.h                     |    8 -
 sound/soc/intel/sst-mfld-platform-compress.c       |  237 +++++++++++++++++++
 ...sst-mfld-platform.c => sst-mfld-platform-pcm.c} |  250 +-------------------
 sound/soc/intel/sst-mfld-platform.h                |   11 +-
 5 files changed, 263 insertions(+), 257 deletions(-)
 create mode 100644 sound/soc/intel/sst-mfld-platform-compress.c
 rename sound/soc/intel/{sst-mfld-platform.c => sst-mfld-platform-pcm.c} (67%)
