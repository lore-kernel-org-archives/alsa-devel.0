From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ASoC: max98088: Add TLV data for volume
	controls.
Date: Fri, 15 Feb 2013 08:55:10 -0800
Message-ID: <1360947310-15217-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f201.google.com (mail-ve0-f201.google.com
 [209.85.128.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F1A9261704
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 17:56:34 +0100 (CET)
Received: by mail-ve0-f201.google.com with SMTP id 14so367567vea.2
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 08:56:33 -0800 (PST)
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
Cc: Dylan Reid <dgreid@chromium.org>, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, evan.ragsdale@maxim-ic.com
List-Id: alsa-devel@alsa-project.org

Specify volumes as defined in the MAX98088/9 data sheet.  Allows ALSA
lib snd_mixer_selem_get_playback_dB_range and related functions to
work.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/codecs/max98088.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index a4c16fd..3a7b7fd 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -739,14 +739,32 @@ static const unsigned int max98088_micboost_tlv[] = {
        2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0),
 };
 
+static const unsigned int max98088_hp_tlv[] = {
+	TLV_DB_RANGE_HEAD(5),
+	0, 6, TLV_DB_SCALE_ITEM(-6700, 400, 0),
+	7, 14, TLV_DB_SCALE_ITEM(-4000, 300, 0),
+	15, 21, TLV_DB_SCALE_ITEM(-1700, 200, 0),
+	22, 27, TLV_DB_SCALE_ITEM(-400, 100, 0),
+	28, 31, TLV_DB_SCALE_ITEM(150, 50, 0),
+};
+
+static const unsigned int max98088_spk_tlv[] = {
+	TLV_DB_RANGE_HEAD(5),
+	0, 6, TLV_DB_SCALE_ITEM(-6200, 400, 0),
+	7, 14, TLV_DB_SCALE_ITEM(-3500, 300, 0),
+	15, 21, TLV_DB_SCALE_ITEM(-1200, 200, 0),
+	22, 27, TLV_DB_SCALE_ITEM(100, 100, 0),
+	28, 31, TLV_DB_SCALE_ITEM(650, 50, 0),
+};
+
 static const struct snd_kcontrol_new max98088_snd_controls[] = {
 
-       SOC_DOUBLE_R("Headphone Volume", M98088_REG_39_LVL_HP_L,
-               M98088_REG_3A_LVL_HP_R, 0, 31, 0),
-       SOC_DOUBLE_R("Speaker Volume", M98088_REG_3D_LVL_SPK_L,
-               M98088_REG_3E_LVL_SPK_R, 0, 31, 0),
-       SOC_DOUBLE_R("Receiver Volume", M98088_REG_3B_LVL_REC_L,
-               M98088_REG_3C_LVL_REC_R, 0, 31, 0),
+	SOC_DOUBLE_R_TLV("Headphone Volume", M98088_REG_39_LVL_HP_L,
+			 M98088_REG_3A_LVL_HP_R, 0, 31, 0, max98088_hp_tlv),
+	SOC_DOUBLE_R_TLV("Speaker Volume", M98088_REG_3D_LVL_SPK_L,
+			 M98088_REG_3E_LVL_SPK_R, 0, 31, 0, max98088_spk_tlv),
+	SOC_DOUBLE_R_TLV("Receiver Volume", M98088_REG_3B_LVL_REC_L,
+			 M98088_REG_3C_LVL_REC_R, 0, 31, 0, max98088_spk_tlv),
 
        SOC_DOUBLE_R("Headphone Switch", M98088_REG_39_LVL_HP_L,
                M98088_REG_3A_LVL_HP_R, 7, 1, 1),
-- 
1.8.0
