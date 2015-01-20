From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: line6: Don't forget to call driver's
	destructor at error path
Date: Tue, 20 Jan 2015 10:04:20 +0100
Message-ID: <1421744662-6497-6-git-send-email-tiwai@suse.de>
References: <1421744662-6497-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C81242604D0
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

Currently disconnect callback is used as a driver's destructor, and
this has to be called not only at the disconnection time but also at
the error paths during probe.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 625272fe227a..e7f9a99e1949 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -568,6 +568,8 @@ int line6_probe(struct usb_interface *interface,
 	return 0;
 
  err_destruct:
+	if (line6->disconnect)
+		line6->disconnect(interface);
 	snd_card_free(card);
  err_put:
 	return ret;
-- 
2.2.1
