From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 4/8] ASoC: Blackfin: fix bug - AD1980/1 SOC
	Audio driver fails to build in case MMAP support is turned off
Date: Tue, 18 Nov 2008 16:18:18 +0800
Message-ID: <1226996302-10234-5-git-send-email-cooloney@kernel.org>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 78F68244CC
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:17:00 +0100 (CET)
In-Reply-To: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk, tiwai@suse.de
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

clean up redudent code and correct building problem in non-mmap mode

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 4be1a49..4d25f73 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -193,8 +193,10 @@ static int bf5xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+#if defined(CONFIG_SND_BF5XX_MMAP_SUPPORT)
 			bf5xx_mmap_copy(substream, runtime->period_size);
 			sport->tx_delay_pos = 0;
+#endif
 			sport_tx_start(sport);
 		} else
 			sport_rx_start(sport);
@@ -267,23 +269,6 @@ static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-static int bf5xx_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct sport_device *sport = runtime->private_data;
-
-	pr_debug("%s enter\n", __func__);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		sport->once = 0;
-		memset(sport->tx_dma_buf, 0, runtime->buffer_size *
-			sizeof(struct ac97_frame));
-	} else
-		memset(sport->rx_dma_buf, 0, runtime->buffer_size *
-			sizeof(struct ac97_frame));
-
-	return 0;
-}
-
 #if defined(CONFIG_SND_BF5XX_MMAP_SUPPORT)
 static int bf5xx_pcm_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma)
@@ -301,7 +286,7 @@ static	int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 		    void __user *buf, snd_pcm_uframes_t count)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-
+	unsigned int chan_mask = ac97_chan_mask[runtime->channels - 1];
 	pr_debug("%s copy pos:0x%lx count:0x%lx\n",
 			substream->stream ? "Capture" : "Playback", pos, count);
 
@@ -317,7 +302,6 @@ static	int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 
 struct snd_pcm_ops bf5xx_pcm_ac97_ops = {
 	.open		= bf5xx_pcm_open,
-	.close		= bf5xx_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= bf5xx_pcm_hw_params,
 	.hw_free	= bf5xx_pcm_hw_free,
-- 
1.5.6.3
