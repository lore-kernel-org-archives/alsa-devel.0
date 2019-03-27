From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: us122l: Use alloc_pages_exact()
Date: Wed, 27 Mar 2019 10:29:59 +0100
Message-ID: <20190327092959.30382-3-tiwai@suse.de>
References: <20190327092959.30382-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7F0CF801D9
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 10:30:01 +0100 (CET)
In-Reply-To: <20190327092959.30382-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: alsa-devel@alsa-project.org

alloc_pages_exact() is more suitable choice for allocating the sound
buffers, as it doesn't need to align with power-of-two.  Along with
the conversion, we can drop __GFP_COMP as well.

The patch also replace the error messages to be more explicit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usb_stream.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index 221adf68bd0c..51d73111263a 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -155,9 +155,9 @@ void usb_stream_free(struct usb_stream_kernel *sk)
 	if (!s)
 		return;
 
-	free_pages((unsigned long)sk->write_page, get_order(s->write_size));
+	free_pages_exact(sk->write_page, s->write_size);
 	sk->write_page = NULL;
-	free_pages((unsigned long)s, get_order(s->read_size));
+	free_pages_exact(s, s->read_size);
 	sk->s = NULL;
 }
 
@@ -172,7 +172,6 @@ struct usb_stream *usb_stream_new(struct usb_stream_kernel *sk,
 	int read_size = sizeof(struct usb_stream);
 	int write_size;
 	int usb_frames = dev->speed == USB_SPEED_HIGH ? 8000 : 1000;
-	int pg;
 
 	in_pipe = usb_rcvisocpipe(dev, in_endpoint);
 	out_pipe = usb_sndisocpipe(dev, out_endpoint);
@@ -202,11 +201,10 @@ struct usb_stream *usb_stream_new(struct usb_stream_kernel *sk,
 		goto out;
 	}
 
-	pg = get_order(read_size);
-	sk->s = (void *) __get_free_pages(GFP_KERNEL|__GFP_COMP|__GFP_ZERO|
-					  __GFP_NOWARN, pg);
+	sk->s = alloc_pages_exact(read_size,
+				  GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
 	if (!sk->s) {
-		snd_printk(KERN_WARNING "couldn't __get_free_pages()\n");
+		pr_warn("us122l: couldn't allocate read buffer\n");
 		goto out;
 	}
 	sk->s->cfg.version = USB_STREAM_INTERFACE_VERSION;
@@ -221,13 +219,11 @@ struct usb_stream *usb_stream_new(struct usb_stream_kernel *sk,
 	sk->s->period_size = frame_size * period_frames;
 
 	sk->s->write_size = write_size;
-	pg = get_order(write_size);
 
-	sk->write_page =
-		(void *)__get_free_pages(GFP_KERNEL|__GFP_COMP|__GFP_ZERO|
-					 __GFP_NOWARN, pg);
+	sk->write_page = alloc_pages_exact(write_size,
+					   GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
 	if (!sk->write_page) {
-		snd_printk(KERN_WARNING "couldn't __get_free_pages()\n");
+		pr_warn("us122l: couldn't allocate write buffer\n");
 		usb_stream_free(sk);
 		return NULL;
 	}
-- 
2.16.4
