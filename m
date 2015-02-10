From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [RESEND PATCH 6/6] ASoC: arizona: Add support for WM8280/WM8281
Date: Tue, 10 Feb 2015 11:18:30 +0000
Message-ID: <1423567110-4414-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1423567110-4414-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423567110-4414-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org, linux.walleij@linaro.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, broonie@kernel.org, rf@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 9550d74..55b5e22 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -281,6 +281,7 @@ int arizona_init_gpio(struct snd_soc_codec *codec)
 
 	switch (arizona->type) {
 	case WM5110:
+	case WM8280:
 		snd_soc_dapm_disable_pin(&codec->dapm, "DRC2 Signal Activity");
 		break;
 	default:
@@ -1669,6 +1670,7 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 
 	switch (fll->arizona->type) {
 	case WM5110:
+	case WM8280:
 		if (fll->arizona->rev < 3 || sync)
 			return init_ratio;
 		break;
-- 
1.7.2.5
