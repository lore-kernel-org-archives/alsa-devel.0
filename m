From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] ALSA: add dummy function to support shared
	mmap in nommu Blackfin arch (v2)
Date: Tue,  2 Sep 2008 17:58:42 +0800
Message-ID: <1220349522-17995-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 208021037FB
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 11:58:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

v1-v2:
 - only adding this dummy function in nommu arch

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/core/pcm_native.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c49b9d9..1e88cde 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3391,6 +3391,14 @@ out:
 }
 #endif /* CONFIG_SND_SUPPORT_OLD_API */
 
+#ifndef CONFIG_MMU
+unsigned long dummy_get_unmapped_area(struct file *file, unsigned long addr,
+				      unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	return 0;
+}
+#endif
+
 /*
  *  Register section
  */
@@ -3407,6 +3415,9 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
 		.fasync =		snd_pcm_fasync,
+#ifndef CONFIG_MMU
+		.get_unmapped_area =	dummy_get_unmapped_area,
+#endif
 	},
 	{
 		.owner =		THIS_MODULE,
@@ -3419,5 +3430,8 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
 		.fasync =		snd_pcm_fasync,
+#ifndef CONFIG_MMU
+		.get_unmapped_area =	dummy_get_unmapped_area,
+#endif
 	}
 };
-- 
1.5.6
