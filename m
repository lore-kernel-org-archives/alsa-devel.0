From: linux@audioscience.com
Subject: [snd-asihpi 2/8] Debug print full substream ID. Other
 minor debug print updates.
Date: Fri, 01 Apr 2011 15:59:46 +1300
Message-ID: <1301626792-13705-3-git-send-email-linux@audioscience.com>
References: <1301626792-13705-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301626792-13705-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |  102 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index edcbe39..434342f 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -57,8 +57,25 @@ MODULE_DESCRIPTION("AudioScience ALSA ASI5000 ASI6000 ASI87xx ASI89xx");
  */
 #define snd_printddd(format, args...) \
 	__snd_printk(3, __FILE__, __LINE__, format, ##args)
+
+/* copied from pcm_lib.c, hope later patch will make that version public
+and this copy can be removed */
+static void pcm_debug_name(struct snd_pcm_substream *substream,
+			   char *name, size_t len)
+{
+	snprintf(name, len, "pcmC%dD%d%c:%d",
+		 substream->pcm->card->number,
+		 substream->pcm->device,
+		 substream->stream ? 'c' : 'p',
+		 substream->number);
+}
+#define DEBUG_NAME(substream, name) char name[16]; pcm_debug_name(substream, name, sizeof(name))
+
 #else
-#define snd_printddd(format, args...)	do { } while (0)
+#define snd_printddd(format, args...) do { } while (0)
+#define pcm_debug_name(s, n, l) do { } while (0)
+#define DEBUG_NAME(name, substream) do { } while (0)
+
 #endif
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* index 0-MAX */
@@ -101,13 +118,6 @@ static int adapter_fs = DEFAULT_SAMPLERATE;
 #define PERIOD_BYTES_MIN  2048
 #define BUFFER_BYTES_MAX (512 * 1024)
 
-/* convert stream to character */
-#define SCHR(s) ((s == SNDRV_PCM_STREAM_PLAYBACK) ? 'P' : 'C')
-
-/*#define TIMER_MILLISECONDS 20
-#define FORCE_TIMER_JIFFIES ((TIMER_MILLISECONDS * HZ + 999)/1000)
-*/
-
 #define MAX_CLOCKSOURCES (HPI_SAMPLECLOCK_SOURCE_LAST + 1 + 7)
 
 struct clk_source {
@@ -288,19 +298,26 @@ static u16 handle_error(u16 err, int line, char *filename)
 #define hpi_handle_error(x)  handle_error(x, __LINE__, __FILE__)
 
 /***************************** GENERAL PCM ****************/
-static void print_hwparams(struct snd_pcm_hw_params *p)
+
+static void print_hwparams(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *p)
 {
-	snd_printd("HWPARAMS \n");
-	snd_printd("samplerate %d \n", params_rate(p));
-	snd_printd("Channels %d \n", params_channels(p));
-	snd_printd("Format %d \n", params_format(p));
-	snd_printd("subformat %d \n", params_subformat(p));
-	snd_printd("Buffer bytes %d \n", params_buffer_bytes(p));
-	snd_printd("Period bytes %d \n", params_period_bytes(p));
-	snd_printd("access %d \n", params_access(p));
-	snd_printd("period_size %d \n", params_period_size(p));
-	snd_printd("periods %d \n", params_periods(p));
-	snd_printd("buffer_size %d \n", params_buffer_size(p));
+	DEBUG_NAME(substream, name);
+	snd_printd("%s HWPARAMS\n", name);
+	snd_printd(" samplerate %d Hz\n", params_rate(p));
+	snd_printd(" channels %d\n", params_channels(p));
+	snd_printd(" format %d\n", params_format(p));
+	snd_printd(" subformat %d\n", params_subformat(p));
+	snd_printd(" buffer %d B\n", params_buffer_bytes(p));
+	snd_printd(" period %d B\n", params_period_bytes(p));
+	snd_printd(" access %d\n", params_access(p));
+	snd_printd(" period_size %d\n", params_period_size(p));
+	snd_printd(" periods %d\n", params_periods(p));
+	snd_printd(" buffer_size %d\n", params_buffer_size(p));
+	snd_printd(" %d B/s\n", params_rate(p) *
+		params_channels(p) *
+		snd_pcm_format_width(params_format(p)) / 8);
+
 }
 
 static snd_pcm_format_t hpi_to_alsa_formats[] = {
@@ -451,7 +468,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	int width;
 	unsigned int bytes_per_sec;
 
-	print_hwparams(params);
+	print_hwparams(substream, params);
 	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 	if (err < 0)
 		return err;
@@ -459,10 +476,6 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (err)
 		return err;
 
-	snd_printdd("format %d, %d chans, %d_hz\n",
-				format, params_channels(params),
-				params_rate(params));
-
 	hpi_handle_error(hpi_format_create(&dpcm->format,
 			params_channels(params),
 			format, params_rate(params), 0, 0));
@@ -509,8 +522,6 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	dpcm->bytes_per_sec = bytes_per_sec;
 	dpcm->buffer_bytes = params_buffer_bytes(params);
 	dpcm->period_bytes = params_period_bytes(params);
-	snd_printdd("buffer_bytes=%d, period_bytes=%d, bps=%d\n",
-			dpcm->buffer_bytes, dpcm->period_bytes, bytes_per_sec);
 
 	return 0;
 }
@@ -564,9 +575,10 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 	struct snd_card_asihpi *card = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *s;
 	u16 e;
+	DEBUG_NAME(substream, name);
+
+	snd_printdd("%s trigger\n", name);
 
-	snd_printdd("%c%d trigger\n",
-			SCHR(substream->stream), substream->number);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_pcm_group_for_each_entry(s, substream) {
@@ -599,9 +611,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			}
 
 			if (card->support_grouping) {
-				snd_printdd("\t%c%d group\n",
-						SCHR(s->stream),
-						s->number);
+				snd_printdd("%d group\n", s->number);
 				e = hpi_stream_group_add(
 					dpcm->h_stream,
 					ds->h_stream);
@@ -636,9 +646,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			s->runtime->status->state = SNDRV_PCM_STATE_SETUP;
 
 			if (card->support_grouping) {
-				snd_printdd("\t%c%d group\n",
-				SCHR(s->stream),
-					s->number);
+				snd_printdd("%d group\n", s->number);
 				snd_pcm_trigger_done(s, substream);
 			} else
 				break;
@@ -732,9 +740,9 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 	int loops = 0;
 	u16 state;
 	u32 buffer_size, bytes_avail, samples_played, on_card_bytes;
+	DEBUG_NAME(substream, name);
 
-	snd_printdd("%c%d snd_card_asihpi_timer_function\n",
-				SCHR(substream->stream), substream->number);
+	snd_printdd("%s snd_card_asihpi_timer_function\n", name);
 
 	/* find minimum newdata and buffer pos in group */
 	snd_pcm_group_for_each_entry(s, substream) {
@@ -786,16 +794,18 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				newdata);
 		}
 
-		snd_printdd("hw_ptr x%04lX, appl_ptr x%04lX\n",
+		snd_printdd("hw_ptr 0x%04lX, appl_ptr 0x%04lX\n",
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->status->hw_ptr),
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->control->appl_ptr));
 
-		snd_printdd("%d %c%d S=%d, rw=%04X, dma=x%04X, left=x%04X,"
-			" aux=x%04X space=x%04X\n",
-			loops, SCHR(s->stream),	s->number,
-			state,	ds->pcm_buf_host_rw_ofs, pcm_buf_dma_ofs, (int)bytes_avail,
+		snd_printdd("%d S=%d, "
+			"rw=0x%04X, dma=0x%04X, left=0x%04X, "
+			"aux=0x%04X space=0x%04X\n",
+			s->number, state,
+			ds->pcm_buf_host_rw_ofs, pcm_buf_dma_ofs,
+			(int)bytes_avail,
 			(int)on_card_bytes, buffer_size-bytes_avail);
 		loops++;
 	}
@@ -814,7 +824,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 
 	next_jiffies = max(next_jiffies, 1U);
 	dpcm->timer.expires = jiffies + next_jiffies;
-	snd_printdd("jif %d buf pos x%04X newdata x%04X xfer x%04X\n",
+	snd_printdd("jif %d buf pos 0x%04X newdata 0x%04X xfer 0x%04X\n",
 			next_jiffies, pcm_buf_dma_ofs, newdata, xfercount);
 
 	snd_pcm_group_for_each_entry(s, substream) {
@@ -863,7 +873,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 static int snd_card_asihpi_playback_ioctl(struct snd_pcm_substream *substream,
 					  unsigned int cmd, void *arg)
 {
-	snd_printdd(KERN_INFO "Playback ioctl %d\n", cmd);
+	snd_printddd(KERN_INFO "P%d ioctl %d\n", substream->number, cmd);
 	return snd_pcm_lib_ioctl(substream, cmd, arg);
 }
 
@@ -873,7 +883,7 @@ static int snd_card_asihpi_playback_prepare(struct snd_pcm_substream *
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
-	snd_printdd("playback prepare %d\n", substream->number);
+	snd_printdd("P%d prepare\n", substream->number);
 
 	hpi_handle_error(hpi_outstream_reset(dpcm->h_stream));
 	dpcm->pcm_buf_host_rw_ofs = 0;
@@ -890,7 +900,7 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t ptr;
 
 	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_dma_ofs  % dpcm->buffer_bytes);
-	snd_printddd("playback_pointer=x%04lx\n", (unsigned long)ptr);
+	snd_printddd("P%d pointer = 0x%04lx\n", substream->number, (unsigned long)ptr);
 	return ptr;
 }
 
-- 
1.7.0.4
