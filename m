From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: jz4740: Remove Makefile entry for removed file
Date: Tue, 22 Apr 2014 22:46:31 +0200
Message-ID: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
jz4740-pcm.c file, but neglected to remove the Makefile entries.

Fixes: 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/jz4740/Makefile b/sound/soc/jz4740/Makefile
index be873c1..d32c540 100644
--- a/sound/soc/jz4740/Makefile
+++ b/sound/soc/jz4740/Makefile
@@ -1,10 +1,8 @@
 #
 # Jz4740 Platform Support
 #
-snd-soc-jz4740-objs := jz4740-pcm.o
 snd-soc-jz4740-i2s-objs := jz4740-i2s.o
 
-obj-$(CONFIG_SND_JZ4740_SOC) += snd-soc-jz4740.o
 obj-$(CONFIG_SND_JZ4740_SOC_I2S) += snd-soc-jz4740-i2s.o
 
 # Jz4740 Machine Support
-- 
1.8.0
