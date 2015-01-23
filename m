From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/16] ALSA: line6: Use dev_err()
Date: Fri, 23 Jan 2015 18:13:20 +0100
Message-ID: <1422033203-23254-14-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 98B9D2654FC
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:41 +0100 (CET)
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

This is the last remaining snd_printk() usage in this driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 677419dcacf9..4152d92105b1 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -128,7 +128,8 @@ static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
 		schedule_timeout(1);
 	} while (--timeout > 0);
 	if (alive)
-		snd_printk(KERN_ERR "timeout: still %d active urbs..\n", alive);
+		dev_err(line6pcm->line6->ifcdev,
+			"timeout: still %d active urbs..\n", alive);
 }
 
 static bool test_flags(unsigned long flags0, unsigned long flags1,
-- 
2.2.2
