From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: [PATCHES]: ALSA CVS PCM does not compile
Date: Fri, 25 Apr 2003 20:58:28 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030425195828.85902.qmail@web40607.mail.yahoo.com>
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

Hi,

The ALSA CVS hasn't compiled for me for a few days.
These patches fix it (compile only - untested). They
won't apply cleanly but they're only one-liners.

Cheers,
Chris

$ cvsalsa diff alsa-kernel/core/pcm.c 
Index: alsa-kernel/core/pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm.c,v
retrieving revision 1.27
diff -u -r1.27 pcm.c
--- alsa-kernel/core/pcm.c      24 Apr 2003 17:59:58
-0000      1.27
+++ alsa-kernel/core/pcm.c      25 Apr 2003 19:52:42
-0000
@@ -319,8 +319,8 @@
        }
        snd_pcm_stream_lock_irq(substream);
        if (runtime->status->state ==
SNDRV_PCM_STATE_OPEN) {
+               snd_pcm_stream_unlock_irq(substream);
                snd_iprintf(buffer, "no setup\n");
-               spin_unlock_irq(&runtime->lock);
                return;
        }
        snd_iprintf(buffer, "access: %s\n",
snd_pcm_access_name(runtime->access));


$ cvsalsa diff alsa-kernel/core/pcm_native.c 
Index: alsa-kernel/core/pcm_native.c
===================================================================
RCS file:
/cvsroot/alsa/alsa-kernel/core/pcm_native.c,v
retrieving revision 1.54
diff -u -r1.54 pcm_native.c
--- alsa-kernel/core/pcm_native.c       24 Apr 2003
17:59:59 -0000      1.54
+++ alsa-kernel/core/pcm_native.c       25 Apr 2003
19:53:15 -0000
@@ -808,7 +808,7 @@
                        if (substream->runtime ==
NULL)
                                continue;
                       
snd_pcm_stream_lock(substream);
-                       if (runtime->status->state ==
SNDRV_PCM_STATE_SUSPENDED) {
+                       if
(substream->runtime->status->state ==
SNDRV_PCM_STATE_SUSPENDED) {
                            
snd_pcm_stream_unlock(substream);
                                continue;
                        }




__________________________________________________
Yahoo! Plus
For a better Internet experience
http://www.yahoo.co.uk/btoffer


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
