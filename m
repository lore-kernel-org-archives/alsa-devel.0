From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/16] ALSA: line6: Fix missing error handling
	in line6_pcm_acquire()
Date: Fri, 23 Jan 2015 18:13:12 +0100
Message-ID: <1422033203-23254-6-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ADF62606E2
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 8a6059adef69..826158fe9149 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -133,7 +133,8 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 		 */
 		if (line6pcm->active_urb_in | line6pcm->unlink_urb_in) {
 			dev_err(line6pcm->line6->ifcdev, "Device not yet ready\n");
-			return -EBUSY;
+			err = -EBUSY;
+			goto pcm_acquire_error;
 		}
 
 		line6pcm->count_in = 0;
-- 
2.2.2
