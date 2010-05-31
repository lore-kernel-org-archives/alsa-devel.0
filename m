From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/9] ALSA: usb-audio: support partially
	write-protected UAC2 controls
Date: Mon, 31 May 2010 13:35:37 +0200
Message-ID: <1275305744-6590-2-git-send-email-daniel@caiaq.de>
References: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D4DFA103889
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:35:57 +0200 (CEST)
In-Reply-To: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

So far, UAC2 controls are marked read-only if any of the channels are
marked read-only in the descriptors. Change this behaviour and

 - mark them writeable unless all channels are read-only
 - store the read-only mask in usb_mixer_elem_info and
 - check the mask again in set_cur_mix_value(), and bail out for
   write-protected channels.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/mixer.c |   30 ++++++++++++++++++++++++------
 sound/usb/mixer.h |    2 ++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 43d6417..9149a84 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -462,6 +462,16 @@ static int set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
 			     int index, int value)
 {
 	int err;
+	unsigned int read_only = (channel == 0) ?
+		cval->master_readonly :
+		cval->ch_readonly & (1 << (channel - 1));
+
+	if (read_only) {
+		snd_printdd(KERN_INFO "%s(): channel %d of control %d is read_only\n",
+			    __func__, channel, cval->control);
+		return 0;
+	}
+
 	err = snd_usb_mixer_set_ctl_value(cval, UAC_SET_CUR, (cval->control << 8) | channel,
 			    value);
 	if (err < 0)
@@ -958,7 +968,7 @@ static size_t append_ctl_name(struct snd_kcontrol *kctl, const char *str)
 static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 			      unsigned int ctl_mask, int control,
 			      struct usb_audio_term *iterm, int unitid,
-			      int read_only)
+			      int readonly_mask)
 {
 	struct uac_feature_unit_descriptor *desc = raw_desc;
 	unsigned int len = 0;
@@ -989,20 +999,25 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 	cval->control = control;
 	cval->cmask = ctl_mask;
 	cval->val_type = audio_feature_info[control-1].type;
-	if (ctl_mask == 0)
+	if (ctl_mask == 0) {
 		cval->channels = 1;	/* master channel */
-	else {
+		cval->master_readonly = readonly_mask;
+	} else {
 		int i, c = 0;
 		for (i = 0; i < 16; i++)
 			if (ctl_mask & (1 << i))
 				c++;
 		cval->channels = c;
+		cval->ch_readonly = readonly_mask;
 	}
 
 	/* get min/max values */
 	get_min_max(cval, 0);
 
-	if (read_only)
+	/* if all channels in the mask are marked read-only, make the control
+	 * read-only. set_cur_mix_value() will check the mask again and won't
+	 * issue write commands to read-only channels. */
+	if (cval->channels == readonly_mask)
 		kctl = snd_ctl_new1(&usb_feature_unit_ctl_ro, cval);
 	else
 		kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
@@ -1195,9 +1210,12 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 				}
 			}
 
-			/* FIXME: the whole unit is read-only if any of the channels is marked read-only */
+			/* NOTE: build_feature_ctl() will mark the control read-only if all channels
+			 * are marked read-only in the descriptors. Otherwise, the control will be
+			 * reported as writeable, but the driver will not actually issue a write
+			 * command for read-only channels */
 			if (ch_bits & 1) /* the first channel must be set (for ease of programming) */
-				build_feature_ctl(state, _ftr, ch_bits, i, &iterm, unitid, !!ch_read_only);
+				build_feature_ctl(state, _ftr, ch_bits, i, &iterm, unitid, ch_read_only);
 			if (uac2_control_is_readable(master_bits, i))
 				build_feature_ctl(state, _ftr, 0, i, &iterm, unitid,
 						  !uac2_control_is_writeable(master_bits, i));
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 1301238..a7cf100 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -34,6 +34,8 @@ struct usb_mixer_elem_info {
 	unsigned int id;
 	unsigned int control;	/* CS or ICN (high byte) */
 	unsigned int cmask; /* channel mask bitmap: 0 = master */
+	unsigned int ch_readonly;
+	unsigned int master_readonly;
 	int channels;
 	int val_type;
 	int min, max, res;
-- 
1.7.1
