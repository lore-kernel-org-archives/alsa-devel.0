From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/6] ASoc: Intel: rename sst-mfld-platform.c
Date: Mon,  5 May 2014 14:27:48 +0530
Message-ID: <1399280272-26644-3-git-send-email-vinod.koul@intel.com>
References: <1399280272-26644-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ED48261B1A
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 11:11:17 +0200 (CEST)
In-Reply-To: <1399280272-26644-1-git-send-email-vinod.koul@intel.com>
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

to sst-mfld-platform-pcm.c so that we can split pcm and compress to different
files for upcoming changes to support more platforms

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Makefile                           |    2 +-
 ...sst-mfld-platform.c => sst-mfld-platform-pcm.c} |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename sound/soc/intel/{sst-mfld-platform.c => sst-mfld-platform-pcm.c} (100%)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index edeb79a..5d3fb6f 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -2,7 +2,7 @@
 snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
 snd-soc-sst-acpi-objs := sst-acpi.o
 
-snd-soc-sst-mfld-platform-objs := sst-mfld-platform.o
+snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o
 snd-soc-mfld-machine-objs := mfld_machine.o
 
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
diff --git a/sound/soc/intel/sst-mfld-platform.c b/sound/soc/intel/sst-mfld-platform-pcm.c
similarity index 100%
rename from sound/soc/intel/sst-mfld-platform.c
rename to sound/soc/intel/sst-mfld-platform-pcm.c
-- 
1.7.0.4
