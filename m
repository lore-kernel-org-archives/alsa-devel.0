From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: arizona: Add DAC Volume Limit controls
Date: Wed, 28 Jun 2017 13:53:17 +0100
Message-ID: <20170628125317.30561-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 91E4A266AF8
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:53:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add controls that allow the limiting of the volume coming from the DACs on
the Arizona class devices, note that wm8998 does not have this feature.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l24.c |  8 ++++++++
 sound/soc/codecs/wm5102.c  | 17 +++++++++++++++++
 sound/soc/codecs/wm5110.c  | 20 ++++++++++++++++++++
 sound/soc/codecs/wm8997.c  | 14 ++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 47e6fddef92b..a972e63bdda5 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -78,6 +78,7 @@ static int cs47l24_adsp_power_ev(struct snd_soc_dapm_widget *w,
 
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
+static DECLARE_TLV_DB_SCALE(vol_limit_tlv, -600, 50, 0);
 static DECLARE_TLV_DB_SCALE(noise_tlv, -13200, 600, 0);
 static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
@@ -203,6 +204,13 @@ SOC_SINGLE_TLV("Speaker Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_4L,
 		 ARIZONA_OUT4L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
+SOC_DOUBLE_R_RANGE_TLV("HPOUT1 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_1L,
+		       ARIZONA_DAC_VOLUME_LIMIT_1R, ARIZONA_OUT1L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("Speaker Volume Limit", ARIZONA_OUT_VOLUME_4L,
+		       ARIZONA_OUT_VOLUME_4R, ARIZONA_OUT4L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+
 SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
 SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 1fe358e6be61..7a295146524b 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -42,6 +42,7 @@ struct wm5102_priv {
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
+static DECLARE_TLV_DB_SCALE(vol_limit_tlv, -600, 50, 0);
 static DECLARE_TLV_DB_SCALE(noise_tlv, -13200, 600, 0);
 static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
@@ -915,6 +916,22 @@ SOC_DOUBLE_R_TLV("SPKDAT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_5L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_5R, ARIZONA_OUT5L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
+SOC_DOUBLE_R_RANGE_TLV("HPOUT1 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_1L,
+		       ARIZONA_DAC_VOLUME_LIMIT_1R, ARIZONA_OUT1L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("HPOUT2 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_2L,
+		       ARIZONA_DAC_VOLUME_LIMIT_2R, ARIZONA_OUT2L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("EPOUT Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_3L,
+		       ARIZONA_DAC_VOLUME_LIMIT_3R, ARIZONA_OUT3L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("Speaker Volume Limit", ARIZONA_OUT_VOLUME_4L,
+		       ARIZONA_OUT_VOLUME_4R, ARIZONA_OUT4L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("SPKDAT1 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_5L,
+		       ARIZONA_DAC_VOLUME_LIMIT_5R, ARIZONA_OUT5L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+
 SOC_ENUM("HPOUT1 OSR", wm5102_hpout_osr[0]),
 SOC_ENUM("HPOUT2 OSR", wm5102_hpout_osr[1]),
 SOC_ENUM("EPOUT OSR", wm5102_hpout_osr[2]),
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 1bc942152eff..f7cf9f7dffa6 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -575,6 +575,7 @@ static int wm5110_in_ev(struct snd_soc_dapm_widget *w,
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
+static DECLARE_TLV_DB_SCALE(vol_limit_tlv, -600, 50, 0);
 static DECLARE_TLV_DB_SCALE(noise_tlv, -13200, 600, 0);
 static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
@@ -855,6 +856,25 @@ SOC_DOUBLE_R_TLV("SPKDAT2 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_6L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_6R, ARIZONA_OUT6L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
+SOC_DOUBLE_R_RANGE_TLV("HPOUT1 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_1L,
+		       ARIZONA_DAC_VOLUME_LIMIT_1R, ARIZONA_OUT1L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("HPOUT2 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_2L,
+		       ARIZONA_DAC_VOLUME_LIMIT_2R, ARIZONA_OUT2L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("HPOUT3 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_3L,
+		       ARIZONA_DAC_VOLUME_LIMIT_3R, ARIZONA_OUT3L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("Speaker Volume Limit", ARIZONA_OUT_VOLUME_4L,
+		       ARIZONA_OUT_VOLUME_4R, ARIZONA_OUT4L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("SPKDAT1 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_5L,
+		       ARIZONA_DAC_VOLUME_LIMIT_5R, ARIZONA_OUT5L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("SPKDAT2 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_6L,
+		       ARIZONA_DAC_VOLUME_LIMIT_6R, ARIZONA_OUT6L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+
 SOC_DOUBLE("SPKDAT1 Switch", ARIZONA_PDM_SPK1_CTRL_1, ARIZONA_SPK1L_MUTE_SHIFT,
 	   ARIZONA_SPK1R_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE("SPKDAT2 Switch", ARIZONA_PDM_SPK2_CTRL_1, ARIZONA_SPK2L_MUTE_SHIFT,
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 49401a8aae64..753a1c6a1484 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -40,6 +40,7 @@ struct wm8997_priv {
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
+static DECLARE_TLV_DB_SCALE(vol_limit_tlv, -600, 50, 0);
 static DECLARE_TLV_DB_SCALE(noise_tlv, -13200, 600, 0);
 static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
@@ -287,6 +288,19 @@ SOC_DOUBLE_R_TLV("SPKDAT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_5L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_5R, ARIZONA_OUT5L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
+SOC_DOUBLE_R_RANGE_TLV("HPOUT1 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_1L,
+		       ARIZONA_DAC_VOLUME_LIMIT_1R, ARIZONA_OUT1L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("EPOUT Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_3L,
+		       ARIZONA_DAC_VOLUME_LIMIT_3R, ARIZONA_OUT3L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("Speaker Volume Limit", ARIZONA_OUT_VOLUME_4L,
+		       ARIZONA_OUT_VOLUME_4R, ARIZONA_OUT4L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+SOC_DOUBLE_R_RANGE_TLV("SPKDAT1 Volume Limit", ARIZONA_DAC_VOLUME_LIMIT_5L,
+		       ARIZONA_DAC_VOLUME_LIMIT_5R, ARIZONA_OUT5L_VOL_LIM_SHIFT,
+		       0x74, 0x8C, 0, vol_limit_tlv),
+
 SOC_ENUM("HPOUT1 OSR", wm8997_hpout_osr[0]),
 SOC_ENUM("EPOUT OSR", wm8997_hpout_osr[1]),
 
-- 
2.11.0
