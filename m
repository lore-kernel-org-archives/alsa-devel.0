From: Clemens Ladisch <clemens@ladisch.de>
Subject: [Patch] race condition in snd_timer_stop - Aiee!
Date: Mon, 29 Apr 2002 14:10:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CCD3826.31B168FA@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

If snd_timer_start schedules a timer instance to be started later
and snd_timer_stop is called before the next timer interrupt,
snd_timer_stop does not remove the (not yet running) timer instance
from the active list. The patch should fix this.


Clemens


--- timer.c.orig        Sat Apr 27 17:54:59 2002
+++ timer.c     Sat Apr 27 17:48:51 2002
@@ -424,6 +424,9 @@
                                }
                        }
                }
+       } else if (timeri->flags & SNDRV_TIMER_IFLG_START) {
+               timeri->flags &= ~SNDRV_TIMER_IFLG_START;
+               list_del_init(&timeri->active_list);
        }
        spin_unlock_irqrestore(&timer->lock, flags);
        return 0;
