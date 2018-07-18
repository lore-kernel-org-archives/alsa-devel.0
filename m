From: Srikanth K H <srikanth.h@samsung.com>
Subject: [PATCHv2 1/1] Preventive fix in sound module
Date: Wed, 18 Jul 2018 20:37:00 +0530
Message-ID: <1531926420-25488-1-git-send-email-srikanth.h@samsung.com>
References: <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
        <CGME20180718150653epcas2p3c2f0e36569529df72ce0b79a22867eac@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, elfring@users.sourceforge.net, ben.hutchings@codethink.co.uk, viro@zeniv.linux.org.uk, keescook@chromium.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, srikanth.h@samsung.com
List-Id: alsa-devel@alsa-project.org

If the timer object is created without the card for entries
"SNDRV_TIMER_CLASS_CARD" and "SNDRV_TIMER_CLASS_PCM", then
while reading the sound info entry in function
"snd_timer_proc_read" the card information is directly
dereferenced without checking for NULL and hence kernel
panic occur. So as preventive measure while the creating
the sound timer object is created the card information
availability is checked for the mentioned entries and
returned error if its NULL.

Signed-off-by: Srikanth K H <srikanth.h@samsung.com>
---
 sound/core/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index c7be4f1..06f734f 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -883,6 +883,11 @@ int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid,
 
 	if (snd_BUG_ON(!tid))
 		return -EINVAL;
+	if (tid->dev_class == SNDRV_TIMER_CLASS_CARD ||
+			tid->dev_class == SNDRV_TIMER_CLASS_PCM) {
+		if (WARN_ON(!card))
+			return -EINVAL;
+	}
 	if (rtimer)
 		*rtimer = NULL;
 	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
@@ -1192,12 +1197,10 @@ static void snd_timer_proc_read(struct snd_info_entry *entry,
 			break;
 		case SNDRV_TIMER_CLASS_CARD:
 			snd_iprintf(buffer, "C%i-%i: ",
-					timer->card ? timer->card->number : -1,
-					timer->tmr_device);
+				    timer->card->number, timer->tmr_device);
 			break;
 		case SNDRV_TIMER_CLASS_PCM:
-			snd_iprintf(buffer, "P%i-%i-%i: ",
-					timer->card ? timer->card->number : -1,
+			snd_iprintf(buffer, "P%i-%i-%i: ", timer->card->number,
 				    timer->tmr_device, timer->tmr_subdevice);
 			break;
 		default:
-- 
1.9.1
