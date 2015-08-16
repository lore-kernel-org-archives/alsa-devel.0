From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 1/2] ALSA: usb-audio: Add a volume scale quirk
	for AudioQuest DragonFly
Date: Sun, 16 Aug 2015 15:50:12 +0300
Message-ID: <1439729413-30804-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.tpnet.fi (webmail.tpnet.fi [62.106.63.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 38FF42604A9
 for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2015 14:50:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

AudioQuest DragonFly DAC reports a volume control range of 0..50
(0x0000..0x0032) which in USB Audio means a range of 0 .. 0.2dB, which
is obviously incorrect and causes software using the dB information in
e.g. volume sliders to have a massive volume difference in 100..102%
range.

The actual volume mapping seems to be neither linear volume nor linear
dB scale, but instead quite close to the cubic mapping e.g. alsamixer
uses, with a range of -53...0 dB.

Add a quirk for DragonFly to use a custom dB mapping, based on my
measurements, using a 10-item range TLV (so it still fits in alsa-lib
MAX_TLV_RANGE_SIZE).

Tested on AudioQuest DragonFly HW v1.2. The quirk is only applied if the
range is 0..50, so if this gets fixed/changed in later HW revisions it
will no longer be applied.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: <stable@vger.kernel.org>
---
 sound/usb/mixer_quirks.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 337c317ead6f..39d7f34e44e6 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -37,6 +37,7 @@
 #include <sound/control.h>
 #include <sound/hwdep.h>
 #include <sound/info.h>
+#include <sound/tlv.h>
 
 #include "usbaudio.h"
 #include "mixer.h"
@@ -1733,6 +1734,38 @@ static int snd_microii_controls_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer)
+{
+	struct usb_mixer_elem_list *list;
+	struct usb_mixer_elem_info *cval;
+	static const int unit_id = 7;
+
+	/* approximation using 10 ranges based on output measurement on hw v1.2 */
+	static const DECLARE_TLV_DB_RANGE(scale,
+		 0,  1, TLV_DB_MINMAX_ITEM(-5300, -4970),
+		 2,  5, TLV_DB_MINMAX_ITEM(-4710, -4160),
+		 6,  7, TLV_DB_MINMAX_ITEM(-3884, -3710),
+		 8, 14, TLV_DB_MINMAX_ITEM(-3443, -2560),
+		15, 16, TLV_DB_MINMAX_ITEM(-2475, -2324),
+		17, 19, TLV_DB_MINMAX_ITEM(-2228, -2031),
+		20, 26, TLV_DB_MINMAX_ITEM(-1910, -1393),
+		27, 31, TLV_DB_MINMAX_ITEM(-1322, -1032),
+		32, 40, TLV_DB_MINMAX_ITEM(-968, -490),
+		41, 50, TLV_DB_MINMAX_ITEM(-441, 0),
+	);
+
+	for (list = mixer->id_elems[unit_id]; list; list = list->next_id_elem) {
+		cval = (struct usb_mixer_elem_info *)list;
+		if (cval->control == UAC_FU_VOLUME &&
+		    cval->min == 0 && cval->max == 50) {
+			usb_audio_info(mixer->chip, "applying DragonFly dB scale quirk\n");
+			list->kctl->tlv.p = scale;
+			list->kctl->vd[0].access |=  SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+			list->kctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+		}
+	}
+}
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err = 0;
@@ -1810,6 +1843,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x1235, 0x800c): /* Focusrite Scarlett 18i20 */
 		err = snd_scarlett_controls_create(mixer);
 		break;
+
+	case USB_ID(0x21b4, 0x0081): /* AudioQuest DragonFly */
+		snd_dragonfly_quirk_db_scale(mixer);
+		break;
 	}
 
 	return err;
-- 
2.3.8
