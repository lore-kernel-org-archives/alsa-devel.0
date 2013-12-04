From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in DSP A mode
Date: Wed,  4 Dec 2013 10:37:04 +0800
Message-ID: <1386124624-22414-3-git-send-email-voice.shen@atmel.com>
References: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@kernel.org
Cc: nicolas.ferre@atmel.com, richard.genoud@gmail.com, zql@glomationinc.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Change sam9x5 with wm8731 work in DSP A mode, this will fix the
left/right channel swap issue.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/sam9x5_wm8731.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 992ae38..06c1811 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -107,7 +107,7 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	dai->stream_name = "WM8731 PCM";
 	dai->codec_dai_name = "wm8731-hifi";
 	dai->init = sam9x5_wm8731_init;
-	dai->dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+	dai->dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF
 		| SND_SOC_DAIFMT_CBM_CFM;
 
 	ret = snd_soc_of_parse_card_name(card, "atmel,model");
-- 
1.7.9.5

