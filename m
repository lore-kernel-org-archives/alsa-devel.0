From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 01/10] ALSA: usb-audio: convert list_for_each
	to entry variant
Date: Sun, 31 Mar 2013 17:52:23 +0200
Message-ID: <1364745152-1762-2-git-send-email-eldad@fogrefinery.com>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CC68261718
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 17:52:57 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id w12so671815bku.8
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 08:52:57 -0700 (PDT)
In-Reply-To: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Change occurances of list_for_each into list_for_each_entry where
applicable.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/card.c     |  4 +---
 sound/usb/endpoint.c |  4 +---
 sound/usb/midi.c     |  5 ++---
 sound/usb/pcm.c      | 30 ++++++++++--------------------
 sound/usb/proc.c     |  7 +++----
 sound/usb/stream.c   | 12 ++++--------
 6 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 2da8ad7..8bab36c 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -645,7 +645,6 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip)
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
-	struct list_head *p;
 	struct snd_usb_stream *as;
 	struct usb_mixer_interface *mixer;
 
@@ -655,8 +654,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	if (!PMSG_IS_AUTO(message)) {
 		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
 		if (!chip->num_suspended_intf++) {
-			list_for_each(p, &chip->pcm_list) {
-				as = list_entry(p, struct snd_usb_stream, list);
+			list_for_each_entry(as, &chip->pcm_list, list) {
 				snd_pcm_suspend_all(as->pcm);
 				as->substream[0].need_setup_ep =
 					as->substream[1].need_setup_ep = true;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 21049b8..b1f687f 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -415,14 +415,12 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 					      struct usb_host_interface *alts,
 					      int ep_num, int direction, int type)
 {
-	struct list_head *p;
 	struct snd_usb_endpoint *ep;
 	int is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
 
 	mutex_lock(&chip->mutex);
 
-	list_for_each(p, &chip->ep_list) {
-		ep = list_entry(p, struct snd_usb_endpoint, list);
+	list_for_each_entry(ep, &chip->ep_list, list) {
 		if (ep->ep_num == ep_num &&
 		    ep->iface == alts->desc.bInterfaceNumber &&
 		    ep->alt_idx == alts->desc.bAlternateSetting) {
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 34b9bb7..1cf943d 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1465,10 +1465,9 @@ static void snd_usbmidi_rawmidi_free(struct snd_rawmidi *rmidi)
 static struct snd_rawmidi_substream *snd_usbmidi_find_substream(struct snd_usb_midi* umidi,
 								int stream, int number)
 {
-	struct list_head* list;
+	struct snd_rawmidi_substream *substream;
 
-	list_for_each(list, &umidi->rmidi->streams[stream].substreams) {
-		struct snd_rawmidi_substream *substream = list_entry(list, struct snd_rawmidi_substream, list);
+	list_for_each_entry(substream, &umidi->rmidi->streams[stream].substreams, list) {
 		if (substream->number == number)
 			return substream;
 	}
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f94397b..e42fc19 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -94,13 +94,11 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
  */
 static struct audioformat *find_format(struct snd_usb_substream *subs)
 {
-	struct list_head *p;
+	struct audioformat *fp;
 	struct audioformat *found = NULL;
 	int cur_attr = 0, attr;
 
-	list_for_each(p, &subs->fmt_list) {
-		struct audioformat *fp;
-		fp = list_entry(p, struct audioformat, list);
+	list_for_each_entry(fp, &subs->fmt_list, list) {
 		if (!(fp->formats & (1uLL << subs->pcm_format)))
 			continue;
 		if (fp->channels != subs->channels)
@@ -802,7 +800,7 @@ static int hw_rule_rate(struct snd_pcm_hw_params *params,
 			struct snd_pcm_hw_rule *rule)
 {
 	struct snd_usb_substream *subs = rule->private;
-	struct list_head *p;
+	struct audioformat *fp;
 	struct snd_interval *it = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	unsigned int rmin, rmax;
 	int changed;
@@ -810,9 +808,7 @@ static int hw_rule_rate(struct snd_pcm_hw_params *params,
 	hwc_debug("hw_rule_rate: (%d,%d)\n", it->min, it->max);
 	changed = 0;
 	rmin = rmax = 0;
-	list_for_each(p, &subs->fmt_list) {
-		struct audioformat *fp;
-		fp = list_entry(p, struct audioformat, list);
+	list_for_each_entry(fp, &subs->fmt_list, list) {
 		if (!hw_check_valid_format(subs, params, fp))
 			continue;
 		if (changed++) {
@@ -856,7 +852,7 @@ static int hw_rule_channels(struct snd_pcm_hw_params *params,
 			    struct snd_pcm_hw_rule *rule)
 {
 	struct snd_usb_substream *subs = rule->private;
-	struct list_head *p;
+	struct audioformat *fp;
 	struct snd_interval *it = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	unsigned int rmin, rmax;
 	int changed;
@@ -864,9 +860,7 @@ static int hw_rule_channels(struct snd_pcm_hw_params *params,
 	hwc_debug("hw_rule_channels: (%d,%d)\n", it->min, it->max);
 	changed = 0;
 	rmin = rmax = 0;
-	list_for_each(p, &subs->fmt_list) {
-		struct audioformat *fp;
-		fp = list_entry(p, struct audioformat, list);
+	list_for_each_entry(fp, &subs->fmt_list, list) {
 		if (!hw_check_valid_format(subs, params, fp))
 			continue;
 		if (changed++) {
@@ -909,7 +903,7 @@ static int hw_rule_format(struct snd_pcm_hw_params *params,
 			  struct snd_pcm_hw_rule *rule)
 {
 	struct snd_usb_substream *subs = rule->private;
-	struct list_head *p;
+	struct audioformat *fp;
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	u64 fbits;
 	u32 oldbits[2];
@@ -917,9 +911,7 @@ static int hw_rule_format(struct snd_pcm_hw_params *params,
 
 	hwc_debug("hw_rule_format: %x:%x\n", fmt->bits[0], fmt->bits[1]);
 	fbits = 0;
-	list_for_each(p, &subs->fmt_list) {
-		struct audioformat *fp;
-		fp = list_entry(p, struct audioformat, list);
+	list_for_each_entry(fp, &subs->fmt_list, list) {
 		if (!hw_check_valid_format(subs, params, fp))
 			continue;
 		fbits |= fp->formats;
@@ -1027,7 +1019,7 @@ static int snd_usb_pcm_check_knot(struct snd_pcm_runtime *runtime,
 
 static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substream *subs)
 {
-	struct list_head *p;
+	struct audioformat *fp;
 	unsigned int pt, ptmin;
 	int param_period_time_if_needed;
 	int err;
@@ -1041,9 +1033,7 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 	runtime->hw.rates = 0;
 	ptmin = UINT_MAX;
 	/* check min/max rates and channels */
-	list_for_each(p, &subs->fmt_list) {
-		struct audioformat *fp;
-		fp = list_entry(p, struct audioformat, list);
+	list_for_each_entry(fp, &subs->fmt_list, list) {
 		runtime->hw.rates |= fp->rates;
 		if (runtime->hw.rate_min > fp->rate_min)
 			runtime->hw.rate_min = fp->rate_min;
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index d218f76..0182ef6 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -73,15 +73,14 @@ void snd_usb_audio_create_proc(struct snd_usb_audio *chip)
  */
 static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct snd_info_buffer *buffer)
 {
-	struct list_head *p;
+	struct audioformat *fp;
 	static char *sync_types[4] = {
 		"NONE", "ASYNC", "ADAPTIVE", "SYNC"
 	};
 
-	list_for_each(p, &subs->fmt_list) {
-		struct audioformat *fp;
+	list_for_each_entry(fp, &subs->fmt_list, list) {
 		snd_pcm_format_t fmt;
-		fp = list_entry(p, struct audioformat, list);
+
 		snd_iprintf(buffer, "  Interface %d\n", fp->iface);
 		snd_iprintf(buffer, "    Altset %d\n", fp->altsetting);
 		snd_iprintf(buffer, "    Format:");
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index ad181d5..42b7e0a 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -42,12 +42,11 @@
  */
 static void free_substream(struct snd_usb_substream *subs)
 {
-	struct list_head *p, *n;
+	struct audioformat *fp, *n;
 
 	if (!subs->num_formats)
 		return; /* not initialized */
-	list_for_each_safe(p, n, &subs->fmt_list) {
-		struct audioformat *fp = list_entry(p, struct audioformat, list);
+	list_for_each_entry_safe(fp, n, &subs->fmt_list, list) {
 		kfree(fp->rate_table);
 		kfree(fp->chmap);
 		kfree(fp);
@@ -313,14 +312,12 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 			     int stream,
 			     struct audioformat *fp)
 {
-	struct list_head *p;
 	struct snd_usb_stream *as;
 	struct snd_usb_substream *subs;
 	struct snd_pcm *pcm;
 	int err;
 
-	list_for_each(p, &chip->pcm_list) {
-		as = list_entry(p, struct snd_usb_stream, list);
+	list_for_each_entry(as, &chip->pcm_list, list) {
 		if (as->fmt_type != fp->fmt_type)
 			continue;
 		subs = &as->substream[stream];
@@ -332,8 +329,7 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 		}
 	}
 	/* look for an empty stream */
-	list_for_each(p, &chip->pcm_list) {
-		as = list_entry(p, struct snd_usb_stream, list);
+	list_for_each_entry(as, &chip->pcm_list, list) {
 		if (as->fmt_type != fp->fmt_type)
 			continue;
 		subs = &as->substream[stream];
-- 
1.8.1.5
