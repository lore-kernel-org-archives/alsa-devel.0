From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] ALSA: firewire: fix a memory leak bug
Date: Thu,  8 Aug 2019 00:50:58 -0500
Message-ID: <1565243458-2771-1-git-send-email-wenwen@cs.uga.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:FIREWIRE AUDIO DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In iso_packets_buffer_init(), 'b->packets' is allocated through
kmalloc_array(). Then, the aligned packet size is checked. If it is
larger than PAGE_SIZE, -EINVAL will be returned to indicate the error.
However, the allocated 'b->packets' is not deallocated on this path,
leading to a memory leak.

To fix the above issue, free 'b->packets' before returning the error code.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/firewire/packets-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/packets-buffer.c b/sound/firewire/packets-buffer.c
index 0d35359..0ecafd0 100644
--- a/sound/firewire/packets-buffer.c
+++ b/sound/firewire/packets-buffer.c
@@ -37,7 +37,7 @@ int iso_packets_buffer_init(struct iso_packets_buffer *b, struct fw_unit *unit,
 	packets_per_page = PAGE_SIZE / packet_size;
 	if (WARN_ON(!packets_per_page)) {
 		err = -EINVAL;
-		goto error;
+		goto err_packets;
 	}
 	pages = DIV_ROUND_UP(count, packets_per_page);
 
-- 
2.7.4
