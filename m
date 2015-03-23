From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH resend] ASoC: fsl-ssi: Fix bitclock calculation
	for master mode
Date: Mon, 23 Mar 2015 15:46:12 +0100
Message-ID: <1427121972-5059-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 66F3A26066D
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 15:46:14 +0100 (CET)
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, broonie@kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Sascha Hauer <s.hauer@pengutronix.de>

in fsl_ssi_set_bclk we are looking for the best divider by iterating
over all possible dividers. The divider is in the range 1..256, so
make this clear by using 'div' as name for the loop counter and iterate
from 1 to 256 instead of 0 to 255. This makes obvious that tmprate is
calculated wrong, it has to be freq * factor * div, not
freq * factor * (i + 2).

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b9fabbf69db6..b8af08e49085 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -578,7 +578,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct regmap *regs = ssi_private->regs;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
-	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
+	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, div;
 	unsigned long clkrate, baudrate, tmprate;
 	u64 sub, savesub = 100000;
 	unsigned int freq;
@@ -602,8 +602,8 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 
 	factor = (div2 + 1) * (7 * psr + 1) * 2;
 
-	for (i = 0; i < 255; i++) {
-		tmprate = freq * factor * (i + 2);
+	for (div = 1; div < 256; div++) {
+		tmprate = freq * factor * div;
 
 		if (baudclk_is_used)
 			clkrate = clk_get_rate(ssi_private->baudclk);
@@ -618,7 +618,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 			continue;
 
 		clkrate /= factor;
-		afreq = clkrate / (i + 1);
+		afreq = clkrate / div;
 
 		if (freq == afreq)
 			sub = 0;
@@ -636,7 +636,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		if (sub < savesub) {
 			baudrate = tmprate;
 			savesub = sub;
-			pm = i;
+			pm = div - 1;
 		}
 
 		/* We are lucky */
-- 
2.1.4
