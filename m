From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] tlv320aic3x.c: controller naming fixes
Date: Fri, 5 Dec 2008 16:57:46 +0100
Message-ID: <20081205155746.GA3745@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A5566244C2
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 16:57:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 532787F402D
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 16:57:49 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z74TJ+ZSA75X for <alsa-devel@alsa-project.org>;
	Fri,  5 Dec 2008 16:57:46 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

- removed "DAC" from name for "Mono playback switch", "HP playback
  switch" and "HPCOM playback switch". The registers used in the macro
  don't have anything to do with the DAC but mute the whole output,
  hence the names were misleading.
- renamed "HPL PGA Bypass Playback Volume" to "HPL Left PGA Bypass
  Playback Volume"
- renamed "HPR PGA Bypass Playback Volume" to "HPR Left PGA Bypass
  Playback Volume"

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
This is the second part of the patch I sent yesterday, plus the naming
fixes recently discussed on the list.

 sound/soc/codecs/tlv320aic3x.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6a12dc3..081f7c4 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -268,7 +268,7 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 
 	SOC_DOUBLE_R("Mono DAC Playback Volume", DACL1_2_MONOLOPM_VOL,
 		     DACR1_2_MONOLOPM_VOL, 0, 0x7f, 1),
-	SOC_SINGLE("Mono DAC Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
+	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
 	SOC_DOUBLE_R("Mono PGA Bypass Playback Volume", PGAL_2_MONOLOPM_VOL,
 		     PGAR_2_MONOLOPM_VOL, 0, 0x7f, 1),
 	SOC_DOUBLE_R("Mono Line2 Bypass Playback Volume", LINE2L_2_MONOLOPM_VOL,
@@ -276,20 +276,20 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 
 	SOC_DOUBLE_R("HP DAC Playback Volume", DACL1_2_HPLOUT_VOL,
 		     DACR1_2_HPROUT_VOL, 0, 0x7f, 1),
-	SOC_DOUBLE_R("HP DAC Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
+	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
 	SOC_DOUBLE_R("HP Right PGA Bypass Playback Volume", PGAR_2_HPLOUT_VOL,
 		     PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
-	SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
+	SOC_SINGLE("HPL Left PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
 		     0, 0x7f, 1),
-	SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
+	SOC_SINGLE("HPR Left PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
 		     0, 0x7f, 1),
 	SOC_DOUBLE_R("HP Line2 Bypass Playback Volume", LINE2L_2_HPLOUT_VOL,
 		     LINE2R_2_HPROUT_VOL, 0, 0x7f, 1),
 
 	SOC_DOUBLE_R("HPCOM DAC Playback Volume", DACL1_2_HPLCOM_VOL,
 		     DACR1_2_HPRCOM_VOL, 0, 0x7f, 1),
-	SOC_DOUBLE_R("HPCOM DAC Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
+	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
 	SOC_SINGLE("HPLCOM PGA Bypass Playback Volume", PGAL_2_HPLCOM_VOL,
 		     0, 0x7f, 1),
-- 
1.5.6.5
