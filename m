From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 02/25] ALSA: compress: add support for 32bit calls in a 64bit kernel
Date: Fri, 22 Mar 2019 16:43:53 +0100
Message-ID: <20190322154425.3852517-3-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Ravindra Lokhande <rlokhande@nvidia.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Joe Perches <joe@perches.com>, Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Ravindra Lokhande <rlokhande@nvidia.com>

Compress offload does not support ioctl calls from a 32bit userspace
in a 64 bit kernel. This patch adds support for ioctls from a 32bit
userspace in a 64bit kernel

Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit c10368897e104c008c610915a218f0fe5fa4ec96)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/compress_offload.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 6163bf3e8177..33d40d6fa3f1 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -38,6 +38,7 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
+#include <linux/compat.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/compress_params.h>
@@ -858,6 +859,15 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
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
@@ -865,6 +875,9 @@ static const struct file_operations snd_compr_file_ops = {
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
2.20.0
