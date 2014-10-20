From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/12] ASoC: stac9766: Cleanup manual bias
	level transitions
Date: Mon, 20 Oct 2014 10:56:39 +0200
Message-ID: <1413795399-29952-12-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 1640A2606EA
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:51 +0200 (CEST)
In-Reply-To: <1413795399-29952-1-git-send-email-lars@metafoo.de>
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
Cc: Johannes Stezenbach <js@sig21.net>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Sven Brandau <brandau@gmx.de>, alsa-devel@alsa-project.org, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>
List-Id: alsa-devel@alsa-project.org

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/stac9766.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 53b810d..9878534 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -254,12 +254,6 @@ static int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
 	return 0;
 }
 
-static int stac9766_codec_suspend(struct snd_soc_codec *codec)
-{
-	stac9766_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int stac9766_codec_resume(struct snd_soc_codec *codec)
 {
 	u16 id, reset;
@@ -278,7 +272,6 @@ reset:
 		reset++;
 		goto reset;
 	}
-	stac9766_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
@@ -349,8 +342,6 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 		goto codec_err;
 	}
 
-	stac9766_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	snd_soc_add_codec_controls(codec, stac9766_snd_ac97_controls,
 			     ARRAY_SIZE(stac9766_snd_ac97_controls));
 
@@ -371,9 +362,9 @@ static struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
 	.write = stac9766_ac97_write,
 	.read = stac9766_ac97_read,
 	.set_bias_level = stac9766_set_bias_level,
+	.suspend_bias_off = true,
 	.probe = stac9766_codec_probe,
 	.remove = stac9766_codec_remove,
-	.suspend = stac9766_codec_suspend,
 	.resume = stac9766_codec_resume,
 	.reg_cache_size = ARRAY_SIZE(stac9766_reg),
 	.reg_word_size = sizeof(u16),
-- 
1.8.0
