From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: mips: Cleanup indirect PCM helper
	usages
Date: Tue,  4 Sep 2018 08:18:51 +0200
Message-ID: <20180904061851.1934-6-tiwai@suse.de>
References: <20180904061851.1934-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BDC212678DB
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 08:18:57 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 17AA1AFEF
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 06:18:56 +0000 (UTC)
In-Reply-To: <20180904061851.1934-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We shouldn't set up the indirect PCM parameters at trigger but they
should be set at prepare.  Also, remove a useless debug message, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/mips/hal2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 2bd1cb7489ff..a4ed54aeaf1d 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -564,6 +564,8 @@ static int hal2_playback_prepare(struct snd_pcm_substream *substream)
 	dac->sample_rate = hal2_compute_rate(dac, runtime->rate);
 	memset(&dac->pcm_indirect, 0, sizeof(dac->pcm_indirect));
 	dac->pcm_indirect.hw_buffer_size = H2_BUF_SIZE;
+	dac->pcm_indirect.hw_queue_size = H2_BUF_SIZE / 2;
+	dac->pcm_indirect.hw_io = dac->buffer_dma;
 	dac->pcm_indirect.sw_buffer_size = snd_pcm_lib_buffer_bytes(substream);
 	dac->substream = substream;
 	hal2_setup_dac(hal2);
@@ -576,8 +578,6 @@ static int hal2_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		hal2->dac.pcm_indirect.hw_io = hal2->dac.buffer_dma;
-		hal2->dac.pcm_indirect.hw_data = 0;
 		hal2_start_dac(hal2);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -615,7 +615,6 @@ static int hal2_playback_ack(struct snd_pcm_substream *substream)
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 	struct hal2_codec *dac = &hal2->dac;
 
-	dac->pcm_indirect.hw_queue_size = H2_BUF_SIZE / 2;
 	return snd_pcm_indirect_playback_transfer(substream,
 						  &dac->pcm_indirect,
 						  hal2_playback_transfer);
@@ -655,6 +654,7 @@ static int hal2_capture_prepare(struct snd_pcm_substream *substream)
 	memset(&adc->pcm_indirect, 0, sizeof(adc->pcm_indirect));
 	adc->pcm_indirect.hw_buffer_size = H2_BUF_SIZE;
 	adc->pcm_indirect.hw_queue_size = H2_BUF_SIZE / 2;
+	adc->pcm_indirect.hw_io = adc->buffer_dma;
 	adc->pcm_indirect.sw_buffer_size = snd_pcm_lib_buffer_bytes(substream);
 	adc->substream = substream;
 	hal2_setup_adc(hal2);
@@ -667,9 +667,6 @@ static int hal2_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		hal2->adc.pcm_indirect.hw_io = hal2->adc.buffer_dma;
-		hal2->adc.pcm_indirect.hw_data = 0;
-		printk(KERN_DEBUG "buffer_dma %x\n", hal2->adc.buffer_dma);
 		hal2_start_adc(hal2);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.18.0
