From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/17] ALSA: line6: Handle impulse response via
	control API
Date: Mon, 19 Jan 2015 16:54:36 +0100
Message-ID: <1421682891-11594-3-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 476F82612BC
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Instead of sysfs and the conditional build with Kconfig, implement the
handling of the impulse response controls via control API, and always
enable the build.  Two new controls, "Impulse Response Volume" and
"Impulse Response Period" are added as a replacement for the former
sysfs files.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/Kconfig    |  12 ----
 sound/usb/line6/capture.c  |   4 --
 sound/usb/line6/pcm.c      | 157 ++++++++++++++++++++++-----------------------
 sound/usb/line6/pcm.h      |  18 ------
 sound/usb/line6/playback.c |   8 ---
 5 files changed, 75 insertions(+), 124 deletions(-)

diff --git a/sound/usb/line6/Kconfig b/sound/usb/line6/Kconfig
index 33deb419dde8..8287ae6a2c26 100644
--- a/sound/usb/line6/Kconfig
+++ b/sound/usb/line6/Kconfig
@@ -38,15 +38,3 @@ config SND_USB_VARIAX
 	help
 	  This is a driver for Variax Workbench device.
 
-config LINE6_USB_IMPULSE_RESPONSE
-	bool "measure impulse response"
-	depends on SND_USB_LINE6
-	help
-	  Say Y here to add code to measure the impulse response of a Line6
-	  device. This is more accurate than user-space methods since it
-	  bypasses any PCM data buffering (e.g., by ALSA or jack). This is
-	  useful for assessing the performance of new devices, but is not
-	  required for normal operation.
-
-	  If unsure, say N.
-
diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index da4ab013ea8e..4cf6fa0541f1 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -244,9 +244,7 @@ static void audio_in_callback(struct urb *urb)
 		line6pcm->prev_fbuf = fbuf;
 		line6pcm->prev_fsize = fsize;
 
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 		if (!(line6pcm->flags & LINE6_BITS_PCM_IMPULSE))
-#endif
 			if (test_bit(LINE6_INDEX_PCM_ALSA_CAPTURE_STREAM,
 				     &line6pcm->flags) && (fsize > 0))
 				line6_capture_copy(line6pcm, fbuf, fsize);
@@ -262,9 +260,7 @@ static void audio_in_callback(struct urb *urb)
 	if (!shutdown) {
 		submit_audio_in_urb(line6pcm);
 
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 		if (!(line6pcm->flags & LINE6_BITS_PCM_IMPULSE))
-#endif
 			if (test_bit(LINE6_INDEX_PCM_ALSA_CAPTURE_STREAM,
 				     &line6pcm->flags))
 				line6_capture_check_period(line6pcm, length);
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index b7348b031bf7..626b6c158023 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -21,80 +21,75 @@
 #include "driver.h"
 #include "playback.h"
 
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
-
-static struct snd_line6_pcm *dev2pcm(struct device *dev)
+/* impulse response volume controls */
+static int snd_line6_impulse_volume_info(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_info *uinfo)
 {
-	struct usb_interface *interface = to_usb_interface(dev);
-	struct usb_line6 *line6 = usb_get_intfdata(interface);
-	struct snd_line6_pcm *line6pcm = line6->line6pcm;
-	return line6pcm;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 255;
+	return 0;
 }
 
-/*
-	"read" request on "impulse_volume" special file.
-*/
-static ssize_t impulse_volume_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static int snd_line6_impulse_volume_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
 {
-	return sprintf(buf, "%d\n", dev2pcm(dev)->impulse_volume);
+	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = line6pcm->impulse_volume;
+	return 0;
 }
 
-/*
-	"write" request on "impulse_volume" special file.
-*/
-static ssize_t impulse_volume_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static int snd_line6_impulse_volume_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_line6_pcm *line6pcm = dev2pcm(dev);
-	int value;
-	int ret;
+	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
+	int value = ucontrol->value.integer.value[0];
 
-	ret = kstrtoint(buf, 10, &value);
-	if (ret < 0)
-		return ret;
+	if (line6pcm->impulse_volume == value)
+		return 0;
 
 	line6pcm->impulse_volume = value;
-
 	if (value > 0)
 		line6_pcm_acquire(line6pcm, LINE6_BITS_PCM_IMPULSE);
 	else
 		line6_pcm_release(line6pcm, LINE6_BITS_PCM_IMPULSE);
+	return 1;
+}
 
-	return count;
+/* impulse response period controls */
+static int snd_line6_impulse_period_info(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 2000;
+	return 0;
 }
-static DEVICE_ATTR_RW(impulse_volume);
 
-/*
-	"read" request on "impulse_period" special file.
-*/
-static ssize_t impulse_period_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static int snd_line6_impulse_period_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
 {
-	return sprintf(buf, "%d\n", dev2pcm(dev)->impulse_period);
+	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = line6pcm->impulse_period;
+	return 0;
 }
 
