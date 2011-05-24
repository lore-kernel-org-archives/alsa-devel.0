From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 4/6] ASoC: davinci-pcm: fix audible glitch on
	2nd ping-pong playback
Date: Tue, 24 May 2011 14:50:18 -0400
Message-ID: <befb6c49f0af9ff09380f919bf1be7d5e7b4c0ab.1306258759.git.bengardiner@nanometrics.ca>
References: <cover.1306258759.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 2980B1039C3
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 20:50:28 +0200 (CEST)
Received: by mail-vw0-f44.google.com with SMTP id 12so5134736vws.3
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 11:50:28 -0700 (PDT)
In-Reply-To: <cover.1306258759.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Steven Faludi <stevenfaludi@nanometrics.ca>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

The release of the dma channels was being performed in prepare and there was a
edma_resume call for the asp-channel only being executed on START, RESUME and
PAUSE_RELEASE.

The mcasp on da850evm with ping-pong buffers enabled was exhibiting an audible
glitch on every playback after the first. It was determined through trial and
error that the following two changes fix this problem:

1) Move the edma_start calls from prepare to trigger and 2) reverse the order
of starting the asp and ram channels.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: Steven Faludi <stevenfaludi@nanometrics.ca>
CC: Troy Kisky <troy.kisky@boundarydevices.com>

---
 sound/soc/davinci/davinci-pcm.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 9b5a9bf..5d9269a 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -544,6 +544,13 @@ static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		edma_start(prtd->asp_channel);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+		    prtd->ram_channel >= 0) {
+			/* copy 1st iram buffer */
+			edma_start(prtd->ram_channel);
+		}
+		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		edma_resume(prtd->asp_channel);
@@ -582,11 +589,6 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 		print_buf_info(prtd->asp_link[0], "asp_link[0]");
 		print_buf_info(prtd->asp_link[1], "asp_link[1]");
 
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			/* copy 1st iram buffer */
-			edma_start(prtd->ram_channel);
-		}
-		edma_start(prtd->asp_channel);
 		return 0;
 	}
 	prtd->period = 0;
@@ -596,7 +598,6 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 	edma_read_slot(prtd->asp_link[0], &prtd->asp_params);
 	edma_write_slot(prtd->asp_channel, &prtd->asp_params);
 	davinci_pcm_enqueue_dma(substream);
-	edma_start(prtd->asp_channel);
 
 	return 0;
 }
-- 
1.7.4.1
