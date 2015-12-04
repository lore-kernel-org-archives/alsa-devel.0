From: Ravindra Lokhande <rlokhande@nvidia.com>
Subject: [PATCH v2] ALSA: compress: add support for 32bit calls
	in a 64bit kernel
Date: Fri, 4 Dec 2015 19:02:33 +0530
Message-ID: <1449235953-14737-1-git-send-email-rlokhande@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2668B2614A9
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 14:32:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Ravindra Lokhande <rlokhande@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Compress offload does not support ioctl calls from a 32bit userspace
in a 64 bit kernel. This patch adds support for ioctls from a 32bit
userspace in a 64bit kernel

Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
---

v1 -> v2: use compat_ptr to convert 32 bit address to 64 bit pointer

 sound/core/compress_offload.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index b123c42..4c156a7 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -847,6 +847,15 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	return retval;
 }
 
+/* support of 32bit userspace on 64bit platforms */
+#ifdef CONFIG_COMPAT
+static long snd_compr_ioctl_compat(struct file *file, unsigned int cmd,
+						unsigned long arg)
+{
+	return snd_compr_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static const struct file_operations snd_compr_file_ops = {
 		.owner =	THIS_MODULE,
 		.open =		snd_compr_open,
@@ -854,6 +863,9 @@ static const struct file_operations snd_compr_file_ops = {
 		.write =	snd_compr_write,
 		.read =		snd_compr_read,
 		.unlocked_ioctl = snd_compr_ioctl,
+#ifdef CONFIG_COMPAT
+		.compat_ioctl = snd_compr_ioctl_compat,
+#endif
 		.mmap =		snd_compr_mmap,
 		.poll =		snd_compr_poll,
 };
-- 
2.1.4
