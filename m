From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: ad193X: Provide dB ranges for the
	volume controls
Date: Mon, 28 Nov 2011 17:28:07 +0100
Message-ID: <1322497692-27868-2-git-send-email-lars@metafoo.de>
References: <1322497692-27868-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 30A4A1038C8
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 17:27:19 +0100 (CET)
In-Reply-To: <1322497692-27868-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Lars-Peter@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad193x.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 1dfda5c..7da7e29 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -35,16 +35,18 @@ static const char *ad193x_deemp[] = {"None", "48kHz", "44.1kHz", "32kHz"};
 static const struct soc_enum ad193x_deemp_enum =
 	SOC_ENUM_SINGLE(AD193X_DAC_CTRL2, 1, 4, ad193x_deemp);
 
+static const DECLARE_TLV_DB_MINMAX(adau193x_tlv, -9563, 0);
+
 static const struct snd_kcontrol_new ad193x_snd_controls[] = {
 	/* DAC volume control */
-	SOC_DOUBLE_R("DAC1 Volume", AD193X_DAC_L1_VOL,
-			AD193X_DAC_R1_VOL, 0, 0xFF, 1),
-	SOC_DOUBLE_R("DAC2 Volume", AD193X_DAC_L2_VOL,
-			AD193X_DAC_R2_VOL, 0, 0xFF, 1),
-	SOC_DOUBLE_R("DAC3 Volume", AD193X_DAC_L3_VOL,
-			AD193X_DAC_R3_VOL, 0, 0xFF, 1),
-	SOC_DOUBLE_R("DAC4 Volume", AD193X_DAC_L4_VOL,
-			AD193X_DAC_R4_VOL, 0, 0xFF, 1),
+	SOC_DOUBLE_R_TLV("DAC1 Volume", AD193X_DAC_L1_VOL,
+			AD193X_DAC_R1_VOL, 0, 0xFF, 1, adau193x_tlv),
+	SOC_DOUBLE_R_TLV("DAC2 Volume", AD193X_DAC_L2_VOL,
+			AD193X_DAC_R2_VOL, 0, 0xFF, 1, adau193x_tlv),
+	SOC_DOUBLE_R_TLV("DAC3 Volume", AD193X_DAC_L3_VOL,
+			AD193X_DAC_R3_VOL, 0, 0xFF, 1, adau193x_tlv),
+	SOC_DOUBLE_R_TLV("DAC4 Volume", AD193X_DAC_L4_VOL,
+			AD193X_DAC_R4_VOL, 0, 0xFF, 1, adau193x_tlv),
 
 	/* ADC switch control */
 	SOC_DOUBLE("ADC1 Switch", AD193X_ADC_CTRL0, AD193X_ADCL1_MUTE,
-- 
1.7.7.3
