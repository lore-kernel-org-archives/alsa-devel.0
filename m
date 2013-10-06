From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v4 01/15] ALSA: usb-audio: remove unused
	parameter from sync_ep_set_params
Date: Sun,  6 Oct 2013 22:31:06 +0200
Message-ID: <1381091480-23636-2-git-send-email-eldad@fogrefinery.com>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 40197261A5E
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 22:31:27 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id my13so2292827bkb.35
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 13:31:27 -0700 (PDT)
In-Reply-To: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Nikolay Martynov <mar.kolya@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Since the format is not actually used in sync_ep_set_params(),
there is no need to pass it down.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 21dc642..5dd51af 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -714,8 +714,7 @@ out_of_memory:
 /*
  * configure a sync endpoint
  */
-static int sync_ep_set_params(struct snd_usb_endpoint *ep,
-			      struct audioformat *fmt)
+static int sync_ep_set_params(struct snd_usb_endpoint *ep)
 {
 	int i;
 
@@ -812,7 +811,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 					 buffer_periods, fmt, sync_ep);
 		break;
 	case  SND_USB_ENDPOINT_TYPE_SYNC:
-		err = sync_ep_set_params(ep, fmt);
+		err = sync_ep_set_params(ep);
 		break;
 	default:
 		err = -EINVAL;
-- 
1.8.1.5
