From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: alsa timer slippage
Date: Mon, 15 Dec 2003 09:53:08 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312150953.08559.cannam@all-day-breakfast.com>
References: <E1AVXB7-00025m-JG@sc8-sf-list2.sourceforge.net> <200312150230.33546.plcl@telefonica.net> <200312150916.03357.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312150916.03357.cannam@all-day-breakfast.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 15 Dec 2003 9:16 am, Chris Cannam wrote:
> This seems to suggest that the default system-based timer is doing
> something a bit naive, like assuming it was called back on time
> without actually checking.

Hmm yes, even this crappy little patch to alsa-kernel/core/timer.c 
(gross adjustment to each system timer tick according to how late the 
previous one was) improves things for me.  With this the timer still 
slips, but never quite enough to be audible in a MIDI-only stream.  
The PCM clock is still much much better though.

@@ -940,9 +940,16 @@
        return 1000000000L / HZ;
 }

+static long lateness;
+
 static void snd_timer_s_function(unsigned long data)
 {
+       struct timer_list *tlist;
        snd_timer_t *timer = (snd_timer_t *)data;
+
+       tlist = (struct timer_list *) timer->private_data;
+       lateness = (long)jiffies - (long)tlist->expires;
+
        snd_timer_interrupt(timer, timer->sticks);
 }

@@ -951,7 +958,7 @@
        struct timer_list *tlist;

        tlist = (struct timer_list *) timer->private_data;
-       tlist->expires = jiffies + timer->sticks;
+       tlist->expires = jiffies + timer->sticks - lateness;
        add_timer(tlist);
        return 0;
 }


Chris



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