-/*
-	"write" request on "impulse_period" special file.
-*/
-static ssize_t impulse_period_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static int snd_line6_impulse_period_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
 {
-	int value;
-	int ret;
+	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
+	int value = ucontrol->value.integer.value[0];
 
-	ret = kstrtoint(buf, 10, &value);
-	if (ret < 0)
-		return ret;
+	if (line6pcm->impulse_period == value)
+		return 0;
 
-	dev2pcm(dev)->impulse_period = value;
-	return count;
+	line6pcm->impulse_period = value;
+	return 1;
 }
-static DEVICE_ATTR_RW(impulse_period);
-
-#endif
 
 static bool test_flags(unsigned long flags0, unsigned long flags1,
 		       unsigned long mask)
@@ -314,14 +309,28 @@ static int snd_line6_control_playback_put(struct snd_kcontrol *kcontrol,
 }
 
 /* control definition */
-static struct snd_kcontrol_new line6_control_playback = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "PCM Playback Volume",
-	.index = 0,
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
-	.info = snd_line6_control_playback_info,
-	.get = snd_line6_control_playback_get,
-	.put = snd_line6_control_playback_put
+static struct snd_kcontrol_new line6_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "PCM Playback Volume",
+		.info = snd_line6_control_playback_info,
+		.get = snd_line6_control_playback_get,
+		.put = snd_line6_control_playback_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Impulse Response Volume",
+		.info = snd_line6_impulse_volume_info,
+		.get = snd_line6_impulse_volume_get,
+		.put = snd_line6_impulse_volume_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Impulse Response Period",
+		.info = snd_line6_impulse_period_info,
+		.get = snd_line6_impulse_period_get,
+		.put = snd_line6_impulse_period_put
+	},
 };
 
 /*
@@ -332,11 +341,6 @@ static void line6_cleanup_pcm(struct snd_pcm *pcm)
 	int i;
 	struct snd_line6_pcm *line6pcm = snd_pcm_chip(pcm);
 
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
-	device_remove_file(line6pcm->line6->ifcdev, &dev_attr_impulse_volume);
-	device_remove_file(line6pcm->line6->ifcdev, &dev_attr_impulse_period);
-#endif
-
 	for (i = LINE6_ISO_BUFFERS; i--;) {
 		if (line6pcm->urb_audio_out[i]) {
 			usb_kill_urb(line6pcm->urb_audio_out[i]);
@@ -423,7 +427,7 @@ int line6_init_pcm(struct usb_line6 *line6,
 		.dev_free = snd_line6_pcm_free,
 	};
 
-	int err;
+	int i, err;
 	unsigned ep_read = line6->properties->ep_audio_r;
 	unsigned ep_write = line6->properties->ep_audio_w;
 	struct snd_line6_pcm *line6pcm;
@@ -462,6 +466,7 @@ int line6_init_pcm(struct usb_line6 *line6,
 	spin_lock_init(&line6pcm->lock_audio_out);
 	spin_lock_init(&line6pcm->lock_audio_in);
 	spin_lock_init(&line6pcm->lock_trigger);
+	line6pcm->impulse_period = LINE6_IMPULSE_DEFAULT_PERIOD;
 
 	err = line6_create_audio_out_urbs(line6pcm);
 	if (err < 0)
@@ -472,24 +477,12 @@ int line6_init_pcm(struct usb_line6 *line6,
 		return err;
 
 	/* mixer: */
