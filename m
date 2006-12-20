From: Ahmet =?utf-8?B?xLBuYW4=?= <ainan@mathematik.uni-freiburg.de>
Subject: [PATCH] make snd-aloop loopback device work
Date: Wed, 20 Dec 2006 23:58:11 +0100
Message-ID: <20061220225811.GB705@mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ive merged the previously mentioned 2 working implementations into one fi=
le
and made them switchable thru preprocessor directives.
the secure one is the default.

its now fullduplex, this means:

aplay -D hw:0,0 lala.wav
ecasound -i:alsahw,0,1,0

works exactly the same like:

aplay -D hw:0,1 lala.wav
ecasound -i:alsahw,0,0,0

it would be nice if it could be included in the tree, so that other ppl c=
an
test this and yell at me when something is wrong.

still need to workout this pcm_jiffies problem, but when its done then i =
will
also provide an patch for dummy.c, couse it suffers the same problem on
HZ > 100 kernels.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary: make snd-aloop loopback device work

the snd-aloop device is a full-duplex loopback device, that can
be used to connect 2 apps together, so that each apps output
gets the input of the other app.

the first app forces the second app to use its settings, so
no rate, format or channel number conversion is done.

examples (hw:0 is loopback, !default is real soundcard / dmix):

capture output from other apps to hdd:
aplay -D hw:0,0 play.wav
arecord -D hw:0,1 record.wav

the same:
aplay -D hw:0,1 play.wav
arecord -D hw:0,0 record.wav

or have more fun:
ecasound -f:16,2,48000 -i:alsahw,0,1,0 &
ecasound -f:16,2,48000 -i:alsahw,0,1,1 &
ecasound -f:16,2,48000 -i:alsahw,0,1,2 &
...
now open up to 8 oss apps _without_ aoss, sit back and relax.

Signed-off-by: Ahmet =C4=B0nan <ainan <at> mathematik.uni-freiburg.de>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

files:
http://www.mathematik.uni-freiburg.de/IAM/homepages/ainan/alsa-driver-1.0=
.13-aloop-ainan-patch.diff
http://www.mathematik.uni-freiburg.de/IAM/homepages/ainan/aloop-kernel.c

ahmet


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="alsa-driver-1.0.13-aloop-ainan-patch.diff"

--- alsa-driver-1.0.13.orig/drivers/aloop-kernel.c	2006-09-29 13:40:29.000000000 +0200
+++ alsa-driver-1.0.13/drivers/aloop-kernel.c	2006-12-20 21:54:55.438121716 +0100
@@ -30,19 +30,24 @@
 #include <sound/pcm.h>
 #include <sound/initval.h>
 
+/* comment out for experimental non-memcpy code */
+#define SND_CARD_LOOPBACK_COPY_RINGBUFFER
+/* comment in to trash your kernel logfiles */
+/* #define SND_CARD_LOOPBACK_VERBOSE */
+
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("A loopback soundcard");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ALSA,Loopback soundcard}}");
 
-#define MAX_PCM_SUBSTREAMS	256
+#define MAX_PCM_SUBSTREAMS	8
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 0};
 static int pcm_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 static int pcm_substreams[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 8};
-//static int midi_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2};
+/* static int midi_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2}; */
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for loopback soundcard.");
@@ -53,12 +58,26 @@
 module_param_array(pcm_devs, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_devs, "PCM devices # (0-4) for loopback driver.");
 module_param_array(pcm_substreams, int, NULL, 0444);
-MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-16) for loopback driver.");
-//module_param_array(midi_devs, int, NULL, 0444);
-//MODULE_PARM_DESC(midi_devs, "MIDI devices # (0-2) for loopback driver.");
+MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-8) for loopback driver.");
+/* module_param_array(midi_devs, int, NULL, 0444);
+ * MODULE_PARM_DESC(midi_devs, "MIDI devices # (0-2) for loopback driver."); */
+
+typedef struct snd_card_loopback_cable {
+	struct snd_pcm_substream *playback;
+	struct snd_pcm_substream *capture;
+	struct snd_pcm_hardware hw;
+	int playback_valid;
+	int capture_valid;
+	int playback_running;
+	int capture_running;
+	int playback_busy;
+	int capture_busy;
+	unsigned int pcm_buf_pos;
+} snd_card_loopback_cable_t;
 
 typedef struct snd_card_loopback {
 	struct snd_card *card;
+	struct snd_card_loopback_cable cables[MAX_PCM_SUBSTREAMS][2];
 } snd_card_loopback_t;
 
 typedef struct snd_card_loopback_pcm {
@@ -72,12 +91,57 @@
 	unsigned int pcm_irq_pos;	/* IRQ position */
 	unsigned int pcm_buf_pos;	/* position in buffer */
 	struct snd_pcm_substream *substream;
+	struct snd_card_loopback_cable *cable;
 } snd_card_loopback_pcm_t;
 
 static struct snd_card *snd_loopback_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
+#ifdef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+static void ringbuffer_copy(
+		unsigned char *dst, size_t dst_pos, size_t dst_size,
+		unsigned char *src, size_t src_pos, size_t src_size,
+		size_t bytes)
+{
+	size_t moon, star;
+	size_t dst_pos_bytes, src_pos_bytes;
+
+	dst_pos_bytes = dst_pos + bytes;
+	src_pos_bytes = src_pos + bytes;
+	if (dst_pos_bytes <= dst_size) {
+		if (src_pos_bytes <= src_size) {
+			memcpy(dst + dst_pos, src + src_pos, bytes);
+		} else {
+			moon = src_size - src_pos;
+			memcpy(dst + dst_pos, src + src_pos, moon);
+			memcpy(dst + dst_pos + moon, src, bytes - moon);
+		}
+		return;
+	}
+
+	if (src_pos_bytes <= src_size) {
+		star = dst_size - dst_pos;
+		memcpy(dst + dst_pos, src + src_pos, star);
+		memcpy(dst, src + src_pos + star, bytes - star);
+		return;
+	}
 
-static void snd_card_loopback_pcm_timer_start(struct snd_pcm_substream *substream)
+	moon = dst_size - dst_pos;
+	star = src_size - src_pos;
+	if (moon < star) {
+		star -= moon;
+		memcpy(dst + dst_pos, src + src_pos, moon);
+		memcpy(dst, src + src_pos + moon, star);
+		memcpy(dst + star, src, src_pos_bytes - src_size);
+	} else {
+		moon -= star;
+		memcpy(dst + dst_pos, src + src_pos, star);
+		memcpy(dst + dst_pos + star, src, moon);
+		memcpy(dst, src + moon, dst_pos_bytes - dst_size);
+	}
+}
+#endif /* #ifdef SND_CARD_LOOPBACK_COPY_RINGBUFFER */
+
+static void snd_card_loopback_timer_start(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
@@ -86,7 +150,7 @@
 	add_timer(&dpcm->timer);
 }
 
-static void snd_card_loopback_pcm_timer_stop(struct snd_pcm_substream *substream)
+static void snd_card_loopback_timer_stop(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
@@ -97,10 +161,32 @@
 static int snd_card_loopback_playback_trigger(struct snd_pcm_substream *substream,
 					   int cmd)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
-		snd_card_loopback_pcm_timer_start(substream);
+#ifndef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+		/* put playback pos one period ahead capture pos */
+		dpcm->pcm_buf_pos = (dpcm->cable->pcm_buf_pos +
+			dpcm->pcm_count) % dpcm->pcm_size;
+		dpcm->pcm_irq_pos = 0;
+#endif
+		dpcm->cable->playback_running = 1;
+		snd_card_loopback_timer_start(substream);
 	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
-		snd_card_loopback_pcm_timer_stop(substream);
+		dpcm->cable->playback_running = 0;
+		snd_card_loopback_timer_stop(substream);
+#ifndef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+		snd_pcm_format_set_silence(runtime->format, runtime->dma_area,
+				bytes_to_samples(runtime, runtime->dma_bytes));
+#else
+		if (dpcm->cable->capture_valid) {
+		snd_pcm_format_set_silence(dpcm->cable->capture->runtime->format,
+				dpcm->cable->capture->runtime->dma_area,
+				bytes_to_samples(dpcm->cable->capture->runtime,
+					dpcm->cable->capture->runtime->dma_bytes));
+		}
+#endif
+
 	} else {
 		return -EINVAL;
 	}
