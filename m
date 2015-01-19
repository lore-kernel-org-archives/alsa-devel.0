From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/18] ALSA: line6: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:31 +0100
Message-ID: <1421665891-14475-19-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C9962606F4
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0A285ADA3
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:36 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c   | 3 +--
 sound/usb/line6/toneport.c | 8 +++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index fc852f6ab8bc..19904d677114 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -415,8 +415,7 @@ void line6_start_timer(struct timer_list *timer, unsigned int msecs,
 		       void (*function)(unsigned long), unsigned long data)
 {
 	setup_timer(timer, function, data);
-	timer->expires = jiffies + msecs * HZ / 1000;
-	add_timer(timer);
+	mod_timer(timer, jiffies + msecs * HZ / 1000);
 }
 
 /*
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index aae78d8a82d9..7f97f4a812a7 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -433,11 +433,9 @@ static int toneport_try_init(struct usb_interface *interface,
 
 	toneport_setup(toneport);
 
-	init_timer(&toneport->timer);
-	toneport->timer.expires = jiffies + TONEPORT_PCM_DELAY * HZ;
-	toneport->timer.function = toneport_start_pcm;
-	toneport->timer.data = (unsigned long)toneport;
-	add_timer(&toneport->timer);
+	setup_timer(&toneport->timer, toneport_start_pcm,
+		    (unsigned long)toneport);
+	mod_timer(&toneport->timer, jiffies + TONEPORT_PCM_DELAY * HZ);
 
 	return 0;
 }
-- 
2.2.1
