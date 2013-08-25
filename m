From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v3 02/11] ALSA: usb-audio: remove
	deactivate_endpoints()
Date: Sun, 25 Aug 2013 17:43:10 +0200
Message-ID: <1377445399-5678-3-git-send-email-eldad@fogrefinery.com>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 373F92617B8
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 17:43:37 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id r7so782135bkg.8
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 08:43:36 -0700 (PDT)
In-Reply-To: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

The only call site for deactivate_endpoints() at snd_usb_hw_free().
The return value is not checked there, as it is irrelevant if it
fails on hw_free.
This patch moves the deactivation of the endpoints directly into
snd_usb_hw_free().

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b375d58..9ec401a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -282,22 +282,6 @@ static void stop_endpoints(struct snd_usb_substream *subs, bool wait)
 	}
 }
 
-static int deactivate_endpoints(struct snd_usb_substream *subs)
-{
-	int reta, retb;
-
-	reta = snd_usb_endpoint_deactivate(subs->sync_endpoint);
-	retb = snd_usb_endpoint_deactivate(subs->data_endpoint);
-
-	if (reta < 0)
-		return reta;
-
-	if (retb < 0)
-		return retb;
-
-	return 0;
-}
-
 static int search_roland_implicit_fb(struct usb_device *dev, int ifnum,
 				     unsigned int altsetting,
 				     struct usb_host_interface **alts,
@@ -730,7 +714,8 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	down_read(&subs->stream->chip->shutdown_rwsem);
 	if (!subs->stream->chip->shutdown) {
 		stop_endpoints(subs, true);
-		deactivate_endpoints(subs);
+		snd_usb_endpoint_deactivate(subs->sync_endpoint);
+		snd_usb_endpoint_deactivate(subs->data_endpoint);
 	}
 	up_read(&subs->stream->chip->shutdown_rwsem);
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
-- 
1.8.1.5
