From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Add rule to constrain
	the minimum period size" to the asoc tree
Date: Fri, 05 Jan 2018 12:42:45 +0000
Message-ID: <E1eXRKf-00054o-5J@debutante>
References: <20180105101807.7360-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ACE41267A36
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 13:42:47 +0100 (CET)
In-Reply-To: <20180105101807.7360-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Add rule to constrain the minimum period size

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d43c17daf2771f703bd92a78b34c7b0f3dcc9576 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 5 Jan 2018 12:18:07 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Add rule to constrain the minimum period
 size

The minimum period size (in frames) must be not lower than the FIFO size
of McASP and in general too small period size would easily result underrun
in applications as eDMA - the most common DMA servicing McASP have support
for limited number of periods.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 804c6f2bcf21..03ba218160ca 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1242,6 +1242,20 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 	return snd_mask_refine(fmt, &nfmt);
 }
 
+static int davinci_mcasp_hw_rule_min_periodsize(
+		struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *period_size = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	struct snd_interval frames;
+
+	snd_interval_any(&frames);
+	frames.min = 64;
+	frames.integer = 1;
+
+	return snd_interval_refine(period_size, &frames);
+}
+
 static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *cpu_dai)
 {
@@ -1333,6 +1347,11 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	snd_pcm_hw_rule_add(substream->runtime, 0,
+			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+			    davinci_mcasp_hw_rule_min_periodsize, NULL,
+			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
+
 	return 0;
 }
 
-- 
2.15.1
