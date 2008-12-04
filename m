From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] tlv320aic3x.c: split and add some mixer
	controls
Date: Thu, 4 Dec 2008 20:40:48 +0100
Message-ID: <20081204194048.GF21010@buzzloop.caiaq.de>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 71A87103801
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 20:40:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081204175121.GD21010@buzzloop.caiaq.de>
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

- split "Line Playback Switch" into "LineL Playback Switch" and "LineR
  Playback Switch"
- split "Line PGA Bypass Playback Volume" into "LineL Left PGA Bypass
  Playback Volume" and "LineR Right PGA Bypass Playback Volume"
- split "Line Line2 Bypass Playback Volume" into "LineL Line2 Bypass
  Playback Volume" and "LineR Line2 Bypass Playback Volume"
- Added "HP Right PGA Bypass Playback Volume"

This patch was colaboratively created with Uli Luckas.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---

I split the patches now - this one omits the removal of misleading
"DAC"s in some widget names.

 sound/soc/codecs/tlv320aic3x.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 537bbbf..6a12dc3 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -253,11 +253,17 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 
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
@@ -272,6 +278,8 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 		     DACR1_2_HPROUT_VOL, 0, 0x7f, 1),
 	SOC_DOUBLE_R("HP DAC Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
+	SOC_DOUBLE_R("HP Right PGA Bypass Playback Volume", PGAR_2_HPLOUT_VOL,
+		     PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
 	SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
 		     0, 0x7f, 1),
 	SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
-- 
1.5.6.5
