From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 31/32] ASoC: wm9712: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:47 +0100
Message-ID: <1416746269-4935-31-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 9623E261A5F
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:38:13 +0100 (CET)
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

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend. This makes the code a bit shorter and cleaner.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9712.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 52a211b..7c45971 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -636,12 +636,6 @@ err:
 	return -EIO;
 }
 
-static int wm9712_soc_suspend(struct snd_soc_codec *codec)
-{
-	wm9712_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int wm9712_soc_resume(struct snd_soc_codec *codec)
 {
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
@@ -686,8 +680,6 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	/* set alc mux to none */
 	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
 
-	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 
 reset_err:
@@ -706,11 +698,11 @@ static int wm9712_soc_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.probe = 	wm9712_soc_probe,
 	.remove = 	wm9712_soc_remove,
-	.suspend =	wm9712_soc_suspend,
 	.resume =	wm9712_soc_resume,
 	.read = ac97_read,
 	.write = ac97_write,
 	.set_bias_level = wm9712_set_bias_level,
+	.suspend_bias_off = true,
 	.reg_cache_size = ARRAY_SIZE(wm9712_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
-- 
1.8.0
