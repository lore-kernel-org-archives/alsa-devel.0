From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]alsa-driver-0.9.6/acore/hwdep.c
Date: Thu, 4 Sep 2003 18:42:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309041842.31333.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying the hwdep interface with poll().
looking for reasons why removal of USB-device caused bad MAGIC in hwdep.c,
I found this solution:

<PATCH>
--- alsa-driver-0.9.6/acore/hwdep.c     2003-07-30 01:01:23.000000000 +0200
+++ alsa-driver-0.9.6-patched/acore/hwdep.c     2003-09-04 17:45:59.000000000 
+0200
@@ -133,9 +133,14 @@
        set_current_state(TASK_RUNNING);
        remove_wait_queue(&hw->open_wait, &wait);
        if (err >= 0) {
+               err = snd_card_file_add(hw->card, file);
+               if (err < 0)
+                       return -ENODEV;
+
                file->private_data = hw;
                hw->used++;
        }
+
        up(&hw->open_mutex);
        return err;
 }
@@ -151,6 +156,7 @@
        }
        if (hw->used > 0)
                hw->used--;
+       snd_card_file_remove(hw->card, file);
        up(&hw->open_mutex);
        return -ENXIO;
 }
</PATCH>

Also in Web-CVS this part of the code seams not to have the snd_card_file* 
calls.
"It works for me" here. If it is correct, please apply!

regards,
Karsten



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
