From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/4] ASoC: tlv320aic3x: Fix remaining output
	pin switch names
Date: Fri, 27 Aug 2010 16:56:47 +0300
Message-ID: <1282917410-12000-2-git-send-email-jhnikula@gmail.com>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8649224614
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 15:56:06 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1983186ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 06:56:05 -0700 (PDT)
In-Reply-To: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Bit 3 in output pin_CTRL register mutes the whole output pin not just the
route from DAC so remove misleading DAC from control name. Currently only
"Line[L | R] Playback Switch" were correct.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index efae8b5..6e4ed79 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -314,7 +314,7 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Mono DAC Playback Volume",
 			 DACL1_2_MONOLOPM_VOL, DACR1_2_MONOLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_SINGLE("Mono DAC Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
+	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
 	SOC_DOUBLE_R_TLV("Mono PGA Bypass Playback Volume",
 			 PGAL_2_MONOLOPM_VOL, PGAR_2_MONOLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
@@ -325,7 +325,7 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("HP DAC Playback Volume",
 			 DACL1_2_HPLOUT_VOL, DACR1_2_HPROUT_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R("HP DAC Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
+	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
 	SOC_DOUBLE_R_TLV("HP Right PGA Bypass Playback Volume",
 			 PGAR_2_HPLOUT_VOL, PGAR_2_HPROUT_VOL,
@@ -341,7 +341,7 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("HPCOM DAC Playback Volume",
 			 DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R("HPCOM DAC Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
+	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
 	SOC_SINGLE_TLV("HPLCOM PGA Bypass Playback Volume",
 		       PGAL_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
-- 
1.7.1
