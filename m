From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio - trivial patch
Date: Mon, 9 Jan 2006 22:33:30 +0000
Message-ID: <20060109223330.6f256823.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


This patch uses more consistent names for struct audiopipe and it splits
a few exagerately long lines.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__orig/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver__orig/pci/echoaudio/echoaudio.c	2006-01-09 19:55:53.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio.c	2006-01-09 22:14:07.000000000 +0000
@@ -30,7 +30,6 @@ static unsigned int channels_list[10] = 
 
 
 
-
 static int get_firmware(const struct firmware **fw_entry, const struct firmware *frm, struct echoaudio *chip)
 {
 	int err;
@@ -54,13 +53,13 @@ static void free_firmware(const struct f
 *** PCM interface
 ***************************************************************************************************/
 
-static void ssdata_free(struct snd_pcm_runtime *runtime)
+static void audiopipe_free(struct snd_pcm_runtime *runtime)
 {
-	struct audiopipe *ssdata = runtime->private_data;
+	struct audiopipe *pipe = runtime->private_data;
 
-	if (ssdata->sgpage.area)
-		snd_dma_free_pages(&ssdata->sgpage);
-	kfree(ssdata);
+	if (pipe->sgpage.area)
+		snd_dma_free_pages(&pipe->sgpage);
+	kfree(pipe);
 }
 
 
@@ -215,7 +214,7 @@ static int pcm_open(struct snd_pcm_subst
 {
 	struct echoaudio *chip;
 	struct snd_pcm_runtime *runtime;
-	struct audiopipe *ssdata;
+	struct audiopipe *pipe;
 	int err, i;
 
 	if (max_channels <= 0)
@@ -231,32 +230,32 @@ static int pcm_open(struct snd_pcm_subst
 	chip = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
 
-	if (!(ssdata = kmalloc(sizeof(struct audiopipe), GFP_KERNEL)))
+	if (!(pipe = kmalloc(sizeof(struct audiopipe), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(ssdata, 0, sizeof(struct audiopipe));
-	ssdata->pipe_index = -1;		/* Not configured yet */
+	memset(pipe, 0, sizeof(struct audiopipe));
+	pipe->index = -1;		/* Not configured yet */
 
 	/* Set up hw capabilities and contraints */
-	memcpy(&ssdata->hw, &pcm_hardware_skel, sizeof(struct snd_pcm_hardware));
+	memcpy(&pipe->hw, &pcm_hardware_skel, sizeof(struct snd_pcm_hardware));
 	DE_HWP(("max_channels=%d\n", max_channels));
-	ssdata->constr.list = channels_list;
-	ssdata->constr.mask = 0;
+	pipe->constr.list = channels_list;
+	pipe->constr.mask = 0;
 	for (i = 0; channels_list[i] <= max_channels; i++);
-	ssdata->constr.count = i;
-	if (ssdata->hw.channels_max > max_channels)
-		ssdata->hw.channels_max = max_channels;
+	pipe->constr.count = i;
+	if (pipe->hw.channels_max > max_channels)
+		pipe->hw.channels_max = max_channels;
 	if (adat) {
-		ssdata->hw.rate_max = 48000;
-		ssdata->hw.rates &= SNDRV_PCM_RATE_8000_48000;
+		pipe->hw.rate_max = 48000;
+		pipe->hw.rates &= SNDRV_PCM_RATE_8000_48000;
 	}
 
-	runtime->hw = ssdata->hw;
-	runtime->private_data = ssdata;
-	runtime->private_free = ssdata_free;
+	runtime->hw = pipe->hw;
+	runtime->private_data = pipe;
+	runtime->private_free = audiopipe_free;
 	snd_pcm_set_sync(substream);
 
 	/* Only mono and any even number of channels are allowed */
-	if ((err = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, &ssdata->constr)) < 0)
+	if ((err = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, &pipe->constr)) < 0)
 		return err;
 
 	/* All periods should have the same size */
@@ -277,7 +276,7 @@ static int pcm_open(struct snd_pcm_subst
 
 	/* Finally allocate a page for the scatter-gather list */
 	if ((err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(chip->pci),
-					PAGE_SIZE, &ssdata->sgpage)) < 0) {
+					PAGE_SIZE, &pipe->sgpage)) < 0) {
 		DE_HWP(("s-g list allocation failed\n"));
 		return err;
 	}
@@ -431,7 +430,7 @@ static int pcm_close(struct snd_pcm_subs
 	struct echoaudio *chip = snd_pcm_substream_chip(substream);
 	int oc;
 
-	/* Nothing to do here. Audio is already off and ssdata will be freed by its callback */
+	/* Nothing to do here. Audio is already off and pipe will be freed by its callback */
 	DE_ACT(("pcm_close\n"));
 
 	atomic_dec(&chip->opencount);
@@ -455,21 +454,21 @@ static int init_engine(struct snd_pcm_su
 	struct echoaudio *chip;
 	int err, per, rest, page, edge, offs;
 	struct snd_sg_buf *sgbuf;
-	struct audiopipe *ssdata;
+	struct audiopipe *pipe;
 
 	chip = snd_pcm_substream_chip(substream);
-	ssdata = (struct audiopipe *) substream->runtime->private_data;
+	pipe = (struct audiopipe *) substream->runtime->private_data;
 
 	/* Sets up che hardware. If it's already initialized, reset and redo with the new parameters */
 	spin_lock_irq(&chip->lock);
-	if (ssdata->pipe_index >= 0) {
-		DE_HWP(("hwp_ie free(%d)\n", ssdata->pipe_index));
-		err = free_pipes(chip, ssdata);
+	if (pipe->index >= 0) {
+		DE_HWP(("hwp_ie free(%d)\n", pipe->index));
+		err = free_pipes(chip, pipe);
 		snd_assert(!err);
-		chip->substream[ssdata->pipe_index] = NULL;
+		chip->substream[pipe->index] = NULL;
 	}
 
-	err = allocate_pipes(chip, ssdata, pipe_index, interleave);
+	err = allocate_pipes(chip, pipe, pipe_index, interleave);
 	if (err < 0) {
 		spin_unlock_irq(&chip->lock);
 		DE_ACT((KERN_NOTICE "allocate_pipes(%d) err=%d\n", pipe_index, err));
@@ -484,16 +483,16 @@ static int init_engine(struct snd_pcm_su
 	if (err < 0) {
 		snd_printk(KERN_ERR "malloc_pages err=%d\n", err);
 		spin_lock_irq(&chip->lock);
-		free_pipes(chip, ssdata);
+		free_pipes(chip, pipe);
 		spin_unlock_irq(&chip->lock);
-		ssdata->pipe_index = -1;
+		pipe->index = -1;
 		return err;
 	}
 
 	sgbuf = snd_pcm_substream_sgbuf(substream);
 
 	DE_HWP(("pcm_hw_params table size=%d pages=%d\n", sgbuf->size, sgbuf->pages));
-	sglist_init(chip, ssdata);
+	sglist_init(chip, pipe);
 	edge = PAGE_SIZE;
 	for (offs = page = per = 0; offs < params_buffer_bytes(hw_params); per++) {
 		rest = params_period_bytes(hw_params);
@@ -501,12 +500,12 @@ static int init_engine(struct snd_pcm_su
 			rest = params_buffer_bytes(hw_params) - offs;
 		while (rest) {
 			if (rest <= edge - offs) {
-				sglist_add_mapping(chip, ssdata, snd_sgbuf_get_addr(sgbuf, offs), rest);
-				sglist_add_irq(chip, ssdata);
+				sglist_add_mapping(chip, pipe, snd_sgbuf_get_addr(sgbuf, offs), rest);
+				sglist_add_irq(chip, pipe);
 				offs += rest;
 				rest = 0;
 			} else {
-				sglist_add_mapping(chip, ssdata, snd_sgbuf_get_addr(sgbuf, offs), edge - offs);
+				sglist_add_mapping(chip, pipe, snd_sgbuf_get_addr(sgbuf, offs), edge - offs);
 				rest -= edge - offs;
 				offs = edge;
 			}
@@ -518,12 +517,12 @@ static int init_engine(struct snd_pcm_su
 	}
 
 	/* Close the ring buffer */
-	sglist_wrap(chip, ssdata);
+	sglist_wrap(chip, pipe);
 
 	/* This stuff is used by the irq handler, so it must be initialized before chip->substream */
 	chip->last_period[pipe_index] = 0;
-	ssdata->last_counter = 0;
-	ssdata->position = 0;
+	pipe->last_counter = 0;
+	pipe->position = 0;
 	smp_wmb();
 	chip->substream[pipe_index] = substream;
 	chip->rate_set = 1;
@@ -582,17 +581,17 @@ static int pcm_digital_out_hw_params(str
 static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct echoaudio *chip;
-	struct audiopipe *ssdata;
+	struct audiopipe *pipe;
 
 	chip = snd_pcm_substream_chip(substream);
-	ssdata = (struct audiopipe *) substream->runtime->private_data;
+	pipe = (struct audiopipe *) substream->runtime->private_data;
 
 	spin_lock_irq(&chip->lock);
-	if (ssdata->pipe_index >= 0) {
-		DE_HWP(("pcm_hw_free(%d)\n", ssdata->pipe_index));
-		free_pipes(chip, ssdata);
-		chip->substream[ssdata->pipe_index] = NULL;
-		ssdata->pipe_index = -1;
+	if (pipe->index >= 0) {
+		DE_HWP(("pcm_hw_free(%d)\n", pipe->index));
+		free_pipes(chip, pipe);
+		chip->substream[pipe->index] = NULL;
+		pipe->index = -1;
 	}
 	spin_unlock_irq(&chip->lock);
 
@@ -608,7 +607,7 @@ static int pcm_prepare(struct snd_pcm_su
 	struct echoaudio *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audioformat format;
-	int pipe_index = ((struct audiopipe *)runtime->private_data)->pipe_index;
+	int pipe_index = ((struct audiopipe *)runtime->private_data)->index;
 
 	DE_HWP(("Prepare rate=%d format=%d channels=%d\n", runtime->rate, runtime->format, runtime->channels));
 	format.interleave = runtime->channels;
@@ -646,7 +645,7 @@ static int pcm_trigger(struct snd_pcm_su
 {
 	struct echoaudio *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct audiopipe *ssdata = runtime->private_data;
+	struct audiopipe *pipe = runtime->private_data;
 	int i, err;
 	u32 channelmask = 0;
 	struct list_head *pos;
@@ -669,15 +668,15 @@ static int pcm_trigger(struct snd_pcm_su
 		DE_ACT(("pcm_trigger start\n"));
 		for (i = 0; i < DSP_MAXPIPES; i++) {
 			if (channelmask & (1 << i)) {
-				ssdata = chip->substream[i]->runtime->private_data;
-				switch (ssdata->state) {
+				pipe = chip->substream[i]->runtime->private_data;
+				switch (pipe->state) {
 				case PIPE_STATE_STOPPED:
 					chip->last_period[i] = 0;
-					ssdata->last_counter = 0;
-					ssdata->position = 0;
-					*ssdata->dma_counter = 0;
+					pipe->last_counter = 0;
+					pipe->position = 0;
+					*pipe->dma_counter = 0;
 				case PIPE_STATE_PAUSED:
-					ssdata->state = PIPE_STATE_STARTED;
+					pipe->state = PIPE_STATE_STARTED;
 					break;
 				case PIPE_STATE_STARTED:
 					break;
@@ -690,8 +689,8 @@ static int pcm_trigger(struct snd_pcm_su
 		DE_ACT(("pcm_trigger stop\n"));
 		for (i = 0; i < DSP_MAXPIPES; i++) {
 			if (channelmask & (1 << i)) {
-				ssdata = chip->substream[i]->runtime->private_data;
-				ssdata->state = PIPE_STATE_STOPPED;
+				pipe = chip->substream[i]->runtime->private_data;
+				pipe->state = PIPE_STATE_STOPPED;
 			}
 		}
 		err = stop_transport(chip, channelmask);
@@ -700,8 +699,8 @@ static int pcm_trigger(struct snd_pcm_su
 		DE_ACT(("pcm_trigger pause\n"));
 		for (i = 0; i < DSP_MAXPIPES; i++) {
 			if (channelmask & (1 << i)) {
-				ssdata = chip->substream[i]->runtime->private_data;
-				ssdata->state = PIPE_STATE_PAUSED;
+				pipe = chip->substream[i]->runtime->private_data;
+				pipe->state = PIPE_STATE_PAUSED;
 			}
 		}
 		err = pause_transport(chip, channelmask);
@@ -718,17 +717,17 @@ static int pcm_trigger(struct snd_pcm_su
 static snd_pcm_uframes_t pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct audiopipe *ssdata = runtime->private_data;
+	struct audiopipe *pipe = runtime->private_data;
 	size_t cnt, bufsize, pos;
 
-	cnt = le32_to_cpu(*ssdata->dma_counter);
-	ssdata->position += cnt - ssdata->last_counter;
-	ssdata->last_counter = cnt;
+	cnt = le32_to_cpu(*pipe->dma_counter);
+	pipe->position += cnt - pipe->last_counter;
+	pipe->last_counter = cnt;
 	bufsize = substream->runtime->buffer_size;
-	pos = bytes_to_frames(substream->runtime, ssdata->position);
+	pos = bytes_to_frames(substream->runtime, pipe->position);
 
 	while (pos >= bufsize) {
-		ssdata->position -= frames_to_bytes(substream->runtime, bufsize);
+		pipe->position -= frames_to_bytes(substream->runtime, bufsize);
 		pos -= bufsize;
 	}
 	return pos;
@@ -789,16 +788,18 @@ static struct snd_pcm_ops digital_captur
 
 
 /* Preallocate memory only for the first substream because it's the most used one */
-static int snd_echo_preallocate_pages(struct snd_pcm *pcm, struct device *data)
+static int snd_echo_preallocate_pages(struct snd_pcm *pcm, struct device *dev)
 {
-	struct snd_pcm_substream *substream;
+	struct snd_pcm_substream *ss;
 	int stream, err;
 
 	for (stream = 0; stream < 2; stream++)
-		for (substream = pcm->streams[stream].substream; substream; substream = substream->next)
-			if ((err = snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV_SG, data,
-							!substream->number ? 128<<10 : 0, 256<<10)) < 0)
+		for (ss = pcm->streams[stream].substream; ss; ss = ss->next) {
+			err = snd_pcm_lib_preallocate_pages(ss, SNDRV_DMA_TYPE_DEV_SG, dev,
+							ss->number ? 0 : 128<<10, 256<<10);
+			if (err < 0)
 				return err;
+		}
 	return 0;
 }
 
@@ -1277,7 +1278,8 @@ static int snd_echo_digital_mode_info(st
 	uinfo->count = 1;
 	if (uinfo->value.enumerated.item >= chip->num_digital_modes)
 		uinfo->value.enumerated.item = chip->num_digital_modes - 1;
-	strcpy(uinfo->value.enumerated.name, names[chip->digital_mode_list[uinfo->value.enumerated.item]]);
+	strcpy(uinfo->value.enumerated.name, names[
+			chip->digital_mode_list[uinfo->value.enumerated.item]]);
 	return 0;
 }
 
@@ -1415,7 +1417,8 @@ static int snd_echo_clock_source_info(st
 	uinfo->count = 1;
 	if (uinfo->value.enumerated.item >= chip->num_clock_sources)
 		uinfo->value.enumerated.item = chip->num_clock_sources - 1;
-	strcpy(uinfo->value.enumerated.name, names[chip->clock_source_list[uinfo->value.enumerated.item]]);
+	strcpy(uinfo->value.enumerated.name, names[
+			chip->clock_source_list[uinfo->value.enumerated.item]]);
 	return 0;
 }
 
@@ -1826,7 +1829,8 @@ static __devinit int snd_echo_create(str
 	}
 	chip->dsp_registers = (volatile u32 __iomem *)ioremap_nocache(chip->dsp_registers_phys, sz);
 
-	if (request_irq(pci->irq, snd_echo_interrupt, SA_INTERRUPT | SA_SHIRQ, ECHOCARD_NAME, (void *)chip)) {
+	if (request_irq(pci->irq, snd_echo_interrupt, SA_INTERRUPT | SA_SHIRQ,
+						ECHOCARD_NAME, (void *)chip)) {
 		snd_echo_free(chip);
 		snd_printk(KERN_ERR "cannot grab irq\n");
 		return -EBUSY;
diff -dup alsa-driver__orig/pci/echoaudio/echoaudio.h alsa-driver/pci/echoaudio/echoaudio.h
--- alsa-driver__orig/pci/echoaudio/echoaudio.h	2006-01-09 19:55:53.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio.h	2006-01-09 22:14:51.000000000 +0000
@@ -323,7 +323,7 @@ struct audiopipe {
 	volatile u32 *dma_counter;	/* Commpage register that contains the current dma position (lower 32 bits only) */
 	u32 last_counter;		/* The last position, which is used to compute... */
 	u32 position;			/* ...the number of bytes tranferred by the DMA engine, modulo the buffer size */
-	short pipe_index;		/* Index of the first channel or <0 if hw is not configured yet */
+	short index;			/* Index of the first channel or <0 if hw is not configured yet */
 	short interleave;
 	struct snd_dma_buffer sgpage;	/* Room for the scatter-gather list */
 	struct snd_pcm_hardware hw;
diff -dup alsa-driver__orig/pci/echoaudio/echoaudio_dsp.c alsa-driver/pci/echoaudio/echoaudio_dsp.c
--- alsa-driver__orig/pci/echoaudio/echoaudio_dsp.c	2006-01-09 19:55:53.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio_dsp.c	2006-01-09 22:16:02.000000000 +0000
@@ -1137,7 +1137,7 @@ static int allocate_pipes(struct echoaud
 	chip->pipe_alloc_mask |= channel_mask;
 	if (is_cyclic)
 		chip->pipe_cyclic_mask |= channel_mask;
-	pipe->pipe_index = pipe_index;
+	pipe->index = pipe_index;
 	pipe->interleave = interleave;
 	pipe->state = PIPE_STATE_STOPPED;
 
@@ -1163,12 +1163,12 @@ static int free_pipes(struct echoaudio *
 	u32 channel_mask;
 	int i;
 
-	DE_ACT(("free_pipes: Pipe %d\n", pipe->pipe_index));
-	snd_assert(is_pipe_allocated(chip, pipe->pipe_index), return -EINVAL);
+	DE_ACT(("free_pipes: Pipe %d\n", pipe->index));
+	snd_assert(is_pipe_allocated(chip, pipe->index), return -EINVAL);
 
 	/* Compute channel mask for this substream */
 	for (channel_mask = i = 0; i < pipe->interleave; i++)
-		channel_mask |= 1 << (pipe->pipe_index + i);
+		channel_mask |= 1 << (pipe->index + i);
 
 	/* Audio should be already stopped here */
 	snd_assert(pipe->state == PIPE_STATE_STOPPED, return -EINVAL);
@@ -1190,7 +1190,7 @@ static int sglist_init(struct echoaudio 
 {
 	pipe->sglist_head = 0;
 	memset(pipe->sgpage.area, 0, PAGE_SIZE);
-	chip->comm_page->sglist_addr[pipe->pipe_index].addr = cpu_to_le32(pipe->sgpage.addr);
+	chip->comm_page->sglist_addr[pipe->index].addr = cpu_to_le32(pipe->sgpage.addr);
 	return 0;
 }
 



--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
