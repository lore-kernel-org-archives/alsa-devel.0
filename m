From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: es8328: Cleanup manual bias level
	transitions
Date: Sat,  6 Sep 2014 14:29:32 +0200
Message-ID: <1410006575-499-2-git-send-email-lars@metafoo.de>
References: <1410006575-499-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A674264F10
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 14:29:42 +0200 (CEST)
In-Reply-To: <1410006575-499-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/es8328.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 3ff7870..f273251 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -602,8 +602,6 @@ static int es8328_suspend(struct snd_soc_codec *codec)
 
 	es8328 = snd_soc_codec_get_drvdata(codec);
 
-	es8328_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	clk_disable_unprepare(es8328->clk);
 
 	ret = regulator_bulk_disable(ARRAY_SIZE(es8328->supplies),
@@ -643,7 +641,6 @@ static int es8328_resume(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	es8328_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
 
@@ -712,6 +709,8 @@ static struct snd_soc_codec_driver es8328_codec_driver = {
 	.resume		  = es8328_resume,
 	.remove		  = es8328_remove,
 	.set_bias_level	  = es8328_set_bias_level,
+	.suspend_bias_off = true,
+
 	.controls	  = es8328_snd_controls,
 	.num_controls	  = ARRAY_SIZE(es8328_snd_controls),
 	.dapm_widgets	  = es8328_dapm_widgets,
-- 
1.8.0
