From: Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [RFC] [ALSA][CONTROL] Restructured the code for read/write of  a
 single control
Date: Thu, 02 Feb 2017 08:55:50 +0530
Message-ID: <1486005950-27735-1-git-send-email-satendra.t@samsung.com>
References: <CGME20170202032617epcas1p13f71e6400d21aa5471fd671f31e6edd8@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, o-takashi@sakamocchi.jp, linux-kernel@vger.kernel.org, hemanshu.s@samsung.com, nishant.s4@samsung.com, ycheon.song@samsung.com, satendra singh thakur <satendra.t@samsung.com>
List-Id: alsa-devel@alsa-project.org

From: satendra singh thakur <satendra.t@samsung.com>

-Restructured/Combined two functions snd_ctl_elem_read_user and
 snd_ctl_elem_write_user into a single function snd_ctl_elem_rw_user
-These functions were having most of the code which was similar
 to each other
-Thus, there was redundant/duplicate code which was removed
 and a single function was formed/defined.-
-Removed functions snd_ctl_elem_read_user and snd_ctl_elem_write_user
 having redundant/duplicate code

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 sound/core/control.c |   55 ++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index fb096cb..6a8bc19 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -920,28 +920,6 @@ static int snd_ctl_elem_read(struct snd_card *card,
 	return result;
 }
 
-static int snd_ctl_elem_read_user(struct snd_card *card,
-				  struct snd_ctl_elem_value __user *_control)
-{
-	struct snd_ctl_elem_value *control;
-	int result;
-
-	control = memdup_user(_control, sizeof(*control));
-	if (IS_ERR(control))
-		return PTR_ERR(control);
-
-	snd_power_lock(card);
-	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result >= 0)
-		result = snd_ctl_elem_read(card, control);
-	snd_power_unlock(card);
-	if (result >= 0)
-		if (copy_to_user(_control, control, sizeof(*control)))
-			result = -EFAULT;
-	kfree(control);
-	return result;
-}
-
 static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 			      struct snd_ctl_elem_value *control)
 {
@@ -976,22 +954,37 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	return result;
 }
 
-static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
-				   struct snd_ctl_elem_value __user *_control)
+
+/**
+ * snd_ctl_elem_rw_user - Read/write value of an element
+ * @file: the card to which element belongs to
+ * @_control,: the card to which element belongs to
+ * @card: the card to which element belongs to
+ * @pucontrols: user-space pointer to struct snd_ctl_elem_values
+ *
+ * This function reads the value of controls with the given IDs
+ * of the same card
+ */
+
+static int snd_ctl_elem_rw_user(struct snd_ctl_file *file,
+				  struct snd_ctl_elem_value __user *_control,
+			bool write_flag)
 {
 	struct snd_ctl_elem_value *control;
-	struct snd_card *card;
 	int result;
-
+	struct snd_card *card;
 	control = memdup_user(_control, sizeof(*control));
 	if (IS_ERR(control))
 		return PTR_ERR(control);
-
 	card = file->card;
 	snd_power_lock(card);
 	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result >= 0)
-		result = snd_ctl_elem_write(card, file, control);
+	if (result >= 0) {
+		if (write_flag == true)
+			result = snd_ctl_elem_write(card, file, control);
+		else
+			result = snd_ctl_elem_read(card, control);
+	}
 	snd_power_unlock(card);
 	if (result >= 0)
 		if (copy_to_user(_control, control, sizeof(*control)))
@@ -1514,9 +1507,9 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
 		return snd_ctl_elem_info_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ:
-		return snd_ctl_elem_read_user(card, argp);
+		return snd_ctl_elem_rw_user(ctl, argp, false);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE:
-		return snd_ctl_elem_write_user(ctl, argp);
+		return snd_ctl_elem_rw_user(ctl, argp, true);
 	case SNDRV_CTL_IOCTL_ELEM_LOCK:
 		return snd_ctl_elem_lock(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_UNLOCK:
-- 
1.7.9.5
