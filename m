From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Remove from list in
	snd_usb_endpoint_free()
Date: Thu, 26 Jun 2014 18:14:02 +0200
Message-ID: <1403799242-20622-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A47212650FF
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 18:14:05 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 87111AC2A
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 16:14:02 +0000 (UTC)
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

snd_usb_endpoint_free() deallocates the object but it doesn't unlink
from the list.  This is actually no problem in the current usage
because all elements are freed at once, but it's more consistent to do
a proper unlinking there.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This is a 3.17 material.

 sound/usb/endpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 114e3e7ff511..304f36bf29cb 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1011,6 +1011,7 @@ void snd_usb_endpoint_free(struct list_head *head)
 	struct snd_usb_endpoint *ep;
 
 	ep = list_entry(head, struct snd_usb_endpoint, list);
+	list_del(head);
 	kfree(ep);
 }
 
-- 
2.0.0
