From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: ak4671: Fix control-less DAPM routes
Date: Fri, 27 Feb 2015 14:13:02 +0100
Message-ID: <1425042784-727-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-153.synserver.de (smtp-out-157.synserver.de
 [212.40.185.157])
 by alsa0.perex.cz (Postfix) with ESMTP id A3432260703
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 14:19:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Routes without a control must use NULL for the control name. The ak4671
driver uses "NULL" instead in a few places. Previous to commit 5fe5b767dc6f
("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
the DAPM core silently ignored non-NULL controls on non-mixer and non-mux
routes. But starting with that commit it will complain and not add the
route breaking the ak4671 driver in the process.

This patch replaces the incorrect "NULL" control name with NULL to fix the
issue.

Fixes: 5fe5b767dc6f ("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ak4671.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 632e89f..2a58b1d 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -343,25 +343,25 @@ static const struct snd_soc_dapm_widget ak4671_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route ak4671_intercon[] = {
-	{"DAC Left", "NULL", "PMPLL"},
-	{"DAC Right", "NULL", "PMPLL"},
-	{"ADC Left", "NULL", "PMPLL"},
-	{"ADC Right", "NULL", "PMPLL"},
+	{"DAC Left", NULL, "PMPLL"},
+	{"DAC Right", NULL, "PMPLL"},
+	{"ADC Left", NULL, "PMPLL"},
+	{"ADC Right", NULL, "PMPLL"},
 
 	/* Outputs */
-	{"LOUT1", "NULL", "LOUT1 Mixer"},
-	{"ROUT1", "NULL", "ROUT1 Mixer"},
-	{"LOUT2", "NULL", "LOUT2 Mix Amp"},
-	{"ROUT2", "NULL", "ROUT2 Mix Amp"},
-	{"LOUT3", "NULL", "LOUT3 Mixer"},
-	{"ROUT3", "NULL", "ROUT3 Mixer"},
+	{"LOUT1", NULL, "LOUT1 Mixer"},
+	{"ROUT1", NULL, "ROUT1 Mixer"},
+	{"LOUT2", NULL, "LOUT2 Mix Amp"},
+	{"ROUT2", NULL, "ROUT2 Mix Amp"},
+	{"LOUT3", NULL, "LOUT3 Mixer"},
+	{"ROUT3", NULL, "ROUT3 Mixer"},
 
 	{"LOUT1 Mixer", "DACL", "DAC Left"},
 	{"ROUT1 Mixer", "DACR", "DAC Right"},
 	{"LOUT2 Mixer", "DACHL", "DAC Left"},
 	{"ROUT2 Mixer", "DACHR", "DAC Right"},
-	{"LOUT2 Mix Amp", "NULL", "LOUT2 Mixer"},
-	{"ROUT2 Mix Amp", "NULL", "ROUT2 Mixer"},
+	{"LOUT2 Mix Amp", NULL, "LOUT2 Mixer"},
+	{"ROUT2 Mix Amp", NULL, "ROUT2 Mixer"},
 	{"LOUT3 Mixer", "DACSL", "DAC Left"},
 	{"ROUT3 Mixer", "DACSR", "DAC Right"},
 
@@ -381,18 +381,18 @@ static const struct snd_soc_dapm_route ak4671_intercon[] = {
 	{"LIN2", NULL, "Mic Bias"},
 	{"RIN2", NULL, "Mic Bias"},
 
-	{"ADC Left", "NULL", "LIN MUX"},
-	{"ADC Right", "NULL", "RIN MUX"},
+	{"ADC Left", NULL, "LIN MUX"},
+	{"ADC Right", NULL, "RIN MUX"},
 
 	/* Analog Loops */
-	{"LIN1 Mixing Circuit", "NULL", "LIN1"},
-	{"RIN1 Mixing Circuit", "NULL", "RIN1"},
-	{"LIN2 Mixing Circuit", "NULL", "LIN2"},
-	{"RIN2 Mixing Circuit", "NULL", "RIN2"},
-	{"LIN3 Mixing Circuit", "NULL", "LIN3"},
-	{"RIN3 Mixing Circuit", "NULL", "RIN3"},
-	{"LIN4 Mixing Circuit", "NULL", "LIN4"},
-	{"RIN4 Mixing Circuit", "NULL", "RIN4"},
+	{"LIN1 Mixing Circuit", NULL, "LIN1"},
+	{"RIN1 Mixing Circuit", NULL, "RIN1"},
+	{"LIN2 Mixing Circuit", NULL, "LIN2"},
+	{"RIN2 Mixing Circuit", NULL, "RIN2"},
+	{"LIN3 Mixing Circuit", NULL, "LIN3"},
+	{"RIN3 Mixing Circuit", NULL, "RIN3"},
+	{"LIN4 Mixing Circuit", NULL, "LIN4"},
+	{"RIN4 Mixing Circuit", NULL, "RIN4"},
 
 	{"LOUT1 Mixer", "LINL1", "LIN1 Mixing Circuit"},
 	{"ROUT1 Mixer", "RINR1", "RIN1 Mixing Circuit"},
-- 
1.8.0
