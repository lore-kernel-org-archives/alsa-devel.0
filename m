From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Support for one channel
	(mono) audio" to the asoc tree
Date: Mon, 15 May 2017 17:03:54 +0900
Message-ID: <E1dAAyw-0002YV-Bj@finisterre>
References: <20170511065822.7604-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F33B9267399
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:04:02 +0200 (CEST)
In-Reply-To: <20170511065822.7604-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Support for one channel (mono) audio

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e4798d26548b264be6604b45e4281244e96c9a09 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 11 May 2017 09:58:22 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Support for one channel (mono) audio

Mono audio can be achieved by configuring McASP to transmit/receive only
during one timeslot. McASP will still going to generate clocks for the
other slot(s), but will only use the single slot to transmit/receive.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 3c5a9804d3f5..56ec1d301ac2 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -629,7 +629,7 @@ static int davinci_mcasp_ch_constraint(struct davinci_mcasp *mcasp, int stream,
 	if (mcasp->tdm_mask[stream])
 		slots = hweight32(mcasp->tdm_mask[stream]);
 
-	for (i = 2; i <= slots; i++)
+	for (i = 1; i <= slots; i++)
 		list[count++] = i;
 
 	for (i = 2; i <= serializers; i++)
@@ -1297,7 +1297,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 
 	snd_pcm_hw_constraint_minmax(substream->runtime,
 				     SNDRV_PCM_HW_PARAM_CHANNELS,
-				     2, max_channels);
+				     0, max_channels);
 
 	snd_pcm_hw_constraint_list(substream->runtime,
 				   0, SNDRV_PCM_HW_PARAM_CHANNELS,
@@ -1459,13 +1459,13 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 		.suspend	= davinci_mcasp_suspend,
 		.resume		= davinci_mcasp_resume,
 		.playback	= {
-			.channels_min	= 2,
+			.channels_min	= 1,
 			.channels_max	= 32 * 16,
 			.rates 		= DAVINCI_MCASP_RATES,
 			.formats	= DAVINCI_MCASP_PCM_FMTS,
 		},
 		.capture 	= {
-			.channels_min 	= 2,
+			.channels_min 	= 1,
 			.channels_max	= 32 * 16,
 			.rates 		= DAVINCI_MCASP_RATES,
 			.formats	= DAVINCI_MCASP_PCM_FMTS,
@@ -1971,12 +1971,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	 */
 	mcasp->chconstr[SNDRV_PCM_STREAM_PLAYBACK].list =
 		devm_kzalloc(mcasp->dev, sizeof(unsigned int) *
-			     (32 + mcasp->num_serializer - 2),
+			     (32 + mcasp->num_serializer - 1),
 			     GFP_KERNEL);
 
 	mcasp->chconstr[SNDRV_PCM_STREAM_CAPTURE].list =
 		devm_kzalloc(mcasp->dev, sizeof(unsigned int) *
-			     (32 + mcasp->num_serializer - 2),
+			     (32 + mcasp->num_serializer - 1),
 			     GFP_KERNEL);
 
 	if (!mcasp->chconstr[SNDRV_PCM_STREAM_PLAYBACK].list ||
-- 
2.11.0
