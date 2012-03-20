From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: omap-mcbsp: buffer size constraint
	only applies to playback stream
Date: Tue, 20 Mar 2012 13:13:39 +0200
Message-ID: <1332242021-7494-2-git-send-email-peter.ujfalusi@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F53224615
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:13:59 +0100 (CET)
Received: by mail-lpp01m010-f45.google.com with SMTP id e6so5852976lah.4
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 04:13:56 -0700 (PDT)
In-Reply-To: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

In capture stream the buffer size does not need to be constrained to be
bigger then the McBSP FIFO.
In capture the FIFO content is taken out in period length burst, this
enusres that the FIFO is not going to overflow.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 27144a6..1046083 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -138,13 +138,15 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	if (mcbsp->pdata->buffer_size) {
 		/*
 		* Rule for the buffer size. We should not allow
-		* smaller buffer than the FIFO size to avoid underruns
+		* smaller buffer than the FIFO size to avoid underruns.
+		* This applies only for the playback stream.
 		*/
-		snd_pcm_hw_rule_add(substream->runtime, 0,
-				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-				    omap_mcbsp_hwrule_min_buffersize,
-				    mcbsp,
-				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			snd_pcm_hw_rule_add(substream->runtime, 0,
+					    SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					    omap_mcbsp_hwrule_min_buffersize,
+					    mcbsp,
+					    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 
 		/* Make sure, that the period size is always even */
 		snd_pcm_hw_constraint_step(substream->runtime, 0,
-- 
1.7.8.5
