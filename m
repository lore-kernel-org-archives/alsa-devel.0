From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/6] ASoC: davinci-mcasp: Place constraint on
	number of channels
Date: Mon, 10 Nov 2014 12:32:16 +0200
Message-ID: <1415615540-28981-3-git-send-email-peter.ujfalusi@ti.com>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 6946A2614AF
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:32:30 +0100 (CET)
In-Reply-To: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

In IIS (I2S, TDM, etc) mode the maximum number of allowed channels for
either direction can be:
number of serializers for the direction * tdm_slots.
This constraint applicable for the first stream, while consequent stream
should not have more channels then the first stream.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 10c264738a0b..10ae75e19d99 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -90,6 +90,9 @@ struct davinci_mcasp {
 
 	bool	dat_port;
 
+	/* Used for comstraint setting on the second stream */
+	u32	channels;
+
 #ifdef CONFIG_PM_SLEEP
 	struct davinci_mcasp_context context;
 #endif
@@ -811,6 +814,9 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 
 	davinci_config_channel_size(mcasp, word_length);
 
+	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE)
+		mcasp->channels = channels;
+
 	return 0;
 }
 
@@ -839,7 +845,61 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *cpu_dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 max_channels = 0;
+	int i, dir;
+
+	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
+		return 0;
+
+	/*
+	 * Limit the maximum allowed channels for the first stream:
+	 * number of serializers for the direction * tdm slots per serializer
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = TX_MODE;
+	else
+		dir = RX_MODE;
+
+	for (i = 0; i < mcasp->num_serializer; i++) {
+		if (mcasp->serial_dir[i] == dir)
+			max_channels++;
+	}
+	max_channels *= mcasp->tdm_slots;
+	/*
+	 * If the already active stream has less channels than the calculated
+	 * limnit based on the seirializers * tdm_slots, we need to use that as
+	 * a constraint for the second stream.
+	 * Otherwise (first stream or less allowed channels) we use the
+	 * calculated constraint.
+	 */
+	if (mcasp->channels && mcasp->channels < max_channels)
+		max_channels = mcasp->channels;
+
+	snd_pcm_hw_constraint_minmax(substream->runtime,
+				     SNDRV_PCM_HW_PARAM_CHANNELS,
+				     2, max_channels);
+	return 0;
+}
+
+static void davinci_mcasp_shutdown(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *cpu_dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
+		return;
+
+	if (!cpu_dai->active)
+		mcasp->channels = 0;
+}
+
 static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
+	.startup	= davinci_mcasp_startup,
+	.shutdown	= davinci_mcasp_shutdown,
 	.trigger	= davinci_mcasp_trigger,
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
-- 
2.1.3
