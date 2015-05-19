From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] ASoC: rt5631: Replace direct snd_soc_codec
	dapm field access
Date: Tue, 19 May 2015 21:49:07 +0200
Message-ID: <1432064952-31997-3-git-send-email-lars@metafoo.de>
References: <1432064952-31997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9230B2605AF
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 21:49:21 +0200 (CEST)
In-Reply-To: <1432064952-31997-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and
snd_soc_codec_init_bias_level().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/rt5631.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index e285d8a..058167c 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1546,7 +1546,7 @@ static int rt5631_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
 				RT5631_PWR_VREF | RT5631_PWR_MAIN_BIAS,
 				RT5631_PWR_VREF | RT5631_PWR_MAIN_BIAS);
@@ -1614,7 +1614,7 @@ static int rt5631_probe(struct snd_soc_codec *codec)
 			RT5631_DMIC_R_CH_LATCH_RISING);
 	}
 
-	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
+	snd_soc_codec_init_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
-- 
1.8.0
