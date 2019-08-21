From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Fix invalid NULL check in
	snd_emuusb_set_samplerate()
Date: Wed, 21 Aug 2019 08:20:13 +0200
Message-ID: <20190821062013.32014-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 428EDF80157
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 08:20:15 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BDD2BAF23
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 06:20:14 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The quirk function snd_emuusb_set_samplerate() has a NULL check for
the mixer element, but this is useless in the current code.  It used
to be a check against mixer->id_elems[unitid] but it was changed later
to the value after mixer_eleme_list_to_info() which is always non-NULL
due to the container_of() usage.

This patch fixes the check before the conversion.

While we're at it, correct a typo in the comment in the function,
too.

Fixes: 8c558076c740 ("ALSA: usb-audio: Clean up mixer element list traverse")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 199fa157a411..27dcb3743690 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1155,17 +1155,17 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 {
 	struct usb_mixer_interface *mixer;
 	struct usb_mixer_elem_info *cval;
-	int unitid = 12; /* SamleRate ExtensionUnit ID */
+	int unitid = 12; /* SampleRate ExtensionUnit ID */
 
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
-		cval = mixer_elem_list_to_info(mixer->id_elems[unitid]);
-		if (cval) {
+		if (mixer->id_elems[unitid]) {
+			cval = mixer_elem_list_to_info(mixer->id_elems[unitid]);
 			snd_usb_mixer_set_ctl_value(cval, UAC_SET_CUR,
 						    cval->control << 8,
 						    samplerate_id);
 			snd_usb_mixer_notify_id(mixer, unitid);
+			break;
 		}
-		break;
 	}
 }
 
-- 
2.16.4
