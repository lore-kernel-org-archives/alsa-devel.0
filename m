From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: lx6464es - initialization fixes
Date: Mon, 25 Jul 2011 20:34:56 +0200
Message-ID: <a5e69d2bc39aa8f0a29acbcebc4992a84089e662.1311618842.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id D9E18103858
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 20:35:11 +0200 (CEST)
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
Cc: Tim Blechmann <tim@klingt.org>
List-Id: alsa-devel@alsa-project.org

this using this fix, the driver is usable with non-rt kernels. the card
initialization is moved from the prepare to the hw_params callback. also
the error handling is improved.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/lx6464es/lx6464es.c |   72 +++++++++++++++++++++--------------------
 sound/pci/lx6464es/lx6464es.h |    1 +
 sound/pci/lx6464es/lx_core.c  |   43 +++++++++++++++----------
 sound/pci/lx6464es/lx_core.h  |    3 +-
 4 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 1bd7a54..722212e 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -103,16 +103,14 @@ static int lx_set_granularity(struct lx6464es *chip, u32 gran);
 
 
 static int lx_hardware_open(struct lx6464es *chip,
-			    struct snd_pcm_substream *substream)
+			    struct snd_pcm_substream *substream,
+			    int channels, snd_pcm_uframes_t period_size)
 {
 	int err = 0;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int channels = runtime->channels;
 	int is_capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 
-	snd_pcm_uframes_t period_size = runtime->period_size;
-
-	snd_printd(LXP "allocating pipe for %d channels\n", channels);
+	snd_printk(LXP "allocating pipe for %d channels, %lu period size\n",
+		   channels, period_size);
 	err = lx_pipe_allocate(chip, 0, is_capture, channels);
 	if (err < 0) {
 		snd_printk(KERN_ERR LXP "allocating pipe failed\n");
@@ -130,14 +128,14 @@ static int lx_hardware_open(struct lx6464es *chip,
 }
 
 static int lx_hardware_start(struct lx6464es *chip,
-			     struct snd_pcm_substream *substream)
+			     struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *hw_params)
 {
 	int err = 0;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int is_capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 
 	snd_printd(LXP "setting stream format\n");
-	err = lx_stream_set_format(chip, runtime, 0, is_capture);
+	err = lx_stream_set_format(chip, hw_params, 0, is_capture);
 	if (err < 0) {
 		snd_printk(KERN_ERR LXP "setting stream format failed\n");
 		return err;
@@ -295,13 +293,33 @@ static snd_pcm_uframes_t lx_pcm_stream_pointer(struct snd_pcm_substream
 	return pos;
 }
 
+
 static int lx_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct lx6464es *chip = snd_pcm_substream_chip(substream);
 	int err = 0;
-	const int is_capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 
-	snd_printdd("->lx_pcm_prepare\n");
+	snd_printd("->lx_pcm_prepare %d\n", is_capture);
+
+	mutex_lock(&chip->setup_mutex);
+
+	if (chip->board_sample_rate != substream->runtime->rate) {
+		if (!err)
+			chip->board_sample_rate = substream->runtime->rate;
+	}
+
+	mutex_unlock(&chip->setup_mutex);
+	snd_printd("<-lx_pcm_prepare\n");
+	return err;
+}
+
+static int lx_pcm_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *hw_params, int is_capture)
+{
+	struct lx6464es *chip = snd_pcm_substream_chip(substream);
+	int err = 0;
+
+	snd_printd("->lx_pcm_hw_params\n");
 
 	mutex_lock(&chip->setup_mutex);
 
@@ -322,14 +340,16 @@ static int lx_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	snd_printd(LXP "opening hardware\n");
-	err = lx_hardware_open(chip, substream);
+	err = lx_hardware_open(chip, substream,
+			       params_channels(hw_params),
+			       params_period_size(hw_params));
 	if (err < 0) {
 		snd_printk(KERN_ERR LXP "failed to open hardware. "
 			   "Error code %d\n", err);
 		goto exit;
 	}
 
-	err = lx_hardware_start(chip, substream);
+	err = lx_hardware_start(chip, substream, hw_params);
 	if (err < 0) {
 		snd_printk(KERN_ERR LXP "failed to start hardware. "
 			   "Error code %d\n", err);
@@ -338,26 +358,6 @@ static int lx_pcm_prepare(struct snd_pcm_substream *substream)
 
 	chip->hardware_running[is_capture] = 1;
 
-	if (chip->board_sample_rate != substream->runtime->rate) {
-		if (!err)
-			chip->board_sample_rate = substream->runtime->rate;
-	}
-
-exit:
-	mutex_unlock(&chip->setup_mutex);
-	return err;
-}
-
-static int lx_pcm_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *hw_params, int is_capture)
-{
-	struct lx6464es *chip = snd_pcm_substream_chip(substream);
-	int err = 0;
-
-	snd_printdd("->lx_pcm_hw_params\n");
-
-	mutex_lock(&chip->setup_mutex);
-
 	/* set dma buffer */
 	err = snd_pcm_lib_malloc_pages(substream,
 				       params_buffer_bytes(hw_params));
@@ -367,6 +367,7 @@ static int lx_pcm_hw_params(struct snd_pcm_substream *substream,
 	else
 		chip->playback_stream.stream = substream;
 
+exit:
 	mutex_unlock(&chip->setup_mutex);
 	return err;
 }
@@ -389,7 +390,7 @@ static int lx_pcm_hw_free(struct snd_pcm_substream *substream)
 	int err = 0;
 	int is_capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 
-	snd_printdd("->lx_pcm_hw_free\n");
+	snd_printd("->lx_pcm_hw_free\n");
 	mutex_lock(&chip->setup_mutex);
 
 	if (chip->hardware_running[is_capture]) {
@@ -477,7 +478,7 @@ static void lx_trigger_stop(struct lx6464es *chip, struct lx_stream *lx_stream)
 	int err;
 
 	snd_printd(LXP "stopping: stopping stream\n");
-	err = lx_stream_stop(chip, 0, is_capture);
+	err = lx_stream_pause(chip, 0, is_capture);
 	if (err < 0)
 		snd_printk(KERN_ERR LXP "couldn't stop stream\n");
 	else
@@ -1005,6 +1006,7 @@ static int __devinit snd_lx6464es_create(struct snd_card *card,
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
+	chip->hardware_running[0] = chip->hardware_running[1] = 0;
 
 	/* initialize synchronization structs */
 	spin_lock_init(&chip->lock);
diff --git a/sound/pci/lx6464es/lx6464es.h b/sound/pci/lx6464es/lx6464es.h
index aea621e..2a97a21 100644
--- a/sound/pci/lx6464es/lx6464es.h
+++ b/sound/pci/lx6464es/lx6464es.h
@@ -30,6 +30,7 @@
 
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 
 #include "lx_core.h"
 
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 617f98b..3a9e1dd 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -353,8 +353,11 @@ polling_successful:
 			lx_dsp_reg_readbuf(chip, eReg_CRM2, rmh->stat,
 					   rmh->stat_len);
 		}
-	} else
+		lx_message_dump(rmh);
+	} else {
 		snd_printk(LXP "rmh error: %08x\n", reg);
+		dump_stack();
+	}
 
 	/* clear Reg_CSM_MR */
 	lx_dsp_reg_write(chip, eReg_CSM, 0);
@@ -362,15 +365,11 @@ polling_successful:
 	switch (reg) {
 	case ED_DSP_TIMED_OUT:
 		snd_printk(KERN_WARNING LXP "lx_message_send: dsp timeout\n");
-		return -ETIMEDOUT;
 
 	case ED_DSP_CRASHED:
 		snd_printk(KERN_WARNING LXP "lx_message_send: dsp crashed\n");
-		return -EAGAIN;
 	}
 
-	lx_message_dump(rmh);
-
 	return reg;
 }
 
