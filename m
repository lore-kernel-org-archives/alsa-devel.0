From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 01/10] ALSA: usb-audio: remove unused
	parameter from sync_ep_set_params
Date: Wed, 21 Aug 2013 23:37:56 +0200
Message-ID: <1377121085-20563-2-git-send-email-eldad@fogrefinery.com>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D544264F34
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 23:38:24 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id mx11so389036bkb.18
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 14:38:24 -0700 (PDT)
In-Reply-To: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
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

Since the format is not actually used in sync_ep_set_params(),
there is no need to pass it down.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 93e970f..86b23af 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -703,8 +703,7 @@ out_of_memory:
 /*
  * configure a sync endpoint
  */
-static int sync_ep_set_params(struct snd_usb_endpoint *ep,
-			      struct audioformat *fmt)
+static int sync_ep_set_params(struct snd_usb_endpoint *ep)
 {
 	int i;
 
@@ -796,7 +795,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
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
