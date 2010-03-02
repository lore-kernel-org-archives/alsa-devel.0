From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 4/4] ASoC: OMAP3: Report delay on playback caused
	by the internal FIFO
Date: Tue,  2 Mar 2010 15:39:51 +0200
Message-ID: <1267537191-25254-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 29F5B1038CC
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:40:08 +0100 (CET)
In-Reply-To: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Use the new delay calback function to report the delay through
ALSA for application caused by the internal FIFO.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d297256..72036b5 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -248,6 +248,31 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return err;
 }
 
+static snd_pcm_sframes_t omap_mcbsp_dai_delay(
+			struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	u16 fifo_use;
+	snd_pcm_sframes_t delay;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		fifo_use = omap_mcbsp_get_tx_buffstat(mcbsp_data->bus_id);
+	else
+		return 0;
+
+	/*
+	 * Devide the used locations with the channel count to get the
+	 * FIFO usage in samples (don't care about partial samples in the
+	 * buffer).
+	 */
+	delay = fifo_use / substream->runtime->channels;
+
+	return delay;
+}
+
 static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *dai)
@@ -599,6 +624,7 @@ static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
 	.startup	= omap_mcbsp_dai_startup,
 	.shutdown	= omap_mcbsp_dai_shutdown,
 	.trigger	= omap_mcbsp_dai_trigger,
+	.delay		= omap_mcbsp_dai_delay,
 	.hw_params	= omap_mcbsp_dai_hw_params,
 	.set_fmt	= omap_mcbsp_dai_set_dai_fmt,
 	.set_clkdiv	= omap_mcbsp_dai_set_clkdiv,
-- 
1.7.0
