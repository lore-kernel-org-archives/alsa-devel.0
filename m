From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5670: fix wrong name of sto2 adc 2
	mux
Date: Wed, 26 Jul 2017 15:28:25 +0800
Message-ID: <1501054106-25264-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id C711B26648D
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 09:28:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The kcontrol name of Stereo2 ADC 2 Mux is not matched with what we used
in dapm widget.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0376667..2866f9b 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1175,7 +1175,7 @@ static const struct snd_kcontrol_new rt5670_sto_adc_2_mux =
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc2_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_l_mux =
+static const struct snd_kcontrol_new rt5670_sto2_adc_2_mux =
 	SOC_DAPM_ENUM("Stereo2 ADC 2 Mux", rt5670_stereo2_adc2_enum);
 
 
-- 
2.7.4
