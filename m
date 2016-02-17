From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: max98926: Fix blr_clk_ratio
	calculation
Date: Wed, 17 Feb 2016 08:46:07 +0800
Message-ID: <1455669967.6195.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ECB9265794
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 01:46:12 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id fy10so876138pac.1
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 16:46:12 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Current code calculates blr_clk_ratio before setting max98926->ch_size, fix
it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Anish,
I don't have this h/w, please review and test this patch.

thanks,
Axel

 sound/soc/codecs/max98926.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 66884ebd..5245e10 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -383,8 +383,7 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
 	int rate = params_rate(params), i;
 	struct snd_soc_codec *codec = dai->codec;
 	struct max98926_priv *max98926 = snd_soc_codec_get_drvdata(codec);
-	/* BCLK/LRCLK ratio calculation */
-	int blr_clk_ratio = params_channels(params) * max98926->ch_size;
+	int blr_clk_ratio;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -414,6 +413,9 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* BCLK/LRCLK ratio calculation */
+	blr_clk_ratio = params_channels(params) * max98926->ch_size;
+
 	switch (blr_clk_ratio) {
 	case 32:
 		regmap_update_bits(max98926->regmap,
-- 
2.1.4
