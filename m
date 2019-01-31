From: manuel.rhdt@gmail.com
Subject: [PATCH] ALSA: usb-audio: Fix implicit fb endpoint
	setup by quirk
Date: Thu, 31 Jan 2019 15:32:35 +0100
Message-ID: <d7a90b82916812e11851582a102de42913265522.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1339B267448
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 15:32:37 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id d15so2736428wmb.3
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 06:32:37 -0800 (PST)
Received: from mrdesktop.fritz.box (ip5f5ac579.dynamic.kabel-deutschland.de.
 [95.90.197.121])
 by smtp.gmail.com with ESMTPSA id s132sm5310449wmf.28.2019.01.31.06.32.36
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 31 Jan 2019 06:32:36 -0800 (PST)
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

The commit a60945fd08e4 ("ALSA: usb-audio: move implicit fb quirks to
separate function") introduced an error in the handling of quirks for
implicit feedback endpoints. This commit fixes this.

If a quirk successfully sets up an implicit feedback endpoint, usb-audio
no longer tries to find the implicit fb endpoint itself.

Signed-off-by: Manuel Reinhardt <manuel.rhdt@gmail.com>
---
 sound/usb/pcm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 382847154227..db114f3977e0 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -314,6 +314,9 @@ static int search_roland_implicit_fb(struct usb_device *dev, int ifnum,
 	return 0;
 }
 
+/* Setup an implicit feedback endpoint from a quirk. Returns 0 if no quirk
+ * applies. Returns 1 if a quirk was found.
+ */
 static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 					 struct usb_device *dev,
 					 struct usb_interface_descriptor *altsd,
@@ -384,7 +387,7 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 
 	subs->data_endpoint->sync_master = subs->sync_endpoint;
 
-	return 0;
+	return 1;
 }
 
 static int set_sync_endpoint(struct snd_usb_substream *subs,
@@ -423,6 +426,10 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	if (err < 0)
 		return err;
 
+	/* endpoint set by quirk */
+	if (err > 0)
+		return 0;
+
 	if (altsd->bNumEndpoints < 2)
 		return 0;
 
-- 
2.20.1