@@ -110,20 +196,31 @@
 static int snd_card_loopback_capture_trigger(struct snd_pcm_substream *substream,
 					  int cmd)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
-		snd_card_loopback_pcm_timer_start(substream);
+#ifndef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+		/* put capture pos one period behind playback pos */
+		dpcm->pcm_buf_pos = (dpcm->cable->pcm_buf_pos +
+			(dpcm->pcm_size - dpcm->pcm_count)) % dpcm->pcm_size;
+		dpcm->pcm_irq_pos = 0;
+#endif
+		dpcm->cable->capture_running = 1;
+		snd_card_loopback_timer_start(substream);
 	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
-		snd_card_loopback_pcm_timer_stop(substream);
+		dpcm->cable->capture_running = 0;
+		snd_card_loopback_timer_stop(substream);
 	} else {
 		return -EINVAL;
 	}
 	return 0;
 }
 
-static int snd_card_loopback_pcm_prepare(struct snd_pcm_substream *substream)
+static int snd_card_loopback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
+	snd_card_loopback_cable_t *cable = dpcm->cable;
 	unsigned int bps;
 
 	bps = runtime->rate * runtime->channels;
@@ -133,24 +230,44 @@
 		return -EINVAL;
 	dpcm->pcm_bps = bps;
 	dpcm->pcm_jiffie = bps / HZ;
-	dpcm->pcm_size = snd_pcm_lib_buffer_bytes(substream);
-	dpcm->pcm_count = snd_pcm_lib_period_bytes(substream);
+	dpcm->pcm_size = frames_to_bytes(runtime, runtime->buffer_size);
+	dpcm->pcm_count = frames_to_bytes(runtime, runtime->period_size);
 	dpcm->pcm_irq_pos = 0;
 	dpcm->pcm_buf_pos = 0;
-	return 0;
-}
+	cable->hw.formats = (1ULL << runtime->format);
+	cable->hw.rate_min = runtime->rate;
+	cable->hw.rate_max = runtime->rate;
+	cable->hw.channels_min = runtime->channels;
+	cable->hw.channels_max = runtime->channels;
+#ifndef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+	cable->hw.buffer_bytes_max = frames_to_bytes(runtime, runtime->buffer_size);
+	cable->hw.period_bytes_min = frames_to_bytes(runtime, runtime->period_size);
+	cable->hw.period_bytes_max = frames_to_bytes(runtime, runtime->period_size);
+	cable->hw.periods_min = runtime->periods;
+	cable->hw.periods_max = runtime->periods;
+#endif
 
-static int snd_card_loopback_playback_prepare(struct snd_pcm_substream *substream)
-{
-	return snd_card_loopback_pcm_prepare(substream);
-}
+	snd_pcm_format_set_silence(runtime->format, runtime->dma_area,
+			bytes_to_samples(runtime, runtime->dma_bytes));
 
-static int snd_card_loopback_capture_prepare(struct snd_pcm_substream *substream)
-{
-	return snd_card_loopback_pcm_prepare(substream);
+	if (SNDRV_PCM_STREAM_PLAYBACK == substream->stream)
+		cable->playback_valid = 1;
+	else
+		cable->capture_valid = 1;
+
+#ifdef SND_CARD_LOOPBACK_VERBOSE
+	printk(KERN_INFO "snd-aloop(%s): frq=%d chs=%d fmt=%d buf=%d per=%d pers=%d\n",
+			(SNDRV_PCM_STREAM_PLAYBACK == substream->stream ? "playback" : "capture"),
+			runtime->rate, runtime->channels,
+			snd_pcm_format_width(runtime->format),
+			frames_to_bytes(runtime, runtime->buffer_size),
+			frames_to_bytes(runtime, runtime->period_size),
+			runtime->periods);
+#endif
+	return 0;
 }
 
