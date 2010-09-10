From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/2] ALSA: snd-usb-caiaq: Add support for
	Traktor Kontrol S4
Date: Fri, 10 Sep 2010 17:04:57 +0800
Message-ID: <1284109497-6537-1-git-send-email-daniel@caiaq.de>
References: <s5hvd6e3rg9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E00A10395A
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 11:05:23 +0200 (CEST)
In-Reply-To: <s5hvd6e3rg9.wl%tiwai@suse.de>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This patch adds support for the new Traktor Kontrol S4 by Native
Instruments. It features a new audio data streaming model, MIDI
in and out ports, a huge number of 174 dimmable LEDs, 96 buttons
and 46 absolute encoder axis, including some rotary encoders.

All features are supported by the driver now.

Did some code refactoring along the way.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/Kconfig         |    2 +
 sound/usb/caiaq/audio.c   |  175 +++++++++++++++++++++++++++++---
 sound/usb/caiaq/control.c |  208 ++++++++++++++++++++++++++++++++++++-
 sound/usb/caiaq/device.c  |    8 ++-
 sound/usb/caiaq/device.h  |    6 +-
 sound/usb/caiaq/input.c   |  248 ++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 598 insertions(+), 49 deletions(-)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 44d6d2e..112984f 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -65,6 +65,7 @@ config SND_USB_CAIAQ
 	    * Native Instruments Guitar Rig Session I/O
 	    * Native Instruments Guitar Rig mobile
 	    * Native Instruments Traktor Kontrol X1
+	    * Native Instruments Traktor Kontrol S4
 
 	   To compile this driver as a module, choose M here: the module
 	   will be called snd-usb-caiaq.
@@ -82,6 +83,7 @@ config SND_USB_CAIAQ_INPUT
 	   * Native Instruments Kore Controller
 	   * Native Instruments Kore Controller 2
 	   * Native Instruments Audio Kontrol 1
+	   * Native Instruments Traktor Kontrol S4
 
 config SND_USB_US122L
 	tristate "Tascam US-122L USB driver"
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 4328cad..68b9747 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -111,7 +111,7 @@ static int stream_start(struct snd_usb_caiaqdev *dev)
 	memset(dev->sub_capture, 0, sizeof(dev->sub_capture));
 	dev->input_panic = 0;
 	dev->output_panic = 0;
-	dev->first_packet = 1;
+	dev->first_packet = 4;
 	dev->streaming = 1;
 	dev->warned = 0;
 
@@ -169,7 +169,7 @@ static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 }
 
 static int snd_usb_caiaq_pcm_hw_params(struct snd_pcm_substream *sub,
-			     		struct snd_pcm_hw_params *hw_params)
+				       struct snd_pcm_hw_params *hw_params)
 {
 	debug("%s(%p)\n", __func__, sub);
 	return snd_pcm_lib_malloc_pages(sub, params_buffer_bytes(hw_params));
@@ -189,7 +189,7 @@ static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *sub)
 #endif
 
 static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
-                                 48000, 64000, 88200, 96000, 176400, 192000 };
+				48000, 64000, 88200, 96000, 176400, 192000 };
 
 static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 {
@@ -201,12 +201,39 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 	debug("%s(%p)\n", __func__, substream);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		dev->period_out_count[index] = BYTES_PER_SAMPLE + 1;
-		dev->audio_out_buf_pos[index] = BYTES_PER_SAMPLE + 1;
+		int out_pos;
+
+		switch (dev->spec.data_alignment) {
+		case 0:
+		case 2:
+			out_pos = BYTES_PER_SAMPLE + 1;
+			break;
+		case 3:
+		default:
+			out_pos = 0;
+			break;
+		}
+
+		dev->period_out_count[index] = out_pos;
+		dev->audio_out_buf_pos[index] = out_pos;
 	} else {
-		int in_pos = (dev->spec.data_alignment == 2) ? 0 : 2;
-		dev->period_in_count[index] = BYTES_PER_SAMPLE + in_pos;
-		dev->audio_in_buf_pos[index] = BYTES_PER_SAMPLE + in_pos;
+		int in_pos;
+
+		switch (dev->spec.data_alignment) {
+		case 0:
+			in_pos = BYTES_PER_SAMPLE + 2;
+			break;
+		case 2:
+			in_pos = BYTES_PER_SAMPLE;
+			break;
+		case 3:
+		default:
+			in_pos = 0;
+			break;
+		}
+
+		dev->period_in_count[index] = in_pos;
+		dev->audio_in_buf_pos[index] = in_pos;
 	}
 
 	if (dev->streaming)
@@ -221,7 +248,7 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 	snd_pcm_limit_hw_rates(runtime);
 
 	bytes_per_sample = BYTES_PER_SAMPLE;
-	if (dev->spec.data_alignment == 2)
+	if (dev->spec.data_alignment >= 2)
 		bytes_per_sample++;
 
 	bpp = ((runtime->rate / 8000) + CLOCK_DRIFT_TOLERANCE)
