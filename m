From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: [PATCH] Fix pause function
Date: 03 Jun 2003 19:45:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xy90jnjhf.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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


This patch fixes the kernel side of snd_pcm_pause() to actually pause
instead of always returning -EBADFD.  The patch is against
alsa-driver-0.9.4, same as CVS HEAD for this file.

--- acore/pcm_native.c~	Tue Jun  3 13:48:09 2003
+++ acore/pcm_native.c	Tue Jun  3 19:27:06 2003
@@ -863,7 +863,7 @@
 
 static int snd_pcm_pause(snd_pcm_substream_t *substream, int push)
 {
-	return snd_pcm_action(&snd_pcm_action_pause, substream, 0);
+	return snd_pcm_action(&snd_pcm_action_pause, substream, push);
 }
 
 #ifdef CONFIG_PM


-- 
Måns Rullgård
mru@users.sf.net



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
