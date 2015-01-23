From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/16] ALSA: line6: Fix the error recovery in
	line6_pcm_acquire()
Date: Fri, 23 Jan 2015 18:13:14 +0100
Message-ID: <1422033203-23254-8-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 933B42654F6
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:41 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

line6_pcm_acquire() tries to restore the newly obtained resources at
the error path.  But some flags aren't recorded and released properly
when the corresponding buffer is already present.  These bits have to
be cleared in the error recovery, too.

Also, "flags_final" can be initialized to zero since we pass only the
subset of "channels" bits.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index f740b4490d75..9a2a15f4c4e4 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -106,7 +106,7 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 		flags_new = flags_old | channels;
 	} while (cmpxchg(&line6pcm->flags, flags_old, flags_new) != flags_old);
 
-	flags_final = flags_old;
+	flags_final = 0;
 
 	line6pcm->prev_fbuf = NULL;
 
@@ -120,9 +120,9 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 				err = -ENOMEM;
 				goto pcm_acquire_error;
 			}
-
-			flags_final |= channels & LINE6_BITS_CAPTURE_BUFFER;
 		}
+
+		flags_final |= channels & LINE6_BITS_CAPTURE_BUFFER;
 	}
 
 	if (test_flags(flags_old, flags_new, LINE6_BITS_CAPTURE_STREAM)) {
@@ -157,9 +157,9 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 				err = -ENOMEM;
 				goto pcm_acquire_error;
 			}
-
-			flags_final |= channels & LINE6_BITS_PLAYBACK_BUFFER;
 		}
+
+		flags_final |= channels & LINE6_BITS_PLAYBACK_BUFFER;
 	}
 
 	if (test_flags(flags_old, flags_new, LINE6_BITS_PLAYBACK_STREAM)) {
@@ -187,7 +187,7 @@ pcm_acquire_error:
 	   If not all requested resources/streams could be obtained, release
 	   those which were successfully obtained (if any).
 	*/
-	line6_pcm_release(line6pcm, flags_final & channels);
+	line6_pcm_release(line6pcm, flags_final);
 	return err;
 }
 EXPORT_SYMBOL_GPL(line6_pcm_acquire);
-- 
2.2.2
