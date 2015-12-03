From: Ravindra Lokhande <rlokhande@nvidia.com>
Subject: [PATCH] ALSA: compress: add support for 32bit calls in
	a 64bit kernel
Date: Thu, 3 Dec 2015 11:02:09 +0530
Message-ID: <1449120729-9044-1-git-send-email-rlokhande@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 96AA42652CE
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 06:33:42 +0100 (CET)
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
 sound/core/compress_offload.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index b123c42..98f6b47 100644
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
+	return snd_compr_ioctl(file, cmd, arg);
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
