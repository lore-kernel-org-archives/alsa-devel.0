From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Multi-component: JZ4740: QI_LB60 board
	fixes
Date: Sun, 15 Aug 2010 17:48:47 +0200
Message-ID: <1281887327-9104-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-244.synserver.de (smtp-out-244.synserver.de
	[212.40.180.244]) by alsa0.perex.cz (Postfix) with SMTP id 099C1244AB
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 17:49:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch contains two small fixes for the sound board driver for the qi_lb60
introduced by the multi-component patches:
* Remove unnecessary includes: Those includes where only used to get the
  definitions for the DAI devices and are thus not needed anymore.
* Fix a typo.

Signed-off-By: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/qi_lb60.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 78dabeb..ef1a99e 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -22,11 +22,6 @@
 #include <sound/soc-dapm.h>
 #include <linux/gpio.h>
 
-#include "../codecs/jz4740.h"
-#include "jz4740-pcm.h"
-#include "jz4740-i2s.h"
-
-
 #define QI_LB60_SND_GPIO JZ_GPIO_PORTB(29)
 #define QI_LB60_AMP_GPIO JZ_GPIO_PORTD(4)
 
@@ -86,7 +81,7 @@ static struct snd_soc_dai_link qi_lb60_dai = {
 	.name = "jz4740",
 	.stream_name = "jz4740",
 	.cpu_dai_name = "jz4740-i2s",
-	.platform_name = "jz4740-pmc-audio",
+	.platform_name = "jz4740-pcm-audio",
 	.codec_dai_name = "jz4740-hifi",
 	.codec_name = "jz4740-codec",
 	.init = qi_lb60_codec_init,
-- 
1.5.6.5
