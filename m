From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] [RESEND] tlv320aic3x: control additions and
	cleanups
Date: Fri, 5 Dec 2008 17:31:00 +0100
Message-ID: <20081205163100.GA3940@buzzloop.caiaq.de>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
	<20081204183746.GB6628@sirena.org.uk>
	<bd7b27490812050445l6e94ccfbx9339d87b51d518c6@mail.gmail.com>
	<20081205130001.GB10489@sirena.org.uk>
	<bd7b27490812050521j735b088i874f3f7f3b476f66@mail.gmail.com>
	<20081205134257.GD10489@sirena.org.uk>
	<20081205151103.GC1821@buzzloop.caiaq.de>
	<bd7b27490812050737k3a3efe92mefdbbd6083ba73e7@mail.gmail.com>
	<20081205162430.GE10489@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 800922412E
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 17:31:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081205162430.GE10489@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, u.luckas@road.de
List-Id: alsa-devel@alsa-project.org

- split "Line Playback Switch" into "LineL Playback Switch" and "LineR
  Playback Switch"
- split "Line PGA Bypass Playback Volume" into "LineL Left PGA Bypass
  Playback Volume" and "LineR Right PGA Bypass Playback Volume"
- split "Line Line2 Bypass Playback Volume" into "LineL Line2 Bypass
  Playback Volume" and "LineR Line2 Bypass Playback Volume"
- Added "HP Right PGA Bypass Playback Volume"

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
Resent the patch Jarkko acked on.

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
