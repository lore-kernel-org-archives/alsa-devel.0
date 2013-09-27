From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: adau1373: Remove ADAU1373_PLL_CTRL7
	register definition
Date: Fri, 27 Sep 2013 13:47:09 +0200
Message-ID: <1380282430-28159-2-git-send-email-lars@metafoo.de>
References: <1380282430-28159-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-078.synserver.de (smtp-out-078.synserver.de
 [212.40.185.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CF4126507E
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 13:45:57 +0200 (CEST)
In-Reply-To: <1380282430-28159-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

There is no such register.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1373.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index c57c1f8..2f84054 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -74,7 +74,6 @@ struct adau1373 {
 #define ADAU1373_PLL_CTRL4(x)	(0x2c + (x) * 7)
 #define ADAU1373_PLL_CTRL5(x)	(0x2d + (x) * 7)
 #define ADAU1373_PLL_CTRL6(x)	(0x2e + (x) * 7)
-#define ADAU1373_PLL_CTRL7(x)	(0x2f + (x) * 7)
 #define ADAU1373_HEADDECT	0x36
 #define ADAU1373_ADC_DAC_STATUS	0x37
 #define ADAU1373_ADC_CTRL	0x3c
-- 
1.8.0
