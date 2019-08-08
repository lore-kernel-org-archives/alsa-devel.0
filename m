From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] sound: fix a memory leak bug
Date: Thu,  8 Aug 2019 00:15:21 -0500
Message-ID: <1565241321-2418-1-git-send-email-wenwen@cs.uga.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In sound_insert_unit(), the controlling structure 's' is allocated through
kmalloc(). Then it is added to the sound driver list by invoking
__sound_insert_unit(). Later on, if __register_chrdev() fails, 's' is
removed from the list through __sound_remove_unit(). If 'index' is not less
than 0, -EBUSY is returned to indicate the error. However, 's' is not
deallocated on this execution path, leading to a memory leak bug.

To fix the above issue, free 's' before -EBUSY is returned.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/sound_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index b730d97..90d118c 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -275,7 +275,8 @@ static int sound_insert_unit(struct sound_unit **list, const struct file_operati
 				goto retry;
 			}
 			spin_unlock(&sound_loader_lock);
-			return -EBUSY;
+			r = -EBUSY;
+			goto fail;
 		}
 	}
 
-- 
2.7.4
