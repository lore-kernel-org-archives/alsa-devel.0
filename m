From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 1/2] ASoC: max98090: Correct pclk divisor
	settings
Date: Mon,  3 Nov 2014 10:28:56 -0800
Message-ID: <1415039337-28026-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f73.google.com (mail-pa0-f73.google.com
 [209.85.220.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 18B9D2604F8
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 19:29:21 +0100 (CET)
Received: by mail-pa0-f73.google.com with SMTP id lj1so1978201pab.4
 for <alsa-devel@alsa-project.org>; Mon, 03 Nov 2014 10:29:20 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dylan Reid <dgreid@chromium.org>, broonie@kernel.org, ralph.birt@maximintegrated.com, jerry.wong@maximintegrated.com
List-Id: alsa-devel@alsa-project.org

The Baytrail-based chromebooks have a 20MHz mclk, the code was setting
the divisor incorrectly in this case.  According to the 98090
datasheet, the divisor should be set to DIV1 for 10 <= mclk <= 20.
Correct this and the surrounding clock ranges as well to match the
datasheet.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/codecs/max98090.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index d519294..1229554 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1941,13 +1941,13 @@ static int max98090_dai_set_sysclk(struct snd_soc_dai *dai,
 	 *		 0x02 (when master clk is 20MHz to 40MHz)..
 	 *		 0x03 (when master clk is 40MHz to 60MHz)..
 	 */
-	if ((freq >= 10000000) && (freq < 20000000)) {
+	if ((freq >= 10000000) && (freq <= 20000000)) {
 		snd_soc_write(codec, M98090_REG_SYSTEM_CLOCK,
 			M98090_PSCLK_DIV1);
-	} else if ((freq >= 20000000) && (freq < 40000000)) {
+	} else if ((freq > 20000000) && (freq <= 40000000)) {
 		snd_soc_write(codec, M98090_REG_SYSTEM_CLOCK,
 			M98090_PSCLK_DIV2);
-	} else if ((freq >= 40000000) && (freq < 60000000)) {
+	} else if ((freq > 40000000) && (freq <= 60000000)) {
 		snd_soc_write(codec, M98090_REG_SYSTEM_CLOCK,
 			M98090_PSCLK_DIV4);
 	} else {
-- 
2.1.2.330.g565301e
