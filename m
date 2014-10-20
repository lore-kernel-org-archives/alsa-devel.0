From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/12] ASoC: max98095: Cleanup manual bias
	level transitions
Date: Mon, 20 Oct 2014 10:56:34 +0200
Message-ID: <1413795399-29952-7-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 478302606E0
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:47 +0200 (CEST)
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

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98095.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 0ee6797..42103ca 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2317,9 +2317,6 @@ static int max98095_probe(struct snd_soc_codec *codec)
 
 	snd_soc_write(codec, M98095_097_PWR_SYS, M98095_PWRSV);
 
-	/* initialize registers cache to hardware default */
-	max98095_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	snd_soc_write(codec, M98095_048_MIX_DAC_LR,
 		M98095_DAI1L_TO_DACL|M98095_DAI1R_TO_DACR);
 
@@ -2359,8 +2356,6 @@ static int max98095_remove(struct snd_soc_codec *codec)
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *client = to_i2c_client(codec->dev);
 
-	max98095_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	if (max98095->headphone_jack || max98095->mic_jack)
 		max98095_jack_detect_disable(codec);
 
-- 
1.8.0
