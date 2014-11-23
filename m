From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/32] ASoC: wm8804: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:28 +0100
Message-ID: <1416746269-4935-12-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id EADD52616B9
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:37:58 +0100 (CET)
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
 sound/soc/codecs/wm8804.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 3addc5f..1315f76 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -524,7 +524,6 @@ static int wm8804_remove(struct snd_soc_codec *codec)
 	int i;
 
 	wm8804 = snd_soc_codec_get_drvdata(codec);
-	wm8804_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); ++i)
 		regulator_unregister_notifier(wm8804->supplies[i].consumer,
@@ -606,8 +605,6 @@ static int wm8804_probe(struct snd_soc_codec *codec)
 		goto err_reg_enable;
 	}
 
-	wm8804_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 
 err_reg_enable:
-- 
1.8.0
