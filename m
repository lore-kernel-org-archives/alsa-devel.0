From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 4/4] ALSA: add dummy function to support shared
	mmap in nommu Blackfin arch
Date: Wed, 27 Aug 2008 17:39:28 +0800
Message-ID: <1219829968-6431-5-git-send-email-cooloney@kernel.org>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C1DD103859
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Aug 2008 11:39:21 +0200 (CEST)
In-Reply-To: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, liam.girdwood@wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/core/pcm_native.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c49b9d9..cb202a1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3391,6 +3391,12 @@ out:
 }
 #endif /* CONFIG_SND_SUPPORT_OLD_API */
 
+unsigned long dummy_get_unmapped_area(struct file *file, unsigned long addr,
+				      unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	return 0;
+}
+
 /*
  *  Register section
  */
@@ -3407,6 +3413,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
 		.fasync =		snd_pcm_fasync,
+		.get_unmapped_area =	dummy_get_unmapped_area,
 	},
 	{
 		.owner =		THIS_MODULE,
@@ -3419,5 +3426,6 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
 		.fasync =		snd_pcm_fasync,
+		.get_unmapped_area =	dummy_get_unmapped_area,
 	}
 };
-- 
1.5.6
