From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: cs42xx8: Do not use rtd->codec
Date: Mon, 19 May 2014 08:03:03 +0200
Message-ID: <1400479384-19108-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-039.synserver.de
 [212.40.185.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 61EB22650FF
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 08:04:29 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Nicolin Chen <Guangyu.Chen@freescale.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

rtd->codec does not necessarily point to the CODEC instance for which the
callback was called (e.g. for CODEC<->CODEC or multi-CODEC links). Use
dai->codec instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/cs42xx8.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 8502032..a25bc60 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -248,8 +248,7 @@ static int cs42xx8_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct cs42xx8_priv *cs42xx8 = snd_soc_codec_get_drvdata(codec);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u32 ratio = cs42xx8->sysclk / params_rate(params);
-- 
1.8.0
