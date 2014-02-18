From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 020/102] ASoC: isabelle: Fix the wrong number
	of items in enum ctls
Date: Tue, 18 Feb 2014 12:36:55 +0100
Message-ID: <1392723422-12689-5-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D699265583
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:37:06 +0100 (CET)
In-Reply-To: <1392723422-12689-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

isabelle codec driver has a few places wrongly defining the number of
enum items.

Use SOC_ENUM_SINGLE_DECL() macro and they are automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/isabelle.c | 52 ++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 5839048ec467..cb736ddc446d 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -140,13 +140,17 @@ static const char *isabelle_rx1_texts[] = {"VRX1", "ARX1"};
 static const char *isabelle_rx2_texts[] = {"VRX2", "ARX2"};
 
 static const struct soc_enum isabelle_rx1_enum[] = {
-	SOC_ENUM_SINGLE(ISABELLE_VOICE_HPF_CFG_REG, 3, 1, isabelle_rx1_texts),
-	SOC_ENUM_SINGLE(ISABELLE_AUDIO_HPF_CFG_REG, 5, 1, isabelle_rx1_texts),
+	SOC_ENUM_SINGLE(ISABELLE_VOICE_HPF_CFG_REG, 3,
+			ARRAY_SIZE(isabelle_rx1_texts), isabelle_rx1_texts),
+	SOC_ENUM_SINGLE(ISABELLE_AUDIO_HPF_CFG_REG, 5,
+			ARRAY_SIZE(isabelle_rx1_texts), isabelle_rx1_texts),
 };
 
 static const struct soc_enum isabelle_rx2_enum[] = {
-	SOC_ENUM_SINGLE(ISABELLE_VOICE_HPF_CFG_REG, 2, 1, isabelle_rx2_texts),
-	SOC_ENUM_SINGLE(ISABELLE_AUDIO_HPF_CFG_REG, 4, 1, isabelle_rx2_texts),
+	SOC_ENUM_SINGLE(ISABELLE_VOICE_HPF_CFG_REG, 2,
+			ARRAY_SIZE(isabelle_rx2_texts), isabelle_rx2_texts),
+	SOC_ENUM_SINGLE(ISABELLE_AUDIO_HPF_CFG_REG, 4,
+			ARRAY_SIZE(isabelle_rx2_texts), isabelle_rx2_texts),
 };
 
 /* Headset DAC playback switches */
@@ -161,13 +165,17 @@ static const char *isabelle_atx_texts[] = {"AMIC1", "DMIC"};
 static const char *isabelle_vtx_texts[] = {"AMIC2", "DMIC"};
 
 static const struct soc_enum isabelle_atx_enum[] = {
-	SOC_ENUM_SINGLE(ISABELLE_AMIC_CFG_REG, 7, 1, isabelle_atx_texts),
-	SOC_ENUM_SINGLE(ISABELLE_DMIC_CFG_REG, 0, 1, isabelle_atx_texts),
+	SOC_ENUM_SINGLE(ISABELLE_AMIC_CFG_REG, 7,
+			ARRAY_SIZE(isabelle_atx_texts), isabelle_atx_texts),
+	SOC_ENUM_SINGLE(ISABELLE_DMIC_CFG_REG, 0,
+			ARRAY_SIZE(isabelle_atx_texts), isabelle_atx_texts),
 };
 
 static const struct soc_enum isabelle_vtx_enum[] = {
-	SOC_ENUM_SINGLE(ISABELLE_AMIC_CFG_REG, 6, 1, isabelle_vtx_texts),
-	SOC_ENUM_SINGLE(ISABELLE_DMIC_CFG_REG, 0, 1, isabelle_vtx_texts),
+	SOC_ENUM_SINGLE(ISABELLE_AMIC_CFG_REG, 6,
+			ARRAY_SIZE(isabelle_vtx_texts), isabelle_vtx_texts),
+	SOC_ENUM_SINGLE(ISABELLE_DMIC_CFG_REG, 0,
+			ARRAY_SIZE(isabelle_vtx_texts), isabelle_vtx_texts),
 };
 
 static const struct snd_kcontrol_new atx_mux_controls =
@@ -183,17 +191,13 @@ static const char *isabelle_amic1_texts[] = {
 /* Left analog microphone selection */
 static const char *isabelle_amic2_texts[] = {"Sub Mic", "Aux/FM Right"};
 
-static const struct soc_enum isabelle_amic1_enum[] = {
-	SOC_ENUM_SINGLE(ISABELLE_AMIC_CFG_REG, 5,
-			ARRAY_SIZE(isabelle_amic1_texts),
-			isabelle_amic1_texts),
-};
+static SOC_ENUM_SINGLE_DECL(isabelle_amic1_enum,
+			    ISABELLE_AMIC_CFG_REG, 5,
+			    isabelle_amic1_texts);
 
-static const struct soc_enum isabelle_amic2_enum[] = {
-	SOC_ENUM_SINGLE(ISABELLE_AMIC_CFG_REG, 4,
-			ARRAY_SIZE(isabelle_amic2_texts),
-			isabelle_amic2_texts),
-};
+static SOC_ENUM_SINGLE_DECL(isabelle_amic2_enum,
+			    ISABELLE_AMIC_CFG_REG, 4,
+			    isabelle_amic2_texts);
 
 static const struct snd_kcontrol_new amic1_control =
 	SOC_DAPM_ENUM("Route", isabelle_amic1_enum);
@@ -206,16 +210,20 @@ static const char *isabelle_st_audio_texts[] = {"ATX1", "ATX2"};
 static const char *isabelle_st_voice_texts[] = {"VTX1", "VTX2"};
 
 static const struct soc_enum isabelle_st_audio_enum[] = {
-	SOC_ENUM_SINGLE(ISABELLE_ATX_STPGA1_CFG_REG, 7, 1,
+	SOC_ENUM_SINGLE(ISABELLE_ATX_STPGA1_CFG_REG, 7,
+			ARRAY_SIZE(isabelle_st_audio_texts),
 			isabelle_st_audio_texts),
-	SOC_ENUM_SINGLE(ISABELLE_ATX_STPGA2_CFG_REG, 7, 1,
+	SOC_ENUM_SINGLE(ISABELLE_ATX_STPGA2_CFG_REG, 7,
+			ARRAY_SIZE(isabelle_st_audio_texts),
 			isabelle_st_audio_texts),
 };
 
 static const struct soc_enum isabelle_st_voice_enum[] = {
-	SOC_ENUM_SINGLE(ISABELLE_VTX_STPGA1_CFG_REG, 7, 1,
+	SOC_ENUM_SINGLE(ISABELLE_VTX_STPGA1_CFG_REG, 7,
+			ARRAY_SIZE(isabelle_st_voice_texts),
 			isabelle_st_voice_texts),
-	SOC_ENUM_SINGLE(ISABELLE_VTX2_STPGA2_CFG_REG, 7, 1,
+	SOC_ENUM_SINGLE(ISABELLE_VTX2_STPGA2_CFG_REG, 7,
+			ARRAY_SIZE(isabelle_st_voice_texts),
 			isabelle_st_voice_texts),
 };
 
-- 
1.8.5.2
