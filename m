From: Greg KH <gregkh@suse.de>
Subject: [01/08] Fix Oops with ALSA timer event notification
Date: Tue, 5 Apr 2005 09:46:05 -0700
Message-ID: <20050405164604.GB17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DA494241
	for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2005 18:49:04 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

the patch below fixes the bug of ALSA timer notification, which is
used in the recent ALSA dmix plugin.

 - fixed Oops in read()
 - fixed wake-up polls and signals with new events

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux/sound/core/timer.c	20 Jan 2005 17:37:00 -0000	1.50
+++ linux/sound/core/timer.c	14 Mar 2005 22:07:32 -0000
@@ -1117,7 +1117,8 @@
 	if (tu->qused >= tu->queue_size) {
 		tu->overrun++;
 	} else {
-		memcpy(&tu->queue[tu->qtail++], tread, sizeof(*tread));
+		memcpy(&tu->tqueue[tu->qtail++], tread, sizeof(*tread));
+		tu->qtail %= tu->queue_size;
 		tu->qused++;
 	}
 }
@@ -1140,6 +1141,8 @@
 	spin_lock(&tu->qlock);
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	spin_unlock(&tu->qlock);
+	kill_fasync(&tu->fasync, SIGIO, POLL_IN);
+	wake_up(&tu->qchange_sleep);
 }
 
 static void snd_timer_user_tinterrupt(snd_timer_instance_t *timeri,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
