From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 069/102] ASoC: ml26124: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:25 +0100
Message-ID: <1392723517-12772-42-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AC36B2655DD
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
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

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ml26124.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 185fa3bc3052..577fb8776ce7 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -73,11 +73,11 @@ static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
 static const char * const ml26124_companding[] = {"16bit PCM", "u-law",
 						  "A-law"};
 
-static const struct soc_enum ml26124_adc_companding_enum
-	= SOC_ENUM_SINGLE(ML26124_SAI_TRANS_CTL, 6, 3, ml26124_companding);
+static SOC_ENUM_SINGLE_DECL(ml26124_adc_companding_enum,
+			    ML26124_SAI_TRANS_CTL, 6, ml26124_companding);
 
-static const struct soc_enum ml26124_dac_companding_enum
-	= SOC_ENUM_SINGLE(ML26124_SAI_RCV_CTL, 6, 3, ml26124_companding);
+static SOC_ENUM_SINGLE_DECL(ml26124_dac_companding_enum,
+			    ML26124_SAI_RCV_CTL, 6, ml26124_companding);
 
 static const struct snd_kcontrol_new ml26124_snd_controls[] = {
 	SOC_SINGLE_TLV("Capture Digital Volume", ML26124_RECORD_DIG_VOL, 0,
@@ -136,8 +136,8 @@ static const struct snd_kcontrol_new ml26124_output_mixer_controls[] = {
 static const char * const ml26124_input_select[] = {"Analog MIC SingleEnded in",
 				"Digital MIC in", "Analog MIC Differential in"};
 
-static const struct soc_enum ml26124_insel_enum =
-	SOC_ENUM_SINGLE(ML26124_MIC_IF_CTL, 0, 3, ml26124_input_select);
+static SOC_ENUM_SINGLE_DECL(ml26124_insel_enum,
+			    ML26124_MIC_IF_CTL, 0, ml26124_input_select);
 
 static const struct snd_kcontrol_new ml26124_input_mux_controls =
 	SOC_DAPM_ENUM("Input Select", ml26124_insel_enum);
-- 
1.8.5.2
