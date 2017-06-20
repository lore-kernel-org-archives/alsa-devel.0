From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: pcm: Limit the appl_ptr sync
	workaround only for old user-space
Date: Tue, 20 Jun 2017 17:33:52 +0200
Message-ID: <20170620153352.27775-4-tiwai@suse.de>
References: <20170620153352.27775-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 16EC526732F
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 17:33:56 +0200 (CEST)
In-Reply-To: <20170620153352.27775-1-tiwai@suse.de>
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
sync by disabling status/control mmap.  Instead of forcibly disabling,
we disable the status/control mmap selectively only when the
user-space does *not* understand the protocol.  That is, when the
user-space reports it supporting the new protocol version including
the sync appl_ptr feature, we allow the mmap like the normal case.
Then user-space is supposed to do the sync in addition to the mmap.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index df3e0303409f..3f91d5c4ed76 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3336,6 +3336,7 @@ static const struct vm_operations_struct snd_pcm_vm_ops_status =
 static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file *file,
 			       struct vm_area_struct *area)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	long size;
 
 	/* Disallow the status/control mmap when SYNC_APPLPTR flag is set;
@@ -3344,8 +3345,12 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 	 * In theory, it should be enough to disallow only PCM control mmap,
 	 * but since the current alsa-lib implementation requires both status
 	 * and control mmaps always paired, we have to disable both of them.
+	 *
+	 * If user_pversion is 2.0.14 or greater, it implies that user-space
+	 * supports the explicit appl_ptr sync, so we still allow the mmap.
 	 */
-	if (substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
+	if (runtime->user_pversion < SNDRV_PROTOCOL_VERSION(2, 0, 14) &&
+	    (runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR))
 		return -ENXIO;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
@@ -3382,10 +3387,12 @@ static const struct vm_operations_struct snd_pcm_vm_ops_control =
 static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file *file,
 				struct vm_area_struct *area)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	long size;
 
 	/* see the comment in snd_pcm_mmap_status() */
-	if (substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
+	if (runtime->user_pversion < SNDRV_PROTOCOL_VERSION(2, 0, 14) &&
+	    (runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR))
 		return -ENXIO;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
-- 
2.13.1
