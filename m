From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: speyside: Constrain the CPU link to
	8kHz based rates
Date: Wed, 14 Mar 2012 20:36:34 +0000
Message-ID: <1331757394-27488-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1331757394-27488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4D21103B8E
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 21:36:41 +0100 (CET)
In-Reply-To: <1331757394-27488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

While the CODEC now supports other rates we're only clocking it for 8kHz
based rates. In future we'll probably want to take advantage of the extra
flexibility but this ensures userspace doesn't use the wrong rates for now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index ce5af12..fafffd9 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -126,6 +126,28 @@ static void speyside_set_polarity(struct snd_soc_codec *codec,
 	snd_soc_dapm_sync(&codec->dapm);
 }
 
+static const unsigned int speyside_cpu_constraints[] = {
+	8000, 16000, 32000, 48000,
+};
+
+static struct snd_pcm_hw_constraint_list speyside_cpu_constraints_list = {
+	.count	= ARRAY_SIZE(speyside_cpu_constraints),
+	.list	= speyside_cpu_constraints,
+};
+
+static int speyside_cpu_startup(struct snd_pcm_substream *substream)
+{
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   &speyside_cpu_constraints_list);
+
+	return 0;
+}
+
+static struct snd_soc_ops speyside_cpu_ops = {
+	.startup = speyside_cpu_startup,
+};
+
 static int speyside_wm8996_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *dai = rtd->codec_dai;
@@ -183,6 +205,7 @@ static struct snd_soc_dai_link speyside_dai[] = {
 		.init = speyside_wm8996_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
+		.ops = &speyside_cpu_ops,
 	},
 	{
 		.name = "Baseband",
-- 
1.7.9.1
