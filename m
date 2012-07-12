From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ALSA: snd-usb: tighten EP_FLAG_RUNNING
	checks
Date: Thu, 12 Jul 2012 15:19:46 +0200
Message-ID: <1342099187-6978-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FF9F2440E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 15:29:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, philipp@dreimann.net, joseph.salisbury@canonical.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

In endpoint.c, bail out earlier in case the stream is stopped. Also
clear the flag from deactivate_urbs() in case the chip's shutdown
flag is set.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/endpoint.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e690690..a75bdf4 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -350,7 +350,8 @@ static void snd_complete_urb(struct urb *urb)
 		     urb->status == -ENODEV ||		/* device removed */
 		     urb->status == -ECONNRESET ||	/* unlinked */
 		     urb->status == -ESHUTDOWN ||	/* device disabled */
-		     ep->chip->shutdown))		/* device disconnected */
+		     ep->chip->shutdown) ||		/* device disconnected */
+		     !test_bit(EP_FLAG_RUNNING, &ep->flags))
 		goto exit_clear;
 
 	if (usb_pipeout(ep->pipe)) {
@@ -522,13 +523,13 @@ static int deactivate_urbs(struct snd_usb_endpoint *ep, int force, int can_sleep
 	unsigned int i;
 	int async;
 
+	clear_bit(EP_FLAG_RUNNING, &ep->flags);
+
 	if (!force && ep->chip->shutdown) /* to be sure... */
 		return -EBADFD;
 
 	async = !can_sleep && ep->chip->async_unlink;
 
-	clear_bit(EP_FLAG_RUNNING, &ep->flags);
-
 	INIT_LIST_HEAD(&ep->ready_playback_urbs);
 	ep->next_packet_read_pos = 0;
 	ep->next_packet_write_pos = 0;
-- 
1.7.10.4
