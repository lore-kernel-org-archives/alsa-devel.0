From: Rene Herman <rene.herman@gmail.com>
Subject: snd_mixart_send_msg / snd_mixart_send_msg_wait_notif
Date: Tue, 18 Sep 2007 13:54:23 +0200
Message-ID: <46EFBC6F.2050800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C2E2A244C0
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 13:55:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Digigram <alsa@digigram.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.

While looking through ALSA for schedule_timeout() calls, I ran into:

int snd_mixart_send_msg(...)
{

	[ ... ]

         set_current_state(TASK_UNINTERRUPTIBLE);
         add_wait_queue(&mgr->msg_sleep, &wait);
         spin_unlock_irq(&mgr->msg_lock);
         timeout = schedule_timeout(MSG_TIMEOUT_JIFFIES);
         remove_wait_queue(&mgr->msg_sleep, &wait);

         if (! timeout) {
                 /* error - no ack */
                 mutex_unlock(&mgr->msg_mutex);
                 snd_printk(KERN_ERR "error: no reponse on msg %x\n", 
msg_frame);
                 return -EIO;
         }

	[ ... ]

}

and the same in snd_mixart_send_msg_wait_notif().

I believe there to be  something wrong with this code. A schedule_timeout() 
in TASK_UNINTERRUPTIBLE is always going to return 0. Didn't you intend to 
use a wait_event_timeout() or something like that? Puzzled, since you err 
out on !timeout, and it seems every run through this would end up there.

Rene.
