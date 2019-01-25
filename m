From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Fix tight loop of OSS capture stream
Date: Fri, 25 Jan 2019 17:29:00 +0100
Message-ID: <20190125162900.4501-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A871A2673DD
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 17:29:03 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 27DC5ACBD
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 16:29:03 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

When the trigger=off is passed for a PCM OSS stream, it sets the
start_threshold of the substream to the boundary.  This can be
problematic for a capture stream, unfortunately, like the following,
as detected by syzkaller:
- In __snd_pcm_lib_xfer() that is invoked from snd_pcm_oss_read()
  loop, we have a check whether the stream was already started or the
  stream can be auto-started.
- With trigger=0, we explicitly disable the auto-start, and the
  function returns 0 at this check.
- The loop continues tightly, which may lead to an RCU stall.

This patch fixes the bug by simply allowing the wait for non-started
stream in the case of OSS capture.  For native usages, it's supposed
to be done by the caller side (which is user-space), hence it returns
zero like before.

(In theory, this could wait there, but I'd like to stay in a safer
 side for not breaking the existing stuff.)

Reported-by: syzbot+fbe0496f92a0ce7b786c@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 40013b26f671..6c99fa8ac5fa 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2112,6 +2112,13 @@ int pcm_lib_apply_appl_ptr(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+/* allow waiting for a capture stream that hasn't been started */
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
+#define wait_capture_start(substream)	((substream)->oss.oss)
+#else
+#define wait_capture_start(substream)	false
+#endif
+
 /* the common loop for read/write data */
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *data, bool interleaved,
@@ -2182,7 +2189,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 			err = snd_pcm_start(substream);
 			if (err < 0)
 				goto _end_unlock;
-		} else {
+		} else if (!wait_capture_start(substream)) {
 			/* nothing to do */
 			err = 0;
 			goto _end_unlock;
-- 
2.16.4
