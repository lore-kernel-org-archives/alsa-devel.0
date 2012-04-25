From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: SSM2602: Add sysclk based rate
	constraints
Date: Wed, 25 Apr 2012 11:42:46 +0200
Message-ID: <1335346968-6086-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-102.synserver.de
	[212.40.185.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 19AC6104841
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 11:40:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Not all advertised rates are available for all sysclk frequencies. Add
additional sysclk based rate constraints.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 4c94fd2..dcedd74 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -53,6 +53,7 @@ enum ssm2602_type {
 /* codec private data */
 struct ssm2602_priv {
 	unsigned int sysclk;
+	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 	enum snd_soc_control_type control_type;
 	struct snd_pcm_substream *master_substream;
 	struct snd_pcm_substream *slave_substream;
@@ -195,6 +196,24 @@ static const struct snd_soc_dapm_route ssm2604_routes[] = {
 	{"ADC", NULL, "Line Input"},
 };
 
+static const unsigned int ssm2602_rates_12288000[] = {
+	8000, 32000, 48000, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list ssm2602_constraints_12288000 = {
+	.list = ssm2602_rates_12288000,
+	.count = ARRAY_SIZE(ssm2602_rates_12288000),
+};
+
+static const unsigned int ssm2602_rates_11289600[] = {
+	8000, 44100, 88200,
+};
+
+static struct snd_pcm_hw_constraint_list ssm2602_constraints_11289600 = {
+	.list = ssm2602_rates_11289600,
+	.count = ARRAY_SIZE(ssm2602_rates_11289600),
+};
+
 struct ssm2602_coeff {
 	u32 mclk;
 	u32 rate;
@@ -320,6 +339,12 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 	} else
 		ssm2602->master_substream = substream;
 
+	if (ssm2602->sysclk_constraints) {
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   ssm2602->sysclk_constraints);
+	}
+
 	return 0;
 }
 
@@ -361,16 +386,21 @@ static int ssm2602_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 			return -EINVAL;
 
 		switch (freq) {
-		case 11289600:
-		case 12000000:
 		case 12288000:
-		case 16934400:
 		case 18432000:
-			ssm2602->sysclk = freq;
+			ssm2602->sysclk_constraints = &ssm2602_constraints_12288000;
+			break;
+		case 11289600:
+		case 16934400:
+			ssm2602->sysclk_constraints = &ssm2602_constraints_11289600;
+			break;
+		case 12000000:
+			ssm2602->sysclk_constraints = NULL;
 			break;
 		default:
 			return -EINVAL;
 		}
+		ssm2602->sysclk = freq;
 	} else {
 		unsigned int mask;
 
-- 
1.7.9.5
