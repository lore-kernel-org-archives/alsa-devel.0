From: Rene Herman <rene.herman@gmail.com>
Subject: Re: snd_mixart_send_msg /
	snd_mixart_send_msg_wait_notif
Date: Tue, 18 Sep 2007 13:57:11 +0200
Message-ID: <46EFBD17.9090302@gmail.com>
References: <46EFBC6F.2050800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id CE6AC244C0
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 13:58:10 +0200 (CEST)
In-Reply-To: <46EFBC6F.2050800@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Digigram <alsa@digigram.com>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 01:54 PM, Rene Herman wrote:

People just _make_ me reply to myself:

  alsa@digigram.com
     SMTP error from remote mailer after RCPT TO:<alsa@digigram.com>:
     host mail.digigram.com [213.30.172.230]: 550 5.1.1 <alsa@digigram.com>:
     Recipient address rejected: User unknown in relay recipient table

> While looking through ALSA for schedule_timeout() calls, I ran into:
> 
> int snd_mixart_send_msg(...)
> {
> 
>     [ ... ]
> 
>         set_current_state(TASK_UNINTERRUPTIBLE);
>         add_wait_queue(&mgr->msg_sleep, &wait);
>         spin_unlock_irq(&mgr->msg_lock);
>         timeout = schedule_timeout(MSG_TIMEOUT_JIFFIES);
>         remove_wait_queue(&mgr->msg_sleep, &wait);
> 
>         if (! timeout) {
>                 /* error - no ack */
>                 mutex_unlock(&mgr->msg_mutex);
>                 snd_printk(KERN_ERR "error: no reponse on msg %x\n", 
> msg_frame);
>                 return -EIO;
>         }
> 
>     [ ... ]
> 
> }
> 
> and the same in snd_mixart_send_msg_wait_notif().
> 
> I believe there to be  something wrong with this code. A 
> schedule_timeout() in TASK_UNINTERRUPTIBLE is always going to return 0. 
> Didn't you intend to use a wait_event_timeout() or something like that? 
> Puzzled, since you err out on !timeout, and it seems every run through 
> this would end up there.

Rene.
