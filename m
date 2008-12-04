From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] tlv320aic3x: control additions and cleanups
Date: Thu, 4 Dec 2008 18:51:21 +0100
Message-ID: <20081204175121.GD21010@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B2781037F9
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 18:51:25 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: u.luckas@road.de
List-Id: alsa-devel@alsa-project.org

Some minor updates for sound/soc/codecs/tlv320aic3x.c:

- removed "DAC" from name for "Mono playback switch", "HP playback
  switch" and "HPCOM playback switch". The registers used in the macro
  don't have anything to do with the DAC but mute the whole output,
  hence the names were misleading.
- split "Line Playback Switch" into "LineL Playback Switch" and "LineR
  Playback Switch"
- split "Line PGA Bypass Playback Volume" into "LineL Left PGA Bypass
  Playback Volume" and "LineR Right PGA Bypass Playback Volume"
- split "Line Line2 Bypass Playback Volume" into "LineL Line2 Bypass
  Playback Volume" and "LineR Line2 Bypass Playback Volume"
- Added "HP Right PGA Bypass Playback Volume"

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Uli Luckas <u.luckas@road.de>                                                                                                             
---
 sound/soc/codecs/tlv320aic3x.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 537bbbf..7cdaea3 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -253,16 +253,22 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 
 	SOC_DOUBLE_R("Line DAC Playback Volume", DACL1_2_LLOPM_VOL,
 		     DACR1_2_RLOPM_VOL, 0, 0x7f, 1),
-	SOC_DOUBLE_R("Line DAC Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3,
-		     0x01, 0),
-	SOC_DOUBLE_R("Line PGA Bypass Playback Volume", PGAL_2_LLOPM_VOL,
-		     PGAR_2_RLOPM_VOL, 0, 0x7f, 1),
-	SOC_DOUBLE_R("Line Line2 Bypass Playback Volume", LINE2L_2_LLOPM_VOL,
+	SOC_SINGLE("LineL Playback Switch", LLOPM_CTRL, 3, 0x01, 0),
+	SOC_SINGLE("LineR Playback Switch", RLOPM_CTRL, 3, 0x01, 0),
+	SOC_DOUBLE_R("LineL DAC Playback Volume", DACL1_2_LLOPM_VOL,
+		     DACR1_2_LLOPM_VOL, 0, 0x7f, 1),
+	SOC_SINGLE("LineL Left PGA Bypass Playback Volume", PGAL_2_LLOPM_VOL,
+		     0, 0x7f, 1),
+	SOC_SINGLE("LineR Right PGA Bypass Playback Volume", PGAR_2_RLOPM_VOL,
+		     0, 0x7f, 1),
+	SOC_DOUBLE_R("LineL Line2 Bypass Playback Volume", LINE2L_2_LLOPM_VOL,
+		     LINE2R_2_LLOPM_VOL, 0, 0x7f, 1),
+	SOC_DOUBLE_R("LineR Line2 Bypass Playback Volume", LINE2L_2_RLOPM_VOL,
 		     LINE2R_2_RLOPM_VOL, 0, 0x7f, 1),
 
 	SOC_DOUBLE_R("Mono DAC Playback Volume", DACL1_2_MONOLOPM_VOL,
 		     DACR1_2_MONOLOPM_VOL, 0, 0x7f, 1),
-	SOC_SINGLE("Mono DAC Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
+	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
 	SOC_DOUBLE_R("Mono PGA Bypass Playback Volume", PGAL_2_MONOLOPM_VOL,
 		     PGAR_2_MONOLOPM_VOL, 0, 0x7f, 1),
 	SOC_DOUBLE_R("Mono Line2 Bypass Playback Volume", LINE2L_2_MONOLOPM_VOL,
@@ -270,8 +276,10 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 
 	SOC_DOUBLE_R("HP DAC Playback Volume", DACL1_2_HPLOUT_VOL,
 		     DACR1_2_HPROUT_VOL, 0, 0x7f, 1),
-	SOC_DOUBLE_R("HP DAC Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
+	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
+	SOC_DOUBLE_R("HP Right PGA Bypass Playback Volume", PGAR_2_HPLOUT_VOL,
+		     PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
 	SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
 		     0, 0x7f, 1),
 	SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
@@ -281,7 +289,7 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 
 	SOC_DOUBLE_R("HPCOM DAC Playback Volume", DACL1_2_HPLCOM_VOL,
 		     DACR1_2_HPRCOM_VOL, 0, 0x7f, 1),
-	SOC_DOUBLE_R("HPCOM DAC Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
+	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
 	SOC_SINGLE("HPLCOM PGA Bypass Playback Volume", PGAL_2_HPLCOM_VOL,
 		     0, 0x7f, 1),
-- 
1.5.6.5
