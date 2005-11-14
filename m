From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001559]: hang in snd_pcm_drain()
Date: Mon, 14 Nov 2005 19:14:25 +0100
Message-ID: <0597b0e52aedf3c0b92ab060671e4166@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A7CB01BF
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 19:14:27 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1559> 
======================================================================
Reported By:                Faust3
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1559
Category:                   CORE - pcm
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-14-2005 19:14 CET
Last Modified:              11-14-2005 19:14 CET
======================================================================
Summary:                    hang in snd_pcm_drain()
Description: 
MPlayer sometimes hangs during uninit in snd_pcm_drain()
Sometimes one can play up to 40 files untill it happens, so this is not
easily reproducable.
Although I could reproduce it with alsa-lib-1.0.10rc3 and kernel 2.6.15rc1
and 2.6.14.
As far as I know it does not happen with 2.6.12. I did not test 2.6.13

Here is some backtrace when pressing ctrl-c (I can redo with debugging
symbols if needed)
0xffffe410 in __kernel_vsyscall ()
(gdb) bt
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb797e0bd in poll () from /lib/tls/i686/cmov/libc.so.6
#2  0xb7efcca1 in snd_pcm_wait_nocheck () from /usr/lib/libasound.so.2
#3  0xb7f32a2d in _snd_pcm_dmix_open () from /usr/lib/libasound.so.2
#4  0xb7efaa9c in snd_pcm_drain () from /usr/lib/libasound.so.2
#5  0xb7f0c63b in snd_pcm_generic_drain () from /usr/lib/libasound.so.2
#6  0xb7efaa9c in snd_pcm_drain () from /usr/lib/libasound.so.2
#7  0xb7f1712e in _snd_pcm_rate_open () from /usr/lib/libasound.so.2
#8  0xb7efaa9c in snd_pcm_drain () from /usr/lib/libasound.so.2
#9  0x080cd4a9 in uninit ()
#10 0x08856ad8 in ?? ()
#11 0x00000006 in ?? ()
#12 0xbf9f2148 in ?? ()
#13 0x081f750c in getch2_disable ()
#14 0x00000000 in ?? ()
#15 0x00000000 in ?? ()
#16 0x08643700 in getch2_buf ()
#17 0x08072839 in uninit_player ()
#18 0x00000007 in ?? ()
#19 0x084dbcc6 in _IO_stdin_used ()
#20 0x00000e4b in ?? ()
#21 0xbf9f0efc in ?? ()
#22 0x00000004 in ?? ()
#23 0x00000004 in ?? ()
#24 0x08076959 in main ()

Attaching strace will make it continue.

As far as I can tell the problematic poll is in 
static unsigned int snd_timer_user_poll(struct file *file, poll_table *
wait)

in sound/core/timer.c in the kernel.

I don't know if this has any importance but tu->qused in the above
function is 2, about 2 polls before the hang. During normal playback it
always seems to be 0 or 1

It might have also something to do with the many xruns I'm getting with
some files,
but I think the xruns are more likely a MPlayer problem.
The problem does not occure when using oss emulation.

Please tell me if you need additional info or if I should add some debug
printf/printks etc.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-05 19:14 Faust3         New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
