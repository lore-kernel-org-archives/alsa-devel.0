From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, PATCH RFC,
	v4 03/10] usb-audio: use sender stride for implicit feedback
Date: Wed, 28 Nov 2012 23:55:34 +0100
Message-ID: <1354143341-1623-4-git-send-email-eldad@fogrefinery.com>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 14062264F1A
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 23:55:55 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5643893bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 14:55:55 -0800 (PST)
In-Reply-To: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: Grant Diffey <gdiffey@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

For implicit feedback endpoints, the number of bytes for each packet
is matched by the corresponding synchronizing endpoint.
The size is calculated by taking the actual size and dividing it by
the stride - currently by the endpoint's stride, but we should use the
synchronization source's stride.
This is evident when the number of channels differ between the
synchronization source and the implicitly fed-back endpoint, as with
M-Audio Fast Track C400 - the synchronization source (capture)
has 4 channels, while the implicit feedback mode endpoint has 6.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 34de6f2..72e711c 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1034,15 +1034,18 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 		/*
 		 * Iterate through the inbound packet and prepare the lengths
 		 * for the output packet. The OUT packet we are about to send
-		 * will have the same amount of payload bytes than the IN
-		 * packet we just received.
+		 * will have the same amount of payload bytes per stride as the
+		 * IN packet we just received. Since the actual size is scaled
+		 * by the stride, use the sender stride to calculate the length
+		 * in case the number of channels differ between the implicitly
+		 * fed-back endpoint and the synchronizing endpoint.
 		 */
 
 		out_packet->packets = in_ctx->packets;
 		for (i = 0; i < in_ctx->packets; i++) {
 			if (urb->iso_frame_desc[i].status == 0)
 				out_packet->packet_size[i] =
-					urb->iso_frame_desc[i].actual_length / ep->stride;
+					urb->iso_frame_desc[i].actual_length / sender->stride;
 			else
 				out_packet->packet_size[i] = 0;
 		}
-- 
1.7.8.6
