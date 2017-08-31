From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: usx2y: Put missing KERN_CONT prefix
Date: Thu, 31 Aug 2017 11:33:33 +0200
Message-ID: <20170831093334.9050-6-tiwai@suse.de>
References: <20170831093334.9050-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 627432672C2
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:33:39 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 77C25AEE9
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 09:33:37 +0000 (UTC)
In-Reply-To: <20170831093334.9050-1-tiwai@suse.de>
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

The usx2y driver has a debug printk code without proper KERN_ prefix.
On recent kernels, KERN_CONT prefix is mandatory for continued output
lines.  Put it properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usb_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index bf618e1500ac..fe926cb9192e 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -625,9 +625,9 @@ static void i_capture_start(struct urb *urb)
 		       urb->iso_frame_desc[0].actual_length);
 		for (pack = 1; pack < urb->number_of_packets; ++pack) {
 			int l = urb->iso_frame_desc[pack].actual_length;
-			printk(" %i", l);
+			printk(KERN_CONT " %i", l);
 		}
-		printk("\n");
+		printk(KERN_CONT "\n");
 	}
 #endif
 	if (!empty && s->state < usb_stream_sync1)
-- 
2.14.1
