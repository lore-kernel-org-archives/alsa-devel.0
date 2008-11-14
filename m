From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: OMAP: Add more supported sample
	rates into McBSP DAI driver
Date: Fri, 14 Nov 2008 14:58:44 +0000
Message-ID: <1226674726-11678-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081114145705.GA11635@rakim.wolfsonmicro.main>
	<1226674726-11678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77483103817
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 15:58:47 +0100 (CET)
In-Reply-To: <1226674726-11678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Originally it was put too tight limits to support only 44.1 kHz and 48 kHz
sample rates in McBSP DAI driver. Extend it now to 8 kHz - 96 kHz. With
96 kHz and 2*16 bits, bit clock is 3.072 MHz < 3.125 MHz (I2S max?).

Tested on Nokia N810 with TVL320AIC33 from rates 8 - 96 kHz and on Texas
Instruments Beagle with TWL4030 from rates 8 - 48 kHz.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Acked-by: Steve Sakoman <steve@sakoman.com>
Acked-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
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
