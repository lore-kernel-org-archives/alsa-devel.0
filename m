From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ALSA: core: Fix possible null-pointer dereferences in snd_timer_proc_read()
Date: Wed, 24 Jul 2019 20:13:27 +0800
Message-ID: <20190724121327.9894-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, bhelgaas@google.com, tglx@linutronix.de, rfontana@redhat.com, gregkh@linuxfoundation.org, kirr@nexedi.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: alsa-devel@alsa-project.org

In snd_timer_proc_read(), there is an if statement on line 1204 to check
whether timer->card is NULL:
    if (timer->card && timer->card->shutdown)

When timer->card is NULL, it is used on lines 1212 and 1215:
    timer->card->number

Thus, possible null-pointer dereferences may occur.

To fix these bugs, timer->card is checked before being used.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/core/timer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 5c9fbf3f4340..967d06a3cdec 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1208,11 +1208,13 @@ static void snd_timer_proc_read(struct snd_info_entry *entry,
 			snd_iprintf(buffer, "G%i: ", timer->tmr_device);
 			break;
 		case SNDRV_TIMER_CLASS_CARD:
-			snd_iprintf(buffer, "C%i-%i: ",
-				    timer->card->number, timer->tmr_device);
+			snd_iprintf(buffer, "C%i-%i: ", 
+					timer->card ? timer->card->number : -1, 
+					timer->tmr_device);
 			break;
 		case SNDRV_TIMER_CLASS_PCM:
-			snd_iprintf(buffer, "P%i-%i-%i: ", timer->card->number,
+			snd_iprintf(buffer, "P%i-%i-%i: ",
+					timer->card ? timer->card->number : -1,
 				    timer->tmr_device, timer->tmr_subdevice);
 			break;
 		default:
-- 
2.17.0
