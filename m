From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2/3] ALSA: pcm: merge pcm_..._mmap_allowed fcns
	to the snd_pcm_mmap_... fcns
Date: Mon,  4 Feb 2019 12:28:33 +0100
Message-ID: <20190204112834.27083-3-perex@perex.cz>
References: <20190204112834.27083-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id E8574267557
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 12:29:03 +0100 (CET)
In-Reply-To: <20190204112834.27083-1-perex@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Phil Burk <philburk@google.com>, Zach Riggle <riggle@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

There is no benefit to have this code separate. The result code is even
smaller and simplier for the review. No functional change.

diffstat: 23 insertions(+), 34 deletions(-)

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/pcm_native.c | 56 +++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index bb14658e4482..ffc6b32973ba 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3295,6 +3295,16 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 			       struct vm_area_struct *area)
 {
 	long size;
+	struct snd_pcm_file *pcm_file = file->private_data;
+	if (pcm_file->no_compat_mmap)
+		return -ENXIO;
+	/* See snd_pcm_mmap_control() below.
+	 * Since older alsa-lib requires both status and control mmaps to be
+	 * coupled, we have to disable the status mmap for old alsa-lib, too.
+	 */
+	if (pcm_file->user_pversion < SNDRV_PROTOCOL_VERSION(2, 0, 14) &&
+	    (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR))
+		return -ENXIO;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3331,6 +3341,15 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 				struct vm_area_struct *area)
 {
 	long size;
+	struct snd_pcm_file *pcm_file = file->private_data;
+	if (pcm_file->no_compat_mmap)
+		return -ENXIO;
+	/* Disallow the control mmap when SYNC_APPLPTR flag is set;
+	 * it enforces the user-space to fall back to snd_pcm_sync_ptr(),
+	 * thus it effectively assures the manual update of appl_ptr.
+	 */
+	if (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
+		return -ENXIO;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3342,50 +3361,23 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 	return 0;
 }
 
-static bool pcm_status_mmap_allowed(struct snd_pcm_file *pcm_file)
-{
-	if (pcm_file->no_compat_mmap)
-		return false;
-	/* See pcm_control_mmap_allowed() below.
-	 * Since older alsa-lib requires both status and control mmaps to be
-	 * coupled, we have to disable the status mmap for old alsa-lib, too.
-	 */
-	if (pcm_file->user_pversion < SNDRV_PROTOCOL_VERSION(2, 0, 14) &&
-	    (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR))
-		return false;
-	return true;
-}
-
-static bool pcm_control_mmap_allowed(struct snd_pcm_file *pcm_file)
-{
-	if (pcm_file->no_compat_mmap)
-		return false;
-	/* Disallow the control mmap when SYNC_APPLPTR flag is set;
-	 * it enforces the user-space to fall back to snd_pcm_sync_ptr(),
-	 * thus it effectively assures the manual update of appl_ptr.
-	 */
-	if (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
-		return false;
-	return true;
-}
-
 #else /* ! coherent mmap */
+
 /*
  * don't support mmap for status and control records.
  */
-#define pcm_status_mmap_allowed(pcm_file)	false
-#define pcm_control_mmap_allowed(pcm_file)	false
-
 static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file *file,
 			       struct vm_area_struct *area)
 {
 	return -ENXIO;
 }
+
 static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file *file,
 				struct vm_area_struct *area)
 {
 	return -ENXIO;
 }
+
 #endif /* coherent mmap */
 
 static inline struct page *
@@ -3559,12 +3551,8 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	switch (offset) {
 	case SNDRV_PCM_MMAP_OFFSET_STATUS:
-		if (!pcm_status_mmap_allowed(pcm_file))
-			return -ENXIO;
 		return snd_pcm_mmap_status(substream, file, area);
 	case SNDRV_PCM_MMAP_OFFSET_CONTROL:
-		if (!pcm_control_mmap_allowed(pcm_file))
-			return -ENXIO;
 		return snd_pcm_mmap_control(substream, file, area);
 	default:
 		return snd_pcm_mmap_data(substream, file, area);
-- 
2.13.6
