From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH]  ALSA: usx2y: Fix potential NULL pointer dereference
Date: Mon,  4 Mar 2019 17:00:02 -0600
Message-ID: <20190304230003.13050-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

 usb_alloc_urb can fail due to kmalloc failure and push the error
 upstream. Further this can cause a NULL pointer dereference in
 init_pipe_urbs. This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/usb/usx2y/usb_stream.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index b0f8979ff2d2..221adf68bd0c 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -104,7 +104,12 @@ static int init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 
 	for (u = 0; u < USB_STREAM_NURBS; ++u) {
 		sk->inurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
+		if (!sk->inurb[u])
+			return -ENOMEM;
+
 		sk->outurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
+		if (!sk->outurb[u])
+			return -ENOMEM;
 	}
 
 	if (init_pipe_urbs(sk, use_packsize, sk->inurb, indata, dev, in_pipe) ||
-- 
2.17.1
