From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] ASoC: pxa2xx-i2s: Remove unused DAI ID
	defines
Date: Sat, 15 Oct 2016 19:32:56 +0200
Message-ID: <1476552777-1849-6-git-send-email-lars@metafoo.de>
References: <1476552777-1849-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 35A732666EA
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 19:33:10 +0200 (CEST)
In-Reply-To: <1476552777-1849-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used for matching instead and the
defines are unused. This particular ID was never used and presumably never
will be, so remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/pxa2xx-i2s.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.h b/sound/soc/pxa/pxa2xx-i2s.h
index 070f3c6..7e218e2 100644
--- a/sound/soc/pxa/pxa2xx-i2s.h
+++ b/sound/soc/pxa/pxa2xx-i2s.h
@@ -9,9 +9,6 @@
 #ifndef _PXA2XX_I2S_H
 #define _PXA2XX_I2S_H
 
-/* pxa2xx DAI ID's */
-#define PXA2XX_DAI_I2S			0
-
 /* I2S clock */
 #define PXA2XX_I2S_SYSCLK		0
 
-- 
2.1.4
