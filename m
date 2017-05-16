From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/3] ALSA: pcm: conditionally avoid mmap of
	control data
Date: Tue, 16 May 2017 06:31:58 +0530
Message-ID: <1494896518-23399-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 428FA266E50
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 03:15:57 +0200 (CEST)
In-Reply-To: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In case of mmap, by default alsa-lib mmaps both control and status data.

If driver subscribes for application pointer update, driver needs to get
notification whenever appl ptr changes. With the above case driver won't
get appl ptr notifications.

This patch check on a hw info flag and returns error when user land asks
for mmaping control & status data, thus forcing user to issue
IOCTL_SYNC_PTR.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 include/uapi/sound/asound.h |  1 +
 sound/core/pcm_native.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index c697ff90450d..dea7d89b41ca 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -284,6 +284,7 @@ enum {
 #define SNDRV_PCM_INFO_HAS_LINK_ABSOLUTE_ATIME     0x02000000  /* report absolute hardware link audio time, not reset on startup */
 #define SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME    0x04000000  /* report estimated link audio time */
 #define SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME 0x08000000  /* report synchronized audio/system time */
+#define SNDRV_PCM_INFO_NO_STATUS_MMAP	0x10000000	/* status and control mmap not supported */
 
 #define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c14cdbd9ff86..2635a7d4d1fa 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3524,21 +3524,38 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 	struct snd_pcm_file * pcm_file;
 	struct snd_pcm_substream *substream;	
 	unsigned long offset;
+	unsigned int info;
 	
 	pcm_file = file->private_data;
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
+	info = substream->runtime->hw.info;
 
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	switch (offset) {
 	case SNDRV_PCM_MMAP_OFFSET_STATUS:
 		if (pcm_file->no_compat_mmap)
 			return -ENXIO;
+		/*
+		 * force fallback to ioctl if driver doesn't support status
+		 * and control mmap.
+		 */
+		if (info & SNDRV_PCM_INFO_NO_STATUS_MMAP)
+			return -ENXIO;
+
 		return snd_pcm_mmap_status(substream, file, area);
 	case SNDRV_PCM_MMAP_OFFSET_CONTROL:
 		if (pcm_file->no_compat_mmap)
 			return -ENXIO;
+
+		/*
+		 * force fallback to ioctl if driver doesn't support status
+		 * and control mmap.
+		 */
+		if (info & SNDRV_PCM_INFO_NO_STATUS_MMAP)
+			return -ENXIO;
+
 		return snd_pcm_mmap_control(substream, file, area);
 	default:
 		return snd_pcm_mmap_data(substream, file, area);
-- 
1.9.1
