From: Rene Herman <rene.herman@gmail.com>
Subject: Re: snd_mixart_send_msg /
	snd_mixart_send_msg_wait_notif
Date: Tue, 18 Sep 2007 15:13:42 +0200
Message-ID: <46EFCF06.9000902@gmail.com>
References: <46EFBC6F.2050800@gmail.com> <s5h6428cfjk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F30C2432E
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 15:14:40 +0200 (CEST)
In-Reply-To: <s5h6428cfjk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 02:40 PM, Takashi Iwai wrote:

> At Tue, 18 Sep 2007 13:54:23 +0200,
> Rene Herman wrote:
>> Hi.
>>
>> While looking through ALSA for schedule_timeout() calls, I ran into:
>>
>> int snd_mixart_send_msg(...)
>> {
>>
>> 	[ ... ]
>>
>>          set_current_state(TASK_UNINTERRUPTIBLE);
>>          add_wait_queue(&mgr->msg_sleep, &wait);
>>          spin_unlock_irq(&mgr->msg_lock);
>>          timeout = schedule_timeout(MSG_TIMEOUT_JIFFIES);
>>          remove_wait_queue(&mgr->msg_sleep, &wait);
>>
>>          if (! timeout) {
>>                  /* error - no ack */
>>                  mutex_unlock(&mgr->msg_mutex);
>>                  snd_printk(KERN_ERR "error: no reponse on msg %x\n", 
>> msg_frame);
>>                  return -EIO;
>>          }
>>
>> 	[ ... ]
>>
>> }
>>
>> and the same in snd_mixart_send_msg_wait_notif().
>>
>> I believe there to be  something wrong with this code. A schedule_timeout() 
>> in TASK_UNINTERRUPTIBLE is always going to return 0.
> 
> No, it returns the time left at the point it's woken up.
> *_uninterruptible() ignores signals but not wake_up() itself
> (otherwise it makes no sense).  The description in the kernel comment
> is misleading indeed.

And the wake_up() is done from interrupt here -- yes, okay, I understand 
now. Thanks.

(send email to digigram asking what happened to that alsa@ address by the way).

Rene.
