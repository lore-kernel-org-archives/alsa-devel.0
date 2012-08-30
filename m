From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/3] ALSA: snd-usb: fix cross-interface
	streaming devices
Date: Thu, 30 Aug 2012 18:52:31 +0200
Message-ID: <1346345551-8956-4-git-send-email-zonque@gmail.com>
References: <1346345551-8956-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 577A1265DB2
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 18:52:57 +0200 (CEST)
In-Reply-To: <1346345551-8956-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, linux@romal.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 68e67f40b ("ALSA: snd-usb: move calls to usb_set_interface")
saved us some unnecessary calls to snd_usb_set_interface() but ignored
the fact that there is at least one device out there which operates on
two endpoint in different interfaces simultaniously.

Take care for this by catching the case where data and sync endpoints
are located on different interfaces and calling snd_usb_set_interface()
between the start of the two endpoints.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Robert M. Albrecht <linux@romal.de>
---
 sound/usb/pcm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e80b668..fd5e982 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -236,6 +236,21 @@ static int start_endpoints(struct snd_usb_substream *subs, int can_sleep)
 	    !test_and_set_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags)) {
 		struct snd_usb_endpoint *ep = subs->sync_endpoint;
 
+		if (subs->data_endpoint->iface != subs->sync_endpoint->iface ||
+		    subs->data_endpoint->alt_idx != subs->sync_endpoint->alt_idx) {
+			err = usb_set_interface(subs->dev,
+						subs->sync_endpoint->iface,
+						subs->sync_endpoint->alt_idx);
+			if (err < 0) {
+				snd_printk(KERN_ERR
+					   "%d:%d:%d: cannot set interface (%d)\n",
+					   subs->dev->devnum,
+					   subs->sync_endpoint->iface,
+					   subs->sync_endpoint->alt_idx, err);
+				return -EIO;
+			}
+		}
+
 		snd_printdd(KERN_DEBUG "Starting sync EP @%p\n", ep);
 
 		ep->sync_slave = subs->data_endpoint;
-- 
1.7.11.4
