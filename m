From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] soc: codecs: tlv320aic32x4: fix initialization
	of micpga routing
Date: Thu,  6 Oct 2011 20:53:36 +0200
Message-ID: <1317927216-23476-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 502FB103A7E
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 21:30:42 +0200 (CEST)
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <w.sang@pengutronix.de>) id 1RBteT-00009C-TP
	for alsa-devel@alsa-project.org; Thu, 06 Oct 2011 21:30:41 +0200
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
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

Checking the pdata-flags used 'or', so the check is always true. Use 'and' to
correctly mask the flags.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic32x4.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e93b9d1..a68982e 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -685,10 +685,10 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Mic PGA routing */
-	if (aic32x4->micpga_routing | AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K) {
+	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K) {
 		snd_soc_write(codec, AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_IN2R_10K);
 	}
-	if (aic32x4->micpga_routing | AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K) {
+	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K) {
 		snd_soc_write(codec, AIC32X4_RMICPGANIN, AIC32X4_RMICPGANIN_IN1L_10K);
 	}
 
-- 
1.7.2.5
