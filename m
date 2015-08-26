From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: usb-audio: Handle normal and
	auto-suspend equally
Date: Wed, 26 Aug 2015 16:16:09 +0200
Message-ID: <1440598569-4473-4-git-send-email-tiwai@suse.de>
References: <1440598569-4473-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4995C260522
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 16:16:14 +0200 (CEST)
In-Reply-To: <1440598569-4473-1-git-send-email-tiwai@suse.de>
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
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: alsa-devel@alsa-project.org

In theory, the device may get suspended even at runtime PM suspend.
Currently we don't save the mixer state for autopm, and it may bring
inconsistency.

This patch removes the special handling for autosuspend.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 73c5833e7657..18f56646ce86 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -689,30 +689,20 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	if (chip == (void *)-1L)
 		return 0;
 
-	if (!PMSG_IS_AUTO(message)) {
+	chip->autosuspended = !!PMSG_IS_AUTO(message);
+	if (!chip->autosuspended)
 		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
-		if (!chip->num_suspended_intf++) {
-			list_for_each_entry(as, &chip->pcm_list, list) {
-				snd_pcm_suspend_all(as->pcm);
-				as->substream[0].need_setup_ep =
-					as->substream[1].need_setup_ep = true;
-			}
-			list_for_each(p, &chip->midi_list) {
-				snd_usbmidi_suspend(p);
-			}
+	if (!chip->num_suspended_intf++) {
+		list_for_each_entry(as, &chip->pcm_list, list) {
+			snd_pcm_suspend_all(as->pcm);
+			as->substream[0].need_setup_ep =
+				as->substream[1].need_setup_ep = true;
 		}
-	} else {
-		/*
-		 * otherwise we keep the rest of the system in the dark
-		 * to keep this transparent
-		 */
-		if (!chip->num_suspended_intf++)
-			chip->autosuspended = 1;
-	}
-
-	if (chip->num_suspended_intf == 1)
+		list_for_each(p, &chip->midi_list)
+			snd_usbmidi_suspend(p);
 		list_for_each_entry(mixer, &chip->mixer_list, list)
 			snd_usb_mixer_suspend(mixer);
+	}
 
 	return 0;
 }
-- 
2.5.0
