From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 1/3] ASoC: davinci-pcm: latch EDMA errors
Date: Fri, 30 Sep 2011 17:23:01 -0400
Message-ID: <647c53d57c6dc6b9780f7f1ad21f39106e702566.1317417232.git.bengardiner@nanometrics.ca>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D741103823
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 23:23:09 +0200 (CEST)
Received: by mail-qy0-f172.google.com with SMTP id 32so775298qyk.3
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2011 14:23:08 -0700 (PDT)
In-Reply-To: <cover.1317417232.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1317417232.git.bengardiner@nanometrics.ca>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

The davinci-pcm driver currently ignores all EDMA completion callbacks that
could be indicating an error.

Latch any edma error-status callbacks and report them as SNDDRV_PCM_POS_XRUN
like is done in fsl_dma.c.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>

---

In testing when an error occured early-on in playback the stream did not halt,
but several underruns were reported until eventually the stream halted.

Is there a better way to report HW errors up the stack?
---
 sound/soc/davinci/davinci-pcm.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index d5fe08c..41a3b5b 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -155,6 +155,7 @@ struct davinci_runtime_data {
 	int ram_link2;
 	struct edmacc_param asp_params;
 	struct edmacc_param ram_params;
+	unsigned error:1;
 };
 
 static void davinci_pcm_period_elapsed(struct snd_pcm_substream *substream)
@@ -245,8 +246,12 @@ static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
 	print_buf_info(prtd->ram_channel, "i ram_channel");
 	pr_debug("davinci_pcm: link=%d, status=0x%x\n", link, ch_status);
 
-	if (unlikely(ch_status != DMA_COMPLETE))
+	if (unlikely(ch_status != DMA_COMPLETE)) {
+		spin_lock(&prtd->lock);
+		prtd->error = 1;
+		spin_unlock(&prtd->lock);
 		return;
+	}
 
 	if (snd_pcm_running(substream)) {
 		spin_lock(&prtd->lock);
@@ -635,7 +640,7 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 	unsigned int offset;
-	int asp_count;
+	int asp_count, error;
 	unsigned int period_size = snd_pcm_lib_period_bytes(substream);
 
 	/*
@@ -647,8 +652,12 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	 */
 	spin_lock(&prtd->lock);
 	asp_count = prtd->period - 2;
+	error = prtd->error;
 	spin_unlock(&prtd->lock);
 
+	if (error)
+		return SNDRV_PCM_POS_XRUN;
+
 	if (asp_count < 0)
 		asp_count += runtime->periods;
 	asp_count *= period_size;
-- 
1.7.4.1
