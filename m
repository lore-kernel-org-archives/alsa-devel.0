From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: pcm: Add the explicit appl_ptr sync
	support
Date: Tue, 20 Jun 2017 17:33:50 +0200
Message-ID: <20170620153352.27775-2-tiwai@suse.de>
References: <20170620153352.27775-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 180F8267332
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

Currently x86 platforms use the PCM status/control mmaps for
transferring the PCM status and appl_ptr between kernel and
user-spaces.  The mmap is a most efficient way of communication, but
it has a drawback per its nature, namely, it can't notify the change
explicitly to kernel.

The lack of appl_ptr update notification is a problem on a few
existing drivers, but it's mostly a small issue and negligible.
However, a new type of driver that uses DSP for a deep buffer
management requires the exact position of appl_ptr for calculating the
buffer prefetch size, and the asynchronous appl_ptr update between
kernel and user-spaces becomes a significant problem for it.

How can we enforce user-space to report the appl_ptr update?  The way
is relatively simple.  Just by disabling the PCM control mmap, the
user-space is supposed to fall back to the mode using SYNC_PTR ioctl,
and the kernel gets control over that.  This fallback mode is used in
all non-x86 platforms as default, and also in the 32bit compatible
model on all platforms including x86.  It's been implemented already
over a decade, so we can say it's fairly safe and stably working.

With the help of the knowledge above, this patch introduces a new PCM
info flag SNDRV_PCM_INFO_SYNC_APPLPTR for achieving the appl_ptr sync
from user-space.  When a driver sets this flag at open, the PCM status
/ control mmap is disabled, which effectively switches to SYNC_PTR
mode in user-space side.

In this version, both PCM status and control mmaps are disabled
although only the latter, control mmap, is the target.  It's because
the current alsa-lib implementation supposes that both status and
control mmaps are always coupled, thus it handles a fatal error when
only one of them fails.

Of course, the disablement of the status/control mmaps may bring a
slight performance overhead.  Thus, as of now, this should be used
only for the dedicated devices that deserves.

Note that the disablement of mmap is a sort of workaround.  In the
later patch, we'll introduce the way to identify the protocol version
alsa-lib supports, and keep mmap working while the sync_ptr is
performed together.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asound.h |  1 +
 sound/core/pcm_native.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index fd41697cb4d3..7eee52eb7462 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -268,6 +268,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_MMAP_VALID	0x00000002	/* period data are valid during transfer */
 #define SNDRV_PCM_INFO_DOUBLE		0x00000004	/* Double buffering needed for PCM start/stop */
 #define SNDRV_PCM_INFO_BATCH		0x00000010	/* double buffering */
+#define SNDRV_PCM_INFO_SYNC_APPLPTR	0x00000020	/* need the explicit sync of appl_ptr update */
 #define SNDRV_PCM_INFO_INTERLEAVED	0x00000100	/* channels are interleaved */
 #define SNDRV_PCM_INFO_NONINTERLEAVED	0x00000200	/* channels are not interleaved */
 #define SNDRV_PCM_INFO_COMPLEX		0x00000400	/* complex frame organization (mmap only) */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index d35c6614fdab..ef2ce64dcdb3 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3330,6 +3330,16 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 			       struct vm_area_struct *area)
 {
 	long size;
+
+	/* Disallow the status/control mmap when SYNC_APPLPTR flag is set;
+	 * it enforces the user-space to fall back to snd_pcm_sync_ptr(),
+	 * thus it effectively assures the manual update of appl_ptr.
+	 * In theory, it should be enough to disallow only PCM control mmap,
+	 * but since the current alsa-lib implementation requires both status
+	 * and control mmaps always paired, we have to disable both of them.
+	 */
+	if (substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
+		return -ENXIO;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3366,6 +3376,10 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 				struct vm_area_struct *area)
 {
 	long size;
+
+	/* see the comment in snd_pcm_mmap_status() */
+	if (substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
+		return -ENXIO;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
-- 
2.13.1
