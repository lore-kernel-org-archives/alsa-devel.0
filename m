From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: line6: Fix write on zero-sized buffer
Date: Tue,  2 Jul 2019 20:11:45 +0200
Message-ID: <20190702181145.9979-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A63DF800C1
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 20:11:48 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7C84FAFCD
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 18:11:47 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

LINE6 drivers allocate the buffers based on the value returned from
usb_maxpacket() calls.  The manipulated device may return zero for
this, and this results in the kmalloc() with zero size (and it may
succeed) while the other part of the driver code writes the packet
data with the fixed size -- which eventually overwrites.

This patch adds a simple sanity check for the invalid buffer size for
avoiding that problem.

Reported-by: syzbot+219f00fb49874dcaea17@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 72c6f8e82a7e..78c2d6cab3b5 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -560,6 +560,11 @@ int line6_init_pcm(struct usb_line6 *line6,
 	line6pcm->max_packet_size_out =
 		usb_maxpacket(line6->usbdev,
 			usb_sndisocpipe(line6->usbdev, ep_write), 1);
+	if (!line6pcm->max_packet_size_in || !line6pcm->max_packet_size_out) {
+		dev_err(line6pcm->line6->ifcdev,
+			"cannot get proper max packet size\n");
+		return -EINVAL;
+	}
 
 	spin_lock_init(&line6pcm->out.lock);
 	spin_lock_init(&line6pcm->in.lock);
-- 
2.16.4
