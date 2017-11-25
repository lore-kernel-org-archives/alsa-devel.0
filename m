From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/24] ALSA: ctl: introduce local framework to
	handle compat ioctl requests
Date: Sat, 25 Nov 2017 18:19:43 +0900
Message-ID: <20171125092006.24408-2-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 40F59266F66
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:12 +0100 (CET)
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

Some architectures have a execution mode to execute programs for derived
architectures. Linux system supports the execution mode. For this purpose,
system call compatibility layer is available to manage ABI differences of
the architectures; e.g. adoption different data model (ILP32/LP64) and
size/alignment of machine types.

In ALSA control interface, there're some structures which have different
layout depending on the ABIs. To absorb the difference, ALSA control core
has an I/O compatibility layer. Tasks of this layer are summarized as:
1. convert structure layout from program ABI to native ABI
2. process I/O request with structure layout of native ABI
3. convert structure layout from native ABI to program ABI

Current implementation of this layer is not enough structured for the above
processing. This commit adds a consistent way to handle the above tasks.

Actual implementation of the tasks differs depending on the structures.
This commit adds a local framework for handlers tothe tasks. A handler
includes below members:
 - cmd: a command of ioctl(2) on program ABI. The 'size' field is used to
        distinguish compat I/O requests from native I/O requests, and
        allocate data buffer.
 - deserialize: for task 1.
 - func: for task 2.
 - serialize: for task 3.
 - orig_cmd: a command of ioctl(2) on native ABI. The 'size' field is used
             to allocate an alternative buffer.

The handlers are processed in a callback of
'struct file_operations.compat_ioctl'. In this callback, two buffers are
allocated/deallocated for safe conversion of layout between program/native
ABI.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 97 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 23 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index a848836a5de0..dec89717d8e3 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -443,11 +443,25 @@ enum {
 #endif /* CONFIG_X86_X32 */
 };
 
-static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
+static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
+				 unsigned long arg)
 {
+	static const struct {
+		unsigned int cmd;
+		int (*deserialize)(struct snd_ctl_file *ctl_file, void *dst,
+				   void *src);
+		int (*func)(struct snd_ctl_file *ctl_file, void *buf);
+		int (*serialize)(struct snd_ctl_file *ctl_file, void *dst,
+				 void *src);
+		unsigned int orig_cmd;
+	} handlers[] = {
+		{ 0, NULL, NULL, NULL, 0, },
+	};
 	struct snd_ctl_file *ctl;
-	struct snd_kctl_ioctl *p;
 	void __user *argp = compat_ptr(arg);
+	void *buf, *data;
+	unsigned int size;
+	int i;
 	int err;
 
 	ctl = file->private_data;
@@ -455,18 +469,6 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
 		return -ENXIO;
 
 	switch (cmd) {
-	case SNDRV_CTL_IOCTL_PVERSION:
-	case SNDRV_CTL_IOCTL_CARD_INFO:
-	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
-	case SNDRV_CTL_IOCTL_POWER:
-	case SNDRV_CTL_IOCTL_POWER_STATE:
-	case SNDRV_CTL_IOCTL_ELEM_LOCK:
-	case SNDRV_CTL_IOCTL_ELEM_UNLOCK:
-	case SNDRV_CTL_IOCTL_ELEM_REMOVE:
-	case SNDRV_CTL_IOCTL_TLV_READ:
-	case SNDRV_CTL_IOCTL_TLV_WRITE:
-	case SNDRV_CTL_IOCTL_TLV_COMMAND:
-		return snd_ctl_ioctl(file, cmd, (unsigned long)argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST32:
 		return snd_ctl_elem_list_compat(ctl->card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO32:
@@ -487,16 +489,65 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
 #endif /* CONFIG_X86_X32 */
 	}
 
-	down_read(&snd_ioctl_rwsem);
-	list_for_each_entry(p, &snd_control_compat_ioctls, list) {
-		if (p->fioctl) {
-			err = p->fioctl(ctl->card, ctl, cmd, arg);
-			if (err != -ENOIOCTLCMD) {
-				up_read(&snd_ioctl_rwsem);
-				return err;
+	for (i = 0; i < ARRAY_SIZE(handlers); ++i) {
+		if (handlers[i].cmd == cmd)
+			break;
+	}
+	if (i == ARRAY_SIZE(handlers)) {
+		struct snd_kctl_ioctl *p;
+
+		down_read(&snd_ioctl_rwsem);
+		list_for_each_entry(p, &snd_control_compat_ioctls, list) {
+			if (p->fioctl) {
+				err = p->fioctl(ctl->card, ctl, cmd, arg);
+				if (err != -ENOIOCTLCMD) {
+					up_read(&snd_ioctl_rwsem);
+					return err;
+				}
 			}
 		}
+		up_read(&snd_ioctl_rwsem);
+
+		return snd_ctl_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+	}
+
+	/* Allocate a buffer to convert layout of structure for native ABI. */
+	buf = kzalloc(_IOC_SIZE(handlers[i].orig_cmd), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Allocate an alternative buffer to copy from/to user space. */
+	size = _IOC_SIZE(handlers[i].cmd);
+	data = kzalloc(size, GFP_KERNEL);
+	if (!data) {
+		kfree(buf);
+		return -ENOMEM;
+	}
+
+	if (handlers[i].cmd & IOC_IN) {
+		if (copy_from_user(data, compat_ptr(arg), size)) {
+			err = -EFAULT;
+			goto end;
+		}
 	}
-	up_read(&snd_ioctl_rwsem);
-	return -ENOIOCTLCMD;
+
+	err = handlers[i].deserialize(ctl, buf, data);
+	if (err < 0)
+		goto end;
+
+	err = handlers[i].func(ctl, buf);
+	if (err < 0)
+		goto end;
+
+	err = handlers[i].serialize(ctl, data, buf);
+	if (err >= 0) {
+		if (handlers[i].cmd & IOC_OUT) {
+			if (copy_to_user(compat_ptr(arg), data, size))
+				err = -EFAULT;
+		}
+	}
+end:
+	kfree(data);
+	kfree(buf);
+	return err;
 }
-- 
2.14.1
