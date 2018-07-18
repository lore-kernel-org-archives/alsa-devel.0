From: Srikanth K H <srikanth.h@samsung.com>
Subject: [PATCH 1/1] Preventive fix in sound module
Date: Wed, 18 Jul 2018 15:37:48 +0530
Message-ID: <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
References: <CGME20180718100741epcas1p393bea852d102e903ab6a48ff952761db@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, elfring@users.sourceforge.net, ben.hutchings@codethink.co.uk, viro@zeniv.linux.org.uk, keescook@chromium.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, srikanth.h@samsung.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Srikanth K H <srikanth.h@samsung.com>
---
 sound/core/timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index b6f076bb..c7be4f1 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1192,10 +1192,12 @@ static void snd_timer_proc_read(struct snd_info_entry *entry,
 			break;
 		case SNDRV_TIMER_CLASS_CARD:
 			snd_iprintf(buffer, "C%i-%i: ",
-				    timer->card->number, timer->tmr_device);
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
1.9.1
