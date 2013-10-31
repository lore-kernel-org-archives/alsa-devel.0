From: Hector Palacios <hector.palacios@digi.com>
Subject: [RFC PATCH] ASoC: sgtl5000: interconnect ADC with Mic
	Bias
Date: Thu, 31 Oct 2013 18:39:33 +0100
Message-ID: <1383241173-2052-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.2]) by alsa0.perex.cz (Postfix) with ESMTP id E8BDB265698
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 18:40:12 +0100 (CET)
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
Cc: fabio.estevam@freescale.com, Hector Palacios <hector.palacios@digi.com>, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

The interconnection of the Mic Bias to the ADC allows to
control the Mic Bias Output Impedance.
Without it, recording from a PC microphone results in silence.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 sound/soc/codecs/sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index ea47938..60d5012 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -231,6 +231,7 @@ static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
 	{"Capture Mux", "MIC_IN", "MIC_IN"},	/* mic_in --> adc_mux */
 
 	{"ADC", NULL, "VAG_POWER"},
+	{"ADC", NULL, "Mic Bias"},
 	{"ADC", NULL, "Capture Mux"},		/* adc_mux --> adc */
 	{"AIFOUT", NULL, "ADC"},		/* adc --> i2s_out */
 