@@ -253,6 +280,8 @@ static int snd_usb_caiaq_pcm_trigger(struct snd_pcm_substream *sub, int cmd)
 {
 	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(sub);
 
+	debug("%s(%p) cmd %d\n", __func__, sub, cmd);
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
@@ -402,6 +431,61 @@ static void read_in_urb_mode2(struct snd_usb_caiaqdev *dev,
 	}
 }
 
+static void read_in_urb_mode3(struct snd_usb_caiaqdev *dev,
+			      const struct urb *urb,
+			      const struct usb_iso_packet_descriptor *iso)
+{
+	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
+	int stream, i;
+
+	/* paranoia check */
+	if (iso->actual_length % (BYTES_PER_SAMPLE_USB * CHANNELS_PER_STREAM))
+		return;
+
+	for (i = 0; i < iso->actual_length;) {
+		for (stream = 0; stream < dev->n_streams; stream++) {
+			struct snd_pcm_substream *sub = dev->sub_capture[stream];
+			char *audio_buf = NULL;
+			int c, n, sz = 0;
+
+			if (sub && !dev->input_panic) {
+				struct snd_pcm_runtime *rt = sub->runtime;
+				audio_buf = rt->dma_area;
+				sz = frames_to_bytes(rt, rt->buffer_size);
+			}
+
+			for (c = 0; c < CHANNELS_PER_STREAM; c++) {
+				/* 3 audio data bytes, followed by 1 check byte */
+				if (audio_buf) {
+					for (n = 0; n < BYTES_PER_SAMPLE; n++) {
+						audio_buf[dev->audio_in_buf_pos[stream]++] = usb_buf[i+n];
+
+						if (dev->audio_in_buf_pos[stream] == sz)
+							dev->audio_in_buf_pos[stream] = 0;
+					}
+
+					dev->period_in_count[stream] += BYTES_PER_SAMPLE;
+				}
+
+				i += BYTES_PER_SAMPLE;
+
+				if (usb_buf[i] != ((stream << 1) | c) &&
+				    !dev->first_packet) {
+					if (!dev->input_panic)
+						printk(" EXPECTED: %02x got %02x, c %d, stream %d, i %d\n",
+							((stream << 1) | c), usb_buf[i], c, stream, i);
+					dev->input_panic = 1;
+				}
+
+				i++;
+			}
+		}
+	}
+
+	if (dev->first_packet > 0)
+		dev->first_packet--;
+}
+
 static void read_in_urb(struct snd_usb_caiaqdev *dev,
 			const struct urb *urb,
 			const struct usb_iso_packet_descriptor *iso)
@@ -419,6 +503,9 @@ static void read_in_urb(struct snd_usb_caiaqdev *dev,
 	case 2:
 		read_in_urb_mode2(dev, urb, iso);
 		break;
+	case 3:
+		read_in_urb_mode3(dev, urb, iso);
+		break;
 	}
 
 	if ((dev->input_panic || dev->output_panic) && !dev->warned) {
@@ -429,9 +516,9 @@ static void read_in_urb(struct snd_usb_caiaqdev *dev,
 	}
 }
 
-static void fill_out_urb(struct snd_usb_caiaqdev *dev,
-			 struct urb *urb,
-			 const struct usb_iso_packet_descriptor *iso)
+static void fill_out_urb_mode_0(struct snd_usb_caiaqdev *dev,
+				struct urb *urb,
+				const struct usb_iso_packet_descriptor *iso)
 {
 	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
 	struct snd_pcm_substream *sub;
@@ -457,9 +544,67 @@ static void fill_out_urb(struct snd_usb_caiaqdev *dev,
 		/* fill in the check bytes */
 		if (dev->spec.data_alignment == 2 &&
 		    i % (dev->n_streams * BYTES_PER_SAMPLE_USB) ==
-		    	(dev->n_streams * CHANNELS_PER_STREAM))
-		    for (stream = 0; stream < dev->n_streams; stream++, i++)
-		    	usb_buf[i] = MAKE_CHECKBYTE(dev, stream, i);
+		        (dev->n_streams * CHANNELS_PER_STREAM))
+			for (stream = 0; stream < dev->n_streams; stream++, i++)
+				usb_buf[i] = MAKE_CHECKBYTE(dev, stream, i);
+	}
+}
+
+static void fill_out_urb_mode_3(struct snd_usb_caiaqdev *dev,
+				struct urb *urb,
+				const struct usb_iso_packet_descriptor *iso)
+{
+	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
+	int stream, i;
+
+	for (i = 0; i < iso->length;) {
+		for (stream = 0; stream < dev->n_streams; stream++) {
+			struct snd_pcm_substream *sub = dev->sub_playback[stream];
+			char *audio_buf = NULL;
+			int c, n, sz = 0;
+
+			if (sub) {
+				struct snd_pcm_runtime *rt = sub->runtime;
+				audio_buf = rt->dma_area;
+				sz = frames_to_bytes(rt, rt->buffer_size);
+			}
+
+			for (c = 0; c < CHANNELS_PER_STREAM; c++) {
+				for (n = 0; n < BYTES_PER_SAMPLE; n++) {
+					if (audio_buf) {
+						usb_buf[i+n] = audio_buf[dev->audio_out_buf_pos[stream]++];
+
+						if (dev->audio_out_buf_pos[stream] == sz)
+							dev->audio_out_buf_pos[stream] = 0;
+					} else {
+						usb_buf[i+n] = 0;
+					}
+				}
+
+				if (audio_buf)
+					dev->period_out_count[stream] += BYTES_PER_SAMPLE;
+
+				i += BYTES_PER_SAMPLE;
+
+				/* fill in the check byte pattern */
+				usb_buf[i++] = (stream << 1) | c;
+			}
+		}
+	}
+}
+
+static inline void fill_out_urb(struct snd_usb_caiaqdev *dev,
+				struct urb *urb,
+				const struct usb_iso_packet_descriptor *iso)
+{
+	switch (dev->spec.data_alignment) {
+	case 0:
+	case 2:
+		fill_out_urb_mode_0(dev, urb, iso);
+		break;
+	case 3:
+		fill_out_urb_mode_3(dev, urb, iso);
+		break;
 	}
 }
 
diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index 91c804c..00e5d0a 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -55,6 +55,10 @@ static int control_info(struct snd_kcontrol *kcontrol,
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
 		maxval = 127;
 		break;
+
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
+		maxval = 31;
+		break;
 	}
 
 	if (is_intval) {
@@ -93,6 +97,7 @@ static int control_put(struct snd_kcontrol *kcontrol,
 	struct snd_usb_audio *chip = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
+	int v = ucontrol->value.integer.value[0];
 	unsigned char cmd = EP1_CMD_WRITE_IO;
 
 	if (dev->chip.usb_id ==
@@ -100,12 +105,27 @@ static int control_put(struct snd_kcontrol *kcontrol,
 		cmd = EP1_CMD_DIMM_LEDS;
 
 	if (pos & CNT_INTVAL) {
-		dev->control_state[pos & ~CNT_INTVAL]
-			= ucontrol->value.integer.value[0];
-		snd_usb_caiaq_send_command(dev, cmd,
-				dev->control_state, sizeof(dev->control_state));
+		int i = pos & ~CNT_INTVAL;
+
+		dev->control_state[i] = v;
+
+		if (dev->chip.usb_id ==
+			USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4)) {
+			int actual_len;
+
+			dev->ep8_out_buf[0] = i;
+			dev->ep8_out_buf[1] = v;
+
+			usb_bulk_msg(dev->chip.dev,
+				     usb_sndbulkpipe(dev->chip.dev, 8),
+				     dev->ep8_out_buf, sizeof(dev->ep8_out_buf),
+				     &actual_len, 200);
+		} else {
+			snd_usb_caiaq_send_command(dev, cmd,
+					dev->control_state, sizeof(dev->control_state));
+		}
 	} else {
-		if (ucontrol->value.integer.value[0])
+		if (v)
 			dev->control_state[pos / 8] |= 1 << (pos % 8);
 		else
 			dev->control_state[pos / 8] &= ~(1 << (pos % 8));
@@ -296,6 +316,179 @@ static struct caiaq_controller kontrolx1_controller[] = {
 	{ "LED Deck B: SYNC",		8  | CNT_INTVAL	},
 };
 
+static struct caiaq_controller kontrols4_controller[] = {
+	{ "LED: Master: Quant",			10  | CNT_INTVAL },
+	{ "LED: Master: Headphone",		11  | CNT_INTVAL },
+	{ "LED: Master: Master",		12  | CNT_INTVAL },
+	{ "LED: Master: Snap",			14  | CNT_INTVAL },
+	{ "LED: Master: Warning",		15  | CNT_INTVAL },
+	{ "LED: Master: Master button",		112 | CNT_INTVAL },
+	{ "LED: Master: Snap button",		113 | CNT_INTVAL },
+	{ "LED: Master: Rec",			118 | CNT_INTVAL },
+	{ "LED: Master: Size",			119 | CNT_INTVAL },
+	{ "LED: Master: Quant button",		120 | CNT_INTVAL },
+	{ "LED: Master: Browser button",	121 | CNT_INTVAL },
+	{ "LED: Master: Play button",		126 | CNT_INTVAL },
+	{ "LED: Master: Undo button",		127 | CNT_INTVAL },
+
+	{ "LED: Channel A: >",			4   | CNT_INTVAL },
+	{ "LED: Channel A: <",			5   | CNT_INTVAL },
+	{ "LED: Channel A: Meter 1",		97  | CNT_INTVAL },
+	{ "LED: Channel A: Meter 2",		98  | CNT_INTVAL },
+	{ "LED: Channel A: Meter 3",		99  | CNT_INTVAL },
+	{ "LED: Channel A: Meter 4",		100 | CNT_INTVAL },
+	{ "LED: Channel A: Meter 5",		101 | CNT_INTVAL },
+	{ "LED: Channel A: Meter 6",		102 | CNT_INTVAL },
+	{ "LED: Channel A: Meter clip",		103 | CNT_INTVAL },
+	{ "LED: Channel A: Active",		114 | CNT_INTVAL },
+	{ "LED: Channel A: Cue",		116 | CNT_INTVAL },
+	{ "LED: Channel A: FX1",		149 | CNT_INTVAL },
+	{ "LED: Channel A: FX2",		148 | CNT_INTVAL },
+
+	{ "LED: Channel B: >",			2   | CNT_INTVAL },
+	{ "LED: Channel B: <",			3   | CNT_INTVAL },
+	{ "LED: Channel B: Meter 1",		89  | CNT_INTVAL },
+	{ "LED: Channel B: Meter 2",		90  | CNT_INTVAL },
+	{ "LED: Channel B: Meter 3",		91  | CNT_INTVAL },
+	{ "LED: Channel B: Meter 4",		92  | CNT_INTVAL },
+	{ "LED: Channel B: Meter 5",		93  | CNT_INTVAL },
+	{ "LED: Channel B: Meter 6",		94  | CNT_INTVAL },
+	{ "LED: Channel B: Meter clip",		95  | CNT_INTVAL },
+	{ "LED: Channel B: Active",		122 | CNT_INTVAL },
+	{ "LED: Channel B: Cue",		125 | CNT_INTVAL },
+	{ "LED: Channel B: FX1",		147 | CNT_INTVAL },
+	{ "LED: Channel B: FX2",		146 | CNT_INTVAL },
+
+	{ "LED: Channel C: >",			6   | CNT_INTVAL },
+	{ "LED: Channel C: <",			7   | CNT_INTVAL },
+	{ "LED: Channel C: Meter 1",		105 | CNT_INTVAL },
+	{ "LED: Channel C: Meter 2",		106 | CNT_INTVAL },
+	{ "LED: Channel C: Meter 3",		107 | CNT_INTVAL },
+	{ "LED: Channel C: Meter 4",		108 | CNT_INTVAL },
+	{ "LED: Channel C: Meter 5",		109 | CNT_INTVAL },
+	{ "LED: Channel C: Meter 6",		110 | CNT_INTVAL },
+	{ "LED: Channel C: Meter clip",		111 | CNT_INTVAL },
+	{ "LED: Channel C: Active",		115 | CNT_INTVAL },
+	{ "LED: Channel C: Cue",		117 | CNT_INTVAL },
+	{ "LED: Channel C: FX1",		151 | CNT_INTVAL },
+	{ "LED: Channel C: FX2",		150 | CNT_INTVAL },
+
+	{ "LED: Channel D: >",			0   | CNT_INTVAL },
+	{ "LED: Channel D: <",			1   | CNT_INTVAL },
+	{ "LED: Channel D: Meter 1",		81  | CNT_INTVAL },
+	{ "LED: Channel D: Meter 2",		82  | CNT_INTVAL },
+	{ "LED: Channel D: Meter 3",		83  | CNT_INTVAL },
+	{ "LED: Channel D: Meter 4",		84  | CNT_INTVAL },
+	{ "LED: Channel D: Meter 5",		85  | CNT_INTVAL },
+	{ "LED: Channel D: Meter 6",		86  | CNT_INTVAL },
+	{ "LED: Channel D: Meter clip",		87  | CNT_INTVAL },
+	{ "LED: Channel D: Active",		123 | CNT_INTVAL },
+	{ "LED: Channel D: Cue",		124 | CNT_INTVAL },
+	{ "LED: Channel D: FX1",		145 | CNT_INTVAL },
+	{ "LED: Channel D: FX2",		144 | CNT_INTVAL },
+
+	{ "LED: Deck A: 1 (blue)",		22  | CNT_INTVAL },
+	{ "LED: Deck A: 1 (green)",		23  | CNT_INTVAL },
+	{ "LED: Deck A: 2 (blue)",		20  | CNT_INTVAL },
+	{ "LED: Deck A: 2 (green)",		21  | CNT_INTVAL },
+	{ "LED: Deck A: 3 (blue)",		18  | CNT_INTVAL },
+	{ "LED: Deck A: 3 (green)",		19  | CNT_INTVAL },
+	{ "LED: Deck A: 4 (blue)",		16  | CNT_INTVAL },
+	{ "LED: Deck A: 4 (green)",		17  | CNT_INTVAL },
+	{ "LED: Deck A: Load",			44  | CNT_INTVAL },
+	{ "LED: Deck A: Deck C button",		45  | CNT_INTVAL },
+	{ "LED: Deck A: In",			47  | CNT_INTVAL },
+	{ "LED: Deck A: Out",			46  | CNT_INTVAL },
+	{ "LED: Deck A: Shift",			24  | CNT_INTVAL },
+	{ "LED: Deck A: Sync",			27  | CNT_INTVAL },
+	{ "LED: Deck A: Cue",			26  | CNT_INTVAL },
+	{ "LED: Deck A: Play",			25  | CNT_INTVAL },
+	{ "LED: Deck A: Tempo up",		33  | CNT_INTVAL },
+	{ "LED: Deck A: Tempo down",		32  | CNT_INTVAL },
+	{ "LED: Deck A: Master",		34  | CNT_INTVAL },
+	{ "LED: Deck A: Keylock",		35  | CNT_INTVAL },
+	{ "LED: Deck A: Deck A",		37  | CNT_INTVAL },
+	{ "LED: Deck A: Deck C",		36  | CNT_INTVAL },
+	{ "LED: Deck A: Samples",		38  | CNT_INTVAL },
+	{ "LED: Deck A: On Air",		39  | CNT_INTVAL },
+	{ "LED: Deck A: Sample 1",		31  | CNT_INTVAL },
+	{ "LED: Deck A: Sample 2",		30  | CNT_INTVAL },
+	{ "LED: Deck A: Sample 3",		29  | CNT_INTVAL },
+	{ "LED: Deck A: Sample 4",		28  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 1 - A",		55  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 1 - B",		54  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 1 - C",		53  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 1 - D",		52  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 1 - E",		51  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 1 - F",		50  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 1 - G",		49  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 1 - dot",		48  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 2 - A",		63  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 2 - B",		62  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 2 - C",		61  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 2 - D",		60  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 2 - E",		59  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 2 - F",		58  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 2 - G",		57  | CNT_INTVAL },
+	{ "LED: Deck A: Digit 2 - dot",		56  | CNT_INTVAL },
+
+	{ "LED: Deck B: 1 (blue)",		78  | CNT_INTVAL },
+	{ "LED: Deck B: 1 (green)",		79  | CNT_INTVAL },
+	{ "LED: Deck B: 2 (blue)",		76  | CNT_INTVAL },
+	{ "LED: Deck B: 2 (green)",		77  | CNT_INTVAL },
+	{ "LED: Deck B: 3 (blue)",		74  | CNT_INTVAL },
+	{ "LED: Deck B: 3 (green)",		75  | CNT_INTVAL },
+	{ "LED: Deck B: 4 (blue)",		72  | CNT_INTVAL },
+	{ "LED: Deck B: 4 (green)",		73  | CNT_INTVAL },
+	{ "LED: Deck B: Load",			180 | CNT_INTVAL },
+	{ "LED: Deck B: Deck D button",		181 | CNT_INTVAL },
+	{ "LED: Deck B: In",			183 | CNT_INTVAL },
+	{ "LED: Deck B: Out",			182 | CNT_INTVAL },
+	{ "LED: Deck B: Shift",			64  | CNT_INTVAL },
+	{ "LED: Deck B: Sync",			67  | CNT_INTVAL },
+	{ "LED: Deck B: Cue",			66  | CNT_INTVAL },
+	{ "LED: Deck B: Play",			65  | CNT_INTVAL },
+	{ "LED: Deck B: Tempo up",		185 | CNT_INTVAL },
+	{ "LED: Deck B: Tempo down",		184 | CNT_INTVAL },
+	{ "LED: Deck B: Master",		186 | CNT_INTVAL },
+	{ "LED: Deck B: Keylock",		187 | CNT_INTVAL },
+	{ "LED: Deck B: Deck B",		189 | CNT_INTVAL },
+	{ "LED: Deck B: Deck D",		188 | CNT_INTVAL },
+	{ "LED: Deck B: Samples",		190 | CNT_INTVAL },
+	{ "LED: Deck B: On Air",		191 | CNT_INTVAL },
+	{ "LED: Deck B: Sample 1",		71  | CNT_INTVAL },
+	{ "LED: Deck B: Sample 2",		70  | CNT_INTVAL },
+	{ "LED: Deck B: Sample 3",		69  | CNT_INTVAL },
+	{ "LED: Deck B: Sample 4",		68  | CNT_INTVAL },
+	{ "LED: Deck B: Digit 1 - A",		175 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 1 - B",		174 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 1 - C",		173 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 1 - D",		172 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 1 - E",		171 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 1 - F",		170 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 1 - G",		169 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 1 - dot",		168 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 2 - A",		167 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 2 - B",		166 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 2 - C",		165 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 2 - D",		164 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 2 - E",		163 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 2 - F",		162 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 2 - G",		161 | CNT_INTVAL },
+	{ "LED: Deck B: Digit 2 - dot",		160 | CNT_INTVAL },
+
+	{ "LED: FX1: dry/wet",			153 | CNT_INTVAL },
+	{ "LED: FX1: 1",			154 | CNT_INTVAL },
+	{ "LED: FX1: 2",			155 | CNT_INTVAL },
+	{ "LED: FX1: 3",			156 | CNT_INTVAL },
+	{ "LED: FX1: Mode",			157 | CNT_INTVAL },
+	{ "LED: FX2: dry/wet",			129 | CNT_INTVAL },
+	{ "LED: FX2: 1",			130 | CNT_INTVAL },
+	{ "LED: FX2: 2",			131 | CNT_INTVAL },
+	{ "LED: FX2: 3",			132 | CNT_INTVAL },
+	{ "LED: FX2: Mode",			133 | CNT_INTVAL },
+};
+
 static int __devinit add_controls(struct caiaq_controller *c, int num,
 				  struct snd_usb_caiaqdev *dev)
 {
@@ -354,6 +547,11 @@ int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
 		ret = add_controls(kontrolx1_controller,
 			ARRAY_SIZE(kontrolx1_controller), dev);
 		break;
+
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
+		ret = add_controls(kontrols4_controller,
+			ARRAY_SIZE(kontrols4_controller), dev);
+		break;
 	}
 
 	return ret;
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index da9cb6d..6480c32 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -48,7 +48,8 @@ MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, Audio 8 DJ},"
 			 "{Native Instruments, Session I/O},"
 			 "{Native Instruments, GuitarRig mobile}"
-			 "{Native Instruments, Traktor Kontrol X1}");
+			 "{Native Instruments, Traktor Kontrol X1}"
+			 "{Native Instruments, Traktor Kontrol S4}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
@@ -134,6 +135,11 @@ static struct usb_device_id snd_usb_id_table[] = {
 		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
 		.idProduct =    USB_PID_TRAKTORKONTROLX1
 	},
+	{
+		.match_flags =  USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =    USB_PID_TRAKTORKONTROLS4
+	},
 	{ /* terminator */ }
 };
 
diff --git a/sound/usb/caiaq/device.h b/sound/usb/caiaq/device.h
index f1117ec..e3d8a3e 100644
--- a/sound/usb/caiaq/device.h
+++ b/sound/usb/caiaq/device.h
@@ -16,6 +16,7 @@
 #define USB_PID_SESSIONIO		0x1915
 #define USB_PID_GUITARRIGMOBILE		0x0d8d
 #define USB_PID_TRAKTORKONTROLX1	0x2305
+#define USB_PID_TRAKTORKONTROLS4	0xbaff
 
 #define EP1_BUFSIZE 64
 #define EP4_BUFSIZE 512
@@ -99,13 +100,14 @@ struct snd_usb_caiaqdev {
 	struct snd_pcm_substream *sub_capture[MAX_STREAMS];
 
 	/* Controls */
-	unsigned char control_state[64];
+	unsigned char control_state[256];
+	unsigned char ep8_out_buf[2];
 
 	/* Linux input */
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 	struct input_dev *input_dev;
 	char phys[64];			/* physical device path */
-	unsigned short keycode[64];
+	unsigned short keycode[128];
 	struct urb *ep4_in_urb;
 	unsigned char ep4_in_buf[EP4_BUFSIZE];
 #endif
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index dcb6207..4432ef7 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -67,7 +67,12 @@ static unsigned short keycode_kore[] = {
 	KEY_BRL_DOT5
 };
 
-#define KONTROLX1_INPUTS 40
+#define KONTROLX1_INPUTS	(40)
+#define KONTROLS4_BUTTONS	(12 * 8)
+#define KONTROLS4_AXIS		(46)
+
+#define KONTROLS4_BUTTON(X)	((X) + BTN_MISC)
+#define KONTROLS4_ABS(X)	((X) + ABS_HAT0X)
 
 #define DEG90		(range / 2)
 #define DEG180		(range)
@@ -139,6 +144,13 @@ static unsigned int decode_erp(unsigned char a, unsigned char b)
 #undef HIGH_PEAK
 #undef LOW_PEAK
 
+static inline void snd_caiaq_input_report_abs(struct snd_usb_caiaqdev *dev,
+					      int axis, const unsigned char *buf,
+					      int offset)
+{
+	input_report_abs(dev->input_dev, axis,
+			 (buf[offset * 2] << 8) | buf[offset * 2 + 1]);
+}
 
 static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev,
 					const unsigned char *buf,
@@ -148,36 +160,30 @@ static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev,
 
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL2):
-		input_report_abs(input_dev, ABS_X, (buf[4] << 8) | buf[5]);
-		input_report_abs(input_dev, ABS_Y, (buf[0] << 8) | buf[1]);
-		input_report_abs(input_dev, ABS_Z, (buf[2] << 8) | buf[3]);
-		input_sync(input_dev);
+		snd_caiaq_input_report_abs(dev, ABS_X, buf, 2);
+		snd_caiaq_input_report_abs(dev, ABS_Y, buf, 0);
+		snd_caiaq_input_report_abs(dev, ABS_Z, buf, 1);
 		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
-		input_report_abs(input_dev, ABS_X, (buf[0] << 8) | buf[1]);
-		input_report_abs(input_dev, ABS_Y, (buf[2] << 8) | buf[3]);
-		input_report_abs(input_dev, ABS_Z, (buf[4] << 8) | buf[5]);
-		input_sync(input_dev);
-		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
-		input_report_abs(input_dev, ABS_X, (buf[0] << 8) | buf[1]);
-		input_report_abs(input_dev, ABS_Y, (buf[2] << 8) | buf[3]);
-		input_report_abs(input_dev, ABS_Z, (buf[4] << 8) | buf[5]);
-		input_sync(input_dev);
+		snd_caiaq_input_report_abs(dev, ABS_X, buf, 0);
+		snd_caiaq_input_report_abs(dev, ABS_Y, buf, 1);
+		snd_caiaq_input_report_abs(dev, ABS_Z, buf, 2);
 		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
-		input_report_abs(input_dev, ABS_HAT0X, (buf[8] << 8)  | buf[9]);
-		input_report_abs(input_dev, ABS_HAT0Y, (buf[4] << 8)  | buf[5]);
-		input_report_abs(input_dev, ABS_HAT1X, (buf[12] << 8) | buf[13]);
-		input_report_abs(input_dev, ABS_HAT1Y, (buf[2] << 8)  | buf[3]);
-		input_report_abs(input_dev, ABS_HAT2X, (buf[14] << 8) | buf[15]);
-		input_report_abs(input_dev, ABS_HAT2Y, (buf[0] << 8)  | buf[1]);
-		input_report_abs(input_dev, ABS_HAT3X, (buf[10] << 8) | buf[11]);
-		input_report_abs(input_dev, ABS_HAT3Y, (buf[6] << 8)  | buf[7]);
-		input_sync(input_dev);
+		snd_caiaq_input_report_abs(dev, ABS_HAT0X, buf, 4);
+		snd_caiaq_input_report_abs(dev, ABS_HAT0Y, buf, 2);
+		snd_caiaq_input_report_abs(dev, ABS_HAT1X, buf, 6);
+		snd_caiaq_input_report_abs(dev, ABS_HAT1Y, buf, 1);
+		snd_caiaq_input_report_abs(dev, ABS_HAT2X, buf, 7);
+		snd_caiaq_input_report_abs(dev, ABS_HAT2Y, buf, 0);
+		snd_caiaq_input_report_abs(dev, ABS_HAT3X, buf, 5);
+		snd_caiaq_input_report_abs(dev, ABS_HAT3Y, buf, 3);
 		break;
 	}
+
+	input_sync(input_dev);
 }
 
 static void snd_caiaq_input_read_erp(struct snd_usb_caiaqdev *dev,
@@ -250,6 +256,150 @@ static void snd_caiaq_input_read_io(struct snd_usb_caiaqdev *dev,
 	input_sync(input_dev);
 }
 
+#define TKS4_MSGBLOCK_SIZE	16
+
+static void snd_usb_caiaq_tks4_dispatch(struct snd_usb_caiaqdev *dev,
+					const unsigned char *buf,
+					unsigned int len)
+{
+	while (len) {
+		unsigned int i, block_id = (buf[0] << 8) | buf[1];
+
+		switch (block_id) {
+		case 0:
+			/* buttons */
+			for (i = 0; i < KONTROLS4_BUTTONS; i++)
+				input_report_key(dev->input_dev, KONTROLS4_BUTTON(i),
+						 (buf[4 + (i / 8)] >> (i % 8)) & 1);
+			break;
+
+		case 1:
+			/* left wheel */
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(36), buf[9] | ((buf[8] & 0x3) << 8));
+			/* right wheel */
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(37), buf[13] | ((buf[12] & 0x3) << 8));
+
+			/* rotary encoders */
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(38), buf[3] & 0xf);
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(39), buf[4] >> 4);
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(40), buf[4] & 0xf);
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(41), buf[5] >> 4);
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(42), buf[5] & 0xf);
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(43), buf[6] >> 4);
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(44), buf[6] & 0xf);
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(45), buf[7] >> 4);
+			input_report_abs(dev->input_dev, KONTROLS4_ABS(46), buf[7] & 0xf);
+
+			break;
+		case 2:
+			/* Volume Fader Channel D */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(0), buf, 1);
+			/* Volume Fader Channel B */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(1), buf, 2);
+			/* Volume Fader Channel A */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(2), buf, 3);
+			/* Volume Fader Channel C */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(3), buf, 4);
+			/* Loop Volume */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(4), buf, 6);
+			/* Crossfader */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(7), buf, 7);
+
+			break;
+
+		case 3:
+			/* Tempo Fader R */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(6), buf, 3);
+			/* Tempo Fader L */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(5), buf, 4);
+			/* Mic Volume */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(8), buf, 6);
+			/* Cue Mix */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(9), buf, 7);
+
+			break;
+
+		case 4:
+			/* Wheel distance sensor L */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(10), buf, 1);
+			/* Wheel distance sensor R */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(11), buf, 2);
+			/* Channel D EQ - Filter */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(12), buf, 3);
+			/* Channel D EQ - Low */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(13), buf, 4);
+			/* Channel D EQ - Mid */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(14), buf, 5);
+			/* Channel D EQ - Hi */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(15), buf, 6);
+			/* FX2 - dry/wet */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(16), buf, 7);
+
+			break;
+
+		case 5:
+			/* FX2 - 1 */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(17), buf, 1);
+			/* FX2 - 2 */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(18), buf, 2);
+			/* FX2 - 3 */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(19), buf, 3);
+			/* Channel B EQ - Filter */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(20), buf, 4);
+			/* Channel B EQ - Low */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(21), buf, 5);
+			/* Channel B EQ - Mid */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(22), buf, 6);
+			/* Channel B EQ - Hi */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(23), buf, 7);
+
+			break;
+
+		case 6:
+			/* Channel A EQ - Filter */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(24), buf, 1);
+			/* Channel A EQ - Low */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(25), buf, 2);
+			/* Channel A EQ - Mid */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(26), buf, 3);
+			/* Channel A EQ - Hi */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(27), buf, 4);
+			/* Channel C EQ - Filter */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(28), buf, 5);
+			/* Channel C EQ - Low */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(29), buf, 6);
+			/* Channel C EQ - Mid */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(30), buf, 7);
+
+			break;
+
+		case 7:
+			/* Channel C EQ - Hi */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(31), buf, 1);
+			/* FX1 - wet/dry */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(32), buf, 2);
+			/* FX1 - 1 */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(33), buf, 3);
+			/* FX1 - 2 */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(34), buf, 4);
+			/* FX1 - 3 */
+			snd_caiaq_input_report_abs(dev, KONTROLS4_ABS(35), buf, 5);
+
+			break;
+
+		default:
+			debug("%s(): bogus block (id %d)\n",
+				__func__, block_id);
+			return;
+		}
+
+		len -= TKS4_MSGBLOCK_SIZE;
+		buf += TKS4_MSGBLOCK_SIZE;
+	}
+
+	input_sync(dev->input_dev);
+}
+
 static void snd_usb_caiaq_ep4_reply_dispatch(struct urb *urb)
 {
 	struct snd_usb_caiaqdev *dev = urb->context;
@@ -259,11 +409,11 @@ static void snd_usb_caiaq_ep4_reply_dispatch(struct urb *urb)
 	if (urb->status || !dev || urb != dev->ep4_in_urb)
 		return;
 
-	if (urb->actual_length < 24)
-		goto requeue;
-
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		if (urb->actual_length < 24)
+			goto requeue;
+
 		if (buf[0] & 0x3)
 			snd_caiaq_input_read_io(dev, buf + 1, 7);
 
@@ -271,6 +421,10 @@ static void snd_usb_caiaq_ep4_reply_dispatch(struct urb *urb)
 			snd_caiaq_input_read_analog(dev, buf + 8, 16);
 
 		break;
+
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
+		snd_usb_caiaq_tks4_dispatch(dev, buf, urb->actual_length);
+		break;
 	}
 
 requeue:
