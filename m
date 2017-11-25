From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/24] ALSA: ctl: allocation of elem_info data
	for ELEM_ADD/ELEM_REPLACE requests
Date: Sat, 25 Nov 2017 18:19:57 +0900
Message-ID: <20171125092006.24408-16-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 833FE2674D1
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:18 +0100 (CET)
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

In current implementation, for I/O request of ELEM_ADD/ELEM_REPLACE, kernel
stack is used to copy 'struct snd_ctl_elem_info' data. However, the size of
this structure is a bit big and usage of kernel stack is not preferable.

This commit allocates a memory object on kernel space, instead.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 268771ed2939..a321576a6308 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1405,23 +1405,26 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	return 0;
 }
 
-static int snd_ctl_elem_add_user(struct snd_ctl_file *file,
-				 struct snd_ctl_elem_info __user *_info, int replace)
+static int snd_ctl_elem_add_user(struct snd_ctl_file *ctl_file,
+				 void __user *arg, int replace)
 {
-	struct snd_ctl_elem_info info;
+	struct snd_ctl_elem_info *info;
 	int err;
 
-	if (copy_from_user(&info, _info, sizeof(info)))
-		return -EFAULT;
-	err = snd_ctl_elem_add(file, &info, replace);
-	if (err < 0)
-		return err;
-	if (copy_to_user(_info, &info, sizeof(info))) {
-		snd_ctl_remove_user_ctl(file, &info.id);
-		return -EFAULT;
+	info = memdup_user(arg, sizeof(*info));
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	err = snd_ctl_elem_add(ctl_file, info, replace);
+	if (err >= 0) {
+		if (copy_to_user(arg, info, sizeof(*info))) {
+			snd_ctl_remove_user_ctl(ctl_file, &info->id);
+			err = -EFAULT;
+		}
 	}
 
-	return 0;
+	kfree(info);
+	return err;
 }
 
 static int snd_ctl_elem_remove(struct snd_ctl_file *file,
-- 
2.14.1
