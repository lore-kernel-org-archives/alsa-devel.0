From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ALSA: line6/toneport: Move setup_timer()
	at the beginning
Date: Tue, 20 Jan 2015 10:04:19 +0100
Message-ID: <1421744662-6497-5-git-send-email-tiwai@suse.de>
References: <1421744662-6497-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EBA29260508
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 10:04:36 +0100 (CET)
In-Reply-To: <1421744662-6497-1-git-send-email-tiwai@suse.de>
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

... so that timer_del_sync() in the destructor can be called safely at
any time.  Also move the mod_timer() call in toneport_setup(), which
is a bit clearer place.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/toneport.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index e5669bd3233a..fb6d5e1e2ade 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -360,6 +360,8 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 
 	if (toneport_has_led(toneport->type))
 		toneport_update_led(&usbdev->dev);
+
+	mod_timer(&toneport->timer, jiffies + TONEPORT_PCM_DELAY * HZ);
 }
 
 /*
@@ -390,6 +392,9 @@ static int toneport_init(struct usb_interface *interface,
 	int err;
 	struct usb_line6_toneport *toneport =  (struct usb_line6_toneport *) line6;
 
+	setup_timer(&toneport->timer, toneport_start_pcm,
+		    (unsigned long)toneport);
+
 	line6->disconnect = line6_toneport_disconnect;
 
 	/* initialize PCM subsystem: */
@@ -435,10 +440,6 @@ static int toneport_init(struct usb_interface *interface,
 
 	toneport_setup(toneport);
 
-	setup_timer(&toneport->timer, toneport_start_pcm,
-		    (unsigned long)toneport);
-	mod_timer(&toneport->timer, jiffies + TONEPORT_PCM_DELAY * HZ);
-
 	/* register audio system: */
 	return snd_card_register(line6->card);
 }
-- 
2.2.1
