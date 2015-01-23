From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/16] ALSA: line6: Use logical OR
Date: Fri, 23 Jan 2015 18:13:13 +0100
Message-ID: <1422033203-23254-7-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 30EB02654D9
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:40 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Fixed a few places using bits OR wrongly for condition checks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 826158fe9149..f740b4490d75 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -131,7 +131,7 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 		   a bug, we therefore report an error if capturing is restarted
 		   too soon.
 		 */
-		if (line6pcm->active_urb_in | line6pcm->unlink_urb_in) {
+		if (line6pcm->active_urb_in || line6pcm->unlink_urb_in) {
 			dev_err(line6pcm->line6->ifcdev, "Device not yet ready\n");
 			err = -EBUSY;
 			goto pcm_acquire_error;
@@ -166,7 +166,7 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 		/*
 		  See comment above regarding PCM restart.
 		*/
-		if (line6pcm->active_urb_out | line6pcm->unlink_urb_out) {
+		if (line6pcm->active_urb_out || line6pcm->unlink_urb_out) {
 			dev_err(line6pcm->line6->ifcdev, "Device not yet ready\n");
 			return -EBUSY;
 		}
-- 
2.2.2
