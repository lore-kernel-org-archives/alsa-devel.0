From: Julian Scheel <julian@jusst.de>
Subject: [PATCH] ALSA: usb-audio: uac1: Invalidate ctl on
	interrupt
Date: Thu, 16 Nov 2017 17:35:17 +0100
Message-ID: <20171116163517.5010-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web01.jusst.de (jusst.de [188.40.114.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 36230266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 17:35:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, Julian Scheel <julian@jusst.de>, Stephen Barber <smbarber@chromium.org>, Con Kolivas <con@kolivas.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When an interrupt occurs, the value of at least one of the belonging
controls should have changed. To make sure they get re-read from device
on the next read, invalidate the cache. This was correctly implemented
for uac2 already, but missing for uac1.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 sound/usb/mixer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 91bc8f18791e..1beb5b4d027e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2330,9 +2330,14 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid)
 {
 	struct usb_mixer_elem_list *list;
 
-	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem)
+	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem) {
+		struct usb_mixer_elem_info *info =
+			(struct usb_mixer_elem_info *)list;
+		/* invalidate cache, so the value is read from the device */
+		info->cached = 0;
 		snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 			       &list->kctl->id);
+	}
 }
 
 static void snd_usb_mixer_dump_cval(struct snd_info_buffer *buffer,
-- 
2.15.0
