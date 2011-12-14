From: James Hogan <james.hogan@imgtec.com>
Subject: bugs in "ASoC: core - Optimise and refactor pcm_new() to pass only
 rtd"?
Date: Wed, 14 Dec 2011 12:43:50 +0000
Message-ID: <4EE89A06.80101@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Neil <neil.jones@imgtec.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I've bisected a problem with an out of tree set of asoc drivers down to commit
552d1ef6b5a98d7b95959d5b139071e3c90cebf1 ("ASoC: core - Optimise and refactor
pcm_new() to pass only rtd"). By the looks of it this change was intended not 
to change the workings of the code, however the dai parameter of pcm_new used
to be passed codec_dai in soc_new_pcm() (initialised from rtd->codec_dai), but
each driver now sets it's dai to rtd->cpu_dai instead. This seems to make the
driver check the wrong dai's driver->capture.channels_min in the pcm_new
callback, which makes it dereference
pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream in the driver's
preallocate_dma_buffer() function which can be NULL. Is this a bug (in every
pcm asoc driver) that just happens not to have been noticed, or have I
misunderstood it?

Relevant snippets of the original patch below.

Thanks
James

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 5cb3b88..9465588 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -425,9 +425,11 @@ static void dma_free_dma_buffers(struct snd_pcm *pcm)
 
 static u64 dma_mask = DMA_BIT_MASK(32);
 
-static int dma_new(struct snd_card *card,
-	struct snd_soc_dai *dai, struct snd_pcm *pcm)
+static int dma_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_card *card = rtd->card->snd_card;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
 	pr_debug("Entered %s\n", __func__);


diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c53f5d5..29bf9fb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2143,8 +2143,7 @@ static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
 
 	if (platform->driver->pcm_new) {
-		ret = platform->driver->pcm_new(rtd->card->snd_card,
-						codec_dai, pcm);
+		ret = platform->driver->pcm_new(rtd);
 		if (ret < 0) {
 			pr_err("asoc: platform pcm constructor failed\n");
 			return ret;
