From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 1/9] ALSA: usb-audio: remove unused
	parameter from sync_ep_set_params
Date: Sun, 18 Aug 2013 22:22:35 +0200
Message-ID: <1376857363-1116-2-git-send-email-eldad@fogrefinery.com>
References: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 46B1C261606
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 22:23:00 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id mx12so1164010bkb.6
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 13:23:00 -0700 (PDT)
In-Reply-To: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Since the format is not actually used in sync_ep_set_params(),
there is no need to pass it down.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 659950e..13e3685 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -700,8 +700,7 @@ out_of_memory:
 /*
  * configure a sync endpoint
  */
-static int sync_ep_set_params(struct snd_usb_endpoint *ep,
-			      struct audioformat *fmt)
+static int sync_ep_set_params(struct snd_usb_endpoint *ep)
 {
 	int i;
 
@@ -793,7 +792,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 					 period_bytes, fmt, sync_ep);
 		break;
 	case  SND_USB_ENDPOINT_TYPE_SYNC:
-		err = sync_ep_set_params(ep, fmt);
+		err = sync_ep_set_params(ep);
 		break;
 	default:
 		err = -EINVAL;
-- 
1.8.1.5