-	err =
-	    snd_ctl_add(line6->card,
-			snd_ctl_new1(&line6_control_playback, line6pcm));
-	if (err < 0)
-		return err;
-
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
-	/* impulse response test: */
-	err = device_create_file(line6->ifcdev, &dev_attr_impulse_volume);
-	if (err < 0)
-		return err;
-
-	err = device_create_file(line6->ifcdev, &dev_attr_impulse_period);
-	if (err < 0)
-		return err;
-
-	line6pcm->impulse_period = LINE6_IMPULSE_DEFAULT_PERIOD;
-#endif
+	for (i = 0; i < ARRAY_SIZE(line6_controls); i++) {
+		err = snd_ctl_add(line6->card,
+				  snd_ctl_new1(&line6_controls[i], line6pcm));
+		if (err < 0)
+			return err;
+	}
 
 	return 0;
 }
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 7315e8131184..9328e6ffb191 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -35,9 +35,7 @@
 /* in a "full speed" device (such as the PODxt Pro) this means 1ms */
 #define LINE6_ISO_INTERVAL	1
 
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 #define LINE6_IMPULSE_DEFAULT_PERIOD 100
-#endif
 
 /*
 	Get substream from Line6 PCM data structure
@@ -89,12 +87,10 @@ enum {
 	LINE6_INDEX_PCM_MONITOR_PLAYBACK_STREAM,
 	LINE6_INDEX_PCM_MONITOR_CAPTURE_BUFFER,
 	LINE6_INDEX_PCM_MONITOR_CAPTURE_STREAM,
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 	LINE6_INDEX_PCM_IMPULSE_PLAYBACK_BUFFER,
 	LINE6_INDEX_PCM_IMPULSE_PLAYBACK_STREAM,
 	LINE6_INDEX_PCM_IMPULSE_CAPTURE_BUFFER,
 	LINE6_INDEX_PCM_IMPULSE_CAPTURE_STREAM,
-#endif
 	LINE6_INDEX_PAUSE_PLAYBACK,
 	LINE6_INDEX_PREPARED,
 
@@ -109,12 +105,10 @@ enum {
 	LINE6_BIT(PCM_MONITOR_PLAYBACK_STREAM),
 	LINE6_BIT(PCM_MONITOR_CAPTURE_BUFFER),
 	LINE6_BIT(PCM_MONITOR_CAPTURE_STREAM),
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 	LINE6_BIT(PCM_IMPULSE_PLAYBACK_BUFFER),
 	LINE6_BIT(PCM_IMPULSE_PLAYBACK_STREAM),
 	LINE6_BIT(PCM_IMPULSE_CAPTURE_BUFFER),
 	LINE6_BIT(PCM_IMPULSE_CAPTURE_STREAM),
-#endif
 	LINE6_BIT(PAUSE_PLAYBACK),
 	LINE6_BIT(PREPARED),
 
@@ -133,40 +127,30 @@ enum {
 	    LINE6_BIT_PCM_MONITOR_CAPTURE_BUFFER |
 	    LINE6_BIT_PCM_MONITOR_CAPTURE_STREAM,
 
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 	LINE6_BITS_PCM_IMPULSE =
 	    LINE6_BIT_PCM_IMPULSE_PLAYBACK_BUFFER |
 	    LINE6_BIT_PCM_IMPULSE_PLAYBACK_STREAM |
 	    LINE6_BIT_PCM_IMPULSE_CAPTURE_BUFFER |
 	    LINE6_BIT_PCM_IMPULSE_CAPTURE_STREAM,
-#endif
 
 	/* combined bit masks (by direction): */
 	LINE6_BITS_PLAYBACK_BUFFER =
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 	    LINE6_BIT_PCM_IMPULSE_PLAYBACK_BUFFER |
-#endif
 	    LINE6_BIT_PCM_ALSA_PLAYBACK_BUFFER |
 	    LINE6_BIT_PCM_MONITOR_PLAYBACK_BUFFER,
 
 	LINE6_BITS_PLAYBACK_STREAM =
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 	    LINE6_BIT_PCM_IMPULSE_PLAYBACK_STREAM |
-#endif
 	    LINE6_BIT_PCM_ALSA_PLAYBACK_STREAM |
 	    LINE6_BIT_PCM_MONITOR_PLAYBACK_STREAM,
 
 	LINE6_BITS_CAPTURE_BUFFER =
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 	    LINE6_BIT_PCM_IMPULSE_CAPTURE_BUFFER |
-#endif
 	    LINE6_BIT_PCM_ALSA_CAPTURE_BUFFER |
 	    LINE6_BIT_PCM_MONITOR_CAPTURE_BUFFER,
 
 	LINE6_BITS_CAPTURE_STREAM =
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 	    LINE6_BIT_PCM_IMPULSE_CAPTURE_STREAM |
-#endif
 	    LINE6_BIT_PCM_ALSA_CAPTURE_STREAM |
 	    LINE6_BIT_PCM_MONITOR_CAPTURE_STREAM,
 
@@ -338,7 +322,6 @@ struct snd_line6_pcm {
 	*/
 	int volume_monitor;
 
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 	/**
 		 Volume of impulse response test signal (if zero, test is disabled).
 	*/
@@ -353,7 +336,6 @@ struct snd_line6_pcm {
 		 Counter for impulse response test signal.
 	*/
 	int impulse_count;
-#endif
 
 	/**
 		 Several status bits (see LINE6_BIT_*).
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 0a874105ccef..258147eadf37 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -60,8 +60,6 @@ static void change_volume(struct urb *urb_out, int volume[],
 	}
 }
 
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
-
 /*
 	Create signal for impulse response test.
 */
@@ -105,8 +103,6 @@ static void create_impulse_test_signal(struct snd_line6_pcm *line6pcm,
 	}
 }
 
-#endif
-
 /*
 	Add signal to buffer for software monitoring.
 */
@@ -243,7 +239,6 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	change_volume(urb_out, line6pcm->volume_playback, bytes_per_frame);
 
 	if (line6pcm->prev_fbuf != NULL) {
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 		if (line6pcm->flags & LINE6_BITS_PCM_IMPULSE) {
 			create_impulse_test_signal(line6pcm, urb_out,
 						   bytes_per_frame);
@@ -257,7 +252,6 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 					urb_out->transfer_buffer_length);
 			}
 		} else {
-#endif
 			if (!
 			    (line6pcm->line6->
 			     properties->capabilities & LINE6_CAP_HWMON)
@@ -266,9 +260,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 				add_monitor_signal(urb_out, line6pcm->prev_fbuf,
 						   line6pcm->volume_monitor,
 						   bytes_per_frame);
-#ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 		}
-#endif
 	}
 
 	ret = usb_submit_urb(urb_out, GFP_ATOMIC);
-- 
2.2.1
