From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Ensure we clock two channels
	for I2S mode
Date: Wed, 13 Mar 2013 19:06:13 +0000
Message-ID: <1363201573-3057-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F0E726257E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 20:06:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I2S requires stereo clocking even for mono data.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0c70d503..2b0803e 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -818,7 +818,7 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	struct arizona *arizona = priv->arizona;
 	int base = dai->driver->base;
 	const int *rates;
-	int i, ret;
+	int i, ret, val;
 	int chan_limit = arizona->pdata.max_channels_clocked[dai->id - 1];
 	int bclk, lrclk, wl, frame, bclk_target;
 
@@ -834,6 +834,13 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 		bclk_target *= chan_limit;
 	}
 
+	/* Force stereo for I2S mode */
+	val = snd_soc_read(codec, base + ARIZONA_AIF_FORMAT);
+	if (params_channels(params) == 1 && (val & ARIZONA_AIF1_FMT_MASK)) {
+		arizona_aif_dbg(dai, "Forcing stereo mode\n");
+		bclk_target *= 2;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(arizona_44k1_bclk_rates); i++) {
 		if (rates[i] >= bclk_target &&
 		    rates[i] % params_rate(params) == 0) {
-- 
1.7.10.4
