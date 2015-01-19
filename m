From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/17] ALSA: line6: Remove superfluous
	disconnect call in suspend handler
Date: Mon, 19 Jan 2015 16:54:48 +0100
Message-ID: <1421682891-11594-15-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 63DAF261490
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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

Calling line6_pcm_disconnect() at suspend callback is superfluous and
rather confusing.  Let's get rid of it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 6a3ec07d869f..f222d9ffeca5 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -700,7 +700,6 @@ int line6_suspend(struct usb_interface *interface, pm_message_t message)
 
 	if (line6pcm != NULL) {
 		snd_pcm_suspend_all(line6pcm->pcm);
-		line6_pcm_disconnect(line6pcm);
 		line6pcm->flags = 0;
 	}
 
-- 
2.2.1
