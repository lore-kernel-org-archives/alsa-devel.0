From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/9] ALSA: ua101: use usb_fill_int_urb()
Date: Tue, 19 Jun 2018 23:55:15 +0200
Message-ID: <20180619215521.13688-4-bigeasy@linutronix.de>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CC082675FA
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 23:55:31 +0200 (CEST)
In-Reply-To: <20180619215521.13688-1-bigeasy@linutronix.de>
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-usb@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, tglx@linutronix.de
List-Id: alsa-devel@alsa-project.org

Using usb_fill_int_urb() helps to find code which initializes an
URB. A grep for members of the struct (like ->complete) reveal lots
of other things, too.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/usb/misc/ua101.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 386fbfd5c617..7002fb4c1bce 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -1118,16 +1118,12 @@ static int alloc_stream_urbs(struct ua101 *ua, struct ua101_stream *stream,
 			if (!urb)
 				return -ENOMEM;
 			usb_init_urb(&urb->urb);
-			urb->urb.dev = ua->dev;
-			urb->urb.pipe = stream->usb_pipe;
+			usb_fill_int_urb(&urb->urb, ua->dev, stream->usb_pipe,
+					 addr, max_packet_size, urb_complete,
+					 ua, 1);
 			urb->urb.transfer_flags = URB_NO_TRANSFER_DMA_MAP;
-			urb->urb.transfer_buffer = addr;
 			urb->urb.transfer_dma = dma;
-			urb->urb.transfer_buffer_length = max_packet_size;
 			urb->urb.number_of_packets = 1;
-			urb->urb.interval = 1;
-			urb->urb.context = ua;
-			urb->urb.complete = urb_complete;
 			urb->urb.iso_frame_desc[0].offset = 0;
 			urb->urb.iso_frame_desc[0].length = max_packet_size;
 			stream->urbs[u++] = urb;
-- 
2.17.1
