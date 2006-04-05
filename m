From: Daniel Mack <daniel@caiaq.de>
Subject: driver for Native Instruments' audio devices
Date: Wed, 5 Apr 2006 16:10:46 +0200
Message-ID: <2C67C334-1C47-497E-87CB-974D1853F3FF@caiaq.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-582805674
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Apple-Mail-1-582805674
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi folks,

here's my first shot of a driver for the new audio devices produced
by Native Instruments such as RigKontrol2 and Kore controller.

The patchset should cleanly apply to the current CVS. I also tried to
keep to the coding style as close as possible ;)

Please let me know what you think.

Best,
Daniel



--Apple-Mail-1-582805674
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="caiaq-alsa-cvs.patch"
Content-Disposition: attachment;
	filename=caiaq-alsa-cvs.patch

Index: alsa-kernel/scripts/ksync
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/scripts/ksync,v
retrieving revision 1.66
diff -u -p -r1.66 ksync
--- alsa-kernel/scripts/ksync	2 Feb 2006 12:56:53 -0000	1.66
+++ alsa-kernel/scripts/ksync	5 Apr 2006 13:38:59 -0000
@@ -261,6 +261,7 @@ COMMENT_MAP_DRIVER = [
 		('/pcmcia/Makefile'	,'PCMCIA'),
 		('/pcmcia'		,'ERROR'),
 		('/usb/usx2y/.*'	,'USB USX2Y'),
+		('/usb/caiaq/'		,'caiaq USB driver'),
 		('/usb/Kconfig'		,'USB'),
 		('/usb/Makefile'	,'USB'),
 		('/usb/usbaudio.(c|h)'	,'USB generic driver'),
Index: alsa-kernel/usb/Kconfig
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/Kconfig,v
retrieving revision 1.9
diff -u -p -r1.9 Kconfig
--- alsa-kernel/usb/Kconfig	8 May 2005 21:22:27 -0000	1.9
+++ alsa-kernel/usb/Kconfig	5 Apr 2006 13:38:59 -0000
@@ -29,5 +29,18 @@ config SND_USB_USX2Y
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-usb-usx2y.
 
+config SND_USB_CAIAQ
+	tristate "caiaq/NativeInstruments USB audio devices"
+	depends on SND && USB && (X86 || PPC || ALPHA)
+	select SND_HWDEP
+	select SND_RAWMIDI
+	select SND_PCM
+	help
+	  Say Y here to include support for caiaq USB audio interfaces
+	  such as NativeInstrument's 'RigKontrol2' and 'Kore controller'.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-usb-caiaq.
+
 endmenu
 
Index: alsa-kernel/usb/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/Makefile,v
retrieving revision 1.5
diff -u -p -r1.5 Makefile
--- alsa-kernel/usb/Makefile	3 Aug 2004 14:22:32 -0000	1.5
+++ alsa-kernel/usb/Makefile	5 Apr 2006 13:38:59 -0000
@@ -8,5 +8,6 @@ snd-usb-lib-objs := usbmidi.o
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o snd-usb-lib.o
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usb-lib.o
+obj-$(CONFIG_SND_USB_CAIAQ) += snd-usb-lib.o
 
-obj-$(CONFIG_SND) += usx2y/
+obj-$(CONFIG_SND) += usx2y/ caiaq/

--Apple-Mail-1-582805674
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="caiaq-alsa.patch"
Content-Disposition: attachment;
	filename=caiaq-alsa.patch

diff -Nur -x .svn orig/Makefile alsa-kernel/usb/caiaq/Makefile
--- orig/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ alsa-kernel/usb/caiaq/Makefile	2006-04-05 14:57:48.000000000 +0200
@@ -0,0 +1,3 @@
+snd-usb-caiaq-objs := caiaq-device.o caiaq-audio.o caiaq-midi.o
+
+obj-$(CONFIG_SND_USB_CAIAQ) += snd-usb-caiaq.o
diff -Nur -x .svn orig/caiaq-audio.c alsa-kernel/usb/caiaq/caiaq-audio.c
--- orig/caiaq-audio.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-kernel/usb/caiaq/caiaq-audio.c	2006-04-05 15:36:17.000000000 +0200
@@ -0,0 +1,727 @@
+/*
+ *   Copyright (c) 2006 Daniel Mack
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/interrupt.h>
+#include <linux/usb.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/rawmidi.h>
+
+#include "caiaq-device.h"
+#include "caiaq-audio.h"
+
+#ifndef MAX
+#define MAX(a,b) (((a)>(b))?(a):(b))
+#endif
+
+#define CLOCK_DRIFT_TOLERANCE	3
+
+#define N_URBS 			64
+#define FRAMES_PER_URB		8
+#define BYTES_PER_FRAME		512
+#define CHANNELS_PER_STREAM	2
+				 
+#define ENDPOINT_CAPTURE  	2
+#define ENDPOINT_PLAYBACK 	6
+
+#define BYTES_PER_SAMPLE	3
+				 
+static struct snd_pcm_hardware snd_usb_caiaq_pcm_hardware = {
+	.info 		= (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats 	= SNDRV_PCM_FMTBIT_S24_3BE,
+	.rates 		= (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | 
+			   SNDRV_PCM_RATE_96000),
+	.rate_min	= 44100,
+	.rate_max	= 96000,
+	.channels_min	= 0, /* will overwrite later */
+	.channels_max	= 0, /* will overwrite later */
+	.buffer_bytes_max = 32768,
+	.period_bytes_min = 4096,
+	.period_bytes_max = 32768,
+	.periods_min	= 1,
+	.periods_max	= 1024,
+};
+	
+/* open callback */
+static int snd_usb_caiaq_playback_open(struct snd_pcm_substream *substream)
+{
+	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	debug("snd_usb_caiaq_playback_open(%p)\n", substream);
+	runtime->hw = dev->pcm_info_playback;
+	dev->pcm_sub_playback = substream;
+	return 0;
+}
+
+/* close callback */
+static int snd_usb_caiaq_playback_close(struct snd_pcm_substream *substream)
+{
+	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
+
+	debug("snd_usb_caiaq_playback_close(%p)\n", substream);
+	dev->pcm_sub_playback = NULL;
+	return 0;
+}
+
+/* open callback */
+static int snd_usb_caiaq_capture_open(struct snd_pcm_substream *substream)
+{
+	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	debug("snd_usb_caiaq_capture_open(%p)\n", substream);
+	runtime->hw = dev->pcm_info_capture;
+	dev->pcm_sub_capture = substream;
+	return 0;
+}
+
+/* close callback */
+static int snd_usb_caiaq_capture_close(struct snd_pcm_substream *substream)
+{
+	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
+	debug("snd_usb_caiaq_capture_close(%p)\n", substream);
+	dev->pcm_sub_capture = NULL;
+	return 0;
+}
+
+/* hw_params callback */
+static int snd_usb_caiaq_pcm_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *hw_params)
+{
+	debug("snd_usb_caiaq_pcm_hw_params(%p)\n", substream);
+	return snd_pcm_lib_malloc_pages(substream,
+				   params_buffer_bytes(hw_params));
+}
+
+/* hw_free callback */
+static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	debug("snd_usb_caiaq_pcm_hw_free(%p)\n", substream);
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/* prepare callback */
+static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	int bytes_per_sample, bpp, ret;
+	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	debug("snd_usb_caiaq_pcm_prepare(%p)\n", substream);
+
+	if (dev->streaming) {
+		debug("not setting params again, already streaming\n");
+		return 0;
+	}
+
+	down(&dev->mutex);
+	
+	bytes_per_sample = BYTES_PER_SAMPLE;
+	dev->stream_pitch = frames_to_bytes(substream->runtime, 
+					    substream->runtime->buffer_size);
+
+	if (dev->spec.data_alignment == 1)
+		bytes_per_sample++;
+	
+	bpp = ((runtime->rate / 8000) + CLOCK_DRIFT_TOLERANCE)
+			* bytes_per_sample * 2 * dev->n_streams;
+	
+	debug("setting audio params: %d Hz, %d bits, %d bytes/sample\n",
+			runtime->rate, runtime->sample_bits, bytes_per_sample);
+
+	dev->audio_out_buf_pos = BYTES_PER_SAMPLE + 1;
+	dev->audio_in_buf_pos = BYTES_PER_SAMPLE - 1;
+	
+	ret = snd_usb_caiaq_set_audio_params(dev, runtime->rate, runtime->sample_bits, bpp);
+
+	up(&dev->mutex);
+	
+	return ret;
+}
+
+static void stream_start(void *d)
+{
+	int i, ret;
+	struct snd_usb_caiaqdev *dev = (struct snd_usb_caiaqdev *) d;
+
+	debug("stream_start(%p)\n", dev);
+
+	if (dev->streaming)
+		return;
+	
+	down(&dev->mutex);
+	
+	dev->streaming = 1;
+	dev->input_panic = 0;
+	dev->output_panic = 0;
+	dev->first_packet = 1;
+
+	for (i = 0; i < N_URBS; i++) {
+		ret = usb_submit_urb(dev->data_urbs_in[i], GFP_KERNEL);
+		if (ret < 0)
+			log("unable to trigger initial read #%d! (ret = %d)\n", i, ret);
+	}
+
+	up(&dev->mutex);
+}
+
+static void stream_stop(void *d)
+{
+	int i;
+	struct snd_usb_caiaqdev *dev = (struct snd_usb_caiaqdev *) d;
+	
+	debug("stream_stop(%p)\n", dev);
+
+	if (!dev->streaming)
+		return;
+
+	down(&dev->mutex);
+	dev->streaming = 0;
+
+	for (i = 0; i < N_URBS; i++) {
+		usb_kill_urb(dev->data_urbs_in[i]);
+		usb_kill_urb(dev->data_urbs_out[i]);
+	}
+	
+	up(&dev->mutex);
+}
+
+static void stream_restart(void *d)
+{
+	debug("stream_restart()\n");
+	stream_stop(d);
+	stream_start(d);
+}
+
+/* trigger callback */
+static int snd_usb_caiaq_pcm_trigger(struct snd_pcm_substream *substream,
+				 int cmd)
+{
+	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
+
+	switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+		case SNDRV_PCM_TRIGGER_RESUME:
+			debug("snd_usb_caiaq_pcm_trigger SNDRV_PCM_TRIGGER_START (%p)\n",
+					substream);
+			schedule_delayed_work(&dev->stream_start_work, 0);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			debug("snd_usb_caiaq_pcm_trigger SNDRV_PCM_TRIGGER_STOP (%p)\n",
+					substream);
+			schedule_delayed_work(&dev->stream_stop_work, 0);
+	       		break;
+		default:
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* pointer callback */
+static snd_pcm_uframes_t
+snd_usb_caiaq_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
+	
+	if (dev->pcm_sub_playback)
+		return bytes_to_frames(dev->pcm_sub_playback->runtime, dev->audio_out_buf_pos);
+	
+	if (dev->pcm_sub_capture)
+		return bytes_to_frames(dev->pcm_sub_capture->runtime, dev->audio_in_buf_pos);
+
+	return 0;
+}
+
+/* operators */
+static struct snd_pcm_ops snd_usb_caiaq_playback_ops = {
+	.open =		snd_usb_caiaq_playback_open,
+	.close =	snd_usb_caiaq_playback_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_usb_caiaq_pcm_hw_params,
+	.hw_free =	snd_usb_caiaq_pcm_hw_free,
+	.prepare =	snd_usb_caiaq_pcm_prepare,
+	.trigger =	snd_usb_caiaq_pcm_trigger,
+	.pointer =	snd_usb_caiaq_pcm_pointer,
+};
+
+/* operators */
+static struct snd_pcm_ops snd_usb_caiaq_capture_ops = {
+	.open =		snd_usb_caiaq_capture_open,
+	.close =	snd_usb_caiaq_capture_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_usb_caiaq_pcm_hw_params,
+	.hw_free =	snd_usb_caiaq_pcm_hw_free,
+	.prepare =	snd_usb_caiaq_pcm_prepare,
+	.trigger =	snd_usb_caiaq_pcm_trigger,
+	.pointer =	snd_usb_caiaq_pcm_pointer,
+};
+
+static void read_in_urb_mode0(struct snd_usb_caiaqdev *dev,
+			      struct urb *urb,
+			      const struct usb_iso_packet_descriptor *iso)
+{
+	struct snd_pcm_runtime *runtime;
+	unsigned char *dma_buf;
+	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
+	int stream, i = 0;
+
+	if (!dev->pcm_sub_capture)
+		return;
+	
+	runtime = dev->pcm_sub_capture->runtime;
+	dma_buf = runtime->dma_area;
+	
+	for (;;) {
+		for (stream = 0; stream < dev->n_streams; stream++)
+			dma_buf[dev->audio_in_buf_pos + (stream * dev->stream_pitch)] = usb_buf[i++];
+
+		dev->audio_in_buf_pos++;
+		dev->audio_in_buf_pos %= frames_to_bytes(runtime, runtime->buffer_size);
+
+		if (i >= iso->actual_length)
+			break;
+	}
+
+	dev->period_in_count += bytes_to_frames(runtime, iso->actual_length);
+}
+
+static void read_in_urb_mode2(struct snd_usb_caiaqdev *dev,
+			      struct urb *urb,
+			      const struct usb_iso_packet_descriptor *iso)
+{
+	struct snd_pcm_runtime *runtime = NULL;
+	unsigned char *dma_buf = NULL;
+	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
+	int stream, i = 0;
+	
+	if (dev->pcm_sub_capture) {
+		runtime = dev->pcm_sub_capture->runtime;
+		dma_buf = runtime->dma_area;
+	}
+	
+	for (;;) {
+		if ((dev->audio_in_buf_pos % BYTES_PER_SAMPLE) == 2) {
+			for (stream = 0; stream < dev->n_streams; stream++, i++) {
+				if ((!dev->first_packet) && (usb_buf[i] & 0x3f) != 
+					((stream << 1) | (~(dev->audio_in_buf_pos / 
+							   BYTES_PER_SAMPLE) & 1)))
+					dev->input_panic = 1;
+
+				if (usb_buf[i] & 0x80) 
+					dev->output_panic = 1;
+			}
+		
+		}
+		
+		dev->first_packet = 0;
+		
+		dev->audio_in_buf_pos++;
+		dev->audio_in_buf_pos %= dev->stream_pitch;
+	
+		if (runtime)
+			for (stream = 0; stream < dev->n_streams; stream++)
+				dma_buf[dev->audio_in_buf_pos + (stream * dev->stream_pitch)] = usb_buf[i++];
+		else
+			i += dev->n_streams;
+		
+		if (i >= iso->actual_length)
+			break;
+		
+	}
+
+	if (runtime)
+		dev->period_in_count += bytes_to_frames(runtime, (iso->actual_length/4)*3);
+}
+
+static void read_in_urb(struct snd_usb_caiaqdev *dev,
+			struct urb *urb,
+			const struct usb_iso_packet_descriptor *iso)
+{
+	struct snd_pcm_runtime *runtime = NULL;
+	
+	if (dev->pcm_sub_capture)
+		runtime = dev->pcm_sub_capture->runtime;
+	
+	switch (dev->spec.data_alignment) {
+		case 0:
+			read_in_urb_mode0(dev, urb, iso);
+			break;
+		case 2:
+			read_in_urb_mode2(dev, urb, iso);
+			break;
+	}
+
+	if (dev->input_panic || dev->output_panic) {
+		debug("streaming error detected %s %s\n", 
+				dev->input_panic ? "(input)" : "",
+				dev->output_panic ? "(output)" : "");
+		schedule_delayed_work(&dev->stream_restart_work, 0);
+	}
+	
+	if (runtime)
+		if (dev->period_in_count >= runtime->period_size) {
+			snd_pcm_period_elapsed(dev->pcm_sub_capture);
+			dev->period_in_count %= runtime->period_size;
+		}
+}
+
+static void fill_out_urb_mode0(struct snd_usb_caiaqdev *dev, 
+			       struct urb *urb, 
+       			       const struct usb_iso_packet_descriptor *iso)
+{
+	struct snd_pcm_runtime *runtime;
+	unsigned char *dma_buf;
+	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
+	int stream, i = 0;
+
+	if (!dev->pcm_sub_playback) {
+		memset(usb_buf, 0, iso->length);
+		return;
+	}
+
+	runtime = dev->pcm_sub_playback->runtime;
+	dma_buf = runtime->dma_area;
+
+	for (;;) {
+		for (stream = 0; stream < dev->n_streams; stream++)
+			usb_buf[i++] = dma_buf[dev->audio_out_buf_pos + (stream * dev->stream_pitch)];
+
+		dev->audio_out_buf_pos++;
+		dev->audio_out_buf_pos %= frames_to_bytes(runtime, runtime->buffer_size);
+		
+		if (i >= iso->length)
+			break;
+	}
+
+	dev->period_out_count += bytes_to_frames(runtime, iso->length);
+}
+
+static void fill_out_urb_mode2(struct snd_usb_caiaqdev *dev, 
+			       struct urb *urb, 
+			       const struct usb_iso_packet_descriptor *iso)
+{
+	struct snd_pcm_runtime *runtime = NULL;
+	unsigned char *dma_buf = NULL;
+	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
+	int stream, i = 0;
+	
+	if (dev->pcm_sub_playback) {
+		runtime = dev->pcm_sub_playback->runtime;
+		dma_buf = runtime->dma_area;
+	}
+	
+	for (;;) {
+		if (runtime) {
+			for (stream = 0; stream < dev->n_streams; stream++)
+				usb_buf[i++] = dma_buf[dev->audio_out_buf_pos + 
+							(stream * dev->stream_pitch)];
+		} else
+			i += dev->n_streams;
+
+		if ((dev->audio_out_buf_pos % BYTES_PER_SAMPLE) == 2)
+			for (stream = 0; stream < dev->n_streams; stream++)
+				usb_buf[i++] = (stream << 1) | 
+					((dev->audio_out_buf_pos / BYTES_PER_SAMPLE) & 1);
+		
+		dev->audio_out_buf_pos++;
+		dev->audio_out_buf_pos %= dev->stream_pitch;
+		
+		if (i >= iso->length)
+			break;
+	}
+
+	if (runtime)
+		dev->period_out_count += bytes_to_frames(runtime, (iso->length/4)*3);
+}
+
+static void fill_out_urb(struct snd_usb_caiaqdev *dev, 
+			 struct urb *urb, 
+			 const struct usb_iso_packet_descriptor *iso)
+{
+	struct snd_pcm_runtime *runtime = NULL;
+
+	if (dev->pcm_sub_playback)
+		runtime = dev->pcm_sub_playback->runtime;
+	
+	switch (dev->spec.data_alignment) {
+		case 0:
+			fill_out_urb_mode0(dev, urb, iso);
+			break;
+		case 2:
+			fill_out_urb_mode2(dev, urb, iso);
+			break;
+	}
+	
+	if (runtime)
+		if (dev->period_out_count >= runtime->period_size) {
+			snd_pcm_period_elapsed(dev->pcm_sub_playback);
+			dev->period_out_count %= runtime->period_size;
+		}
+}
+
+static void read_completed(struct urb *urb, struct pt_regs *regs)
+{
+	struct snd_usb_caiaq_cb_info *info = (struct snd_usb_caiaq_cb_info *) urb->context; 
+	struct snd_usb_caiaqdev *dev = info->dev;
+	struct urb *out = dev->data_urbs_out[info->index];
+	int frame, len, send_it = 0, outframe = 0;
+
+	if (!dev->streaming)
+		return;
+
+	if (urb->status != 0)
+		return;
+
+	for (frame = 0; frame < FRAMES_PER_URB; frame++) {
+		if (urb->iso_frame_desc[frame].status != 0)
+			continue;
+
+		len = urb->iso_frame_desc[outframe].actual_length;
+		out->iso_frame_desc[outframe].length = len;
+		out->iso_frame_desc[outframe].actual_length = 0;
+		out->iso_frame_desc[outframe].offset = BYTES_PER_FRAME * frame;
+		
+		if (len) {
+			fill_out_urb(dev, out, &out->iso_frame_desc[outframe]);
+			send_it = 1;
+		}
+
+		outframe++;
+	}
+
+	if (send_it) {
+		out->number_of_packets = FRAMES_PER_URB;
+		out->transfer_flags = URB_ISO_ASAP;
+		usb_submit_urb(out, GFP_ATOMIC);
+	}
+
+	for (frame = 0; frame < FRAMES_PER_URB; frame++) {
+		if (urb->iso_frame_desc[frame].status != 0)
+			continue;
+
+		if (urb->iso_frame_desc[frame].actual_length > 0)
+			read_in_urb(dev, urb, &urb->iso_frame_desc[frame]);
+	}
+	
+	/* prepare urb for re-submission */
+	for (frame = 0; frame < FRAMES_PER_URB; frame++) {
+		urb->iso_frame_desc[frame].offset = BYTES_PER_FRAME * frame;
+		urb->iso_frame_desc[frame].length = BYTES_PER_FRAME;
+		urb->iso_frame_desc[frame].actual_length = 0;
+	}
+	
+	urb->number_of_packets = FRAMES_PER_URB;
+	urb->transfer_flags = URB_ISO_ASAP;
+	usb_submit_urb(urb, GFP_ATOMIC);
+}
+
+static void write_completed(struct urb *urb, struct pt_regs *regs)
+{
+}
+
+static struct urb **alloc_urbs(struct snd_usb_caiaqdev *dev, int dir, int *ret)
+{
+	int i, frame;
+	struct urb **urbs;
+	struct usb_device *usb_dev = dev->chip.dev;
+	unsigned int pipe;
+
+	pipe = (dir == SNDRV_PCM_STREAM_PLAYBACK) ? 
+		usb_sndisocpipe(usb_dev, ENDPOINT_PLAYBACK) :
+		usb_rcvisocpipe(usb_dev, ENDPOINT_CAPTURE);
+
+	urbs = (struct urb **) kmalloc(N_URBS * sizeof(struct urb*), GFP_KERNEL);
+	if (!urbs) {
+		log("unable to kmalloc() urbs, OOM!?\n");
+		*ret = -1;
+		return NULL;
+	}
+
+	for (i = 0; i < N_URBS; i++) {
+		urbs[i] = usb_alloc_urb(FRAMES_PER_URB, GFP_KERNEL);
+		if (!urbs[i]) {
+			log("unable to usb_alloc_urb(), OOM!?\n");
+			*ret = -1;
+			return urbs;
+		}
+
+		urbs[i]->transfer_buffer = kmalloc(FRAMES_PER_URB * BYTES_PER_FRAME, GFP_KERNEL);
+		if (!urbs[i]->transfer_buffer) {
+			log("unable to kmalloc() transfer buffer, OOM!?\n");
+			*ret = -1;
+			return urbs;
+		}
+		
+		for (frame = 0; frame < FRAMES_PER_URB; frame++) {
+			urbs[i]->iso_frame_desc[frame].offset = BYTES_PER_FRAME * frame;
+			urbs[i]->iso_frame_desc[frame].length = BYTES_PER_FRAME;
+		}
+		
+		urbs[i]->dev = usb_dev;
+		urbs[i]->pipe = pipe;
+		urbs[i]->transfer_buffer_length = FRAMES_PER_URB * BYTES_PER_FRAME;
+		urbs[i]->context = &dev->data_cb_info[i];
+		urbs[i]->interval = 1;
+		urbs[i]->start_frame = -1;
+		urbs[i]->transfer_flags = URB_ISO_ASAP;
+		urbs[i]->number_of_packets = FRAMES_PER_URB;
+		urbs[i]->complete = (dir == SNDRV_PCM_STREAM_PLAYBACK) ?
+					write_completed : read_completed;
+	}
+
+	*ret = 0;
+	return urbs;
+}
+
+static void free_urbs(struct urb **urbs)
+{
+	int i;
+
+	if (!urbs)
+		return;
+
+	for (i = 0; i < N_URBS; i++) {
+		if (!urbs[i])
+			continue;
+		
+		usb_kill_urb(urbs[i]);
+
+		if (urbs[i]->transfer_buffer) {
+			kfree(urbs[i]->transfer_buffer);
+			urbs[i]->transfer_buffer = NULL;
+		}
+
+		usb_free_urb(urbs[i]);
+		urbs[i] = NULL;
+	}
+
+	kfree(urbs);
+}
+
+
+int __devinit snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
+{
+	int i, ret;
+	struct snd_pcm *pcm;
+
+	dev->n_audio_in  = MAX(dev->spec.num_analog_audio_in, 
+			       dev->spec.num_digital_audio_in) / CHANNELS_PER_STREAM;
+	dev->n_audio_out = MAX(dev->spec.num_analog_audio_out,
+			       dev->spec.num_digital_audio_out) / CHANNELS_PER_STREAM;
+	dev->n_streams   = MAX(dev->n_audio_in, dev->n_audio_out);
+
+	debug("dev->n_audio_in = %d\n", dev->n_audio_in);
+	debug("dev->n_audio_out = %d\n", dev->n_audio_out);
+	debug("dev->n_streams = %d\n", dev->n_streams);
+	
+	ret = snd_pcm_new(dev->chip.card, dev->product_name, 0, 
+			dev->n_streams, dev->n_streams, &pcm);
+
+	if (ret < 0) {
+		log("snd_pcm_new() returned %d\n", ret);
+		return ret;
+	}
+
+	pcm->private_data = dev;
+	strcpy(pcm->name, dev->product_name);
+	dev->pcm = pcm;
+
+	memcpy(&dev->pcm_info_playback, &snd_usb_caiaq_pcm_hardware, sizeof(snd_usb_caiaq_pcm_hardware));
+	memcpy(&dev->pcm_info_capture, &snd_usb_caiaq_pcm_hardware, sizeof(snd_usb_caiaq_pcm_hardware));
+
+	dev->pcm_info_playback.channels_min = CHANNELS_PER_STREAM;
+	dev->pcm_info_playback.channels_max = CHANNELS_PER_STREAM;
+
+	dev->pcm_info_capture.channels_min = CHANNELS_PER_STREAM;
+	dev->pcm_info_capture.channels_max = CHANNELS_PER_STREAM;
+	
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_usb_caiaq_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_usb_caiaq_capture_ops);
+
+	dev->pcm_sub_playback = NULL;
+	dev->pcm_sub_capture = NULL;
+	
+	snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
+				      SNDRV_DMA_TYPE_CONTINUOUS,
+				      snd_dma_continuous_data(GFP_KERNEL),
+				      64*1024, 128*1024);
+
+	snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
+				      SNDRV_DMA_TYPE_CONTINUOUS,
+				      snd_dma_continuous_data(GFP_KERNEL),
+				      64*1024, 128*1024);
+
+	dev->data_cb_info = (struct snd_usb_caiaq_cb_info *) 
+		kmalloc(sizeof(struct snd_usb_caiaq_cb_info) * N_URBS, GFP_KERNEL);
+
+	if (!dev->data_cb_info)
+		return -ENOMEM;
+
+	for (i = 0; i < N_URBS; i++) {
+		dev->data_cb_info[i].dev = dev;
+		dev->data_cb_info[i].index = i;
+	}
+	
+	dev->data_urbs_in = alloc_urbs(dev, SNDRV_PCM_STREAM_CAPTURE, &ret);
+	if (ret < 0) {
+		free_urbs(dev->data_urbs_in);
+		return -ENOMEM;
+	}
+	
+	dev->data_urbs_out = alloc_urbs(dev, SNDRV_PCM_STREAM_PLAYBACK, &ret);
+	if (ret < 0) {
+		free_urbs(dev->data_urbs_in);
+		free_urbs(dev->data_urbs_out);
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&dev->stream_start_work, stream_start, dev);
+	INIT_WORK(&dev->stream_stop_work, stream_stop, dev);
+	INIT_WORK(&dev->stream_restart_work, stream_restart, dev);
+
+	return 0;
+}
+
+void snd_usb_caiaq_audio_free(struct snd_usb_caiaqdev *dev)
+{
+	up(&dev->mutex);
+
+	cancel_delayed_work(&dev->stream_start_work);
+	cancel_delayed_work(&dev->stream_stop_work);
+	stream_stop(dev);
+
+	free_urbs(dev->data_urbs_in);
+	free_urbs(dev->data_urbs_out);
+
+	dev->data_urbs_in = NULL;
+	dev->data_urbs_out = NULL;
+	
+	if (dev->data_cb_info) {
+		kfree(dev->data_cb_info);
+		dev->data_cb_info = NULL;
+	}
+}
+
diff -Nur -x .svn orig/caiaq-audio.h alsa-kernel/usb/caiaq/caiaq-audio.h
--- orig/caiaq-audio.h	1970-01-01 01:00:00.000000000 +0100
+++ alsa-kernel/usb/caiaq/caiaq-audio.h	2006-04-05 15:36:29.000000000 +0200
@@ -0,0 +1,7 @@
+#ifndef CAIAQ_AUDIO_H
+#define CAIAQ_AUDIO_H
+
+int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev);
+void snd_usb_caiaq_audio_free(struct snd_usb_caiaqdev *dev);
+
+#endif /* CAIAQ_AUDIO_H */
diff -Nur -x .svn orig/caiaq-device.c alsa-kernel/usb/caiaq/caiaq-device.c
--- orig/caiaq-device.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-kernel/usb/caiaq/caiaq-device.c	2006-04-05 15:35:21.000000000 +0200
@@ -0,0 +1,397 @@
+/*
+ * caiaq.c: ALSA driver for caiaq/NativeInstrument devices
+ *
+ *   Copyright (c) 2006 Daniel Mack
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/interrupt.h>
+#include <linux/usb.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/rawmidi.h>
+
+#include "caiaq-device.h"
+#include "caiaq-audio.h"
+#include "caiaq-midi.h"
+
+MODULE_AUTHOR("Daniel Mack <daniel@caiaq.org>");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.0.0");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{{NI(0x17cc), (0x1969)(0x4711) }}");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
+static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable this card */
+static int snd_card_used[SNDRV_CARDS];
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for the caiaq sound device");
+
+enum {
+	SAMPLERATE_44100	= 0,
+	SAMPLERATE_48000	= 1,
+	SAMPLERATE_96000	= 2,
+	SAMPLERATE_192000	= 3,
+	SAMPLERATE_INVALID	= 0xff
+};
+
+enum {
+	DEPTH_NONE	= 0,
+	DEPTH_16	= 1,
+	DEPTH_24	= 2,
+	DEPTH_32	= 3
+};
+
+static struct usb_device_id snd_usb_id_table[] = {
+	{
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =	USB_PID_RIGKONTROL2 
+	},
+	{
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =	USB_PID_KORECONTROLLER
+	},
+	{ /* terminator */ }
+};
+
+static void usb_ep1_command_reply_dispatch (struct urb* urb, struct pt_regs *regs)
+{
+	struct snd_usb_caiaqdev *dev = (struct snd_usb_caiaqdev *) urb->context;
+	char *buf = urb->transfer_buffer;
+
+	if (urb->status != 0)
+		return;
+
+	switch(buf[0]) {
+	case EP1_CMD_GET_DEVICE_INFO:
+	{
+	 	memcpy(&dev->spec, buf+1, sizeof(struct caiaq_device_spec));
+		
+		debug("--- dumping spec ---\n");
+		debug(".............firmware version: 0x%04x\n", dev->spec.fw_version);
+		debug(".............hardware sub-type: %d\n", dev->spec.hw_subtype);
+		debug(".............num of ERP: %d\n", dev->spec.num_erp);
+		debug(".............num of analog inputs: %d\n", dev->spec.num_analog_in);
+		debug(".............num of digital inputs: %d\n", dev->spec.num_digital_in);
+		debug(".............num of digital outputs: %d\n", dev->spec.num_digital_out);
+		debug(".............num of analog audio outputs: %d\n", dev->spec.num_analog_audio_out);
+		debug(".............num of analog audio inputs: %d\n", dev->spec.num_analog_audio_in);
+		debug(".............num of digital audio outputs: %d\n", dev->spec.num_digital_audio_out);
+		debug(".............num of digital audio inputs: %d\n", dev->spec.num_digital_audio_in);
+		debug(".............num of MIDI out: %d\n", dev->spec.num_midi_out);
+		debug(".............num of MIDI in: %d\n", dev->spec.num_midi_in);
+		debug(".............data_alignment: %d\n", dev->spec.data_alignment);
+	
+		schedule_delayed_work(&dev->setup_work, 0);
+		break;
+	}
+	case EP1_CMD_AUDIO_PARAMS:
+		if (buf[1] != 1)
+			debug("unable to set the device's audio params\n");
+		break;
+	case EP1_CMD_MIDI_READ:
+		snd_usb_caiaq_midi_handle_input(dev, buf[1], &buf[3], buf[2]);
+		break;
+	}
+
+	dev->ep1_in_urb->actual_length = 0;
+	usb_submit_urb(dev->ep1_in_urb, GFP_KERNEL);
+}
+
+static int send_command (struct snd_usb_caiaqdev *dev,
+			 unsigned char command, 
+			 const unsigned char *buffer,
+			 int len)
+{
+	int ret, actual_len;
+	struct usb_device *usb_dev = dev->chip.dev;
+	char tmp[EP1_BUFSIZE];
+
+	if (!usb_dev)
+		return -EIO;
+
+	if (len > EP1_BUFSIZE - 1)
+		len = EP1_BUFSIZE - 1;
+
+	if (buffer && len > 0)
+		memcpy(tmp+1, buffer, len);
+	
+	tmp[0] = command;
+
+	ret = usb_bulk_msg(usb_dev, usb_sndbulkpipe(usb_dev, 1),
+			   tmp, len+1, &actual_len, 200);
+	
+	return ret;
+}
+
+int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *dev,
+		   		    int rate, int depth, int bbp)
+{
+	char tmp[5];
+	
+	switch (rate) {
+		case 44100:	tmp[0] = SAMPLERATE_44100;   break;
+		case 48000:	tmp[0] = SAMPLERATE_48000;   break;
+		case 96000:	tmp[0] = SAMPLERATE_96000;   break;
+		case 192000:	tmp[0] = SAMPLERATE_192000;  break;
+		default:	return -EINVAL;
+	}
+
+	switch (depth) {
+		case 16:	tmp[1] = DEPTH_16;   break;
+		case 24:	tmp[1] = DEPTH_24;   break;
+		default:	return -EINVAL;
+	}
+
+	tmp[2] = cpu_to_le16(bbp) & 0xff;
+	tmp[3] = cpu_to_le16(bbp) >> 8;
+	tmp[4] = 1; /* packets per microframe */
+
+	return send_command(dev, EP1_CMD_AUDIO_PARAMS, tmp, sizeof(tmp));
+}
+
+int snd_usb_caiaq_midi_send (struct snd_usb_caiaqdev *dev,
+			     int port, char *buf, int len)
+{
+	char tmp[EP1_BUFSIZE];
+
+	if (len > EP1_BUFSIZE-2) {
+		debug("warning! MIDI overflow!\n");
+		len = EP1_BUFSIZE-2;
+	}
+
+	tmp[0] = port;
+	memcpy(tmp+1, buf, len);
+	return send_command(dev, EP1_CMD_MIDI_WRITE, tmp, len+1);
+}
+
+static void setup_card(void *data)
+{
+	int ret;
+	struct snd_usb_caiaqdev *dev = (struct snd_usb_caiaqdev *) data;
+	struct usb_device *usb_dev = dev->chip.dev;
+	
+	/* device-specific startup specials: */
+	if (usb_dev->descriptor.idVendor == USB_VID_NATIVEINSTRUMENTS &&
+	    usb_dev->descriptor.idProduct == USB_PID_RIGKONTROL2) {
+		char val[3];
+		
+		/* RigKontrol2 - display centered dash ('-') */
+		val[0] = 0x00;
+		val[1] = 0x00;
+		val[2] = 0x01;
+		send_command(dev, EP1_CMD_WRITE_IO, val, 3);
+	}
+	
+	ret = snd_usb_caiaq_audio_init(dev);
+	if (ret != 0)
+		log("Unable to set up audio system (ret=%d)\n", ret);
+	
+	ret = snd_usb_caiaq_midi_init(dev);
+	if (ret != 0)
+		log("Unable to set up MIDI system (ret=%d)\n", ret);
+
+	/* finally, register the card and all its sub-instances */
+	ret = snd_card_register(dev->chip.card);
+	if (ret < 0) {
+		log("snd_card_register() returned %d\n", ret);
+		snd_card_free(dev->chip.card);
+	}
+}
+
+static struct snd_card* create_card(struct usb_device* usb_dev)
+{
+	int devnum;
+	struct snd_card *card;
+	struct snd_usb_caiaqdev *dev;
+
+	for (devnum = 0; devnum < SNDRV_CARDS; devnum++)
+		if (enable[devnum] && !snd_card_used[devnum])
+			break;
+
+	if (devnum >= SNDRV_CARDS)
+		return NULL;
+
+	card = snd_card_new(index[devnum], id[devnum], THIS_MODULE, sizeof(struct snd_usb_caiaqdev));
+	if (!card)
+		return NULL;
+
+	dev = caiaqdev(card);
+	
+	dev->chip.dev = usb_dev;
+	dev->chip.card = card;
+	init_MUTEX(&dev->mutex);
+	
+	snd_card_set_dev(card, &usb_dev->dev);
+
+	return card;
+}
+
+static int init_card(struct snd_usb_caiaqdev *dev)
+{
+	char *c;
+	struct usb_device *usb_dev = dev->chip.dev;
+	struct snd_card *card = dev->chip.card;
+	
+	if (usb_set_interface(usb_dev, 0, 1) != 0) {
+		log("can't set alt interface.\n");
+		return -EIO;
+	}
+
+	dev->ep1_in_urb = usb_alloc_urb(0, GFP_KERNEL);
+	dev->midi_out_urb = usb_alloc_urb(0, GFP_KERNEL);
+
+	if (!dev->ep1_in_urb || !dev->midi_out_urb)
+		return -ENOMEM;
+
+	dev->ep1_in_buf = kmalloc(EP1_BUFSIZE, GFP_KERNEL);
+	dev->midi_out_buf = kmalloc(EP1_BUFSIZE, GFP_KERNEL);
+	
+	if (!dev->ep1_in_buf || !dev->midi_out_buf) {
+		usb_free_urb(dev->ep1_in_urb);
+		usb_free_urb(dev->midi_out_urb);
+		return -ENOMEM;
+	}
+
+	usb_fill_bulk_urb(dev->ep1_in_urb, usb_dev, usb_rcvbulkpipe(usb_dev, 0x1),
+			  dev->ep1_in_buf, EP1_BUFSIZE, usb_ep1_command_reply_dispatch, dev);
+
+	usb_fill_bulk_urb(dev->midi_out_urb, usb_dev, usb_sndbulkpipe(usb_dev, 0x1),
+			  dev->midi_out_buf, EP1_BUFSIZE, snd_usb_caiaq_midi_output_done, dev);
+	
+	if (usb_submit_urb(dev->ep1_in_urb, GFP_KERNEL) != 0)
+		return -EIO;
+
+	INIT_WORK(&dev->setup_work, setup_card, dev);
+	send_command(dev, EP1_CMD_GET_DEVICE_INFO, NULL, 0);
+
+	usb_string(usb_dev, usb_dev->descriptor.iManufacturer,
+			dev->vendor_name, CAIAQ_USB_STR_LEN);
+	
+	usb_string(usb_dev, usb_dev->descriptor.iProduct,
+			dev->product_name, CAIAQ_USB_STR_LEN);
+	
+	usb_string(usb_dev, usb_dev->descriptor.iSerialNumber,
+			dev->serial, CAIAQ_USB_STR_LEN);
+
+	/* terminate serial string at first white space occurence */
+	c = strchr(dev->serial, ' ');
+	if (c)
+		*c = '\0';
+	
+	strcpy(card->driver, MODNAME);
+	strcpy(card->shortname, dev->product_name);
+	sprintf(card->longname, "%s %s (USB ID %04x/%04x, serial %s)", 
+			dev->vendor_name, dev->product_name,
+			usb_dev->descriptor.idVendor, usb_dev->descriptor.idProduct,
+			dev->serial);
+	
+	return 0;
+}
+
+static int snd_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	int ret;
+	struct snd_card *card;
+	struct usb_device *device = interface_to_usbdev(intf);
+	
+	card = create_card(device);
+	
+	if (!card)
+		return -EIO;
+			
+	dev_set_drvdata(&intf->dev, card);
+
+	ret = init_card(caiaqdev(card));
+	if (ret < 0) {
+		log("unable to init card! (ret=%d)\n", ret);
+		return ret;
+	}
+	
+	return 0;
+}
+
+static void snd_disconnect(struct usb_interface *intf)
+{
+	struct snd_usb_caiaqdev *dev;
+	void *ptr = dev_get_drvdata(&intf->dev);
+
+	debug("snd_disconnect(%p)\n", intf);
+
+	if (!ptr)
+		return;
+
+	dev = caiaqdev((struct snd_card*) ptr);
+
+	snd_usb_caiaq_audio_free(dev);
+	cancel_delayed_work(&dev->setup_work);
+
+	if (dev->ep1_in_urb) {
+		usb_kill_urb(dev->ep1_in_urb);
+		usb_free_urb(dev->ep1_in_urb);
+		dev->ep1_in_urb = NULL;
+	}
+	
+	if (dev->midi_out_urb) {
+		usb_kill_urb(dev->midi_out_urb);
+		usb_free_urb(dev->midi_out_urb);
+		dev->midi_out_urb = NULL;
+	}
+
+	if (dev->ep1_in_buf) {
+		kfree(dev->ep1_in_buf);
+		dev->ep1_in_buf = NULL;
+	}
+
+	if (dev->midi_out_buf) {
+		kfree(dev->midi_out_buf);
+		dev->midi_out_buf = NULL;
+	}
+
+	snd_card_free((struct snd_card*) ptr);
+}
+
+
+MODULE_DEVICE_TABLE(usb, snd_usb_id_table);
+static struct usb_driver snd_usb_driver = {
+ 	.owner 		= THIS_MODULE,
+	.name 		= MODNAME,
+	.probe 		= snd_probe,
+	.disconnect	= snd_disconnect,
+	.id_table 	= snd_usb_id_table,
+};
+
+static int __init snd_module_init(void)
+{
+	return usb_register(&snd_usb_driver);
+}
+
+static void __exit snd_module_exit(void)
+{
+	usb_deregister(&snd_usb_driver);
+}
+
+module_init(snd_module_init)
+module_exit(snd_module_exit)
+
diff -Nur -x .svn orig/caiaq-device.h alsa-kernel/usb/caiaq/caiaq-device.h
--- orig/caiaq-device.h	1970-01-01 01:00:00.000000000 +0100
+++ alsa-kernel/usb/caiaq/caiaq-device.h	2006-04-05 15:25:24.000000000 +0200
@@ -0,0 +1,111 @@
+#ifndef CAIAQ_DEVICE_H
+#define CAIAQ_DEVICE_H
+
+#include "../usbaudio.h"
+
+#define USB_VID_NATIVEINSTRUMENTS 0x17cc
+
+#define USB_PID_RIGKONTROL2	0x1969
+#define USB_PID_KORECONTROLLER 	0x4711
+
+#define EP1_BUFSIZE 64
+#define CAIAQ_USB_STR_LEN 0xff
+
+//#define	SND_USB_CAIAQ_DEBUG
+
+#define MODNAME "snd-usb-caiaq"
+#define log(x...) snd_printk(KERN_WARNING MODNAME" log: " x)
+
+#ifdef SND_USB_CAIAQ_DEBUG
+#define debug(x...) snd_printk(KERN_WARNING MODNAME " debug: " x)
+#else
+#define debug(x...)
+#endif
+
+#define EP1_CMD_GET_DEVICE_INFO	0x1
+#define EP1_CMD_WRITE_IO	0x5
+#define EP1_CMD_MIDI_READ	0x6
+#define EP1_CMD_MIDI_WRITE	0x7
+#define EP1_CMD_AUDIO_PARAMS	0x9
+
+struct caiaq_device_spec {
+	unsigned short fw_version;
+	unsigned char hw_subtype;
+	unsigned char num_erp;
+	unsigned char num_analog_in;
+	unsigned char num_digital_in;
+	unsigned char num_digital_out;
+	unsigned char num_analog_audio_out;
+	unsigned char num_analog_audio_in;
+	unsigned char num_digital_audio_out;
+	unsigned char num_digital_audio_in;
+	unsigned char num_midi_out;
+	unsigned char num_midi_in;
+	unsigned char data_alignment;
+} __attribute__ ((packed));
+
+struct snd_usb_caiaq_cb_info;
+
+struct snd_usb_caiaqdev {
+	struct snd_usb_audio chip;
+
+	struct urb *ep1_in_urb;
+	struct urb *midi_out_urb;
+	struct urb **data_urbs_in;
+	struct urb **data_urbs_out;
+
+	struct snd_usb_caiaq_cb_info *data_cb_info;
+	
+	unsigned char *ep1_in_buf;
+	unsigned char *midi_out_buf;
+
+	struct caiaq_device_spec spec;
+	struct work_struct setup_work;
+	struct work_struct stream_start_work;
+	struct work_struct stream_stop_work;
+	struct work_struct stream_restart_work;
+	struct semaphore mutex;
+	
+	int n_streams;
+	int n_audio_in, n_audio_out;
+	int streaming;
+	int stream_pitch;
+	
+	char vendor_name[CAIAQ_USB_STR_LEN];
+	char product_name[CAIAQ_USB_STR_LEN];
+	char serial[CAIAQ_USB_STR_LEN];
+
+	int audio_in_buf_pos;
+	int audio_out_buf_pos;
+
+	int period_in_count;
+	int period_out_count;
+
+	int input_panic;
+	int output_panic;
+	int first_packet;
+	
+	//ALSA
+	struct snd_pcm *pcm;
+	struct snd_pcm_substream *pcm_sub_playback;
+	struct snd_pcm_substream *pcm_sub_capture;
+	struct snd_pcm_hardware pcm_info_playback, pcm_info_capture;
+
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_substream *midi_receive_substream;
+
+	struct snd_rawmidi_substream *midi_out_substream;
+};
+
+struct snd_usb_caiaq_cb_info {
+	struct snd_usb_caiaqdev *dev;
+	int index;
+};
+
+#define caiaqdev(c) ((struct snd_usb_caiaqdev*)(c)->private_data)
+
+int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *dev, int rate, int depth, int bbp);
+int snd_usb_caiaq_midi_send (struct snd_usb_caiaqdev *dev, int port, char *buf, int len);
+
+
+#endif /* CAIAQ_DEVICE_H */
diff -Nur -x .svn orig/caiaq-midi.c alsa-kernel/usb/caiaq/caiaq-midi.c
--- orig/caiaq-midi.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-kernel/usb/caiaq/caiaq-midi.c	2006-04-05 15:36:59.000000000 +0200
@@ -0,0 +1,165 @@
+/*
+ *   Copyright (c) 2006 Daniel Mack
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/interrupt.h>
+#include <linux/usb.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/rawmidi.h>
+#include <sound/pcm.h>
+
+#include "caiaq-device.h"
+#include "caiaq-midi.h"
+
+
+static int snd_usb_caiaq_midi_input_open(struct snd_rawmidi_substream * substream)
+{
+	return 0;
+}
+
+static int snd_usb_caiaq_midi_input_close(struct snd_rawmidi_substream * substream)
+{
+	return 0;
+}
+
+static void snd_usb_caiaq_midi_input_trigger(struct snd_rawmidi_substream * substream, int up)
+{
+	struct snd_usb_caiaqdev *dev = (struct snd_usb_caiaqdev *)
+		substream->rmidi->private_data;
+
+	if (!dev)
+		return;
+	
+	dev->midi_receive_substream = up ? substream : NULL;
+}
+
+
+static int snd_usb_caiaq_midi_output_open(struct snd_rawmidi_substream * substream)
+{
+	return 0;
+}
+
+static int snd_usb_caiaq_midi_output_close(struct snd_rawmidi_substream * substream)
+{
+	return 0;
+}
+
+static void snd_usb_caiaq_midi_output_trigger(struct snd_rawmidi_substream * substream, int up)
+{
+	int len, ret;
+	struct snd_usb_caiaqdev *dev = (struct snd_usb_caiaqdev *) 
+					substream->rmidi->private_data;
+	
+	if (dev->midi_out_substream != NULL)
+		return;
+	
+	if (!up) {
+		dev->midi_out_substream = NULL;
+		return;
+	}
+
+	dev->midi_out_substream = substream;
+	dev->midi_out_buf[0] = EP1_CMD_MIDI_WRITE;
+	dev->midi_out_buf[1] = 0; /* port */
+	len = snd_rawmidi_transmit_peek(substream, dev->midi_out_buf+3, EP1_BUFSIZE-3);
+	dev->midi_out_buf[2] = len;
+	dev->midi_out_urb->transfer_buffer_length = len+3;
+	
+	ret = usb_submit_urb(dev->midi_out_urb, GFP_ATOMIC);
+	if (ret < 0)
+		log("snd_usb_caiaq_midi_output_trigger(%p): usb_submit_urb() failed, %d\n",
+				substream, ret);
+	
+	debug("snd_usb_caiaq_midi_output_trigger(%p): sent %d bytes\n", substream, len);
+}
+
+
+static struct snd_rawmidi_ops snd_usb_caiaq_midi_output =
+{
+	.open =		snd_usb_caiaq_midi_output_open,
+	.close =	snd_usb_caiaq_midi_output_close,
+	.trigger =      snd_usb_caiaq_midi_output_trigger,
+};
+
+static struct snd_rawmidi_ops snd_usb_caiaq_midi_input =
+{
+	.open =		snd_usb_caiaq_midi_input_open,
+	.close =	snd_usb_caiaq_midi_input_close,
+	.trigger =      snd_usb_caiaq_midi_input_trigger,
+};
+
+void snd_usb_caiaq_midi_handle_input(struct snd_usb_caiaqdev *dev, int port, const char *buf, int len)
+{
+	if (!dev->midi_receive_substream)
+		return;
+	
+	snd_rawmidi_receive(dev->midi_receive_substream, buf, len);
+}
+
+int __devinit snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev *device)
+{
+	int ret;
+	struct snd_rawmidi *rmidi;
+
+	ret = snd_rawmidi_new(device->chip.card, device->product_name, 0,
+					device->spec.num_midi_out,
+					device->spec.num_midi_in,
+					&rmidi);
+
+	if (ret < 0)
+		return ret;
+
+	strcpy(rmidi->name, device->product_name);
+
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_DUPLEX;
+	rmidi->private_data = device;
+
+	if (device->spec.num_midi_out > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_usb_caiaq_midi_output);
+	}
+
+	if (device->spec.num_midi_in > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_usb_caiaq_midi_input);
+	}
+	
+	device->rmidi = rmidi;
+
+	return 0;
+}
+
+void snd_usb_caiaq_midi_output_done(struct urb* urb, struct pt_regs *regs)
+{
+	struct snd_usb_caiaqdev *dev = (struct snd_usb_caiaqdev *) urb->context;
+      	char *buf = urb->transfer_buffer;
+	
+	if (urb->status != 0)
+		return;
+
+	if (!dev->midi_out_substream)
+		return;
+
+	snd_rawmidi_transmit_ack(dev->midi_out_substream, buf[2]);
+	dev->midi_out_substream = NULL;
+}
+
diff -Nur -x .svn orig/caiaq-midi.h alsa-kernel/usb/caiaq/caiaq-midi.h
--- orig/caiaq-midi.h	1970-01-01 01:00:00.000000000 +0100
+++ alsa-kernel/usb/caiaq/caiaq-midi.h	2006-04-04 17:44:14.000000000 +0200
@@ -0,0 +1,8 @@
+#ifndef CAIAQ_MIDI_H
+#define CAIAQ_MIDI_H
+
+int snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev *dev);
+void snd_usb_caiaq_midi_handle_input(struct snd_usb_caiaqdev *dev, int port, const char *buf, int len);
+void snd_usb_caiaq_midi_output_done(struct urb* urb, struct pt_regs *regs);
+
+#endif /* CAIAQ_MIDI_H */
diff -Nur -x .svn orig/.cvsignore alsa-driver/usb/caiaq/.cvsignore
--- orig/.cvsignore	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver/usb/caiaq/.cvsignore	2006-04-05 14:54:42.000000000 +0200
@@ -0,0 +1,4 @@
+.depend
+.*.cmd
+*.ko
+*.mod.c
diff -Nur -x .svn orig/Makefile alsa-driver/usb/caiaq/Makefile
--- orig/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver/usb/caiaq/Makefile	2006-04-05 15:04:10.000000000 +0200
@@ -0,0 +1,19 @@
+ifndef SND_TOPDIR
+SND_TOPDIR=../..
+endif
+
+include $(SND_TOPDIR)/toplevel.config
+include $(SND_TOPDIR)/Makefile.conf
+
+clean-files := caiaq-device.c caiaq-audio.c caiaq-midi.c
+
+include $(SND_TOPDIR)/alsa-kernel/usb/caiaq/Makefile
+
+EXTRA_CFLAGS += -I$(SND_TOPDIR)/alsa-kernel/usb/caiaq
+
+include $(SND_TOPDIR)/Rules.make
+
+caiaq-device.c: $(SND_TOPDIR)/alsa-kernel/usb/caiaq/caiaq-device.c
+caiaq-audio.c: $(SND_TOPDIR)/alsa-kernel/usb/caiaq/caiaq-audio.c
+caiaq-midi.c: $(SND_TOPDIR)/alsa-kernel/usb/caiaq/caiaq-midi.c
+

--Apple-Mail-1-582805674--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
