From: Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] sound: soc: intel: remove unneeded dependency from Makefile
Date: Thu,  8 May 2014 10:56:11 +0530
Message-ID: <1399526771-28422-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch removes drops the entries form Makefile, fixing
following issues when make clean was run,

scripts/Makefile.clean:17: sound/soc/intel/board/Makefile: No such file or directory
scripts/Makefile.clean:17: sound/soc/intel/sst/Makefile: No such file or directory

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 Found this issue on linux-next not sure if this is fixed in
 sound subsystem tree.
 
 sound/soc/intel/Makefile |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 57242c4..26544c5 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -32,9 +32,3 @@ PLATFORM_LIBS = platform-libs/controls_v2_dpcm.o
 
 snd-soc-sst-platform-objs := pcm.o compress.o $(PLATFORM_LIBS)
 obj-$(CONFIG_SND_SST_PLATFORM) += snd-soc-sst-platform.o
-
-# Relevant Machine driver
-obj-$(CONFIG_SND_SST_MACHINE) += board/
-
-# IPC driver
-obj-$(CONFIG_SND_INTEL_SST) += sst/
-- 
1.7.9.5
