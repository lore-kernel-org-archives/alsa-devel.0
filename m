From: Pete cat <peterpion@yahoo.com>
Subject: Re: Xrun stack trace for 1010LT
Date: Fri, 5 Dec 2008 06:48:43 -0800 (PST)
Message-ID: <21718.84876.qm@web65413.mail.ac4.yahoo.com>
References: <s5hr64mitp9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65413.mail.ac4.yahoo.com (web65413.mail.ac4.yahoo.com
	[76.13.9.33]) by alsa0.perex.cz (Postfix) with SMTP id DAEFC24515
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 15:48:44 +0100 (CET)
In-Reply-To: <s5hr64mitp9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I understand. Im only a fairly basic C coder and such, so could you recommend a tool which is fairly easy to use? Or would it be better to revert to a non RT kernel (there did not seem to be much improvement when I moved to the RT kernel)?

Thanks, Pete

Takashi Iwai <tiwai@suse.de> wrote: At Fri, 5 Dec 2008 06:18:04 -0800 (PST),
Pete cat wrote:
> 
> Im trying to get xrun free recording from a pair of 1010LTs (ice1712) and ive resorted to setting xrun_debug to record stack traces on xruns.
> 
> Im getting xruns every few minutes (between 2 and 15 minute gaps between single xrun events) and every xrun produces identical stack traces like this:
> 
> [17127.486287] Pid: 775, comm: IRQ-3 Not tainted 2.6.24.1 #2
> [17127.486309]  [] snd_pcm_period_elapsed+0x247/0x2f0
> [17127.486325]  [] __switch_to+0x9e/0x150
> [17127.486336]  [] finish_task_switch+0x34/0xd0
> [17127.486350]  [] snd_ice1712_interrupt+0xa9/0x1a0
> [17127.486364]  [] handle_IRQ_event+0x5c/0x100
> [17127.486379]  [] thread_simple_irq+0x4a/0x90
> [17127.486390]  [] do_irqd+0x229/0x290
> [17127.486404]  [] do_irqd+0x0/0x290
> [17127.486411]  [] kthread+0x42/0x70
> [17127.486418]  [] kthread+0x0/0x70
> [17127.486425]  [] kernel_thread_helper+0x7/0x10
> [17127.486437]  =======================
> 
> Running the rt kernel (Linux ubuntu-studio 2.6.24.1 #2 SMP PREEMPT RT Thu Dec 4 21:30:26 GMT 2008 i686 GNU/Linux) - although the original installation was Ubuntu studio, the kernel is recompiled. The xruns seem to be all on the same card. IRQs are set to priority of 99 with chrt. Software for record is arecord, modified to use a 10 second ring buffer which is written to disk in a separate thread.

Sorry, but this information is useless for RT kernel because the irq
is all threaded...  On RT kernel, you'd better to use a better analyze
tool.


Takashi
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
