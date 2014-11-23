From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 20/32] ASoC: wm8978: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:36 +0100
Message-ID: <1416746269-4935-20-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 56D042619DB
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:38:05 +0100 (CET)
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
 sound/soc/codecs/wm8978.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index ee2ba57..cf70329 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -991,21 +991,11 @@ static int wm8978_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(update_reg); i++)
 		snd_soc_update_bits(codec, update_reg[i], 0x100, 0x100);
 
-	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-/* power down chip */
-static int wm8978_remove(struct snd_soc_codec *codec)
-{
-	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
 	.probe =	wm8978_probe,
-	.remove =	wm8978_remove,
 	.suspend =	wm8978_suspend,
 	.resume =	wm8978_resume,
 	.set_bias_level = wm8978_set_bias_level,
-- 
1.8.0
