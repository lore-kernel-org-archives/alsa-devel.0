From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 1/2] sound: usb: add UAC2 clock sources as
	mixer controls
Date: Sat,  9 Apr 2016 11:21:46 +0200
Message-ID: <1460193708-17889-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 833A72615F7
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2016 11:21:54 +0200 (CEST)
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
Cc: tiwai@suse.de, orm.finnendahl@selma.hfmdk-frankfurt.de, clemens@ladisch.de, jan.baumgart@selma.hfmdk-frankfurt.de, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

UAC2 specifies clock sources that optionally have validity controls.
This patch exposes them as mixer controls, so they can be read (and
at least in theory even be written) by userspace applications in order
to make clock selection policy decisions.

This implementation does nothing if the device is not UAC2 compliant,
or if the clock source does not define said validity control bits.

Tested with a miniDSP USBStreamer (0x2752/0x0016).

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/usb/mixer.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 4f85757..cab6f52 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -45,6 +45,7 @@
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/usb.h>
@@ -1378,6 +1379,71 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 	snd_usb_mixer_add_control(&cval->head, kctl);
 }
 
+static int parse_clock_source_unit(struct mixer_build *state, int unitid,
+				   void *_ftr)
+{
+	struct uac_clock_source_descriptor *hdr = _ftr;
+	struct usb_mixer_elem_info *cval;
+	struct snd_kcontrol *kctl;
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	int ret;
+
+	if (state->mixer->protocol != UAC_VERSION_2)
+		return -EINVAL;
+
+	if (hdr->bLength != sizeof(*hdr)) {
+		usb_audio_dbg(state->chip,
+			      "Bogus clock source descriptor length of %d, ignoring.\n",
+			      hdr->bLength);
+		return 0;
+	}
+
+	/*
+	 * The only property of this unit we are interested in is the
+	 * clock source validity. If that isn't readable, just bail out.
+	 */
+	if (!uac2_control_is_readable(hdr->bmControls,
+				      ilog2(UAC2_CS_CONTROL_CLOCK_VALID)))
+		return 0;
+
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
+		return -ENOMEM;
+
+	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, hdr->bClockID);
+
+	cval->min = 0;
+	cval->max = 1;
+	cval->channels = 1;
+	cval->val_type = USB_MIXER_BOOLEAN;
+	cval->control = UAC2_CS_CONTROL_CLOCK_VALID;
+
+	if (uac2_control_is_writeable(hdr->bmControls,
+				      ilog2(UAC2_CS_CONTROL_CLOCK_VALID)))
+		kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
+	else {
+		cval->master_readonly = 1;
+		kctl = snd_ctl_new1(&usb_feature_unit_ctl_ro, cval);
+	}
+
+	if (!kctl) {
+		kfree(cval);
+		return -ENOMEM;
+	}
+
+	kctl->private_free = snd_usb_mixer_elem_free;
+	ret = snd_usb_copy_string_desc(state, hdr->iClockSource,
+				       name, sizeof(name));
+	if (ret > 0)
+		snprintf(kctl->id.name, sizeof(kctl->id.name),
+			 "%s Validity", name);
+	else
+		snprintf(kctl->id.name, sizeof(kctl->id.name),
+			 "Clock Source %d Validity", hdr->bClockID);
+
+	return snd_usb_mixer_add_control(&cval->head, kctl);
+}
+
 /*
  * parse a feature unit
  *
@@ -2126,10 +2192,11 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 
 	switch (p1[2]) {
 	case UAC_INPUT_TERMINAL:
-	case UAC2_CLOCK_SOURCE:
 		return 0; /* NOP */
 	case UAC_MIXER_UNIT:
 		return parse_audio_mixer_unit(state, unitid, p1);
+	case UAC2_CLOCK_SOURCE:
+		return parse_clock_source_unit(state, unitid, p1);
 	case UAC_SELECTOR_UNIT:
 	case UAC2_CLOCK_SELECTOR:
 		return parse_audio_selector_unit(state, unitid, p1);
-- 
2.4.3
