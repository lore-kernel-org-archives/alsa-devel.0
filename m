From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix card->power_lock congestion
Date: Mon, 20 Oct 2003 11:12:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310201109050.16209-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Fredrik Tolf <fredrik@dolda2000.com>
List-Id: alsa-devel@alsa-project.org

snd_pcm_playback_drain() holds card->power_lock until the substream
has been drained completely. This prevents any other stream on that
card from preparing during this time (which is very annoying if one is
playing several small files which fit entirely into one buffer on a
multi-stream card like emu10k1 or ymfpci).

The patch below unlocks power_lock around the schedule() call. As a
consequence, it is possible to suspend a draining stream, but this has
already been possible before for streams in non-blocking mode.

Additionally, I think that snd_pcm_do_suspend() should call the
trigger callback when the stream is in the draining state, as the
playback needs to be stopped just as in the running state; and
similarly for snd_pcm_do_resume(). But I'm not really sure that I know
what I'm doing here. :)


Regards,
Clemens


-- 

- don't hold power lock while draining
- call trigger callback when suspending/resuming a draining substream


Index: alsa-kernel/core/pcm_native.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_native.c,v
retrieving revision 1.83
diff -u -r1.83 pcm_native.c
--- alsa-kernel/core/pcm_native.c	10 Oct 2003 14:44:56 -0000	1.83
+++ alsa-kernel/core/pcm_native.c	20 Oct 2003 06:56:15 -0000
@@ -888,7 +888,8 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	if (runtime->trigger_master != substream)
 		return 0;
-	if (runtime->status->suspended_state != SNDRV_PCM_STATE_RUNNING)
+	if (runtime->status->suspended_state != SNDRV_PCM_STATE_RUNNING &&
+	    runtime->status->suspended_state != SNDRV_PCM_STATE_DRAINING)
 		return 0;
 	return substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_SUSPEND);
 }
@@ -962,7 +963,8 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	if (runtime->trigger_master != substream)
 		return 0;
-	if (runtime->status->suspended_state != SNDRV_PCM_STATE_RUNNING)
+	if (runtime->status->suspended_state != SNDRV_PCM_STATE_RUNNING &&
+	    runtime->status->suspended_state != SNDRV_PCM_STATE_DRAINING)
 		return 0;
 	return substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_RESUME);
 }
@@ -1243,7 +1245,9 @@
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		snd_pcm_stream_unlock_irq(substream);
+		snd_power_unlock(card);
 		tout = schedule_timeout(10 * HZ);
+		snd_power_lock(card);
 		snd_pcm_stream_lock_irq(substream);
 		if (tout == 0) {
 			state = runtime->status->state == SNDRV_PCM_STATE_SUSPENDED ? SUSPENDED : EXPIRED;




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
