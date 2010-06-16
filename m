From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 5/5] ALSA: usb-audio: simplify control
	interface access
Date: Wed, 16 Jun 2010 17:57:31 +0200
Message-ID: <1276703851-22199-6-git-send-email-daniel@caiaq.de>
References: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A098F1038F6
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 17:57:58 +0200 (CEST)
In-Reply-To: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

As the control interface is now carried in struct snd_usb_audio, we can
simplify the API a little and also drop the private ctrlif field from
struct usb_mixer_interface.

Also remove a left-over function prototype in pcm.h.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/clock.c    |   22 +++++++++-------------
 sound/usb/clock.h    |    4 +---
 sound/usb/endpoint.c |    1 +
 sound/usb/format.c   |    9 ++++-----
 sound/usb/mixer.c    |   37 ++++++++++++++++++-------------------
 sound/usb/mixer.h    |    1 -
 sound/usb/pcm.h      |    3 ---
 sound/usb/quirks.c   |    1 +
 8 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 7279d61..66bd157 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -121,7 +121,6 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
 }
 
 static int __uac_clock_find_source(struct snd_usb_audio *chip,
-				   struct usb_host_interface *host_iface,
 				   int entity_id, unsigned long *visited)
 {
 	struct uac_clock_source_descriptor *source;
@@ -138,11 +137,11 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 	}
 
 	/* first, see if the ID we're looking for is a clock source already */
-	source = snd_usb_find_clock_source(host_iface, entity_id);
+	source = snd_usb_find_clock_source(chip->ctrl_intf, entity_id);
 	if (source)
 		return source->bClockID;
 
-	selector = snd_usb_find_clock_selector(host_iface, entity_id);
+	selector = snd_usb_find_clock_selector(chip->ctrl_intf, entity_id);
 	if (selector) {
 		int ret;
 
@@ -162,16 +161,15 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			return -EINVAL;
 		}
 
-		return __uac_clock_find_source(chip, host_iface,
-					       selector->baCSourceID[ret-1],
+		return __uac_clock_find_source(chip, selector->baCSourceID[ret-1],
 					       visited);
 	}
 
 	/* FIXME: multipliers only act as pass-thru element for now */
-	multiplier = snd_usb_find_clock_multiplier(host_iface, entity_id);
+	multiplier = snd_usb_find_clock_multiplier(chip->ctrl_intf, entity_id);
 	if (multiplier)
-		return __uac_clock_find_source(chip, host_iface,
-					       multiplier->bCSourceID, visited);
+		return __uac_clock_find_source(chip, multiplier->bCSourceID,
+						visited);
 
 	return -EINVAL;
 }
@@ -187,13 +185,11 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
  *
  * Returns the clock source UnitID (>=0) on success, or an error.
  */
-int snd_usb_clock_find_source(struct snd_usb_audio *chip,
-			      struct usb_host_interface *host_iface,
-			      int entity_id)
+int snd_usb_clock_find_source(struct snd_usb_audio *chip, int entity_id)
 {
 	DECLARE_BITMAP(visited, 256);
 	memset(visited, 0, sizeof(visited));
-	return __uac_clock_find_source(chip, host_iface, entity_id, visited);
+	return __uac_clock_find_source(chip, entity_id, visited);
 }
 
 static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
@@ -251,7 +247,7 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	struct usb_device *dev = chip->dev;
 	unsigned char data[4];
 	int err, crate;
-	int clock = snd_usb_clock_find_source(chip, chip->ctrl_intf, fmt->clock);
+	int clock = snd_usb_clock_find_source(chip, fmt->clock);
 
 	if (clock < 0)
 		return clock;
diff --git a/sound/usb/clock.h b/sound/usb/clock.h
index beb2536..4663093 100644
--- a/sound/usb/clock.h
+++ b/sound/usb/clock.h
@@ -5,8 +5,6 @@ int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
 			     struct usb_host_interface *alts,
 			     struct audioformat *fmt, int rate);
 
-int snd_usb_clock_find_source(struct snd_usb_audio *chip,
-			      struct usb_host_interface *host_iface,
-			      int entity_id);
+int snd_usb_clock_find_source(struct snd_usb_audio *chip, int entity_id);
 
 #endif /* __USBAUDIO_CLOCK_H */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 289a165..6ce4ed1 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -33,6 +33,7 @@
 #include "pcm.h"
 #include "helper.h"
 #include "format.h"
