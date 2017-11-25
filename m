From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/24] ALSA: ctl: move removal code to replace
	helper function
Date: Sat, 25 Nov 2017 18:19:59 +0900
Message-ID: <20171125092006.24408-18-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E5284266EDD
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

A previous commit adds a helper function for replacement processing. This
commit do actual separation from a helper function for addition.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c        | 34 +++++++++++++++++++++++-----------
 sound/core/control_compat.c |  5 ++++-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 9e23f84d284d..0aa1f22dcac2 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1256,7 +1256,7 @@ static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
 }
 
 static int snd_ctl_elem_add(struct snd_ctl_file *file,
-			    struct snd_ctl_elem_info *info, int replace)
+			    struct snd_ctl_elem_info *info)
 {
 	/* The capacity of struct snd_ctl_elem_value.value.*/
 	static const unsigned int value_sizes[] = {
@@ -1289,14 +1289,6 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	if (strnlen(info->id.name, sizeof(info->id.name)) >= sizeof(info->id.name))
 		return -EINVAL;
 
-	/* Delete a control to replace them if needed. */
-	if (replace) {
-		info->id.numid = 0;
-		err = snd_ctl_remove_user_ctl(file, &info->id);
-		if (err)
-			return err;
-	}
-
 	/*
 	 * The number of userspace controls are counted control by control,
 	 * not element by element.
@@ -1415,7 +1407,7 @@ static int snd_ctl_elem_add_user(struct snd_ctl_file *ctl_file,
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
-	err = snd_ctl_elem_add(ctl_file, info, 0);
+	err = snd_ctl_elem_add(ctl_file, info);
 	if (err >= 0) {
 		if (copy_to_user(arg, info, sizeof(*info))) {
 			snd_ctl_remove_user_ctl(ctl_file, &info->id);
@@ -1427,6 +1419,26 @@ static int snd_ctl_elem_add_user(struct snd_ctl_file *ctl_file,
 	return err;
 }
 
+static int snd_ctl_elem_replace(struct snd_ctl_file *ctl_file,
+				struct snd_ctl_elem_info *info)
+{
+	int err;
+
+	if (!*info->id.name)
+		return -EINVAL;
+	if (strnlen(info->id.name, sizeof(info->id.name)) >=
+							sizeof(info->id.name))
+		return -EINVAL;
+
+	/* Delete an element set to replace them. */
+	info->id.numid = 0;
+	err = snd_ctl_remove_user_ctl(ctl_file, &info->id);
+	if (err < 0)
+		return err;
+
+	return snd_ctl_elem_add(ctl_file, info);
+}
+
 static int snd_ctl_elem_replace_user(struct snd_ctl_file *ctl_file,
 				     void __user *arg)
 {
@@ -1437,7 +1449,7 @@ static int snd_ctl_elem_replace_user(struct snd_ctl_file *ctl_file,
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
-	err = snd_ctl_elem_add(ctl_file, info, 1);
+	err = snd_ctl_elem_replace(ctl_file, info);
 	if (err >= 0) {
 		if (copy_to_user(arg, info, sizeof(*info))) {
 			snd_ctl_remove_user_ctl(ctl_file, &info->id);
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index d6d1a2bf9542..1cfacea867b6 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -792,7 +792,10 @@ static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
 	default:
 		break;
 	}
-	err = snd_ctl_elem_add(file, data, replace);
+	if (!replace)
+		err = snd_ctl_elem_add(file, data);
+	else
+		err = snd_ctl_elem_replace(file, data);
  error:
 	kfree(data);
 	return err;
-- 
2.14.1