@@ -532,10 +531,22 @@ int lx_pipe_allocate(struct lx6464es *chip, u32 pipe, int is_capture,
 	err = lx_message_send_atomic(chip, &chip->rmh);
 	spin_unlock_irqrestore(&chip->msg_lock, flags);
 
-	if (err != 0)
-		snd_printk(KERN_ERR "lx6464es: could not allocate pipe\n");
+	if (err == 0)
+		return 0;
 
-	return err;
+	switch (err) {
+	case EB_ALLOCATE_AUDIO_IMPOSSIBLE:
+		snd_printk(KERN_ERR "lx6464es: could not allocate pipe "
+			   "(EB_ALLOCATE_AUDIO_IMPOSSIBLE)\n");
+		break;
+
+	case EB_INVALID_AUDIO:
+		snd_printk(KERN_ERR "lx6464es: could not allocate pipe "
+			   "(EB_INVALID_AUDIO)\n");
+		break;
+	}
+
+	return -1;
 }
 
 int lx_pipe_release(struct lx6464es *chip, u32 pipe, int is_capture)
@@ -781,7 +792,8 @@ int lx_stream_set_state(struct lx6464es *chip, u32 pipe,
 	return err;
 }
 
-int lx_stream_set_format(struct lx6464es *chip, struct snd_pcm_runtime *runtime,
+int lx_stream_set_format(struct lx6464es *chip,
+			 struct snd_pcm_hw_params *params,
 			 u32 pipe, int is_capture)
 {
 	int err;
@@ -789,22 +801,19 @@ int lx_stream_set_format(struct lx6464es *chip, struct snd_pcm_runtime *runtime,
 
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	u32 channels = runtime->channels;
-
-	if (runtime->channels != channels)
-		snd_printk(KERN_ERR LXP "channel count mismatch: %d vs %d",
-			   runtime->channels, channels);
+	const u32 channels = params_channels(params);
+	const snd_pcm_format_t format = params_format(params);
 
 	spin_lock_irqsave(&chip->msg_lock, flags);
 	lx_message_init(&chip->rmh, CMD_0C_DEF_STREAM);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
 
-	if (runtime->sample_bits == 16)
+	if (snd_pcm_format_width(format) == 16)
 		/* 16 bit format */
 		chip->rmh.cmd[0] |= (STREAM_FMT_16b << STREAM_FMT_OFFSET);
 
-	if (snd_pcm_format_little_endian(runtime->format))
+	if (snd_pcm_format_little_endian(format))
 		/* little endian/intel format */
 		chip->rmh.cmd[0] |= (STREAM_FMT_intel << STREAM_FMT_OFFSET);
 
@@ -974,7 +983,7 @@ int lx_level_unmute(struct lx6464es *chip, int is_capture, int unmute)
 	chip->rmh.cmd[1] = (u32)(mute_mask >> (u64)32);	       /* hi part */
 	chip->rmh.cmd[2] = (u32)(mute_mask & (u64)0xFFFFFFFF); /* lo part */
 
-	snd_printk("mute %x %x %x\n", chip->rmh.cmd[0], chip->rmh.cmd[1],
+	snd_printd("mute %x %x %x\n", chip->rmh.cmd[0], chip->rmh.cmd[1],
 		   chip->rmh.cmd[2]);
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
diff --git a/sound/pci/lx6464es/lx_core.h b/sound/pci/lx6464es/lx_core.h
index 6bd9cbb..378721a 100644
--- a/sound/pci/lx6464es/lx_core.h
+++ b/sound/pci/lx6464es/lx_core.h
@@ -134,7 +134,8 @@ int lx_pipe_wait_for_start(struct lx6464es *chip, u32 pipe, int is_capture);
 int lx_pipe_wait_for_idle(struct lx6464es *chip, u32 pipe, int is_capture);
 
 /* low-level stream handling */
-int lx_stream_set_format(struct lx6464es *chip, struct snd_pcm_runtime *runtime,
+int lx_stream_set_format(struct lx6464es *chip,
+			 struct snd_pcm_hw_params *runtime,
 			 u32 pipe, int is_capture);
 int lx_stream_state(struct lx6464es *chip, u32 pipe, int is_capture,
 		    int *rstate);
-- 
1.7.4.1
