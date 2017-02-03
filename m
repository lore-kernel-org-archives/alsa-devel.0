From: Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [RFC v2] [ALSA][CONTROL] 1. Added 2 ioctls for
 reading/writing values of multiple controls in one go (at once) 2.
 Restructured the code for read/write of a single control
Date: Fri, 03 Feb 2017 10:58:08 +0530
Message-ID: <1486099688-8057-1-git-send-email-satendra.t@samsung.com>
References: <CGME20170203052820epcas4p2287bdd4bb4de9e5e4c363bcd6872681e@epcas4p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 3933B266591
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 06:28:24 +0100 (CET)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0OKS02ZDP9V90B20@mailout3.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 03 Feb 2017 14:28:21 +0900 (KST)
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
Cc: tiwai@suse.com, linux-kernel@vger.kernel.org, nishant.s4@samsung.com, hemanshu.s@samsung.com, o-takashi@sakamocchi.jp, satendra singh thakur <satendra.t@samsung.com>
List-Id: alsa-devel@alsa-project.org

From: satendra singh thakur <satendra.t@samsung.com>

1.Added 2 ioctls in alsa driver's control interface
-Added an ioctl to read values of multiple elements at once
-Added an ioctl to write values of multiple elements at once
-In the absence of above ioctls user needs to call N ioctls to
 read/write value of N elements which requires N context switches
-Proposed ioctls will allow accessing N elements' values in a single
 context switch
-Above mentioned ioctl will be useful for alsa utils such as amixer
 which reads all controls of given sound card
2. Restructured/Combined two functions snd_ctl_elem_read_user and
snd_ctl_elem_write_user into a single function snd_ctl_elem_rw_user
-These functions were having most of the code which was similar
 to each other
-Thus, there was redundant/duplicate code which was removed
 and a single function was formed/defined.
-Removed functions snd_ctl_elem_read_user and snd_ctl_elem_write_user
 having redundant/duplicate code
3. This is version 2 of RFC, here we combine previous 2 patches
 submitted yesterday (02-Feb) with prefix [RFC] [ALSA][CONTROL]
-Fixed doxygen comments related warnings
-Fixed stack frame related warning

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 include/uapi/sound/asound.h |    8 +++
 sound/core/control.c        |  130 +++++++++++++++++++++++++++++++++----------
 2 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index be353a7..a0dcee7 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -948,6 +948,11 @@ struct snd_ctl_tlv {
 	unsigned int length;	/* in bytes aligned to 4 */
 	unsigned int tlv[0];	/* first TLV */
 };
+/*Struct to read/write multiple element values */
+struct snd_ctl_elem_values {
+	unsigned int num_vals;/* Number of values*/
+	struct snd_ctl_elem_value *pvals;/* Pointer to the array of values */
+};
 
 #define SNDRV_CTL_IOCTL_PVERSION	_IOR('U', 0x00, int)
 #define SNDRV_CTL_IOCTL_CARD_INFO	_IOR('U', 0x01, struct snd_ctl_card_info)
