From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/2] ALSA: ASoC: cs4270: allow passing freq=0
	in set_dai_sysclk()
Date: Fri, 15 Jan 2010 17:36:48 +0100
Message-ID: <1263573409-30863-1-git-send-email-daniel@caiaq.de>
References: <20100113162749.GA26519@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C1A901037F7
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 17:37:06 +0100 (CET)
In-Reply-To: <20100113162749.GA26519@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

For setups with variable MCLKs, the current logic of limiting the
available sampling rates at startup time is not sufficient. We need to
be able to change the setting at a later point, and so the codec must
offer all possible rates until the hw_params are given.

This patches allows that by passing 0 as 'freq' argument to
cs4270_set_dai_sysclk().

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |   40 ++++++++++++++++++++++++++--------------
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index ffe122d..37ed60d 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -192,6 +192,11 @@ static struct cs4270_mode_ratios cs4270_mode_ratios[] = {
  * This function must be called by the machine driver's 'startup' function,
  * otherwise the list of supported sample rates will not be available in
  * time for ALSA.
+ *
+ * For setups with variable MCLKs, pass 0 as 'freq' argument. This will cause
+ * theoretically possible sample rates to be enabled. Call it again with a
+ * proper value set one the external clock is set (most probably you would do
+ * that from a machine's driver 'hw_param' hook.
  */
 static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
@@ -205,20 +210,27 @@ static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 	cs4270->mclk = freq;
 
-	for (i = 0; i < NUM_MCLK_RATIOS; i++) {
-		unsigned int rate = freq / cs4270_mode_ratios[i].ratio;
-		rates |= snd_pcm_rate_to_rate_bit(rate);
-		if (rate < rate_min)
-			rate_min = rate;
-		if (rate > rate_max)
-			rate_max = rate;
-	}
-	/* FIXME: soc should support a rate list */
-	rates &= ~SNDRV_PCM_RATE_KNOT;
+	if (cs4270->mclk) {
+		for (i = 0; i < NUM_MCLK_RATIOS; i++) {
+			unsigned int rate = freq / cs4270_mode_ratios[i].ratio;
+			rates |= snd_pcm_rate_to_rate_bit(rate);
+			if (rate < rate_min)
+				rate_min = rate;
+			if (rate > rate_max)
+				rate_max = rate;
+		}
+		/* FIXME: soc should support a rate list */
+		rates &= ~SNDRV_PCM_RATE_KNOT;
 
-	if (!rates) {
-		dev_err(codec->dev, "could not find a valid sample rate\n");
-		return -EINVAL;
+		if (!rates) {
+			dev_err(codec->dev, "could not find a valid sample rate\n");
+			return -EINVAL;
+		}
+	} else {
+		/* enable all possible rates */
+		rates = SNDRV_PCM_RATE_8000_192000;
+		rate_min = 8000;
+		rate_max = 192000;
 	}
 
 	codec_dai->playback.rates = rates;
-- 
1.6.5.2
