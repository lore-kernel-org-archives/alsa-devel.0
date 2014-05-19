From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: rt5651: Do not use rtd->codec
Date: Mon, 19 May 2014 08:03:04 +0200
Message-ID: <1400479384-19108-2-git-send-email-lars@metafoo.de>
References: <1400479384-19108-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-039.synserver.de
 [212.40.185.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DC4026510F
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 08:04:31 +0200 (CEST)
In-Reply-To: <1400479384-19108-1-git-send-email-lars@metafoo.de>
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
 sound/soc/codecs/rt5651.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index f785b81..9c88d89 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1368,8 +1368,7 @@ static int get_clk_info(int sclk, int rate)
 static int rt5651_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val_len = 0, val_clk, mask_clk;
 	int pre_div, bclk_ms, frame_size;
-- 
1.8.0
