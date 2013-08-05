From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: ASoC: omap-mcbsp 192000 freq
Date: Mon, 5 Aug 2013 12:40:58 +0200
Message-ID: <20130805104058.GB8787@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f171.google.com (mail-ea0-f171.google.com
 [209.85.215.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 18E322625D8
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 12:41:03 +0200 (CEST)
Received: by mail-ea0-f171.google.com with SMTP id n15so1517363ead.16
 for <alsa-devel@alsa-project.org>; Mon, 05 Aug 2013 03:41:02 -0700 (PDT)
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
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I'm working on having pcm1792a and omap platform. Right
now I have already sent and rfc for the codec and I have
a local build that change this file too to support
192000. What I don't understand is the meaning of:

.period_bytes_min       = 32,

What is the relation between fifo_size and period_bytes_min?
because at this frequency 32 bytes are not so much and the fifo
of the port are >= 512 bytes. Is it possible to increase
the period_bytes_min without violating the hw constraints?

Michael

.period_bytes_max       = 64 * 1024,
.periods_min            = 2,
.periods_max            = 255,
.buffer_bytes_max       = 128 * 1024,


>From f1e6fcfd81e6642ba5695c848ac6aa729e7467aa Mon Sep 17 00:00:00 2001
From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Mon, 5 Aug 2013 12:26:35 +0200
Subject: [PATCH] OMAP MCBSP can support 192000 frame rate.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 7483efb..d285ddd 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -39,7 +39,7 @@
 #include "mcbsp.h"
 #include "omap-mcbsp.h"
 
-#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
+#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_192000)
 
 #define OMAP_MCBSP_SOC_SINGLE_S16_EXT(xname, xmin, xmax, \
 	xhandler_get, xhandler_put) \
-- 
1.7.9.5
