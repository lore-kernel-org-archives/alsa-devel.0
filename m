From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/24] ALSA: ctl: cancel allocation in user
	space for ELEM_LIST request
Date: Sat, 25 Nov 2017 18:19:50 +0900
Message-ID: <20171125092006.24408-9-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E8AF1266F74
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:15 +0100 (CET)
In-Reply-To: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In compatibility layer, when handling I/O request of ELEM_LIST, a memory
ofject is allocated in user space, but programs in user land is
unperceiving it. This is not preferable behaviour and it's better to
use an alternative way if available.

This commit adds an allocator on kernel space and copy data on user space
to it, then continue processing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 8a4c58c0cf3b..f0559ed785e0 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -409,26 +409,30 @@ struct snd_ctl_elem_list32 {
 static int snd_ctl_elem_list_compat(struct snd_ctl_file *ctl_file,
 				    struct snd_ctl_elem_list32 __user *data32)
 {
-	struct snd_ctl_elem_list __user *data;
-	compat_caddr_t ptr;
+	struct snd_ctl_elem_list *list;
+	compat_uptr_t uptr;
 	int err;
 
-	data = compat_alloc_user_space(sizeof(*data));
-
-	/* offset, space, used, count */
-	if (copy_in_user(data, data32, 4 * sizeof(u32)))
-		return -EFAULT;
-	/* pids */
-	if (get_user(ptr, &data32->pids) ||
-	    put_user(compat_ptr(ptr), &data->pids))
+	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	if (!list)
 		return -EFAULT;
-	err = snd_ctl_elem_list_user(ctl_file, data);
+
+	if (copy_from_user(list, data32, 4 * sizeof(u32)) ||
+	    get_user(uptr, &data32->pids)) {
+		err = -EFAULT;
+		goto end;
+	}
+	list->pids = compat_ptr(uptr);
+
+	err = snd_ctl_elem_list(ctl_file, list);
 	if (err < 0)
-		return err;
-	/* copy the result */
-	if (copy_in_user(data32, data, 4 * sizeof(u32)))
-		return -EFAULT;
-	return 0;
+		goto end;
+
+	if (copy_to_user(data32, list, 4 * sizeof(u32)))
+		err = -EFAULT;
+end:
+	kfree(list);
+	return err;
 }
 
 /*
-- 
2.14.1