@@ -289,6 +443,7 @@ static int snd_usb_caiaq_input_open(struct input_dev *idev)
 
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
 		if (usb_submit_urb(dev->ep4_in_urb, GFP_KERNEL) != 0)
 			return -EIO;
 		break;
@@ -306,6 +461,7 @@ static void snd_usb_caiaq_input_close(struct input_dev *idev)
 
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
 		usb_kill_urb(dev->ep4_in_urb);
 		break;
 	}
@@ -456,6 +612,46 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 		snd_usb_caiaq_set_auto_msg(dev, 1, 10, 5);
 
 		break;
+
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
+		input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+		BUILD_BUG_ON(sizeof(dev->keycode) < KONTROLS4_BUTTONS);
+		for (i = 0; i < KONTROLS4_BUTTONS; i++)
+			dev->keycode[i] = KONTROLS4_BUTTON(i);
+		input->keycodemax = KONTROLS4_BUTTONS;
+
+		for (i = 0; i < KONTROLS4_AXIS; i++) {
+			int axis = KONTROLS4_ABS(i);
+			input->absbit[BIT_WORD(axis)] |= BIT_MASK(axis);
+		}
+
+		/* 36 analog potentiometers and faders */
+		for (i = 0; i < 36; i++)
+			input_set_abs_params(input, KONTROLS4_ABS(i), 0, 0xfff, 0, 10);
+
+		/* 2 encoder wheels */
+		input_set_abs_params(input, KONTROLS4_ABS(36), 0, 0x3ff, 0, 1);
+		input_set_abs_params(input, KONTROLS4_ABS(37), 0, 0x3ff, 0, 1);
+
+		/* 9 rotary encoders */
+		for (i = 0; i < 9; i++)
+			input_set_abs_params(input, KONTROLS4_ABS(38+i), 0, 0xf, 0, 1);
+
+		dev->ep4_in_urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!dev->ep4_in_urb) {
+			ret = -ENOMEM;
+			goto exit_free_idev;
+		}
+
+		usb_fill_bulk_urb(dev->ep4_in_urb, usb_dev,
+				  usb_rcvbulkpipe(usb_dev, 0x4),
+				  dev->ep4_in_buf, EP4_BUFSIZE,
+				  snd_usb_caiaq_ep4_reply_dispatch, dev);
+
+		snd_usb_caiaq_set_auto_msg(dev, 1, 10, 5);
+
+		break;
+
 	default:
 		/* no input methods supported on this device */
 		goto exit_free_idev;
-- 
1.7.0.4