-static void snd_card_loopback_pcm_timer_function(unsigned long data)
+static void snd_card_loopback_timer_function(unsigned long data)
 {
 	snd_card_loopback_pcm_t *dpcm = (snd_card_loopback_pcm_t *)data;
 	
@@ -160,22 +277,51 @@
 	dpcm->pcm_irq_pos += dpcm->pcm_jiffie;
 	dpcm->pcm_buf_pos += dpcm->pcm_jiffie;
 	dpcm->pcm_buf_pos %= dpcm->pcm_size;
+#ifndef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+	dpcm->cable->pcm_buf_pos = dpcm->pcm_buf_pos;
+#endif
 	if (dpcm->pcm_irq_pos >= dpcm->pcm_count) {
 		dpcm->pcm_irq_pos %= dpcm->pcm_count;
+		spin_unlock_irq(&dpcm->lock);	
 		snd_pcm_period_elapsed(dpcm->substream);
+	} else {
+		spin_unlock_irq(&dpcm->lock);
 	}
-	spin_unlock_irq(&dpcm->lock);	
 }
 
-static snd_pcm_uframes_t snd_card_loopback_playback_pointer(struct snd_pcm_substream *substream)
+#ifdef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+static void snd_card_loopback_capture_timer_function(unsigned long data)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
+	snd_card_loopback_pcm_t *playback_dpcm;
+	snd_card_loopback_pcm_t *dpcm = (snd_card_loopback_pcm_t *)data;
+	
+	dpcm->timer.expires = 1 + jiffies;
+	add_timer(&dpcm->timer);
+	spin_lock_irq(&dpcm->lock);
 
-	return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
+	if (dpcm->cable->playback_running) {
+		playback_dpcm = dpcm->cable->playback->runtime->private_data;
+		ringbuffer_copy(dpcm->substream->runtime->dma_area,
+			dpcm->pcm_buf_pos, dpcm->pcm_size,
+			playback_dpcm->substream->runtime->dma_area,
+			playback_dpcm->pcm_buf_pos, playback_dpcm->pcm_size,
+			dpcm->pcm_jiffie);
+	}
+
+	dpcm->pcm_irq_pos += dpcm->pcm_jiffie;
+	dpcm->pcm_buf_pos += dpcm->pcm_jiffie;
+	dpcm->pcm_buf_pos %= dpcm->pcm_size;
+	if (dpcm->pcm_irq_pos >= dpcm->pcm_count) {
+		dpcm->pcm_irq_pos %= dpcm->pcm_count;
+		spin_unlock_irq(&dpcm->lock);	
+		snd_pcm_period_elapsed(dpcm->substream);
+	} else {
+		spin_unlock_irq(&dpcm->lock);	
+	}
 }
+#endif /* #ifdef SND_CARD_LOOPBACK_COPY_RINGBUFFER */
 
-static snd_pcm_uframes_t snd_card_loopback_capture_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t snd_card_loopback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
@@ -188,16 +334,16 @@
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE),
-	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_192000,
-	.rate_min =		5500,
+	.rates =		(SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_192000),
+	.rate_min =		8000,
 	.rate_max =		192000,
 	.channels_min =		1,
 	.channels_max =		32,
-	.buffer_bytes_max =	1024 * 1024,
-	.period_bytes_min =	32,
-	.period_bytes_max =	128 * 1024,
+	.buffer_bytes_max =	64 * 1024,
+	.period_bytes_min =	64,
+	.period_bytes_max =	64 * 1024,
 	.periods_min =		1,
-	.periods_max =		16,
+	.periods_max =		1024,
 	.fifo_size =		0,
 };
 
