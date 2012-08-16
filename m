From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Remove DRC2
Date: Thu, 16 Aug 2012 18:33:40 +0100
Message-ID: <1345138420-17809-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3BBD9265FF8
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 19:04:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It will be removed from future device revisions.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a00901c..a5aea03 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -128,13 +128,9 @@ SOC_SINGLE_TLV("EQ4 B5 Volume", ARIZONA_EQ4_2, ARIZONA_EQ4_B5_GAIN_SHIFT,
 
 ARIZONA_MIXER_CONTROLS("DRC1L", ARIZONA_DRC1LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DRC1R", ARIZONA_DRC1RMIX_INPUT_1_SOURCE),
-ARIZONA_MIXER_CONTROLS("DRC2L", ARIZONA_DRC2LMIX_INPUT_1_SOURCE),
-ARIZONA_MIXER_CONTROLS("DRC2R", ARIZONA_DRC2RMIX_INPUT_1_SOURCE),
 
 SND_SOC_BYTES_MASK("DRC1", ARIZONA_DRC1_CTRL1, 5,
 		   ARIZONA_DRC1R_ENA | ARIZONA_DRC1L_ENA),
-SND_SOC_BYTES_MASK("DRC2", ARIZONA_DRC2_CTRL1, 5,
-		   ARIZONA_DRC2R_ENA | ARIZONA_DRC2L_ENA),
 
 ARIZONA_MIXER_CONTROLS("LHPF1", ARIZONA_HPLP1MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF2", ARIZONA_HPLP2MIX_INPUT_1_SOURCE),
@@ -236,8 +232,6 @@ ARIZONA_MIXER_ENUMS(EQ4, ARIZONA_EQ4MIX_INPUT_1_SOURCE);
 
 ARIZONA_MIXER_ENUMS(DRC1L, ARIZONA_DRC1LMIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(DRC1R, ARIZONA_DRC1RMIX_INPUT_1_SOURCE);
-ARIZONA_MIXER_ENUMS(DRC2L, ARIZONA_DRC2LMIX_INPUT_1_SOURCE);
-ARIZONA_MIXER_ENUMS(DRC2R, ARIZONA_DRC2RMIX_INPUT_1_SOURCE);
 
 ARIZONA_MIXER_ENUMS(LHPF1, ARIZONA_HPLP1MIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(LHPF2, ARIZONA_HPLP2MIX_INPUT_1_SOURCE);
@@ -353,10 +347,6 @@ SND_SOC_DAPM_PGA("DRC1L", ARIZONA_DRC1_CTRL1, ARIZONA_DRC1L_ENA_SHIFT, 0,
 		 NULL, 0),
 SND_SOC_DAPM_PGA("DRC1R", ARIZONA_DRC1_CTRL1, ARIZONA_DRC1R_ENA_SHIFT, 0,
 		 NULL, 0),
-SND_SOC_DAPM_PGA("DRC2L", ARIZONA_DRC2_CTRL1, ARIZONA_DRC2L_ENA_SHIFT, 0,
-		 NULL, 0),
-SND_SOC_DAPM_PGA("DRC2R", ARIZONA_DRC2_CTRL1, ARIZONA_DRC2R_ENA_SHIFT, 0,
-		 NULL, 0),
 
 SND_SOC_DAPM_PGA("LHPF1", ARIZONA_HPLPF1_1, ARIZONA_LHPF1_ENA_SHIFT, 0,
 		 NULL, 0),
@@ -470,8 +460,6 @@ ARIZONA_MIXER_WIDGETS(EQ4, "EQ4"),
 
 ARIZONA_MIXER_WIDGETS(DRC1L, "DRC1L"),
 ARIZONA_MIXER_WIDGETS(DRC1R, "DRC1R"),
-ARIZONA_MIXER_WIDGETS(DRC2L, "DRC2L"),
-ARIZONA_MIXER_WIDGETS(DRC2R, "DRC2R"),
 
 ARIZONA_MIXER_WIDGETS(LHPF1, "LHPF1"),
 ARIZONA_MIXER_WIDGETS(LHPF2, "LHPF2"),
@@ -557,8 +545,6 @@ SND_SOC_DAPM_OUTPUT("SPKDAT1R"),
 	{ name, "EQ4", "EQ4" }, \
 	{ name, "DRC1L", "DRC1L" }, \
 	{ name, "DRC1R", "DRC1R" }, \
-	{ name, "DRC2L", "DRC2L" }, \
-	{ name, "DRC2R", "DRC2R" }, \
 	{ name, "LHPF1", "LHPF1" }, \
 	{ name, "LHPF2", "LHPF2" }, \
 	{ name, "LHPF3", "LHPF3" }, \
@@ -688,8 +674,6 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 
 	ARIZONA_MIXER_ROUTES("DRC1L", "DRC1L"),
 	ARIZONA_MIXER_ROUTES("DRC1R", "DRC1R"),
-	ARIZONA_MIXER_ROUTES("DRC2L", "DRC2L"),
-	ARIZONA_MIXER_ROUTES("DRC2R", "DRC2R"),
 
 	ARIZONA_MIXER_ROUTES("LHPF1", "LHPF1"),
 	ARIZONA_MIXER_ROUTES("LHPF2", "LHPF2"),
-- 
1.7.10.4
