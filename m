From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: tlv320aic31xx: Remove duplicate const
Date: Thu, 19 Jun 2014 09:40:27 +0200
Message-ID: <1403163631-26215-2-git-send-email-lars@metafoo.de>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id C4661265268
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 09:40:45 +0200 (CEST)
In-Reply-To: <1403163631-26215-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

SOC_ENUM_SINGLE_DECL() already adds the const qualifier, so there is no need to
manually specify it.

Fixes the following warnings from sparse:
	sound/soc/codecs/tlv320aic31xx.c:253:1: warning: duplicate const
	sound/soc/codecs/tlv320aic31xx.c:255:1: warning: duplicate const
	sound/soc/codecs/tlv320aic31xx.c:257:1: warning: duplicate const
	sound/soc/codecs/tlv320aic31xx.c:260:1: warning: duplicate const
	sound/soc/codecs/tlv320aic31xx.c:262:1: warning: duplicate const

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic31xx.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 2341910..5128e66 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -249,17 +249,16 @@ static const char * const mic_select_text[] = {
 	"Off", "FFR 10 Ohm", "FFR 20 Ohm", "FFR 40 Ohm"
 };
 
-static const
-SOC_ENUM_SINGLE_DECL(mic1lp_p_enum, AIC31XX_MICPGAPI, 6, mic_select_text);
-static const
-SOC_ENUM_SINGLE_DECL(mic1rp_p_enum, AIC31XX_MICPGAPI, 4, mic_select_text);
-static const
-SOC_ENUM_SINGLE_DECL(mic1lm_p_enum, AIC31XX_MICPGAPI, 2, mic_select_text);
-
-static const
-SOC_ENUM_SINGLE_DECL(cm_m_enum, AIC31XX_MICPGAMI, 6, mic_select_text);
-static const
-SOC_ENUM_SINGLE_DECL(mic1lm_m_enum, AIC31XX_MICPGAMI, 4, mic_select_text);
+static SOC_ENUM_SINGLE_DECL(mic1lp_p_enum, AIC31XX_MICPGAPI, 6,
+	mic_select_text);
+static SOC_ENUM_SINGLE_DECL(mic1rp_p_enum, AIC31XX_MICPGAPI, 4,
+	mic_select_text);
+static SOC_ENUM_SINGLE_DECL(mic1lm_p_enum, AIC31XX_MICPGAPI, 2,
+	mic_select_text);
+
+static SOC_ENUM_SINGLE_DECL(cm_m_enum, AIC31XX_MICPGAMI, 6, mic_select_text);
+static SOC_ENUM_SINGLE_DECL(mic1lm_m_enum, AIC31XX_MICPGAMI, 4,
+	mic_select_text);
 
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6350, 50, 0);
 static const DECLARE_TLV_DB_SCALE(adc_fgain_tlv, 0, 10, 0);
-- 
1.8.0
