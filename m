From: Pete cat <peterpion@yahoo.com>
Subject: Xrun stack trace for 1010LT
Date: Fri, 5 Dec 2008 06:18:04 -0800 (PST)
Message-ID: <279201.13713.qm@web65401.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65401.mail.ac4.yahoo.com (web65401.mail.ac4.yahoo.com
	[76.13.9.21]) by alsa0.perex.cz (Postfix) with SMTP id 849FE244EB
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 15:18:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Im trying to get xrun free recording from a pair of 1010LTs (ice1712) and ive resorted to setting xrun_debug to record stack traces on xruns.

Im getting xruns every few minutes (between 2 and 15 minute gaps between single xrun events) and every xrun produces identical stack traces like this:

[17127.486287] Pid: 775, comm: IRQ-3 Not tainted 2.6.24.1 #2
[17127.486309]  [<c02ade37>] snd_pcm_period_elapsed+0x247/0x2f0
[17127.486325]  [<c010312e>] __switch_to+0x9e/0x150
[17127.486336]  [<c0128674>] finish_task_switch+0x34/0xd0
[17127.486350]  [<c02c2119>] snd_ice1712_interrupt+0xa9/0x1a0
[17127.486364]  [<c016ab7c>] handle_IRQ_event+0x5c/0x100
[17127.486379]  [<c016b1ba>] thread_simple_irq+0x4a/0x90
[17127.486390]  [<c016bb09>] do_irqd+0x229/0x290
[17127.486404]  [<c016b8e0>] do_irqd+0x0/0x290
[17127.486411]  [<c0141ef2>] kthread+0x42/0x70
[17127.486418]  [<c0141eb0>] kthread+0x0/0x70
[17127.486425]  [<c0105857>] kernel_thread_helper+0x7/0x10
[17127.486437]  =======================

Running the rt kernel (Linux ubuntu-studio 2.6.24.1 #2 SMP PREEMPT RT Thu Dec 4 21:30:26 GMT 2008 i686 GNU/Linux) - although the original installation was Ubuntu studio, the kernel is recompiled. The xruns seem to be all on the same card. IRQs are set to priority of 99 with chrt. Software for record is arecord, modified to use a 10 second ring buffer which is written to disk in a separate thread.

I was hoping that from the stack trace I could work out what was causing the xruns, but from the above it dosent look like there is anything causing them. However this is the first time I am using stack traces so  maybe im missing something. Can anyone point to the fault for me?

Thanks, Pete