@@ -210,53 +356,142 @@
 static int snd_card_loopback_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *hw_params)
 {
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+#ifndef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
+#endif
+	if (0 > snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params)))
+		return -ENOMEM;
+#ifndef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+	/* TODO: no more stealing:
+	 * after letting alsa allocate and configure dma buffers,
+	 * we simply steal the others dma area and overwrite ours. */
+	if (SNDRV_PCM_STREAM_PLAYBACK == substream->stream) {
+		if (dpcm->cable->capture_valid)
+			snd_pcm_set_runtime_buffer(substream,
+				dpcm->cable->capture->runtime->dma_buffer_p);
+	} else {
+		if (dpcm->cable->playback_valid)
+			snd_pcm_set_runtime_buffer(substream,
+				dpcm->cable->playback->runtime->dma_buffer_p);
+	}
+#endif
+	return 0;
 }
 
 static int snd_card_loopback_hw_free(struct snd_pcm_substream *substream)
 {
+#ifndef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+	/* TODO: fix this memory leak:
+	 * we stole it and now we cant even bring it back .. damnit. */
+	return 0; /* snd_pcm_lib_free_pages(substream); */
+#else
 	return snd_pcm_lib_free_pages(substream);
+#endif
 }
 
-static int snd_card_loopback_pcm_open(struct snd_pcm_substream *substream)
+static int snd_card_loopback_open(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
+	int half;
+	struct snd_card_loopback *loopback;
 	snd_card_loopback_pcm_t *dpcm;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	loopback = (struct snd_card_loopback *)substream->private_data;
 
+	if (0 == substream->pcm->device) {
+		if (SNDRV_PCM_STREAM_PLAYBACK == substream->stream)
+			half = 1;
+		else
+			half = 0;
+	} else {
+		if (SNDRV_PCM_STREAM_PLAYBACK == substream->stream)
+			half = 0;
+		else
+			half = 1;
+	}
+	if (SNDRV_PCM_STREAM_PLAYBACK == substream->stream) {
+		if (loopback->cables[substream->number][half].playback_busy)
+			return -EBUSY;
+	} else {
+		if (loopback->cables[substream->number][half].capture_busy)
+			return -EBUSY;
+	}
 	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
 	if (dpcm == NULL)
 		return -ENOMEM;
 	init_timer(&dpcm->timer);
-	dpcm->timer.data = (unsigned long) dpcm;
-	dpcm->timer.function = snd_card_loopback_pcm_timer_function;
 	spin_lock_init(&dpcm->lock);
 	dpcm->substream = substream;
+	dpcm->timer.data = (unsigned long)dpcm;
+	dpcm->timer.function = snd_card_loopback_timer_function;
+	dpcm->cable = &loopback->cables[substream->number][half];
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_loopback_runtime_free;
 	runtime->hw = snd_card_loopback_info;
+
+	if (SNDRV_PCM_STREAM_PLAYBACK == substream->stream) {
+		dpcm->cable->playback = substream;
+		dpcm->cable->playback_valid = 0;
+		dpcm->cable->playback_running = 0;
+		dpcm->cable->playback_busy = 1;
+		if (dpcm->cable->capture_valid)
+			runtime->hw = dpcm->cable->hw;
+		else
+			dpcm->cable->hw = snd_card_loopback_info;
+	} else {
+#ifdef SND_CARD_LOOPBACK_COPY_RINGBUFFER
+		dpcm->timer.function = snd_card_loopback_capture_timer_function;
+#endif
+		dpcm->cable->capture = substream;
+		dpcm->cable->capture_valid = 0;
+		dpcm->cable->capture_running = 0;
+		dpcm->cable->capture_busy = 1;
+		if (dpcm->cable->playback_valid)
+			runtime->hw = dpcm->cable->hw;
+		else
+			dpcm->cable->hw = snd_card_loopback_info;
+	}
+	return 0;
+}
+
+static int snd_card_loopback_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
+	if (SNDRV_PCM_STREAM_PLAYBACK == substream->stream) {
+		dpcm->cable->playback_valid = 0;
+		dpcm->cable->playback_running = 0;
+		dpcm->cable->playback_busy = 0;
+		dpcm->cable->playback = NULL;
+	} else {
+		dpcm->cable->capture_valid = 0;
+		dpcm->cable->capture_running = 0;
+		dpcm->cable->capture_busy = 0;
+		dpcm->cable->capture = NULL;
+	}
 	return 0;
 }
 
 static struct snd_pcm_ops snd_card_loopback_playback_ops = {
-	.open =			snd_card_loopback_pcm_open,
-	.close =		NULL,
+	.open =			snd_card_loopback_open,
+	.close =		snd_card_loopback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
 	.hw_params =		snd_card_loopback_hw_params,
 	.hw_free =		snd_card_loopback_hw_free,
-	.prepare =		snd_card_loopback_playback_prepare,
+	.prepare =		snd_card_loopback_prepare,
 	.trigger =		snd_card_loopback_playback_trigger,
-	.pointer =		snd_card_loopback_playback_pointer,
+	.pointer =		snd_card_loopback_pointer,
 };
 
 static struct snd_pcm_ops snd_card_loopback_capture_ops = {
-	.open =			snd_card_loopback_pcm_open,
-	.close =		NULL,
+	.open =			snd_card_loopback_open,
+	.close =		snd_card_loopback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
 	.hw_params =		snd_card_loopback_hw_params,
 	.hw_free =		snd_card_loopback_hw_free,
-	.prepare =		snd_card_loopback_capture_prepare,
+	.prepare =		snd_card_loopback_prepare,
 	.trigger =		snd_card_loopback_capture_trigger,
-	.pointer =		snd_card_loopback_capture_pointer,
+	.pointer =		snd_card_loopback_pointer,
 };
 
 static int __init snd_card_loopback_pcm(snd_card_loopback_t *loopback, int device, int substreams)
