From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Support for one channel
	(mono) audio
Date: Thu, 11 May 2017 09:58:22 +0300
Message-ID: <20170511065822.7604-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D7F6266483
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 08:58:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

Mono audio can be achieved by configuring McASP to transmit/receive only
during one timeslot. McASP will still going to generate clocks for the
other slot(s), but will only use the single slot to transmit/receive.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 5e02c7a15a83..31b4eac87aa2 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -650,7 +650,7 @@ static int davinci_mcasp_ch_constraint(struct davinci_mcasp *mcasp, int stream,
 	if (mcasp->tdm_mask[stream])
 		slots = hweight32(mcasp->tdm_mask[stream]);
 
-	for (i = 2; i <= slots; i++)
+	for (i = 1; i <= slots; i++)
 		list[count++] = i;
 
 	for (i = 2; i <= serializers; i++)
@@ -1318,7 +1318,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 
 	snd_pcm_hw_constraint_minmax(substream->runtime,
 				     SNDRV_PCM_HW_PARAM_CHANNELS,
-				     2, max_channels);
+				     0, max_channels);
 
 	snd_pcm_hw_constraint_list(substream->runtime,
 				   0, SNDRV_PCM_HW_PARAM_CHANNELS,
@@ -1480,13 +1480,13 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
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
@@ -1992,12 +1992,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
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
2.12.2
