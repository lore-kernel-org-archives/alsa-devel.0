From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/2] usbaudio: implement USB autosuspend
Date: Fri, 11 Mar 2011 13:19:46 +0100
Message-ID: <201103111319.46123.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

>From 42c15a1770f3dbcdf4ed34722d49ffaeea0c9c19 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Fri, 11 Mar 2011 11:44:33 +0100
Subject: [PATCH 2/2] usbaudio: implement USB autosuspend

Devices are autosuspended if no pcm nor midi channel is open
Mixer devices may be opened. This way they are active when
in use to play or record sound, but can be suspended while
users have a mixer application running.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
---
 sound/usb/card.c     |   76 ++++++++++++++++++++++++++++++++++++++++---------
 sound/usb/midi.c     |    8 +++++
 sound/usb/mixer.c    |   23 ++++++++++++++-
 sound/usb/pcm.c      |   20 ++++++++++---
 sound/usb/power.h    |    2 +
 sound/usb/usbaudio.h |    6 +++-
 6 files changed, 113 insertions(+), 22 deletions(-)
 create mode 100644 sound/usb/power.h

diff --git a/sound/usb/card.c b/sound/usb/card.c
index af76f97..ef33920 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -65,6 +65,7 @@
 #include "pcm.h"
 #include "urb.h"
 #include "format.h"
+#include "power.h"
 
 MODULE_AUTHOR("Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>");
 MODULE_DESCRIPTION("USB Audio");
@@ -330,6 +331,7 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 	chip->setup = device_setup[idx];
 	chip->nrpacks = nrpacks;
 	chip->async_unlink = async_unlink;
+	chip->probing = 1;
 
 	chip->usb_id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
 			      le16_to_cpu(dev->descriptor.idProduct));
@@ -451,6 +453,7 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 				goto __error;
 			}
 			chip = usb_chip[i];
+			chip->probing = 1;
 			break;
 		}
 	}
@@ -466,6 +469,7 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 					goto __error;
 				}
 				snd_card_set_dev(chip->card, &intf->dev);
+				chip->pm_intf = intf;
 				break;
 			}
 		if (!chip) {
@@ -505,6 +509,7 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 
 	usb_chip[chip->index] = chip;
 	chip->num_interfaces++;
+	chip->probing = 0;
 	mutex_unlock(&register_mutex);
 	return chip;
 
@@ -581,6 +586,23 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 }
 
 #ifdef CONFIG_PM
+
+int snd_usb_autoresume(struct snd_usb_audio *chip)
+{
+	int err = -ENODEV;
+
+	if (!chip->shutdown && !chip->probing)
+		err = usb_autopm_get_interface(chip->pm_intf);
+
+	return err;
+}
+
+void snd_usb_autosuspend(struct snd_usb_audio *chip)
+{
+	if (!chip->shutdown && !chip->probing)
+		usb_autopm_put_interface(chip->pm_intf);
+}
+
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
@@ -591,18 +613,26 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	if (chip == (void *)-1L)
 		return 0;
 
-	snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
-	if (!chip->num_suspended_intf++) {
-		list_for_each(p, &chip->pcm_list) {
-			as = list_entry(p, struct snd_usb_stream, list);
-			snd_pcm_suspend_all(as->pcm);
-		}
-
-		list_for_each_entry(mixer, &chip->mixer_list, list) {
-			snd_usb_mixer_inactivate(mixer);
-		}
+	if (!(message.event & PM_EVENT_AUTO)) {
+		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
+		if (!chip->num_suspended_intf++) {
+			list_for_each(p, &chip->pcm_list) {
+				as = list_entry(p, struct snd_usb_stream, list);
+				snd_pcm_suspend_all(as->pcm);
+			}
+ 		}
+	} else {
+		/*
+		 * otherwise we keep the rest of the system in the dark
+		 * to keep this transparent
+		 */
+		if (!chip->num_suspended_intf++)
+			chip->autosuspended = 1;
 	}
 
+	list_for_each_entry(mixer, &chip->mixer_list, list)
+		snd_usb_mixer_inactivate(mixer);
+
 	return 0;
 }
 
@@ -610,6 +640,7 @@ static int usb_audio_resume(struct usb_interface *intf)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct usb_mixer_interface *mixer;
+	int err = 0;
 
 	if (chip == (void *)-1L)
 		return 0;
