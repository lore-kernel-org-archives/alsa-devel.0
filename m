From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: arizona: Be more forgiving in BCLK
	selection
Date: Wed,  4 Jul 2012 19:13:45 +0100
Message-ID: <1341425625-17621-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1341425625-17621-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B4F4104404
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 20:13:47 +0200 (CEST)
In-Reply-To: <1341425625-17621-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Allow any BCLK which can be divided down to generate LRCLK, not just the
lowest possible BCLK to clock out the samples.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 8e5246c..8e066eb 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -518,7 +518,8 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 		rates = &arizona_48k_bclk_rates[0];
 
 	for (i = 0; i < ARRAY_SIZE(arizona_44k1_bclk_rates); i++) {
-		if (rates[i] == snd_soc_params_to_bclk(params)) {
+		if (rates[i] >= snd_soc_params_to_bclk(params) &&
+		    rates[i] % params_rate(params) == 0) {
 			bclk = i;
 			break;
 		}
-- 
1.7.10
