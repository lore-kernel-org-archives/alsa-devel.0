From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH 2/2] ASoC: rt5677: Add sidetone controls
Date: Tue, 16 Sep 2014 22:28:59 -0700
Message-ID: <1410931739-6088-2-git-send-email-anatol.pomozov@gmail.com>
References: <1410931739-6088-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f202.google.com (mail-ie0-f202.google.com
 [209.85.223.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 76ECC26520E
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 07:29:12 +0200 (CEST)
Received: by mail-ie0-f202.google.com with SMTP id rd18so178870iec.3
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 22:29:11 -0700 (PDT)
In-Reply-To: <1410931739-6088-1-git-send-email-anatol.pomozov@gmail.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/rt5677.c | 7 +++++++
 sound/soc/codecs/rt5677.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index fbaceb6..86cdf82 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -542,6 +542,7 @@ static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
+static const DECLARE_TLV_DB_SCALE(st_vol_tlv, -4650, 150, 0);
 
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
 static unsigned int bst_tlv[] = {
@@ -578,6 +579,12 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 	SOC_SINGLE_TLV("IN1 Boost", RT5677_IN1, RT5677_BST_SFT1, 8, 0, bst_tlv),
 	SOC_SINGLE_TLV("IN2 Boost", RT5677_IN1, RT5677_BST_SFT2, 8, 0, bst_tlv),
 
+	/* Sidetone Control */
+	SOC_SINGLE("Sidetone Switch", RT5677_SIDETONE_CTRL,
+		RT5677_ST_EN_SFT, 1, 0),
+	SOC_SINGLE_TLV("Sidetone Volume", RT5677_SIDETONE_CTRL,
+		RT5677_ST_VOL_SFT, 31, 0, st_vol_tlv),
+
 	/* ADC Digital Volume Control */
 	SOC_DOUBLE("ADC1 Capture Switch", RT5677_STO1_ADC_DIG_VOL,
 		RT5677_L_MUTE_SFT, RT5677_R_MUTE_SFT, 1, 1),
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 222a4137..d4eb6d5 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -382,6 +382,10 @@
 #define RT5677_ST_SEL_SFT			9
 #define RT5677_ST_EN				(0x1 << 6)
 #define RT5677_ST_EN_SFT			6
+#define RT5677_ST_GAIN				(0x1 << 5)
+#define RT5677_ST_GAIN_SFT			5
+#define RT5677_ST_VOL_MASK			(0x1f << 0)
+#define RT5677_ST_VOL_SFT			0
 
 /* Analog DAC1/2/3 Source Control (0x15) */
 #define RT5677_ANA_DAC3_SRC_SEL_MASK		(0x3 << 4)
-- 
2.1.0.rc2.206.gedb03e5
