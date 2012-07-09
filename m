From: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH 3/3] ASoC: tlv320aic3x: add deemphasis switch
Date: Mon,  9 Jul 2012 09:48:44 +0200
Message-ID: <1341820124-7902-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B82E24451
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2012 09:48:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
List-Id: alsa-devel@alsa-project.org

This patch adds missing deemphasis switch.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 sound/soc/codecs/tlv320aic3x.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index bd03f4d..0b17e66 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -381,6 +381,9 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	*/
 	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),
 
+	/* De-emphasis */
+	SOC_DOUBLE("De-emphasis Switch", AIC3X_CODEC_DFILT_CTRL, 2, 0, 0x01, 0),
+
 	/* Input */
 	SOC_DOUBLE_R_TLV("PGA Capture Volume", LADC_VOL, RADC_VOL,
 			 0, 119, 0, adc_tlv),
-- 
1.7.7
