From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove check for WM8994 AIF clock rate
Date: Mon,  6 Dec 2010 18:06:44 +0000
Message-ID: <1291658804-25307-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F9B41038B9
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 19:06:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We do not need the individual AIF clocks to be over 256fs, we only have
some minimum requirements on SYSCLK. The SYSCLK rate requirements depend
on the DAC and ADC oversampling rates.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d475858..5c3dccc 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1773,10 +1773,6 @@ static int configure_aif_clock(struct snd_soc_codec *codec, int aif)
 			aif + 1, rate);
 	}
 
-	if (rate && rate < 3000000)
-		dev_warn(codec->dev, "AIF%dCLK is %dHz, should be >=3MHz for optimal performance\n",
-			 aif + 1, rate);
-
 	wm8994->aifclk[aif] = rate;
 
 	snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1 + offset,
-- 
1.7.2.3
