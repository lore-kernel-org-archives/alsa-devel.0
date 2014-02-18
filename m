From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 088/102] ASoC: tas5086: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:34 +0100
Message-ID: <1392724308-13375-8-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B3EA265762
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
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

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/tas5086.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index a895a5e4bdf2..15600aef08ee 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -555,12 +555,12 @@ static const char *tas5086_dapm_sdin_texts[] =
 };
 
 static const struct soc_enum tas5086_dapm_input_mux_enum[] = {
-	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 20, 8, tas5086_dapm_sdin_texts),
-	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 16, 8, tas5086_dapm_sdin_texts),
-	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 12, 8, tas5086_dapm_sdin_texts),
-	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 8,  8, tas5086_dapm_sdin_texts),
-	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 4,  8, tas5086_dapm_sdin_texts),
-	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 0,  8, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_INPUT_MUX, 20, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_INPUT_MUX, 16, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_INPUT_MUX, 12, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_INPUT_MUX, 8,  tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_INPUT_MUX, 4,  tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_INPUT_MUX, 0,  tas5086_dapm_sdin_texts),
 };
 
 static const struct snd_kcontrol_new tas5086_dapm_input_mux_controls[] = {
@@ -578,12 +578,12 @@ static const char *tas5086_dapm_channel_texts[] =
 	  "Channel 4 Mux", "Channel 5 Mux", "Channel 6 Mux" };
 
 static const struct soc_enum tas5086_dapm_output_mux_enum[] = {
-	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 20, 6, tas5086_dapm_channel_texts),
-	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 16, 6, tas5086_dapm_channel_texts),
-	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 12, 6, tas5086_dapm_channel_texts),
-	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 8,  6, tas5086_dapm_channel_texts),
-	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 4,  6, tas5086_dapm_channel_texts),
-	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 0,  6, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_PWM_OUTPUT_MUX, 20, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_PWM_OUTPUT_MUX, 16, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_PWM_OUTPUT_MUX, 12, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_PWM_OUTPUT_MUX, 8,  tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_PWM_OUTPUT_MUX, 4,  tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE_CONST(TAS5086_PWM_OUTPUT_MUX, 0,  tas5086_dapm_channel_texts),
 };
 
 static const struct snd_kcontrol_new tas5086_dapm_output_mux_controls[] = {
-- 
1.8.5.2
