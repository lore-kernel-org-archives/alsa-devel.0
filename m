From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: info: Avoid leaking kernel memory
Date: Wed, 13 Mar 2013 17:36:39 +0100
Message-ID: <1363192600-11832-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 805E226197B
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:36:40 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 48945A4F01
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:36:40 +0100 (CET)
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

Make sure that the allocated buffer for reading the proc file won't
expose the uncleared kernel memory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index db308db..58e97b3 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -89,7 +89,7 @@ static int resize_info_buffer(struct snd_info_buffer *buffer,
 	char *nbuf;
 
 	nsize = PAGE_ALIGN(nsize);
-	nbuf = krealloc(buffer->buffer, nsize, GFP_KERNEL);
+	nbuf = krealloc(buffer->buffer, nsize, GFP_KERNEL | __GFP_ZERO);
 	if (! nbuf)
 		return -ENOMEM;
 
@@ -353,7 +353,7 @@ static int snd_info_entry_open(struct inode *inode, struct file *file)
 				goto __nomem;
 			data->rbuffer = buffer;
 			buffer->len = PAGE_SIZE;
-			buffer->buffer = kmalloc(buffer->len, GFP_KERNEL);
+			buffer->buffer = kzalloc(buffer->len, GFP_KERNEL);
 			if (buffer->buffer == NULL)
 				goto __nomem;
 		}
-- 
1.8.1.4