+#include "clock.h"
 
 /*
  * free a substream
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 30364ab..4387f54 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -264,13 +264,12 @@ static int parse_uac2_sample_rate_range(struct audioformat *fp, int nr_triplets,
  * on the audioformat table (audio class v2).
  */
 static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
-				       struct audioformat *fp,
-				       struct usb_host_interface *iface)
+				       struct audioformat *fp)
 {
 	struct usb_device *dev = chip->dev;
 	unsigned char tmp[2], *data;
 	int nr_triplets, data_size, ret = 0;
-	int clock = snd_usb_clock_find_source(chip, chip->ctrl_intf, fp->clock);
+	int clock = snd_usb_clock_find_source(chip, fp->clock);
 
 	if (clock < 0) {
 		snd_printk(KERN_ERR "%s(): unable to find clock source (clock %d)\n",
@@ -391,7 +390,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 		break;
 	case UAC_VERSION_2:
 		/* fp->channels is already set in this case */
-		ret = parse_audio_format_rates_v2(chip, fp, iface);
+		ret = parse_audio_format_rates_v2(chip, fp);
 		break;
 	}
 
@@ -450,7 +449,7 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip,
 		framesize = le16_to_cpu(fmt->wSamplesPerFrame);
 		snd_printd(KERN_INFO "found format II with max.bitrate = %d, frame size=%d\n", brate, framesize);
 		fp->frame_size = framesize;
-		ret = parse_audio_format_rates_v2(chip, fp, iface);
+		ret = parse_audio_format_rates_v2(chip, fp);
 		break;
 	}
 	}
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7ffea71..a8911d9 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -291,16 +291,15 @@ static int get_abs_value(struct usb_mixer_elem_info *cval, int val)
 
 static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request, int validx, int *value_ret)
 {
+	struct snd_usb_audio *chip = cval->mixer->chip;
 	unsigned char buf[2];
 	int val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
 	int timeout = 10;
 
 	while (timeout-- > 0) {
-		if (snd_usb_ctl_msg(cval->mixer->chip->dev,
-				    usb_rcvctrlpipe(cval->mixer->chip->dev, 0),
-				    request,
+		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-				    validx, cval->mixer->ctrlif | (cval->id << 8),
+				    validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
 				    buf, val_len, 100) >= val_len) {
 			*value_ret = convert_signed_value(cval, snd_usb_combine_bytes(buf, val_len));
 			return 0;
@@ -313,6 +312,7 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request, int v
 
 static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request, int validx, int *value_ret)
 {
+	struct snd_usb_audio *chip = cval->mixer->chip;
 	unsigned char buf[2 + 3*sizeof(__u16)]; /* enough space for one range */
 	unsigned char *val;
 	int ret, size;
@@ -328,16 +328,14 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request, int v
 
 	memset(buf, 0, sizeof(buf));
 
-	ret = snd_usb_ctl_msg(cval->mixer->chip->dev,
-			      usb_rcvctrlpipe(cval->mixer->chip->dev, 0),
-			      bRequest,
+	ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), bRequest,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-			      validx, cval->mixer->ctrlif | (cval->id << 8),
+			      validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
 			      buf, size, 1000);
 
 	if (ret < 0) {
 		snd_printk(KERN_ERR "cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
-			   request, validx, cval->mixer->ctrlif | (cval->id << 8), cval->val_type);
+			   request, validx, snd_usb_ctrl_intf(chip) | (cval->id << 8), cval->val_type);
 		return ret;
 	}
 
@@ -413,6 +411,7 @@ static int get_cur_mix_value(struct usb_mixer_elem_info *cval,
 int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 				int request, int validx, int value_set)
 {
+	struct snd_usb_audio *chip = cval->mixer->chip;
 	unsigned char buf[2];
 	int val_len, timeout = 10;
 
@@ -435,15 +434,14 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 	buf[0] = value_set & 0xff;
 	buf[1] = (value_set >> 8) & 0xff;
 	while (timeout-- > 0)
-		if (snd_usb_ctl_msg(cval->mixer->chip->dev,
-				    usb_sndctrlpipe(cval->mixer->chip->dev, 0),
-				    request,
+		if (snd_usb_ctl_msg(chip->dev,
+				    usb_sndctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
-				    validx, cval->mixer->ctrlif | (cval->id << 8),
+				    validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
 				    buf, val_len, 100) >= 0)
 			return 0;
 	snd_printdd(KERN_ERR "cannot set ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d, data = %#x/%#x\n",
-		    request, validx, cval->mixer->ctrlif | (cval->id << 8), cval->val_type, buf[0], buf[1]);
+		    request, validx, snd_usb_ctrl_intf(chip) | (cval->id << 8), cval->val_type, buf[0], buf[1]);
 	return -EINVAL;
 }
 
@@ -761,6 +759,8 @@ static void usb_mixer_elem_free(struct snd_kcontrol *kctl)
  */
 static int get_min_max(struct usb_mixer_elem_info *cval, int default_min)
 {
+	struct snd_usb_audio *chip = cval->mixer->chip;
+
 	/* for failsafe */
 	cval->min = default_min;
 	cval->max = cval->min + 1;
@@ -783,7 +783,7 @@ static int get_min_max(struct usb_mixer_elem_info *cval, int default_min)
 		if (get_ctl_value(cval, UAC_GET_MAX, (cval->control << 8) | minchn, &cval->max) < 0 ||
 		    get_ctl_value(cval, UAC_GET_MIN, (cval->control << 8) | minchn, &cval->min) < 0) {
 			snd_printd(KERN_ERR "%d:%d: cannot get min/max values for control %d (id %d)\n",
-				   cval->id, cval->mixer->ctrlif, cval->control, cval->id);
+				   cval->id, snd_usb_ctrl_intf(chip), cval->control, cval->id);
 			return -EINVAL;
 		}
 		if (get_ctl_value(cval, UAC_GET_RES, (cval->control << 8) | minchn, &cval->res) < 0) {
@@ -1900,7 +1900,7 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 	struct usb_host_interface *hostif;
 	void *p;
 
-	hostif = &usb_ifnum_to_if(mixer->chip->dev, mixer->ctrlif)->altsetting[0];
+	hostif = mixer->chip->ctrl_intf;
 	memset(&state, 0, sizeof(state));
 	state.chip = mixer->chip;
 	state.mixer = mixer;
@@ -1992,7 +1992,7 @@ static void snd_usb_mixer_proc_read(struct snd_info_entry *entry,
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
 		snd_iprintf(buffer,
 			"USB Mixer: usb_id=0x%08x, ctrlif=%i, ctlerr=%i\n",
-				chip->usb_id, mixer->ctrlif,
+				chip->usb_id, snd_usb_ctrl_intf(chip),
 				mixer->ignore_ctl_error);
 		snd_iprintf(buffer, "Card: %s\n", chip->card->longname);
 		for (unitid = 0; unitid < MAX_ID_ELEMS; unitid++) {
@@ -2110,7 +2110,7 @@ static int snd_usb_mixer_status_create(struct usb_mixer_interface *mixer)
 	int buffer_length;
 	unsigned int epnum;
 
-	hostif = &usb_ifnum_to_if(mixer->chip->dev, mixer->ctrlif)->altsetting[0];
+	hostif = mixer->chip->ctrl_intf;
 	/* we need one interrupt input endpoint */
 	if (get_iface_desc(hostif)->bNumEndpoints < 1)
 		return 0;
@@ -2153,7 +2153,6 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	if (!mixer)
 		return -ENOMEM;
 	mixer->chip = chip;
-	mixer->ctrlif = ctrlif;
 	mixer->ignore_ctl_error = ignore_error;
 	mixer->id_elems = kcalloc(MAX_ID_ELEMS, sizeof(*mixer->id_elems),
 				  GFP_KERNEL);
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index a7cf100..26c636c 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -3,7 +3,6 @@
 
 struct usb_mixer_interface {
 	struct snd_usb_audio *chip;
-	unsigned int ctrlif;
 	struct list_head list;
 	unsigned int ignore_ctl_error;
 	struct urb *urb;
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index 1c931b6..ed3e283 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -7,8 +7,5 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 		       struct usb_host_interface *alts,
 		       struct audioformat *fmt);
 
-int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
-			     struct usb_host_interface *alts,
-			     struct audioformat *fmt, int rate);
 
 #endif /* __USBAUDIO_PCM_H */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b45e54c..9a9da09 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -32,6 +32,7 @@
 #include "helper.h"
 #include "endpoint.h"
 #include "pcm.h"
+#include "clock.h"
 
 /*
  * handle the quirks for the contained interfaces
-- 
1.7.1