@@ -974,6 +979,9 @@ struct snd_ctl_tlv {
 #define SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE _IOW('U', 0x42, int)
 #define SNDRV_CTL_IOCTL_POWER		_IOWR('U', 0xd0, int)
 #define SNDRV_CTL_IOCTL_POWER_STATE	_IOR('U', 0xd1, int)
+/*Multipe controls' values read and write*/
+#define SNDRV_CTL_IOCTL_ELEMS_READ	_IOWR('U', 0xe0, struct snd_ctl_elem_values)
+#define SNDRV_CTL_IOCTL_ELEMS_WRITE	_IOWR('U', 0xe1, struct snd_ctl_elem_values)
 
 /*
  *  Read interface.
diff --git a/sound/core/control.c b/sound/core/control.c
index fb096cb..980046c 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -920,27 +920,6 @@ static int snd_ctl_elem_read(struct snd_card *card,
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
 
 static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 			      struct snd_ctl_elem_value *control)
@@ -976,22 +955,38 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	return result;
 }
 
-static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
-				   struct snd_ctl_elem_value __user *_control)
+/**
+ * snd_ctl_elem_rw_user - Read/write value of an element
+ * @file: pointer to control file object
+ * @_control: user pointer to struct snd_ctl_elem_value
+ * @write_flag: flag, true for write, false for read operation
+ *
+ * This function reads the value of controls with the given IDs
+ * of the same card
+ * Return: On success, it returns positive number returned by
+ * snd_ctl_elem_write/snd_ctl_elem_read
+ * On failure, it returns appropriate error
+ */
+
+static int snd_ctl_elem_rw_user(struct snd_ctl_file *file,
+				  struct snd_ctl_elem_value __user *_control,
+			bool write_flag)
 {
 	struct snd_ctl_elem_value *control;
 	struct snd_card *card;
 	int result;
-
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
@@ -1000,6 +995,79 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 	return result;
 }
 
+/**
+ * snd_ctl_elems_rw_user - Read/Write values of more than one element,
+ * one by one
+ * @file: pointer to control file object
+ * @pucontrols: user-space pointer to struct snd_ctl_elem_values
+ * @write_flag: this flag distinguises write or read type request
+ *
+ * This function reads/writes the value of controls with the given IDs
+ * of the same card
+ * Return: On full/partial success, It returns number of successful
+ * controls read/written.
+ * On failure, it returns appropriate error
+ */
+static int snd_ctl_elems_rw_user(struct snd_ctl_file *file,
+				struct snd_ctl_elem_values __user *pucontrols,
+				bool write_flag)
+{
+	struct snd_ctl_elem_values controls;
+	struct snd_ctl_elem_value *pcontrol;
+	struct snd_ctl_elem_value __user *puvals;
+	struct snd_card *card;
+	int result;
+	int vals;
+	int controls_count = 0;
+
+	if (copy_from_user(&controls, pucontrols, sizeof(controls)))
+		return -EFAULT;
+	card = file->card;
+	if (!controls.num_vals || controls.num_vals > card->controls_count)
+		return -EINVAL;
+	/*assign user-space pointer**/
+	puvals = (struct snd_ctl_elem_value __user *) controls.pvals;
+	/**allocate memory to pcontrol*/
+	pcontrol = kmalloc(sizeof(*pcontrol), GFP_KERNEL);
+	if (!pcontrol)
+		return -ENOMEM;
+	for (vals = 0; vals < controls.num_vals; vals++) {
+		if (copy_from_user(pcontrol, puvals + vals, sizeof(*pcontrol)))
+			goto exit_err;
+		snd_power_lock(card);
+		result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
+		if (result >= 0) {
+			if (write_flag == true)
+				result = snd_ctl_elem_write(card, file,
+						pcontrol);
+			else
+				result = snd_ctl_elem_read(card,  pcontrol);
+		}
+		snd_power_unlock(card);
+		if (result < 0) {
+			/**If control failed to set/get
+			 * inform user by sending back -1 in reserved field
+			 * so that one can try again for failed elements
+			 */
+			pcontrol->reserved[0] = (unsigned char) -1;
+			pr_err("ALSA: control: snd_ctl_elem_write/read failed\
+			for control name = %s\n", pcontrol->id.name);
+		} else {
+			controls_count++;
+		}
+		if (copy_to_user(puvals + vals, pcontrol, sizeof(*pcontrol)))
+			goto exit_err;
+	}
+	pr_debug("ALSA: control: Num values successfully read/written %u\n",\
+	controls_count);
+	kfree(pcontrol);
+	/**Return successful control count to user**/
+	return controls_count;
+exit_err:
+	kfree(pcontrol);
+	return -EFAULT;
+}
+
 static int snd_ctl_elem_lock(struct snd_ctl_file *file,
 			     struct snd_ctl_elem_id __user *_id)
 {
@@ -1514,9 +1582,13 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
 		return snd_ctl_elem_info_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ:
-		return snd_ctl_elem_read_user(card, argp);
+		return snd_ctl_elem_rw_user(ctl, argp, false);
+	case SNDRV_CTL_IOCTL_ELEMS_READ:
+		return snd_ctl_elems_rw_user(ctl, argp, false);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE:
-		return snd_ctl_elem_write_user(ctl, argp);
+		return snd_ctl_elem_rw_user(ctl, argp, true);
+	case SNDRV_CTL_IOCTL_ELEMS_WRITE:
+		return snd_ctl_elems_rw_user(ctl, argp, true);
 	case SNDRV_CTL_IOCTL_ELEM_LOCK:
 		return snd_ctl_elem_lock(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_UNLOCK:
-- 
1.7.9.5
