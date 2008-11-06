From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/1] [ALSA] ASoC: TLV320AIC23B Support more
	sample rates
Date: Thu,  6 Nov 2008 16:11:08 -0700
Message-ID: <1226013068-22508-1-git-send-email-troy.kisky@boundarydevices.com>
References: <20081105220550.GA29007@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-01.inet.qwest.net (mpls-qmqp-01.inet.qwest.net
	[63.231.195.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 4302A24444
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 00:11:33 +0100 (CET)
In-Reply-To: <20081105220550.GA29007@sirena.org.uk>
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
Cc: arunks@mistralsolutions.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Add support for more sample rates, different crystals
and split playback/capture rates.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Mark, this is an incremental patch to the #ifdef DEBUG version

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 0096842..8a9ef21 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -301,30 +301,25 @@ static const unsigned char sr_dac_mult_table[] = {
 	A(2), A(11), A(2), A(11),  A(0), A(0), A(0), A(1)
 };
 
-unsigned get_score(int adc, int adc_l, int adc_h, int need_adc,
+static unsigned get_score(int adc, int adc_l, int adc_h, int need_adc,
 		int dac, int dac_l, int dac_h, int need_dac)
 {
 	if ((adc >= adc_l) && (adc <= adc_h) &&
 			(dac >= dac_l) && (dac <= dac_h)) {
-		unsigned diff_adc = need_adc - adc;
-		unsigned diff_dac = need_dac - dac;
-		unsigned score;
-		if (((int)diff_adc) < 0)
-			diff_adc = -diff_adc;
-		if (((int)diff_dac) < 0)
-			diff_dac = -diff_dac;
-		score = diff_adc + diff_dac;
-		return score;
+		int diff_adc = need_adc - adc;
+		int diff_dac = need_dac - dac;
+		return abs(diff_adc) + abs(diff_dac);
 	}
-	return 0xffffffff;
+	return UINT_MAX;
 }
-int find_rate(int mclk, u32 need_adc, u32 need_dac)
+
+static int find_rate(int mclk, u32 need_adc, u32 need_dac)
 {
 	int i, j;
 	int best_i = -1;
 	int best_j = -1;
 	int best_div = 0;
-	unsigned best_score = 0xffffffff;
+	unsigned best_score = UINT_MAX;
 	int adc_l, adc_h, dac_l, dac_h;
 
 	need_adc *= SR_MULT;
@@ -359,7 +354,7 @@ int find_rate(int mclk, u32 need_adc, u32 need_dac)
 			score = get_score((adc >> 1), adc_l, adc_h, need_adc,
 					(dac >> 1), dac_l, dac_h, need_dac);
 			/* prefer to have a /2 */
-			if ((score != 0xffffffff) && (best_score >= score)) {
+			if ((score != UINT_MAX) && (best_score >= score)) {
 				best_score = score;
 				best_i = i;
 				best_j = j;
-- 
1.5.4.3
