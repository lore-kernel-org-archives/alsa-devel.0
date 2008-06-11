From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/10] ASoC: Add TLV information to the LM4857
	controls on the GTA01
Date: Wed, 11 Jun 2008 13:47:14 +0100
Message-ID: <1213188435-1986-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-8-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7706224827
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:17 +0200 (CEST)
In-Reply-To: <1213188435-1986-8-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Montour <mail@mmontour.net>
List-Id: alsa-devel@alsa-project.org

From: Mike Montour <mail@mmontour.net>

Signed-off-by: Mike Montour <mail@mmontour.net>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index c1a0161..3485123 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -22,6 +22,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/tlv.h>
 
 #include <asm/mach-types.h>
 #include <asm/hardware/scoop.h>
@@ -474,13 +475,16 @@ static const struct soc_enum neo_scenario_enum[] = {
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(neo_scenarios), neo_scenarios),
 };
 
+static const DECLARE_TLV_DB_SCALE(stereo_tlv, -4050, 150, 0);
+static const DECLARE_TLV_DB_SCALE(mono_tlv, -3450, 150, 0);
+
 static const struct snd_kcontrol_new wm8753_neo1973_controls[] = {
-	SOC_SINGLE_EXT("Amp Left Playback Volume", LM4857_LVOL, 0, 31, 0,
-		lm4857_get_reg, lm4857_set_reg),
-	SOC_SINGLE_EXT("Amp Right Playback Volume", LM4857_RVOL, 0, 31, 0,
-		lm4857_get_reg, lm4857_set_reg),
-	SOC_SINGLE_EXT("Amp Mono Playback Volume", LM4857_MVOL, 0, 31, 0,
-		lm4857_get_reg, lm4857_set_reg),
+	SOC_SINGLE_EXT_TLV("Amp Left Playback Volume", LM4857_LVOL, 0, 31, 0,
+		lm4857_get_reg, lm4857_set_reg, stereo_tlv),
+	SOC_SINGLE_EXT_TLV("Amp Right Playback Volume", LM4857_RVOL, 0, 31, 0,
+		lm4857_get_reg, lm4857_set_reg, stereo_tlv),
+	SOC_SINGLE_EXT_TLV("Amp Mono Playback Volume", LM4857_MVOL, 0, 31, 0,
+		lm4857_get_reg, lm4857_set_reg, mono_tlv),
 	SOC_ENUM_EXT("Amp Mode", lm4857_mode_enum[0],
 		lm4857_get_mode, lm4857_set_mode),
 	SOC_ENUM_EXT("Neo Mode", neo_scenario_enum[0],
-- 
1.5.5.3
