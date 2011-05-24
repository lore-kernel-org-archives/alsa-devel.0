From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 6/6] ASoC: davinci-pcm: convert to BATCH mode
Date: Tue, 24 May 2011 14:50:20 -0400
Message-ID: <0f61ef7bb618fc7895a339f4eac55abb2092353c.1306258759.git.bengardiner@nanometrics.ca>
References: <cover.1306258759.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C33810386A
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 20:50:31 +0200 (CEST)
Received: by mail-vx0-f175.google.com with SMTP id 7so6039449vxd.20
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 11:50:30 -0700 (PDT)
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

The davinci-pcm driver's snd_pcm_ops pointer function currently calls into
the edma controller driver to read the current positions of the edma channels
to determine pos to return to the ALSA framework. In particular,
davinci_pcm_pointer() calls edma_get_position() and the latter has a comment
indicating that "Its channel should not be active when this is called" whereas
the channel is surely active when snd_pcm_ops.pointer is called.

The operation of davinci-pcm in capture and playback appears to follow close
the other pcm drivers who export SNDRV_PCM_INFO_BATCH except that davinci-pcm
does not report it's positions from pointer() using the last transferred
chunk. Instead it peeks directly into the edma controller to determine the
current position as discussed above.

Convert the davinci-pcm driver to BATCH mode: count the periods elapsed in the
prtd->period member and use its value to report the 'pos' to the alsa
framework in the davinci_pcm_pointer function.

There is a phase offset of 2 periods between the position used by dma setup
and the position reported in the pointer function. Either +2 in the dma
setup or -2 in the pointer function (with wrapping, both) accounts for this
offset -- I opted for the latter since it makes the first-time setup clearer.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: Steven Faludi <stevenfaludi@nanometrics.ca>

---
 sound/soc/davinci/davinci-pcm.c |   67 +++++++++++----------------------------
 1 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index fedca81..fa8fc61 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -65,7 +65,8 @@ static void print_buf_info(int slot, char *name)
 static struct snd_pcm_hardware pcm_hardware_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
+		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME|
+		 SNDRV_PCM_INFO_BATCH),
 	.formats = DAVINCI_PCM_FMTBITS,
 	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
@@ -87,7 +88,8 @@ static struct snd_pcm_hardware pcm_hardware_playback = {
 static struct snd_pcm_hardware pcm_hardware_capture = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_PAUSE),
+		 SNDRV_PCM_INFO_PAUSE |
+		 SNDRV_PCM_INFO_BATCH),
 	.formats = DAVINCI_PCM_FMTBITS,
 	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
@@ -231,8 +233,6 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	else
 		edma_set_transfer_params(link, acnt, fifo_level, count,
 							fifo_level, ABSYNC);
-
-	davinci_pcm_period_elapsed(substream);
 }
 
 static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
@@ -247,12 +247,13 @@ static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
 		return;
 
 	if (snd_pcm_running(substream)) {
+		spin_lock(&prtd->lock);
 		if (prtd->ram_channel < 0) {
 			/* No ping/pong must fix up link dma data*/
-			spin_lock(&prtd->lock);
 			davinci_pcm_enqueue_dma(substream);
-			spin_unlock(&prtd->lock);
 		}
+		davinci_pcm_period_elapsed(substream);
+		spin_unlock(&prtd->lock);
 		snd_pcm_period_elapsed(substream);
 	}
 }
@@ -588,6 +589,7 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
 
+	davinci_pcm_period_reset(substream);
 	if (prtd->ram_channel >= 0) {
 		int ret = ping_pong_dma_setup(substream);
 		if (ret < 0)
@@ -603,15 +605,19 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 		print_buf_info(prtd->asp_link[0], "asp_link[0]");
 		print_buf_info(prtd->asp_link[1], "asp_link[1]");
 
+		davinci_pcm_period_elapsed(substream);
+		davinci_pcm_period_elapsed(substream);
+
 		return 0;
 	}
-	davinci_pcm_period_reset(substream);
 	davinci_pcm_enqueue_dma(substream);
+	davinci_pcm_period_elapsed(substream);
 
 	/* Copy self-linked parameter RAM entry into master channel */
 	edma_read_slot(prtd->asp_link[0], &prtd->asp_params);
 	edma_write_slot(prtd->asp_channel, &prtd->asp_params);
 	davinci_pcm_enqueue_dma(substream);
+	davinci_pcm_period_elapsed(substream);
 
 	return 0;
 }
@@ -623,51 +629,16 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	struct davinci_runtime_data *prtd = runtime->private_data;
 	unsigned int offset;
 	int asp_count;
-	dma_addr_t asp_src, asp_dst;
+	unsigned int period_size = snd_pcm_lib_period_bytes(substream);
 
 	spin_lock(&prtd->lock);
-	if (prtd->ram_channel >= 0) {
-		int ram_count;
-		int mod_ram;
-		dma_addr_t ram_src, ram_dst;
-		unsigned int period_size = snd_pcm_lib_period_bytes(substream);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			/* reading ram before asp should be safe
-			 * as long as the asp transfers less than a ping size
-			 * of bytes between the 2 reads
-			 */
-			edma_get_position(prtd->ram_channel,
-					&ram_src, &ram_dst);
-			edma_get_position(prtd->asp_channel,
-					&asp_src, &asp_dst);
-			asp_count = asp_src - prtd->asp_params.src;
-			ram_count = ram_src - prtd->ram_params.src;
-			mod_ram = ram_count % period_size;
-			mod_ram -= asp_count;
-			if (mod_ram < 0)
-				mod_ram += period_size;
-			else if (mod_ram == 0) {
-				if (snd_pcm_running(substream))
-					mod_ram += period_size;
-			}
-			ram_count -= mod_ram;
-			if (ram_count < 0)
-				ram_count += period_size * runtime->periods;
-		} else {
-			edma_get_position(prtd->ram_channel,
-					&ram_src, &ram_dst);
-			ram_count = ram_dst - prtd->ram_params.dst;
-		}
-		asp_count = ram_count;
-	} else {
-		edma_get_position(prtd->asp_channel, &asp_src, &asp_dst);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			asp_count = asp_src - runtime->dma_addr;
-		else
-			asp_count = asp_dst - runtime->dma_addr;
-	}
+	asp_count = prtd->period - 2;
 	spin_unlock(&prtd->lock);
 
+	if (asp_count < 0)
+		asp_count += runtime->periods;
+	asp_count *= period_size;
+
 	offset = bytes_to_frames(runtime, asp_count);
 	if (offset >= runtime->buffer_size)
 		offset = 0;
-- 
1.7.4.1
