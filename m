From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH] ASoC: omap-mcbsp: Add support for highter
 rate up to 384000
Date: Wed, 7 Aug 2013 20:28:41 +0200
Message-ID: <20130807182841.GA7823@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f53.google.com (mail-ee0-f53.google.com [74.125.83.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F9FF261740
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 20:28:49 +0200 (CEST)
Received: by mail-ee0-f53.google.com with SMTP id b15so1048110eek.40
 for <alsa-devel@alsa-project.org>; Wed, 07 Aug 2013 11:28:49 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add support for highter rate up to 384000Khz. There are codecs in the
market that can play up to this frequency.
Test was done just with:

#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_192000)

playing wav file 32bit/192000Khz stereo. Some glitch has observed
but this should depend on the selected min buffer bytes that was
left untouched in aplay and in the omap-pcm driver.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 7483efb..1e95f6a 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -39,7 +39,9 @@
 #include "mcbsp.h"
 #include "omap-mcbsp.h"
 
-#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
+#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_192000 |		\
+				 SNDRV_PCM_RATE_CONTINUOUS |		\
+				 SNDRV_PCM_RATE_KNOT)
 
 #define OMAP_MCBSP_SOC_SINGLE_S16_EXT(xname, xmin, xmax, \
 	xhandler_get, xhandler_put) \
@@ -574,11 +576,15 @@ static struct snd_soc_dai_driver omap_mcbsp_dai = {
 		.channels_max = 16,
 		.rates = OMAP_MCBSP_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+		.rate_min = 8000,
+		.rate_max = 384000,
 	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 16,
 		.rates = OMAP_MCBSP_RATES,
+		.rate_min = 8000,
+		.rate_max = 384000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 	},
 	.ops = &mcbsp_dai_ops,
-- 
1.7.9.5
