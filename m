From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [Xen-devel][PATCH] ALSA: xen-front: Do not use stream buffer size before it is set
Date: Thu,  4 Apr 2019 15:38:38 +0300
Message-ID: <20190404123838.22162-1-andr2000@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This fixes the regression introduced while moving to Xen shared
buffer implementation.

Fixes: 58f9d806d16a ("ALSA: xen-front: Use Xen common shared buffer implementation")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 sound/xen/xen_snd_front_alsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index a7f413cb704d..b14ab512c2ce 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -441,7 +441,7 @@ static int shbuf_setup_backstore(struct xen_snd_front_pcm_stream_info *stream,
 {
 	int i;
 
-	stream->buffer = alloc_pages_exact(stream->buffer_sz, GFP_KERNEL);
+	stream->buffer = alloc_pages_exact(buffer_sz, GFP_KERNEL);
 	if (!stream->buffer)
 		return -ENOMEM;
 
-- 
2.21.0
