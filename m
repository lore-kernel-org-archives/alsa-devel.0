From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: line6: Abort if inconsistent usbdev
	is found at disconnect
Date: Tue, 20 Jan 2015 10:04:17 +0100
Message-ID: <1421744662-6497-3-git-send-email-tiwai@suse.de>
References: <1421744662-6497-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BE5E02604B9
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

It's utterly unsafe to proceed further the disconnect procedure if the
assigned usbdev is inconsistent with the expected object.  Better to
put a WARN_ON() for more cautions and abort immediately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index e8d51381ffdb..625272fe227a 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -585,12 +585,12 @@ void line6_disconnect(struct usb_interface *interface)
 	if (!line6)
 		return;
 
+	if (WARN_ON(usbdev != line6->usbdev))
+		return;
+
 	if (line6->urb_listen != NULL)
 		line6_stop_listen(line6);
 
-	if (usbdev != line6->usbdev)
-		dev_err(line6->ifcdev, "driver bug: inconsistent usb device\n");
-
 	snd_card_disconnect(line6->card);
 	if (line6->line6pcm)
 		line6_pcm_disconnect(line6->line6pcm);
-- 
2.2.1
