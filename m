From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: s6000: Allow to build when
	COMPILE_TEST is enabled
Date: Mon, 30 Jun 2014 10:01:38 +0200
Message-ID: <1404115299-24109-2-git-send-email-lars@metafoo.de>
References: <1404115299-24109-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-252.synserver.de (smtp-out-252.synserver.de
 [212.40.185.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 76FA82617B6
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 10:02:53 +0200 (CEST)
In-Reply-To: <1404115299-24109-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
List-Id: alsa-devel@alsa-project.org

Most of the ASoC s6000 code is architecture independent. This patch makes it
possible to select the platform when COMPILE_TEST is enabled.

The only architecture dependent code is the PCM driver which will still only be
selected if XTENSA_VARIANT_S6000 is enabled.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/s6000/Kconfig       | 10 ++++++++--
 sound/soc/s6000/Makefile      |  2 +-
 sound/soc/s6000/s6105-ipcam.c |  2 --
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/s6000/Kconfig b/sound/soc/s6000/Kconfig
index c74eb3d..4823e1e 100644
--- a/sound/soc/s6000/Kconfig
+++ b/sound/soc/s6000/Kconfig
@@ -1,17 +1,23 @@
 config SND_S6000_SOC
 	tristate "SoC Audio for the Stretch s6000 family"
-	depends on XTENSA_VARIANT_S6000
+	depends on XTENSA_VARIANT_S6000 || COMPILE_TEST
+	depends on HAS_IOMEM
+	select SND_S6000_SOC_PCM if XTENSA_VARIANT_S6000
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  s6000 family chips. You will also need to select the platform
 	  to support below.
 
+config SND_S6000_SOC_PCM
+	tristate
+
 config SND_S6000_SOC_I2S
 	tristate
 
 config SND_S6000_SOC_S6IPCAM
 	tristate "SoC Audio support for Stretch 6105 IP Camera"
-	depends on SND_S6000_SOC && XTENSA_PLATFORM_S6105
+	depends on SND_S6000_SOC
+	depends on XTENSA_PLATFORM_S6105 || COMPILE_TEST
 	select SND_S6000_SOC_I2S
 	select SND_SOC_TLV320AIC3X
 	help
diff --git a/sound/soc/s6000/Makefile b/sound/soc/s6000/Makefile
index 7a61361..0f0ae2a 100644
--- a/sound/soc/s6000/Makefile
+++ b/sound/soc/s6000/Makefile
@@ -2,7 +2,7 @@
 snd-soc-s6000-objs := s6000-pcm.o
 snd-soc-s6000-i2s-objs := s6000-i2s.o
 
-obj-$(CONFIG_SND_S6000_SOC) += snd-soc-s6000.o
+obj-$(CONFIG_SND_S6000_SOC_PCM) += snd-soc-s6000.o
 obj-$(CONFIG_SND_S6000_SOC_I2S) += snd-soc-s6000-i2s.o
 
 # s6105 Machine Support
diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index 0b21d1d..50875e6 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -19,8 +19,6 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include <variant/dmac.h>
-
 #include "s6000-pcm.h"
 #include "s6000-i2s.h"
 
-- 
1.8.0