@@ -619,16 +650,32 @@ static int usb_audio_resume(struct usb_interface *intf)
 	 * ALSA leaves material resumption to user space
 	 * we just notify and restart the mixers
 	 */
-	list_for_each_entry(mixer, &chip->mixer_list, list)
-		snd_usb_mixer_activate(mixer);
+	list_for_each_entry(mixer, &chip->mixer_list, list) {
+		err = snd_usb_mixer_activate(mixer);
+		if (err < 0)
+			goto err_out;
+	}
 	
-	snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
+	if (!chip->autosuspended)
+		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
+	chip->autosuspended = 0;
 
-	return 0;
+err_out:
+	return err;
 }
 #else
 #define usb_audio_suspend	NULL
 #define usb_audio_resume	NULL
+
+int snd_usb_autoresume(struct snd_usb_audio *chip)
+{
+	return 0;
+}
+
+void snd_usb_autosuspend(struct snd_usb_audio *chip)
+{
+		return;
+}
 #endif		/* CONFIG_PM */
 
 static struct usb_device_id usb_audio_ids [] = {
@@ -652,6 +699,7 @@ static struct usb_driver usb_audio_driver = {
 	.suspend =	usb_audio_suspend,
 	.resume =	usb_audio_resume,
 	.id_table =	usb_audio_ids,
+	.supports_autosuspend = 1,
 };
 
 static int __init snd_usb_audio_init(void)
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index db2dc5f..b4b39c0 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -54,6 +54,7 @@
 #include <sound/asequencer.h>
 #include "usbaudio.h"
 #include "midi.h"
+#include "power.h"
 #include "helper.h"
 
 /*
@@ -1044,6 +1045,7 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
 	struct snd_usb_midi* umidi = substream->rmidi->private_data;
 	struct usbmidi_out_port* port = NULL;
 	int i, j;
+	int err;
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
 		if (umidi->endpoints[i].out)
@@ -1056,6 +1058,9 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
 		snd_BUG();
 		return -ENXIO;
 	}
+	err = usb_autopm_get_interface(umidi->iface);
+	if (err < 0)
+		return -EIO;
 	substream->runtime->private_data = port;
 	port->state = STATE_UNKNOWN;
 	substream_open(substream, 1);
@@ -1064,7 +1069,10 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
 
 static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
 {
+	struct snd_usb_midi* umidi = substream->rmidi->private_data;
+
 	substream_open(substream, 0);
+	usb_autopm_put_interface(umidi->iface);
 	return 0;
 }
 
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index da65130..168c4fa 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -61,6 +61,7 @@
 #include "mixer.h"
 #include "helper.h"
 #include "mixer_quirks.h"
+#include "power.h"
 
 #define MAX_ID_ELEMS	256
 
@@ -295,16 +296,22 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request, int v
 	unsigned char buf[2];
 	int val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
 	int timeout = 10;
+	int err;
 
+	err = snd_usb_autoresume(cval->mixer->chip);
+	if (err < 0)
+		return -EIO;
 	while (timeout-- > 0) {
 		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				    validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
 				    buf, val_len, 100) >= val_len) {
 			*value_ret = convert_signed_value(cval, snd_usb_combine_bytes(buf, val_len));
+			snd_usb_autosuspend(cval->mixer->chip);
 			return 0;
 		}
 	}
+	snd_usb_autosuspend(cval->mixer->chip);
 	snd_printdd(KERN_ERR "cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
 		    request, validx, snd_usb_ctrl_intf(chip) | (cval->id << 8), cval->val_type);
 	return -EINVAL;
@@ -328,12 +335,18 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request, int v
 
 	memset(buf, 0, sizeof(buf));
 
+	ret = snd_usb_autoresume(chip) ? -EIO : 0;
+	if (ret)
+		goto error;
+
 	ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), bRequest,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
 			      buf, size, 1000);
+	snd_usb_autosuspend(chip);
 
 	if (ret < 0) {
+error:
 		snd_printk(KERN_ERR "cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
 			   request, validx, snd_usb_ctrl_intf(chip) | (cval->id << 8), cval->val_type);
 		return ret;
@@ -413,7 +426,7 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 {
 	struct snd_usb_audio *chip = cval->mixer->chip;
 	unsigned char buf[2];
-	int val_len, timeout = 10;
+	int val_len, err, timeout = 10;
 
 	if (cval->mixer->protocol == UAC_VERSION_1) {
 		val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
@@ -433,13 +446,19 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 	value_set = convert_bytes_value(cval, value_set);
 	buf[0] = value_set & 0xff;
 	buf[1] = (value_set >> 8) & 0xff;
+	err = snd_usb_autoresume(chip);
+	if (err < 0)
+		return -EIO;
 	while (timeout-- > 0)
 		if (snd_usb_ctl_msg(chip->dev,
 				    usb_sndctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 				    validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
-				    buf, val_len, 100) >= 0)
+				    buf, val_len, 100) >= 0) {
+			snd_usb_autosuspend(chip);
 			return 0;
+		}
+	snd_usb_autosuspend(chip);
 	snd_printdd(KERN_ERR "cannot set ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d, data = %#x/%#x\n",
 		    request, validx, snd_usb_ctrl_intf(chip) | (cval->id << 8), cval->val_type, buf[0], buf[1]);
 	return -EINVAL;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e3f6805..b8dcbf4 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -32,6 +32,7 @@
 #include "helper.h"
 #include "pcm.h"
 #include "clock.h"
+#include "power.h"
 
 /*
  * return the current pcm pointer.  just based on the hwptr_done value.
@@ -739,6 +740,9 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 		pt = 125 * (1 << fp->datainterval);
 		ptmin = min(ptmin, pt);
 	}
+	err = snd_usb_autoresume(subs->stream->chip);
+	if (err < 0)
+		return err;
 
 	param_period_time_if_needed = SNDRV_PCM_HW_PARAM_PERIOD_TIME;
 	if (snd_usb_get_speed(subs->dev) == USB_SPEED_FULL)
@@ -756,21 +760,21 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 				       SNDRV_PCM_HW_PARAM_CHANNELS,
 				       param_period_time_if_needed,
 				       -1)) < 0)
-		return err;
+		goto rep_err;
 	if ((err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				       hw_rule_channels, subs,
 				       SNDRV_PCM_HW_PARAM_FORMAT,
 				       SNDRV_PCM_HW_PARAM_RATE,
 				       param_period_time_if_needed,
 				       -1)) < 0)
-		return err;
+		goto rep_err;
 	if ((err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
 				       hw_rule_format, subs,
 				       SNDRV_PCM_HW_PARAM_RATE,
 				       SNDRV_PCM_HW_PARAM_CHANNELS,
 				       param_period_time_if_needed,
 				       -1)) < 0)
-		return err;
+		goto rep_err;
 	if (param_period_time_if_needed >= 0) {
 		err = snd_pcm_hw_rule_add(runtime, 0,
 					  SNDRV_PCM_HW_PARAM_PERIOD_TIME,
@@ -780,11 +784,15 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 					  SNDRV_PCM_HW_PARAM_RATE,
 					  -1);
 		if (err < 0)
-			return err;
+			goto rep_err;
 	}
 	if ((err = snd_usb_pcm_check_knot(runtime, subs)) < 0)
-		return err;
+		goto rep_err;
 	return 0;
+
+rep_err:
+	snd_usb_autosuspend(subs->stream->chip);
+	return err;
 }
 
 static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
@@ -798,6 +806,7 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 	runtime->hw = snd_usb_hardware;
 	runtime->private_data = subs;
 	subs->pcm_substream = substream;
+	/* runtime PM is also done there */
 	return setup_hw_info(runtime, subs);
 }
 
@@ -811,6 +820,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 		subs->interface = -1;
 	}
 	subs->pcm_substream = NULL;
+	snd_usb_autosuspend(subs->stream->chip);
 	return 0;
 }
 
diff --git a/sound/usb/power.h b/sound/usb/power.h
new file mode 100644
index 0000000..d2e1a6e
--- /dev/null
+++ b/sound/usb/power.h
@@ -0,0 +1,2 @@
+int snd_usb_autoresume(struct snd_usb_audio *chip);
+void snd_usb_autosuspend(struct snd_usb_audio *chip);
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 6e66fff..32f2a97 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -34,10 +34,14 @@ struct snd_usb_audio {
 	int index;
 	struct usb_device *dev;
 	struct snd_card *card;
+	struct usb_interface *pm_intf;
 	u32 usb_id;
-	int shutdown;
 	struct mutex shutdown_mutex;
+	unsigned int shutdown:1;
+	unsigned int probing:1;
+	unsigned int autosuspended:1;	
 	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
+	
 	int num_interfaces;
 	int num_suspended_intf;
 
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
