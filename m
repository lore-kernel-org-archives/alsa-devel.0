From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 4/4] ASoC: sam9g20_wm8731: disable clock and correct sequence when unload
Date: Thu, 31 Jan 2013 11:53:40 +0800
Message-ID: <1359604420-15171-5-git-send-email-voice.shen@atmel.com>
References: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

disable clock and correct sequence when unload

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index da97629..2d6fbd0 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -305,10 +305,10 @@ static int at91sam9g20ek_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-	atmel_ssc_put_audio(0);
-	snd_soc_unregister_card(card);
-	clk_put(mclk);
+	clk_disable(mclk);
 	mclk = NULL;
+	snd_soc_unregister_card(card);
+	atmel_ssc_put_audio(0);
 
 	return 0;
 }
-- 
1.7.9.5

