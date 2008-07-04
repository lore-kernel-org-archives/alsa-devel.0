From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 2/2] ALSA: soc - cs4270: fix ADC/DAC rate
	matching
Date: Fri, 4 Jul 2008 19:44:04 +0400
Message-ID: <20080704154404.GB27136@polina.dev.rtsoft.ru>
References: <20080704154313.GA11635@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 3662424A83
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 17:44:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080704154313.GA11635@polina.dev.rtsoft.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

CS4270 is unable to handle different rates separately for ADC and DAC,
so the rates should always match. This patch fixes it so that the first
substream that configured the codec will own hardware parameters, thus
subsequent substreams should comply with existing parameters or bail out.

This patch fixes the issue when capture substream may ruin the playback,
and vice versa.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 sound/soc/codecs/cs4270.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index d250491..d5a7a00 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -45,6 +45,8 @@
 struct cs4270_private {
 	unsigned int mclk; /* Input frequency of the MCLK pin */
 	unsigned int mode; /* The mode (I2S or left-justified) */
+	struct snd_pcm_substream *master_substream; /* Owns hw_params */
+	unsigned int rate; /* Rate that master substream has configured */
 };
 
 /*
@@ -383,6 +385,19 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	rate = params_rate(params);	/* Sampling rate, in Hz */
 	ratio = cs4270->mclk / rate;	/* MCLK/LRCK ratio */
 
+	/*
+	 * CODEC is using the same rate for ADC and DAC. If, for example,
+	 * we're currently playing something with one rate, we must use the
+	 * same rate for recording. The substream that did hw_params first
+	 * wins.
+	 */
+	if (!cs4270->master_substream)
+		cs4270->master_substream = substream;
+	else if (cs4270->master_substream != substream &&
+			cs4270->rate != rate)
+		return -EINVAL;
+	cs4270->rate = rate;
+
 	for (i = 0; i < NUM_MCLK_RATIOS; i++) {
 		if (cs4270_mode_ratios[i].ratio == ratio)
 			break;
@@ -462,6 +477,20 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int cs4270_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct cs4270_private *cs4270 = rtd->socdev->codec->private_data;
+
+	/*
+	 * Master substream don't want to own the hw params anymore, so from
+	 * now on other streams could do their own params.
+	 */
+	if (cs4270->master_substream == substream)
+		cs4270->master_substream = NULL;
+	return 0;
+}
+
 #ifdef CONFIG_SND_SOC_CS4270_HWMUTE
 
 /*
@@ -745,6 +774,7 @@ static int cs4270_probe(struct platform_device *pdev)
 	if (codec->control_data) {
 		/* Initialize codec ops */
 		cs4270_dai.ops.hw_params = cs4270_hw_params;
+		cs4270_dai.ops.hw_free = cs4270_hw_free;
 		cs4270_dai.dai_ops.set_sysclk = cs4270_set_dai_sysclk;
 		cs4270_dai.dai_ops.set_fmt = cs4270_set_dai_fmt;
 #ifdef CONFIG_SND_SOC_CS4270_HWMUTE
-- 
1.5.5.4
