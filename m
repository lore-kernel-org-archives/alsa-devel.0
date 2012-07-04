From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: arizona: Rename current rates tables
	to bclk_rates
Date: Wed,  4 Jul 2012 19:13:43 +0100
Message-ID: <1341425625-17621-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 35D97244F9
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 20:13:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

They're the rates for the BCLK, not for the sample rate, so rename so that
we don't confuse ourselves.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 3b5730b..67760b4 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -363,7 +363,7 @@ static int arizona_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static const int arizona_48k_rates[] = {
+static const int arizona_48k_bclk_rates[] = {
 	-1,
 	48000,
 	64000,
@@ -385,7 +385,7 @@ static const int arizona_48k_rates[] = {
 	24576000,
 };
 
-static const int arizona_44k1_rates[] = {
+static const int arizona_44k1_bclk_rates[] = {
 	-1,
 	44100,
 	58800,
@@ -445,17 +445,17 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	int bclk, lrclk, wl, frame, sr_val;
 
 	if (params_rate(params) % 8000)
-		rates = &arizona_44k1_rates[0];
+		rates = &arizona_44k1_bclk_rates[0];
 	else
-		rates = &arizona_48k_rates[0];
+		rates = &arizona_48k_bclk_rates[0];
 
-	for (i = 0; i < ARRAY_SIZE(arizona_44k1_rates); i++) {
+	for (i = 0; i < ARRAY_SIZE(arizona_44k1_bclk_rates); i++) {
 		if (rates[i] == snd_soc_params_to_bclk(params)) {
 			bclk = i;
 			break;
 		}
 	}
-	if (i == ARRAY_SIZE(arizona_44k1_rates)) {
+	if (i == ARRAY_SIZE(arizona_44k1_bclk_rates)) {
 		arizona_aif_err(dai, "Unsupported sample rate %dHz\n",
 				params_rate(params));
 		return -EINVAL;
-- 
1.7.10
