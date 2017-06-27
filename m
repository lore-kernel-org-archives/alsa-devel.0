From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 2/2] ALSA: pcm: Disable only control mmap
	for explicit appl_ptr sync
Date: Tue, 27 Jun 2017 12:29:44 +0200
Message-ID: <20170627102944.6836-3-tiwai@suse.de>
References: <20170627102944.6836-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 62ED1266D57
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 12:29:47 +0200 (CEST)
In-Reply-To: <20170627102944.6836-1-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Now that user-space (typically alsa-lib) can specify which protocol
version it supports, we can optimize the kernel code depending on the
reported protocol version.

In this patch, we change the previous hack for enforcing the appl_ptr
sync by disabling status/control mmap.  Instead of forcibly disabling
both mmaps, we disable only the control mmap when user-space declares
the supported protocol version new enough.  For older user-space,
still both PCM status and control mmaps are disabled when requested by
the driver due to the compatibility reason.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1c53d93e68f2..0d1834310531 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3388,12 +3388,23 @@ static bool pcm_status_mmap_allowed(struct snd_pcm_file *pcm_file)
 {
 	if (pcm_file->no_compat_mmap)
 		return false;
-	/* Disallow the status/control mmap when SYNC_APPLPTR flag is set;
+	/* See pcm_control_mmap_allowed() below.
+	 * Since older alsa-lib requires both status and control mmaps to be
+	 * coupled, we have to disable the status mmap for old alsa-lib, too.
+	 */
+	if (pcm_file->user_pversion < SNDRV_PROTOCOL_VERSION(2, 0, 14) &&
+	    (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR))
+		return false;
+	return true;
+}
+
+static bool pcm_control_mmap_allowed(struct snd_pcm_file *pcm_file)
+{
+	if (pcm_file->no_compat_mmap)
+		return false;
+	/* Disallow the control mmap when SYNC_APPLPTR flag is set;
 	 * it enforces the user-space to fall back to snd_pcm_sync_ptr(),
 	 * thus it effectively assures the manual update of appl_ptr.
-	 * In theory, it should be enough to disallow only PCM control mmap,
-	 * but since the current alsa-lib implementation requires both status
-	 * and control mmaps always paired, we have to disable both of them.
 	 */
 	if (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
 		return false;
@@ -3405,6 +3416,7 @@ static bool pcm_status_mmap_allowed(struct snd_pcm_file *pcm_file)
  * don't support mmap for status and control records.
  */
 #define pcm_status_mmap_allowed(pcm_file)	false
+#define pcm_control_mmap_allowed(pcm_file)	false
 
 static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file *file,
 			       struct vm_area_struct *area)
@@ -3593,7 +3605,7 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 			return -ENXIO;
 		return snd_pcm_mmap_status(substream, file, area);
 	case SNDRV_PCM_MMAP_OFFSET_CONTROL:
-		if (!pcm_status_mmap_allowed(pcm_file))
+		if (!pcm_control_mmap_allowed(pcm_file))
 			return -ENXIO;
 		return snd_pcm_mmap_control(substream, file, area);
 	default:
-- 
2.13.2
