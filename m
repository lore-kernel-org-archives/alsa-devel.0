From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: ALSA timer and 2.6.0-test1 panic
Date: Wed, 16 Jul 2003 14:16:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1x3ch6650f.fsf@users.sourceforge.net>
References: <yw1xlluyln01.fsf@users.sourceforge.net>
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
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> I get thousands of these messages when using the ALSA timer in kernel
> 2.6.0-test1:
>
> bad: scheduling while atomic!
> Call Trace:
>  [<c0118408>] schedule+0x3ab/0x3b0
>  [<c0123190>] schedule_timeout+0x5f/0xb3
>  [<d08fffb6>] snd_timer_user_poll+0x2a/0x41 [snd_timer]
>  [<c0123128>] process_timeout+0x0/0x9
>  [<c0160aa7>] do_poll+0xa1/0xc0
>  [<c0160c62>] sys_poll+0x19c/0x28e
>  [<c0160035>] __pollwait+0x0/0xc6
>  [<c010911b>] syscall_call+0x7/0xb
>
> bad: scheduling while atomic!
> Call Trace:
>  [<c0118408>] schedule+0x3ab/0x3b0
>  [<c014ed0e>] sys_read+0x61/0x63
>  [<c0109142>] work_resched+0x5/0x16
>
> bad: scheduling while atomic!
> Call Trace:
>  [<c0118408>] schedule+0x3ab/0x3b0
>  [<c014ed0e>] sys_read+0x61/0x63
>  [<c0109142>] work_resched+0x5/0x16
>
> Everything works like it should anyhow, until the program stops.  At
> that time the kernel panics (killing interrupt handler).

If I disable the preemptive kernel it works fine.

-- 
Måns Rullgård
mru@users.sf.net



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
