From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Check for bias level when powering
	down
Date: Wed, 22 Feb 2012 15:54:38 +0000
Message-ID: <1329926079-22981-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 738C31040D0
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 16:54:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Recent enhancements in the bias management means that we might not be
in standby when the CODEC is idle and can have active widgets without
being in full power mode but the shutdown functionality assumes these
things. Add checks for the bias level at each stage so that we don't
do transitions other than the ON->PREPARE->STANDBY->OFF ones that the
drivers are expecting.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9029aad..3a5adab 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3237,9 +3237,13 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 	 * standby.
 	 */
 	if (powerdown) {
-		snd_soc_dapm_set_bias_level(dapm, SND_SOC_BIAS_PREPARE);
+		if (dapm->bias_level == SND_SOC_BIAS_ON)
+			snd_soc_dapm_set_bias_level(dapm,
+						    SND_SOC_BIAS_PREPARE);
 		dapm_seq_run(dapm, &down_list, 0, false);
-		snd_soc_dapm_set_bias_level(dapm, SND_SOC_BIAS_STANDBY);
+		if (dapm->bias_level == SND_SOC_BIAS_PREPARE)
+			snd_soc_dapm_set_bias_level(dapm,
+						    SND_SOC_BIAS_STANDBY);
 	}
 }
 
@@ -3252,7 +3256,9 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card)
 
 	list_for_each_entry(codec, &card->codec_dev_list, list) {
 		soc_dapm_shutdown_codec(&codec->dapm);
-		snd_soc_dapm_set_bias_level(&codec->dapm, SND_SOC_BIAS_OFF);
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+			snd_soc_dapm_set_bias_level(&codec->dapm,
+						    SND_SOC_BIAS_OFF);
 	}
 }
 
-- 
1.7.9.1
