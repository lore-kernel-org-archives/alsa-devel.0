From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/6] ASoC: Intel: rework the mfld platform
	driver
Date: Mon,  5 May 2014 14:27:46 +0530
Message-ID: <1399280272-26644-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 614A3261AF7
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 11:11:13 +0200 (CEST)
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

Not much logical changes in code but modularize the existing code

Vinod Koul (6):
  ASoC: Intel: remove FSF snail mail address
  ASoc: Intel: rename sst-mfld-platform.c
  ASoC: Intel: mark sst_set_stream_status as non static
  ASoC: Intel: split the pcm and compress to different files
  ASoC: Intel: remove unused sst-mfld platform dais
  ASoC: Intel: rename pcm dias to media dai

 sound/soc/intel/Makefile                           |    2 +-
 sound/soc/intel/sst-mfld-dsp.h                     |    4 -
 sound/soc/intel/sst-mfld-platform-compress.c       |  228 ++++++++++++++++
 ...sst-mfld-platform.c => sst-mfld-platform-pcm.c} |  278 ++------------------
 sound/soc/intel/sst-mfld-platform.h                |    9 +-
 5 files changed, 254 insertions(+), 267 deletions(-)
 create mode 100644 sound/soc/intel/sst-mfld-platform-compress.c
 rename sound/soc/intel/{sst-mfld-platform.c => sst-mfld-platform-pcm.c} (62%)
