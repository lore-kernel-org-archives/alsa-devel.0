From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: snd-usb-caiaq: switch to dev_*()
	logging
Date: Sun,  3 Mar 2013 20:46:22 +0100
Message-ID: <1362339982-13977-2-git-send-email-zonque@gmail.com>
References: <1362339982-13977-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id EFF332625DD
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 20:46:37 +0100 (CET)
In-Reply-To: <1362339982-13977-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Get rid of the proprietary functions log() and debug() and use the
generic dev_*() approach. A macro is needed to cast a cdev to a struct
device *.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/caiaq/audio.c   | 61 ++++++++++++++++++++++++++++++-----------------
 sound/usb/caiaq/control.c |  1 +
 sound/usb/caiaq/device.c  | 42 +++++++++++++++++---------------
 sound/usb/caiaq/device.h  | 10 +-------
 sound/usb/caiaq/input.c   |  8 +++++--
 sound/usb/caiaq/midi.c    |  9 +++----
 6 files changed, 75 insertions(+), 56 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 75d8ba9..67330af 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -16,6 +16,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */
 
+#include <linux/device.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -101,8 +102,9 @@ all_substreams_zero(struct snd_pcm_substream **subs)
 static int stream_start(struct snd_usb_caiaqdev *cdev)
 {
 	int i, ret;
+	struct device *dev = caiaqdev_to_dev(cdev);
 
-	debug("%s(%p)\n", __func__, cdev);
+	dev_dbg(dev, "%s(%p)\n", __func__, cdev);
 
 	if (cdev->streaming)
 		return -EINVAL;
@@ -118,7 +120,8 @@ static int stream_start(struct snd_usb_caiaqdev *cdev)
 	for (i = 0; i < N_URBS; i++) {
 		ret = usb_submit_urb(cdev->data_urbs_in[i], GFP_ATOMIC);
 		if (ret) {
-			log("unable to trigger read #%d! (ret %d)\n", i, ret);
+			dev_err(dev, "unable to trigger read #%d! (ret %d)\n",
+				i, ret);
 			cdev->streaming = 0;
 			return -EPIPE;
 		}
@@ -130,8 +133,9 @@ static int stream_start(struct snd_usb_caiaqdev *cdev)
 static void stream_stop(struct snd_usb_caiaqdev *cdev)
 {
 	int i;
+	struct device *dev = caiaqdev_to_dev(cdev);
 
-	debug("%s(%p)\n", __func__, cdev);
+	dev_dbg(dev, "%s(%p)\n", __func__, cdev);
 	if (!cdev->streaming)
 		return;
 
@@ -150,17 +154,21 @@ static void stream_stop(struct snd_usb_caiaqdev *cdev)
 static int snd_usb_caiaq_substream_open(struct snd_pcm_substream *substream)
 {
 	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(substream);
-	debug("%s(%p)\n", __func__, substream);
+	struct device *dev = caiaqdev_to_dev(cdev);
+
+	dev_dbg(dev, "%s(%p)\n", __func__, substream);
 	substream->runtime->hw = cdev->pcm_info;
 	snd_pcm_limit_hw_rates(substream->runtime);
+
 	return 0;
 }
 
 static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 {
 	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(substream);
+	struct device *dev = caiaqdev_to_dev(cdev);
 
-	debug("%s(%p)\n", __func__, substream);
+	dev_dbg(dev, "%s(%p)\n", __func__, substream);
 	if (all_substreams_zero(cdev->sub_playback) &&
 	    all_substreams_zero(cdev->sub_capture)) {
 		/* when the last client has stopped streaming,
@@ -175,14 +183,12 @@ static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 static int snd_usb_caiaq_pcm_hw_params(struct snd_pcm_substream *sub,
 				       struct snd_pcm_hw_params *hw_params)
 {
-	debug("%s(%p)\n", __func__, sub);
 	return snd_pcm_lib_malloc_pages(sub, params_buffer_bytes(hw_params));
 }
 
 static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *sub)
 {
 	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(sub);
-	debug("%s(%p)\n", __func__, sub);
 	deactivate_substream(cdev, sub);
 	return snd_pcm_lib_free_pages(sub);
 }
@@ -201,8 +207,9 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 	int index = substream->number;
 	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct device *dev = caiaqdev_to_dev(cdev);
 
-	debug("%s(%p)\n", __func__, substream);
+	dev_dbg(dev, "%s(%p)\n", __func__, substream);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		int out_pos;
@@ -283,8 +290,9 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 static int snd_usb_caiaq_pcm_trigger(struct snd_pcm_substream *sub, int cmd)
 {
 	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(sub);
+	struct device *dev = caiaqdev_to_dev(cdev);
 
-	debug("%s(%p) cmd %d\n", __func__, sub, cmd);
+	dev_dbg(dev, "%s(%p) cmd %d\n", __func__, sub, cmd);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -443,6 +451,7 @@ static void read_in_urb_mode3(struct snd_usb_caiaqdev *cdev,
 			      const struct usb_iso_packet_descriptor *iso)
 {
 	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
+	struct device *dev = caiaqdev_to_dev(cdev);
 	int stream, i;
 
 	/* paranoia check */
@@ -479,8 +488,8 @@ static void read_in_urb_mode3(struct snd_usb_caiaqdev *cdev,
 				if (usb_buf[i] != ((stream << 1) | c) &&
 				    !cdev->first_packet) {
 					if (!cdev->input_panic)
-						printk(" EXPECTED: %02x got %02x, c %d, stream %d, i %d\n",
-							((stream << 1) | c), usb_buf[i], c, stream, i);
+						dev_warn(dev, " EXPECTED: %02x got %02x, c %d, stream %d, i %d\n",
+							 ((stream << 1) | c), usb_buf[i], c, stream, i);
 					cdev->input_panic = 1;
 				}
 
@@ -497,6 +506,8 @@ static void read_in_urb(struct snd_usb_caiaqdev *cdev,
 			const struct urb *urb,
 			const struct usb_iso_packet_descriptor *iso)
 {
+	struct device *dev = caiaqdev_to_dev(cdev);
+
 	if (!cdev->streaming)
 		return;
 
@@ -516,7 +527,7 @@ static void read_in_urb(struct snd_usb_caiaqdev *cdev,
 	}
 
 	if ((cdev->input_panic || cdev->output_panic) && !cdev->warned) {
-		debug("streaming error detected %s %s\n",
+		dev_warn(dev, "streaming error detected %s %s\n",
 				cdev->input_panic ? "(input)" : "",
 				cdev->output_panic ? "(output)" : "");
 		cdev->warned = 1;
@@ -619,6 +630,7 @@ static void read_completed(struct urb *urb)
 {
 	struct snd_usb_caiaq_cb_info *info = urb->context;
 	struct snd_usb_caiaqdev *cdev;
+	struct device *dev;
 	struct urb *out = NULL;
 	int i, frame, len, send_it = 0, outframe = 0;
 	size_t offset = 0;
@@ -627,6 +639,7 @@ static void read_completed(struct urb *urb)
 		return;
 
 	cdev = info->cdev;
+	dev = caiaqdev_to_dev(cdev);
 
 	if (!cdev->streaming)
 		return;
@@ -639,7 +652,7 @@ static void read_completed(struct urb *urb)
 		}
 
 	if (!out) {
-		log("Unable to find an output urb to use\n");
+		dev_err(dev, "Unable to find an output urb to use\n");
 		goto requeue;
 	}
 
@@ -708,6 +721,7 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *cdev, int dir, int *ret)
 	int i, frame;
 	struct urb **urbs;
 	struct usb_device *usb_dev = cdev->chip.dev;
+	struct device *dev = caiaqdev_to_dev(cdev);
 	unsigned int pipe;
 
 	pipe = (dir == SNDRV_PCM_STREAM_PLAYBACK) ?
@@ -716,7 +730,7 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *cdev, int dir, int *ret)
 
 	urbs = kmalloc(N_URBS * sizeof(*urbs), GFP_KERNEL);
 	if (!urbs) {
-		log("unable to kmalloc() urbs, OOM!?\n");
+		dev_err(dev, "unable to kmalloc() urbs, OOM!?\n");
 		*ret = -ENOMEM;
 		return NULL;
 	}
@@ -724,7 +738,7 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *cdev, int dir, int *ret)
 	for (i = 0; i < N_URBS; i++) {
 		urbs[i] = usb_alloc_urb(FRAMES_PER_URB, GFP_KERNEL);
 		if (!urbs[i]) {
-			log("unable to usb_alloc_urb(), OOM!?\n");
+			dev_err(dev, "unable to usb_alloc_urb(), OOM!?\n");
 			*ret = -ENOMEM;
 			return urbs;
 		}
@@ -732,7 +746,7 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *cdev, int dir, int *ret)
 		urbs[i]->transfer_buffer =
 			kmalloc(FRAMES_PER_URB * BYTES_PER_FRAME, GFP_KERNEL);
 		if (!urbs[i]->transfer_buffer) {
-			log("unable to kmalloc() transfer buffer, OOM!?\n");
+			dev_err(dev, "unable to kmalloc() transfer buffer, OOM!?\n");
 			*ret = -ENOMEM;
 			return urbs;
 		}
@@ -783,6 +797,7 @@ static void free_urbs(struct urb **urbs)
 int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 {
 	int i, ret;
+	struct device *dev = caiaqdev_to_dev(cdev);
 
 	cdev->n_audio_in  = max(cdev->spec.num_analog_audio_in,
 			       cdev->spec.num_digital_audio_in) /
@@ -792,12 +807,12 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 				CHANNELS_PER_STREAM;
 	cdev->n_streams = max(cdev->n_audio_in, cdev->n_audio_out);
 
-	debug("cdev->n_audio_in = %d\n", cdev->n_audio_in);
-	debug("cdev->n_audio_out = %d\n", cdev->n_audio_out);
-	debug("cdev->n_streams = %d\n", cdev->n_streams);
+	dev_dbg(dev, "cdev->n_audio_in = %d\n", cdev->n_audio_in);
+	dev_dbg(dev, "cdev->n_audio_out = %d\n", cdev->n_audio_out);
+	dev_dbg(dev, "cdev->n_streams = %d\n", cdev->n_streams);
 
 	if (cdev->n_streams > MAX_STREAMS) {
-		log("unable to initialize device, too many streams.\n");
+		dev_err(dev, "unable to initialize device, too many streams.\n");
 		return -EINVAL;
 	}
 
@@ -805,7 +820,7 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 			cdev->n_audio_out, cdev->n_audio_in, &cdev->pcm);
 
 	if (ret < 0) {
-		log("snd_pcm_new() returned %d\n", ret);
+		dev_err(dev, "snd_pcm_new() returned %d\n", ret);
 		return ret;
 	}
 
@@ -880,7 +895,9 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 
 void snd_usb_caiaq_audio_free(struct snd_usb_caiaqdev *cdev)
 {
-	debug("%s(%p)\n", __func__, cdev);
+	struct device *dev = caiaqdev_to_dev(cdev);
+
+	dev_dbg(dev, "%s(%p)\n", __func__, cdev);
 	stream_stop(cdev);
 	free_urbs(cdev->data_urbs_in);
 	free_urbs(cdev->data_urbs_out);
diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index 2c51959..ae6b50f 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -17,6 +17,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/usb.h>
 #include <sound/control.h>
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 45c3853..d898f73 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -20,6 +20,7 @@
 */
 
 #include <linux/moduleparam.h>
+#include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -159,10 +160,11 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 {
 	int ret;
 	struct snd_usb_caiaqdev *cdev = urb->context;
+	struct device *dev = caiaqdev_to_dev(cdev);
 	unsigned char *buf = urb->transfer_buffer;
 
 	if (urb->status || !cdev) {
-		log("received EP1 urb->status = %i\n", urb->status);
+		dev_warn(dev, "received EP1 urb->status = %i\n", urb->status);
 		return;
 	}
 
@@ -170,7 +172,7 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 	case EP1_CMD_GET_DEVICE_INFO:
 	 	memcpy(&cdev->spec, buf+1, sizeof(struct caiaq_device_spec));
 		cdev->spec.fw_version = le16_to_cpu(cdev->spec.fw_version);
-		debug("device spec (firmware %d): audio: %d in, %d out, "
+		dev_dbg(dev, "device spec (firmware %d): audio: %d in, %d out, "
 			"MIDI: %d in, %d out, data alignment %d\n",
 			cdev->spec.fw_version,
 			cdev->spec.num_analog_audio_in,
@@ -209,7 +211,7 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 	cdev->ep1_in_urb.actual_length = 0;
 	ret = usb_submit_urb(&cdev->ep1_in_urb, GFP_ATOMIC);
 	if (ret < 0)
-		log("unable to submit urb. OOM!?\n");
+		dev_err(dev, "unable to submit urb. OOM!?\n");
 }
 
 int snd_usb_caiaq_send_command(struct snd_usb_caiaqdev *cdev,
@@ -239,6 +241,7 @@ int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *cdev,
 {
 	int ret;
 	char tmp[5];
+	struct device *dev = caiaqdev_to_dev(cdev);
 
 	switch (rate) {
 	case 44100:	tmp[0] = SAMPLERATE_44100;   break;
@@ -259,7 +262,7 @@ int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *cdev,
 	tmp[3] = bpp >> 8;
 	tmp[4] = 1; /* packets per microframe */
 
-	debug("setting audio params: %d Hz, %d bits, %d bpp\n",
+	dev_dbg(dev, "setting audio params: %d Hz, %d bits, %d bpp\n",
 		rate, depth, bpp);
 
 	cdev->audio_parm_answer = -1;
@@ -274,7 +277,7 @@ int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *cdev,
 		return -EPIPE;
 
 	if (cdev->audio_parm_answer != 1)
-		debug("unable to set the device's audio params\n");
+		dev_dbg(dev, "unable to set the device's audio params\n");
 	else
 		cdev->bpp = bpp;
 
@@ -293,6 +296,7 @@ static void setup_card(struct snd_usb_caiaqdev *cdev)
 {
 	int ret;
 	char val[4];
+	struct device *dev = caiaqdev_to_dev(cdev);
 
 	/* device-specific startup specials */
 	switch (cdev->chip.usb_id) {
@@ -346,32 +350,32 @@ static void setup_card(struct snd_usb_caiaqdev *cdev)
 	    cdev->spec.num_digital_audio_in > 0) {
 		ret = snd_usb_caiaq_audio_init(cdev);
 		if (ret < 0)
-			log("Unable to set up audio system (ret=%d)\n", ret);
+			dev_err(dev, "Unable to set up audio system (ret=%d)\n", ret);
 	}
 
 	if (cdev->spec.num_midi_in +
 	    cdev->spec.num_midi_out > 0) {
 		ret = snd_usb_caiaq_midi_init(cdev);
 		if (ret < 0)
-			log("Unable to set up MIDI system (ret=%d)\n", ret);
+			dev_err(dev, "Unable to set up MIDI system (ret=%d)\n", ret);
 	}
 
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 	ret = snd_usb_caiaq_input_init(cdev);
 	if (ret < 0)
-		log("Unable to set up input system (ret=%d)\n", ret);
+		dev_err(dev, "Unable to set up input system (ret=%d)\n", ret);
 #endif
 
 	/* finally, register the card and all its sub-instances */
 	ret = snd_card_register(cdev->chip.card);
 	if (ret < 0) {
-		log("snd_card_register() returned %d\n", ret);
+		dev_err(dev, "snd_card_register() returned %d\n", ret);
 		snd_card_free(cdev->chip.card);
 	}
 
 	ret = snd_usb_caiaq_control_init(cdev);
 	if (ret < 0)
-		log("Unable to set up control system (ret=%d)\n", ret);
+		dev_err(dev, "Unable to set up control system (ret=%d)\n", ret);
 }
 
 static int create_card(struct usb_device *usb_dev,
@@ -412,10 +416,11 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
 	char *c, usbpath[32];
 	struct usb_device *usb_dev = cdev->chip.dev;
 	struct snd_card *card = cdev->chip.card;
+	struct device *dev = caiaqdev_to_dev(cdev);
 	int err, len;
 
 	if (usb_set_interface(usb_dev, 0, 1) != 0) {
-		log("can't set alt interface.\n");
+		dev_err(dev, "can't set alt interface.\n");
 		return -EIO;
 	}
 
@@ -473,8 +478,7 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
 	}
 
 	usb_make_path(usb_dev, usbpath, sizeof(usbpath));
-	snprintf(card->longname, sizeof(card->longname),
-		       "%s %s (%s)",
+	snprintf(card->longname, sizeof(card->longname), "%s %s (%s)",
 		       cdev->vendor_name, cdev->product_name, usbpath);
 
 	setup_card(cdev);
@@ -496,7 +500,7 @@ static int snd_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, card);
 	ret = init_card(caiaqdev(card));
 	if (ret < 0) {
-		log("unable to init card! (ret=%d)\n", ret);
+		dev_err(&usb_dev->dev, "unable to init card! (ret=%d)\n", ret);
 		snd_card_free(card);
 		return ret;
 	}
@@ -506,15 +510,16 @@ static int snd_probe(struct usb_interface *intf,
 
 static void snd_disconnect(struct usb_interface *intf)
 {
-	struct snd_usb_caiaqdev *cdev;
 	struct snd_card *card = usb_get_intfdata(intf);
-
-	debug("%s(%p)\n", __func__, intf);
+	struct snd_usb_caiaqdev *cdev = caiaqdev(card);
+	struct device *dev;
 
 	if (!card)
 		return;
 
-	cdev = caiaqdev(card);
+	dev = caiaqdev_to_dev(cdev);
+	dev_dbg(dev, "%s(%p)\n", __func__, intf);
+
 	snd_card_disconnect(card);
 
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
@@ -539,4 +544,3 @@ static struct usb_driver snd_usb_driver = {
 };
 
 module_usb_driver(snd_usb_driver);
-
diff --git a/sound/usb/caiaq/device.h b/sound/usb/caiaq/device.h
index 7176a0e..ad102fa 100644
--- a/sound/usb/caiaq/device.h
+++ b/sound/usb/caiaq/device.h
@@ -25,16 +25,7 @@
 #define CAIAQ_USB_STR_LEN 0xff
 #define MAX_STREAMS 32
 
-//#define	SND_USB_CAIAQ_DEBUG
-
 #define MODNAME "snd-usb-caiaq"
-#define log(x...) snd_printk(KERN_WARNING MODNAME" log: " x)
-
-#ifdef SND_USB_CAIAQ_DEBUG
-#define debug(x...) snd_printk(KERN_WARNING MODNAME " debug: " x)
-#else
-#define debug(x...) do { } while(0)
-#endif
 
 #define EP1_CMD_GET_DEVICE_INFO	0x1
 #define EP1_CMD_READ_ERP	0x2
@@ -129,6 +120,7 @@ struct snd_usb_caiaq_cb_info {
 };
 
 #define caiaqdev(c) ((struct snd_usb_caiaqdev*)(c)->private_data)
+#define caiaqdev_to_dev(d)	(d->chip.card->dev)
 
 int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *cdev, int rate, int depth, int bbp);
 int snd_usb_caiaq_set_auto_msg (struct snd_usb_caiaqdev *cdev, int digital, int analog, int erp);
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index a32ad7c..fe8f4b4 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -16,6 +16,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */
 
+#include <linux/device.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/usb.h>
@@ -340,6 +341,8 @@ static void snd_usb_caiaq_tks4_dispatch(struct snd_usb_caiaqdev *cdev,
 					const unsigned char *buf,
 					unsigned int len)
 {
+	struct device *dev = caiaqdev_to_dev(cdev);
+
 	while (len) {
 		unsigned int i, block_id = (buf[0] << 8) | buf[1];
 
@@ -466,7 +469,7 @@ static void snd_usb_caiaq_tks4_dispatch(struct snd_usb_caiaqdev *cdev,
 			break;
 
 		default:
-			debug("%s(): bogus block (id %d)\n",
+			dev_dbg(dev, "%s(): bogus block (id %d)\n",
 				__func__, block_id);
 			return;
 		}
@@ -500,6 +503,7 @@ static void snd_usb_caiaq_maschine_dispatch(struct snd_usb_caiaqdev *cdev,
 static void snd_usb_caiaq_ep4_reply_dispatch(struct urb *urb)
 {
 	struct snd_usb_caiaqdev *cdev = urb->context;
+	struct device *dev = caiaqdev_to_dev(cdev);
 	unsigned char *buf = urb->transfer_buffer;
 	int ret;
 
@@ -535,7 +539,7 @@ requeue:
 	cdev->ep4_in_urb->actual_length = 0;
 	ret = usb_submit_urb(cdev->ep4_in_urb, GFP_ATOMIC);
 	if (ret < 0)
-		log("unable to submit urb. OOM!?\n");
+		dev_err(dev, "unable to submit urb. OOM!?\n");
 }
 
 static int snd_usb_caiaq_input_open(struct input_dev *idev)
diff --git a/sound/usb/caiaq/midi.c b/sound/usb/caiaq/midi.c
index 63c5a2c..2d75884 100644
--- a/sound/usb/caiaq/midi.c
+++ b/sound/usb/caiaq/midi.c
@@ -16,6 +16,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */
 
+#include <linux/device.h>
 #include <linux/usb.h>
 #include <linux/gfp.h>
 #include <sound/rawmidi.h>
@@ -65,6 +66,7 @@ static void snd_usb_caiaq_midi_send(struct snd_usb_caiaqdev *cdev,
 				    struct snd_rawmidi_substream *substream)
 {
 	int len, ret;
+	struct device *dev = caiaqdev_to_dev(cdev);
 
 	cdev->midi_out_buf[0] = EP1_CMD_MIDI_WRITE;
 	cdev->midi_out_buf[1] = 0; /* port */
@@ -79,9 +81,9 @@ static void snd_usb_caiaq_midi_send(struct snd_usb_caiaqdev *cdev,
 
 	ret = usb_submit_urb(&cdev->midi_out_urb, GFP_ATOMIC);
 	if (ret < 0)
-		log("snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed,"
-		    "ret=%d, len=%d\n",
-		    substream, ret, len);
+		dev_err(dev,
+			"snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed,"
+			"ret=%d, len=%d\n", substream, ret, len);
 	else
 		cdev->midi_out_active = 1;
 }
@@ -171,4 +173,3 @@ void snd_usb_caiaq_midi_output_done(struct urb* urb)
 
 	snd_usb_caiaq_midi_send(cdev, cdev->midi_out_substream);
 }
-
-- 
1.8.1.4
