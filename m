From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 4/4] ASoC: max98373: Modified control names for TLV controls
Date: Tue,  9 Jan 2018 21:02:01 -0800
Message-ID: <1515560521-10850-4-git-send-email-ryans.lee@maximintegrated.com>
References: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changelog:
	Added suffix - 'Volume' to all TLV controls.

 sound/soc/codecs/max98373.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index c5ff30f..66e9ddb 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -611,13 +611,13 @@ SOC_ENUM("Output Voltage", max98373_out_volt_enum),
 /* Dynamic Headroom Tracking */
 SOC_SINGLE("DHT Switch", MAX98373_R20D4_DHT_EN,
 	MAX98373_DHT_EN_SHIFT, 1, 0),
-SOC_SINGLE_TLV("DHT Gain Min", MAX98373_R20D1_DHT_CFG,
+SOC_SINGLE_TLV("DHT Min Volume", MAX98373_R20D1_DHT_CFG,
 	MAX98373_DHT_SPK_GAIN_MIN_SHIFT, 9, 0, max98373_dht_spkgain_min_tlv),
-SOC_SINGLE_TLV("DHT Rot Pnt", MAX98373_R20D1_DHT_CFG,
+SOC_SINGLE_TLV("DHT Rot Pnt Volume", MAX98373_R20D1_DHT_CFG,
 	MAX98373_DHT_ROT_PNT_SHIFT, 15, 0, max98373_dht_rotation_point_tlv),
-SOC_SINGLE_TLV("DHT Attack Step", MAX98373_R20D2_DHT_ATTACK_CFG,
+SOC_SINGLE_TLV("DHT Attack Step Volume", MAX98373_R20D2_DHT_ATTACK_CFG,
 	MAX98373_DHT_ATTACK_STEP_SHIFT, 4, 0, max98373_dht_step_size_tlv),
-SOC_SINGLE_TLV("DHT Release Step", MAX98373_R20D3_DHT_RELEASE_CFG,
+SOC_SINGLE_TLV("DHT Release Step Volume", MAX98373_R20D3_DHT_RELEASE_CFG,
 	MAX98373_DHT_RELEASE_STEP_SHIFT, 4, 0, max98373_dht_step_size_tlv),
 SOC_ENUM("DHT Attack Rate", max98373_dht_attack_rate_enum),
 SOC_ENUM("DHT Release Rate", max98373_dht_release_rate_enum),
@@ -650,36 +650,36 @@ SOC_SINGLE("BDE Thresh Hysteresis", MAX98373_R209B_BDE_THRESH_HYST, 0, 0xFF, 0),
 SOC_SINGLE("BDE Hold Time", MAX98373_R2090_BDE_LVL_HOLD, 0, 0xFF, 0),
 SOC_SINGLE("BDE Attack Rate", MAX98373_R2091_BDE_GAIN_ATK_REL_RATE, 4, 0xF, 0),
 SOC_SINGLE("BDE Release Rate", MAX98373_R2091_BDE_GAIN_ATK_REL_RATE, 0, 0xF, 0),
-SOC_SINGLE_TLV("BDE LVL1 Clip Thresh", MAX98373_R20A9_BDE_L1_CFG_2,
+SOC_SINGLE_TLV("BDE LVL1 Clip Thresh Volume", MAX98373_R20A9_BDE_L1_CFG_2,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
-SOC_SINGLE_TLV("BDE LVL2 Clip Thresh", MAX98373_R20AC_BDE_L2_CFG_2,
+SOC_SINGLE_TLV("BDE LVL2 Clip Thresh Volume", MAX98373_R20AC_BDE_L2_CFG_2,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
-SOC_SINGLE_TLV("BDE LVL3 Clip Thresh", MAX98373_R20AF_BDE_L3_CFG_2,
+SOC_SINGLE_TLV("BDE LVL3 Clip Thresh Volume", MAX98373_R20AF_BDE_L3_CFG_2,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
-SOC_SINGLE_TLV("BDE LVL4 Clip Thresh", MAX98373_R20B2_BDE_L4_CFG_2,
+SOC_SINGLE_TLV("BDE LVL4 Clip Thresh Volume", MAX98373_R20B2_BDE_L4_CFG_2,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
-SOC_SINGLE_TLV("BDE LVL1 Clip Gain Reduct", MAX98373_R20AA_BDE_L1_CFG_3,
+SOC_SINGLE_TLV("BDE LVL1 Clip Reduction Volume", MAX98373_R20AA_BDE_L1_CFG_3,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
-SOC_SINGLE_TLV("BDE LVL2 Clip Gain Reduct", MAX98373_R20AD_BDE_L2_CFG_3,
+SOC_SINGLE_TLV("BDE LVL2 Clip Reduction Volume", MAX98373_R20AD_BDE_L2_CFG_3,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
-SOC_SINGLE_TLV("BDE LVL3 Clip Gain Reduct", MAX98373_R20B0_BDE_L3_CFG_3,
+SOC_SINGLE_TLV("BDE LVL3 Clip Reduction Volume", MAX98373_R20B0_BDE_L3_CFG_3,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
-SOC_SINGLE_TLV("BDE LVL4 Clip Gain Reduct", MAX98373_R20B3_BDE_L4_CFG_3,
+SOC_SINGLE_TLV("BDE LVL4 Clip Reduction Volume", MAX98373_R20B3_BDE_L4_CFG_3,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
-SOC_SINGLE_TLV("BDE LVL1 Limiter Thresh", MAX98373_R20A8_BDE_L1_CFG_1,
+SOC_SINGLE_TLV("BDE LVL1 Limiter Thresh Volume", MAX98373_R20A8_BDE_L1_CFG_1,
 	0, 0xF, 0, max98373_limiter_thresh_tlv),
-SOC_SINGLE_TLV("BDE LVL2 Limiter Thresh", MAX98373_R20AB_BDE_L2_CFG_1,
+SOC_SINGLE_TLV("BDE LVL2 Limiter Thresh Volume", MAX98373_R20AB_BDE_L2_CFG_1,
 	0, 0xF, 0, max98373_limiter_thresh_tlv),
-SOC_SINGLE_TLV("BDE LVL3 Limiter Thresh", MAX98373_R20AE_BDE_L3_CFG_1,
+SOC_SINGLE_TLV("BDE LVL3 Limiter Thresh Volume", MAX98373_R20AE_BDE_L3_CFG_1,
 	0, 0xF, 0, max98373_limiter_thresh_tlv),
-SOC_SINGLE_TLV("BDE LVL4 Limiter Thresh", MAX98373_R20B1_BDE_L4_CFG_1,
+SOC_SINGLE_TLV("BDE LVL4 Limiter Thresh Volume", MAX98373_R20B1_BDE_L4_CFG_1,
 	0, 0xF, 0, max98373_limiter_thresh_tlv),
 /* Limiter */
 SOC_SINGLE("Limiter Switch", MAX98373_R20E2_LIMITER_EN,
 	MAX98373_LIMITER_EN_SHIFT, 1, 0),
 SOC_SINGLE("Limiter Src Switch", MAX98373_R20E0_LIMITER_THRESH_CFG,
 	MAX98373_LIMITER_THRESH_SRC_SHIFT, 1, 0),
-SOC_SINGLE_TLV("Limiter Thresh", MAX98373_R20E0_LIMITER_THRESH_CFG,
+SOC_SINGLE_TLV("Limiter Thresh Volume", MAX98373_R20E0_LIMITER_THRESH_CFG,
 	MAX98373_LIMITER_THRESH_SHIFT, 15, 0, max98373_limiter_thresh_tlv),
 SOC_ENUM("Limiter Attack Rate", max98373_limiter_attack_rate_enum),
 SOC_ENUM("Limiter Release Rate", max98373_limiter_release_rate_enum),
-- 
2.7.4
