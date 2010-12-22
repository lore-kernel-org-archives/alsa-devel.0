From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add jack IRQ trace to 88pm860x driver
Date: Wed, 22 Dec 2010 00:10:42 +0000
Message-ID: <1292976642-11536-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 099AC103B1D
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 01:10:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/88pm860x-codec.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 08e15de..a34fb92 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -22,6 +22,7 @@
 #include <sound/tlv.h>
 #include <sound/initval.h>
 #include <sound/jack.h>
+#include <trace/events/asoc.h>
 
 #include "88pm860x-codec.h"
 
@@ -1262,6 +1263,10 @@ static irqreturn_t pm860x_codec_handler(int irq, void *data)
 	mask = pm860x->det.hs_shrt | pm860x->det.hook_det | pm860x->det.lo_shrt
 		| pm860x->det.hp_det;
 
+	if (status & (HEADSET_STATUS | MIC_STATUS | SHORT_HS1 | SHORT_HS2 |
+		      SHORT_LO1 | SHORT_LO2))
+		trace_snd_soc_jack_irq(dev_name(pm860x->codec->dev));
+
 	if ((pm860x->det.hp_det & SND_JACK_HEADPHONE)
 		&& (status & HEADSET_STATUS))
 		report |= SND_JACK_HEADPHONE;
-- 
1.7.2.3
