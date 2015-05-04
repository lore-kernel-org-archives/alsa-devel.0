From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] ASoC: adav80x: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  4 May 2015 18:46:11 +0200
Message-ID: <1430757974-7432-4-git-send-email-lars@metafoo.de>
References: <1430757974-7432-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 57F0726067B
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 18:46:22 +0200 (CEST)
In-Reply-To: <1430757974-7432-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adav80x.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 260a652..36d8425 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -539,7 +539,7 @@ static int adav80x_set_sysclk(struct snd_soc_codec *codec,
 			      unsigned int freq, int dir)
 {
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	if (dir == SND_SOC_CLOCK_IN) {
 		switch (clk_id) {
@@ -622,6 +622,7 @@ static int adav80x_set_sysclk(struct snd_soc_codec *codec,
 static int adav80x_set_pll(struct snd_soc_codec *codec, int pll_id,
 		int source, unsigned int freq_in, unsigned int freq_out)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	unsigned int pll_ctrl1 = 0;
 	unsigned int pll_ctrl2 = 0;
@@ -687,7 +688,7 @@ static int adav80x_set_pll(struct snd_soc_codec *codec, int pll_id,
 
 		adav80x->pll_src = source;
 
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_sync(dapm);
 	}
 
 	return 0;
@@ -800,11 +801,12 @@ static struct snd_soc_dai_driver adav80x_dais[] = {
 
 static int adav80x_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 
 	/* Force PLLs on for SYSCLK output */
-	snd_soc_dapm_force_enable_pin(&codec->dapm, "PLL1");
-	snd_soc_dapm_force_enable_pin(&codec->dapm, "PLL2");
+	snd_soc_dapm_force_enable_pin(dapm, "PLL1");
+	snd_soc_dapm_force_enable_pin(dapm, "PLL2");
 
 	/* Power down S/PDIF receiver, since it is currently not supported */
 	regmap_write(adav80x->regmap, ADAV80X_PLL_OUTE, 0x20);
-- 
1.8.0
