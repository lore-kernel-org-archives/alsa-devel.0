From: =?UTF-8?B?UHJjaGFsIEppxZnDrQ==?= <jiri.prchal@aksignal.cz>
Subject: [PATCH] ASoC: tlv320aic3x: add deemphasis switch
Date: Fri, 29 Jun 2012 10:53:32 +0200
Message-ID: <4FED6D0C.50004@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 37DFE11CF56
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 10:53:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vbarinov@embeddedalley.com, mr.swami.reddy@ti.com, peter.ujfalusi@ti.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, sudhakar.raj@ti.com, nsekhar@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

This patch adds missing deemphasis switch.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
  sound/soc/codecs/tlv320aic3x.c |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 4ed6c20..2265e94 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -381,6 +381,9 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
  	SOC_ENUM("Left AGC Decay time", aic3x_agc_enum[LAGC_DEC_ENUM]),
  	SOC_ENUM("Right AGC Decay time", aic3x_agc_enum[RAGC_DEC_ENUM]),

+	/* De-emphasis */
+	SOC_DOUBLE("De-emphasis Switch", AIC3X_CODEC_DFILT_CTRL, 2, 0, 0x01, 0),
+
  	/* Input */
  	SOC_DOUBLE_R_TLV("PGA Capture Volume", LADC_VOL, RADC_VOL,
  			 0, 119, 0, adc_tlv),
-- 
1.7.7
