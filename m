From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/32] ASoC: wm8580: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:21 +0100
Message-ID: <1416746269-4935-5-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 130E82615FC
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:37:54 +0100 (CET)
In-Reply-To: <1416746269-4935-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8580.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 911605e..0a887c5 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -882,8 +882,6 @@ static int wm8580_probe(struct snd_soc_codec *codec)
 		goto err_regulator_enable;
 	}
 
-	wm8580_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 
 err_regulator_enable:
@@ -897,8 +895,6 @@ static int wm8580_remove(struct snd_soc_codec *codec)
 {
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 
-	wm8580_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	regulator_bulk_disable(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
 
 	return 0;
-- 
1.8.0
