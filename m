From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: ak4104: Manage TXE using DAPM
Date: Wed,  7 Aug 2013 19:07:19 +0100
Message-ID: <1375898839-15992-2-git-send-email-broonie@kernel.org>
References: <1375898839-15992-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A0E5C261793
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 20:07:48 +0200 (CEST)
In-Reply-To: <1375898839-15992-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Saves some code. We should also be able to manage the power up and reset
registers using DAPM but it's probably more trouble than it's worth in
mains powered systems.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4104.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 9a7c89b..71059c0 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -52,11 +52,14 @@ struct ak4104_private {
 };
 
 static const struct snd_soc_dapm_widget ak4104_dapm_widgets[] = {
+SND_SOC_DAPM_PGA("TXE", AK4104_REG_TX, AK4104_TX_TXE, 0, NULL, 0),
+
 SND_SOC_DAPM_OUTPUT("TX"),
 };
 
 static const struct snd_soc_dapm_route ak4104_dapm_routes[] = {
-	{ "TX", NULL, "Playback" },
+	{ "TXE", NULL, "Playback" },
+	{ "TX", NULL, "TXE" },
 };
 
 static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
@@ -146,29 +149,11 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* enable transmitter */
-	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_TX,
-				 AK4104_TX_TXE, AK4104_TX_TXE);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-static int ak4104_hw_free(struct snd_pcm_substream *substream,
-			  struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
-
-	/* disable transmitter */
-	return regmap_update_bits(ak4104->regmap, AK4104_REG_TX,
-				  AK4104_TX_TXE, 0);
-}
-
 static const struct snd_soc_dai_ops ak4101_dai_ops = {
 	.hw_params = ak4104_hw_params,
-	.hw_free = ak4104_hw_free,
 	.set_fmt = ak4104_set_dai_fmt,
 };
 
-- 
1.8.4.rc1
