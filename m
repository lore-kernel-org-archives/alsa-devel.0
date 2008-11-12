From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH] ASoC: OMAP: Add more supported
	sample rates into McBSP DAI driver
Date: Wed, 12 Nov 2008 17:05:51 +0200
Message-ID: <1226502351-21838-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 264751037EF
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 16:06:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Arun KS <arunks@mistralsolutions.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

Originally it was put too tight limits to support only 44.1 kHz and 48 kHz
sample rates in McBSP DAI driver. Extend it now to 8 kHz - 96 kHz. With
96 kHz and 2*16 bits, bit clock is 3.072 MHz < 3.125 MHz (I2S max?).

Tested on Nokia N810 with TVL320AIC33 from rates 8 - 96 kHz and on Texas
Instruments Beagle with TWL4030 from rates 8 - 48 kHz.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Steve Sakoman <steve@sakoman.com>
Cc: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8485a8a..3d4060b 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -36,9 +36,7 @@
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
 
-#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_44100 | \
-				 SNDRV_PCM_RATE_48000 | \
-				 SNDRV_PCM_RATE_KNOT)
+#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
 
 struct omap_mcbsp_data {
 	unsigned int			bus_id;
-- 
1.5.6.5
