From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: info: Use kvzalloc() for a temporary
	write buffer
Date: Mon, 22 May 2017 17:51:46 +0200
Message-ID: <20170522155146.4758-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AC490266E84
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 17:51:48 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1E911AB5D
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 15:51:48 +0000 (UTC)
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

We used to use kmalloc (more exactly, krealloc()) for creating and
growing the temporary buffer for text proc write.  It can grow up to
16kB, and it's already a bit doubtful whether it's always safe to use
kmalloc().  With the recent addition of kvmalloc(), we can have a
better chance for succeed of memory allocation, so let's switch to
that new API.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 8ab72e0f5932..fc14ebe751d8 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -344,12 +344,12 @@ static ssize_t snd_info_text_entry_write(struct file *file,
 		}
 	}
 	if (next > buf->len) {
-		char *nbuf = krealloc(buf->buffer, PAGE_ALIGN(next),
-				      GFP_KERNEL | __GFP_ZERO);
+		char *nbuf = kvzalloc(PAGE_ALIGN(next), GFP_KERNEL);
 		if (!nbuf) {
 			err = -ENOMEM;
 			goto error;
 		}
+		kvfree(buf->buffer);
 		buf->buffer = nbuf;
 		buf->len = PAGE_ALIGN(next);
 	}
@@ -427,7 +427,7 @@ static int snd_info_text_entry_release(struct inode *inode, struct file *file)
 	single_release(inode, file);
 	kfree(data->rbuffer);
 	if (data->wbuffer) {
-		kfree(data->wbuffer->buffer);
+		kvfree(data->wbuffer->buffer);
 		kfree(data->wbuffer);
 	}
 
-- 
2.13.0