@@ -264,22 +499,27 @@
 	struct snd_pcm *pcm;
 	int err;
 
-	if ((err = snd_pcm_new(loopback->card, "Loopback PCM", device, substreams, substreams, &pcm)) < 0)
-		return err;
-	if (device == 0)
+	if (0 == device) {
+		if ((err = snd_pcm_new(loopback->card, "Loopback PCM", device, substreams, substreams, &pcm)) < 0)
+			return err;
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_card_loopback_playback_ops);
-	else
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_card_loopback_capture_ops);
+	} else {
+		if ((err = snd_pcm_new(loopback->card, "Loopback PCM", device, substreams, substreams, &pcm)) < 0)
+			return err;
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_card_loopback_playback_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_card_loopback_capture_ops);
+	}
 	pcm->private_data = loopback;
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "Loopback PCM");
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-					      snd_dma_continuous_data(GFP_KERNEL),
-					      0, 64*1024);
+			snd_dma_continuous_data(GFP_KERNEL), 0, 64*1024);
+
 	return 0;
 }
 
-static int __init snd_card_loopback_new_mixer(snd_card_loopback_t * loopback)
+static int __init snd_card_loopback_new_mixer(snd_card_loopback_t *loopback)
 {
 	struct snd_card *card = loopback->card;
 
@@ -292,7 +532,7 @@
 {
 	struct snd_card *card;
 	struct snd_card_loopback *loopback;
-	int err;
+	int subdev, half, err;
 
 	if (!enable[dev])
 		return -ENODEV;
@@ -301,6 +541,21 @@
 	if (card == NULL)
 		return -ENOMEM;
 	loopback = (struct snd_card_loopback *)card->private_data;
+
+	for (subdev = 0; subdev < pcm_substreams[dev]; subdev++) {
+		for (half = 0; half < 2; half++) {
+			loopback->cables[subdev][half].playback = NULL;
+			loopback->cables[subdev][half].capture = NULL;
+			loopback->cables[subdev][half].playback_valid = 0;
+			loopback->cables[subdev][half].capture_valid = 0;
+			loopback->cables[subdev][half].playback_running = 0;
+			loopback->cables[subdev][half].capture_running = 0;
+			loopback->cables[subdev][half].playback_busy = 0;
+			loopback->cables[subdev][half].capture_busy = 0;
+			loopback->cables[subdev][half].pcm_buf_pos = 0;
+		}
+	}
+	
 	loopback->card = card;
 	if (pcm_substreams[dev] < 1)
 		pcm_substreams[dev] = 1;

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--/9DWx/yDrRhgMJTb--
