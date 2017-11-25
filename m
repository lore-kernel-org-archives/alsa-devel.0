From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/24] ALSA: ctl: add replace helper function
	to allocate own buffer
Date: Sat, 25 Nov 2017 18:19:58 +0900
Message-ID: <20171125092006.24408-17-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id CAD2E26698E
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:17 +0100 (CET)
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

In current implementation, an execution path of ELEM_REPLACE request
joins in an execution path of ELEM_ADD in the last. An advance preparation
of the replacement can be split from processing of the addition. This
separation might be a good granularity of helper functions.

For a preparation to it, this commit adds an unique helper function for
the replacement. In this time, the execution path still joins in the one
of the addition.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index a321576a6308..9e23f84d284d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1406,7 +1406,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 }
 
 static int snd_ctl_elem_add_user(struct snd_ctl_file *ctl_file,
-				 void __user *arg, int replace)
+				 void __user *arg)
 {
 	struct snd_ctl_elem_info *info;
 	int err;
@@ -1415,7 +1415,29 @@ static int snd_ctl_elem_add_user(struct snd_ctl_file *ctl_file,
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
-	err = snd_ctl_elem_add(ctl_file, info, replace);
+	err = snd_ctl_elem_add(ctl_file, info, 0);
+	if (err >= 0) {
+		if (copy_to_user(arg, info, sizeof(*info))) {
+			snd_ctl_remove_user_ctl(ctl_file, &info->id);
+			err = -EFAULT;
+		}
+	}
+
+	kfree(info);
+	return err;
+}
+
+static int snd_ctl_elem_replace_user(struct snd_ctl_file *ctl_file,
+				     void __user *arg)
+{
+	struct snd_ctl_elem_info *info;
+	int err;
+
+	info = memdup_user(arg, sizeof(*info));
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	err = snd_ctl_elem_add(ctl_file, info, 1);
 	if (err >= 0) {
 		if (copy_to_user(arg, info, sizeof(*info))) {
 			snd_ctl_remove_user_ctl(ctl_file, &info->id);
@@ -1592,9 +1614,9 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_ELEM_UNLOCK:
 		return snd_ctl_elem_unlock(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_ADD:
-		return snd_ctl_elem_add_user(ctl, argp, 0);
+		return snd_ctl_elem_add_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_REPLACE:
-		return snd_ctl_elem_add_user(ctl, argp, 1);
+		return snd_ctl_elem_replace_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_REMOVE:
 		return snd_ctl_elem_remove(ctl, argp);
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
-- 
2.14.1
