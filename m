From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 3/3] ALSA: pcm: Limit the appl_ptr sync
	workaround only for old user-space
Date: Wed, 21 Jun 2017 17:31:14 +0200
Message-ID: <20170621153114.6207-4-tiwai@suse.de>
References: <20170621153114.6207-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 611B92668F0
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 17:31:17 +0200 (CEST)
In-Reply-To: <20170621153114.6207-1-tiwai@suse.de>
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
 sound/core/pcm_native.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1c53d93e68f2..88c939a86f36 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3394,8 +3394,12 @@ static bool pcm_status_mmap_allowed(struct snd_pcm_file *pcm_file)
 	 * In theory, it should be enough to disallow only PCM control mmap,
 	 * but since the current alsa-lib implementation requires both status
 	 * and control mmaps always paired, we have to disable both of them.
+	 *
+	 * If user_pversion is 2.0.14 or greater, it implies that user-space
+	 * supports the explicit appl_ptr sync, so we still allow the mmap.
 	 */
-	if (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
+	if (pcm_file->user_pversion < SNDRV_PROTOCOL_VERSION(2, 0, 14) &&
+	    (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR))
 		return false;
 	return true;
 }
-- 
2.13.1
