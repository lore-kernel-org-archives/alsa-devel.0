From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/7] ALSA: pcm: avoid mmap of control data if
	.update_appl_ptr is implemented
Date: Fri, 30 Sep 2016 18:13:26 +0530
Message-ID: <1475239410-16548-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BA685260083
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 14:50:13 +0200 (CEST)
In-Reply-To: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

In case of mmap, by default alsa-lib mmaps both control & status data.

If driver subscribes for .appl_ptr_update, driver needs to get
notification whenever appl ptr changes. So with control & status mmaped,
driver won't get appl ptr notifications.

In alsa-lib IOCTL_SYNC_PTR can be forced using  sync_ptr_ioctl flag in
conf But this makes driver behavior dependent on a flag in the conf.

This patch conditionally checks for .appl_ptr_update and returns error
when user land asks for mmaping control & status data, thus forcing user
to issue IOCTL_SYNC_PTR.

One drawback with this approach is, if .appl_ptr_update is subscribed by
driver, the user space looses flexibility to mmap the control & status
data.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/core/pcm_native.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c56d4ed..1965d83 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3535,10 +3535,22 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 	case SNDRV_PCM_MMAP_OFFSET_STATUS:
 		if (pcm_file->no_compat_mmap)
 			return -ENXIO;
+		/*
+		 * we want to force sync pointer,
+		 * if driver implements appl_ptr_update
+		 */
+		if (substream->ops->appl_ptr_update)
+			return -ENXIO;
 		return snd_pcm_mmap_status(substream, file, area);
 	case SNDRV_PCM_MMAP_OFFSET_CONTROL:
 		if (pcm_file->no_compat_mmap)
 			return -ENXIO;
+		/*
+		 * we want to force sync pointer,
+		 * if driver implements appl_ptr_update
+		 */
+		if (substream->ops->appl_ptr_update)
+			return -ENXIO;
 		return snd_pcm_mmap_control(substream, file, area);
 	default:
 		return snd_pcm_mmap_data(substream, file, area);
-- 
1.9.1
