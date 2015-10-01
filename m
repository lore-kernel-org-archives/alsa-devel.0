From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: Add the control of ClassD
	modulator Speaker Gain Ratio
Date: Thu, 1 Oct 2015 14:47:10 +0800
Message-ID: <1443682030-18258-2-git-send-email-oder_chiou@realtek.com>
References: <1443682030-18258-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C989260674
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 08:47:20 +0200 (CEST)
In-Reply-To: <1443682030-18258-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 12 ++++++++++++
 sound/soc/codecs/rt5645.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 080cc1c..7686ae6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -469,6 +469,14 @@ static const DECLARE_TLV_DB_RANGE(bst_tlv,
 	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0)
 );
 
+/* {-6, -4.5, -3, -1.5, 0, 0.82, 1.58, 2.28} dB */
+static const DECLARE_TLV_DB_RANGE(spk_clsd_tlv,
+	0, 4, TLV_DB_SCALE_ITEM(-600, 150, 0),
+	5, 5, TLV_DB_SCALE_ITEM(82, 0, 0),
+	6, 6, TLV_DB_SCALE_ITEM(158, 0, 0),
+	7, 7, TLV_DB_SCALE_ITEM(228, 0, 0)
+);
+
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
@@ -476,6 +484,10 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	SOC_DOUBLE_TLV("Speaker Playback Volume", RT5645_SPK_VOL,
 		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 39, 1, out_vol_tlv),
 
+	/* ClassD modulator Speaker Gain Ratio */
+	SOC_SINGLE_TLV("Speaker ClassD Playback Volume", RT5645_SPO_CLSD_RATIO,
+		RT5645_SPK_G_CLSD_SFT, 7, 0, spk_clsd_tlv),
+
 	/* Headphone Output Volume */
 	SOC_DOUBLE("Headphone Channel Switch", RT5645_HP_VOL,
 		RT5645_VOL_L_SFT, RT5645_VOL_R_SFT, 1, 1),
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 61bc8ab..13ac732 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -670,6 +670,10 @@
 #define RT5645_M_SV_R_SPM_R			(0x1 << 0)
 #define RT5645_M_SV_R_SPM_R_SFT			0
 
+/* SPOMIX Ratio Control (0x4a) */
+#define RT5645_SPK_G_CLSD_MASK			(0x7 << 0)
+#define RT5645_SPK_G_CLSD_SFT			0
+
 /* Mono Output Mixer Control (0x4c) */
 #define RT5645_M_OV_L_MM			(0x1 << 9)
 #define RT5645_M_OV_L_MM_SFT			9
-- 
1.8.1.1.439.g50a6b54
