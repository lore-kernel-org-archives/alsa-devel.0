From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Subject: [patch] pcm-record (was cs46xx record (Thinkpad A22) => deadlock)
Date: Tue, 29 Oct 2002 15:07:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DBE962D.80007@gmx.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060607080902030601030504"
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060607080902030601030504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I dug a little around in the code. The infinitive loop was caused by 
being stuck in DRAINING mode. snd_pcm_lib_read1() returns -EPIPE in this 
case (pcm_lib.c: 2146). Then we return to snd_pcm_oss_read3() which 
continues to call this function until jdoomsday (= SysRq+b). I changed 
the code to call snd_pcm_update_hw_ptr() before that. The patch is 
attached. It *seems* to fix it. You want to have a _real_ close look at 
that if you want to apply the patch, as it is just a shot in the dark. 
At least I know now that the problem is (I figured it out by inserting 
printk).

greetings,
Wilfried

--------------060607080902030601030504
Content-Type: text/plain;
 name="alsa-driver-0.9.0.rc5+loopfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver-0.9.0.rc5+loopfix.diff"

--- pcm_lib.c.bak	Tue Oct 29 13:40:50 2002
+++ pcm_lib.c	Tue Oct 29 14:44:42 2002
@@ -2138,7 +2138,7 @@
 		snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
 		snd_pcm_uframes_t avail;
 		snd_pcm_uframes_t cont;
-		if (runtime->sleep_min == 0 && runtime->status->state == SNDRV_PCM_STATE_RUNNING)
+		if (runtime->sleep_min == 0 && ( runtime->status->state == SNDRV_PCM_STATE_RUNNING || runtime->status->state == SNDRV_PCM_STATE_DRAINING))
 			snd_pcm_update_hw_ptr(substream);
 		avail = snd_pcm_capture_avail(runtime);
 		if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {

--------------060607080902030601030504--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
