From: Luca <kronos.it@gmail.com>
Subject: [1.0.11] aplay randomly hangs
Date: Thu, 27 Apr 2006 18:57:16 +0200
Message-ID: <20060427165716.GA916@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.191])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A366E188
	for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 18:57:16 +0200 (MEST)
Received: by nproxy.gmail.com with SMTP id a4so328118nfc
        for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 09:57:16 -0700 (PDT)
Content-Disposition: inline
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

(please CC me)

Hello,
with the upgrade from 1.0.10 to 1.0.11 aplays randomly hangs,
sometimes (not always) with the following message:

*** glibc detected *** free(): invalid pointer: 0x08081628 ***

When it happens aplay is stuck:

USER        PID ACCESS COMMAND
/dev/snd/pcmC0D0p    kronos    15872 f...m  aplay
		     kronos    15874 f...m  aplay
/dev/snd/timer       kronos    15872 f....  aplay

This is backtrace of a dead aplay:

*** glibc detected *** free(): invalid pointer: 0x080821b0 ***

Program received signal SIGABRT, Aborted.
[Switching to Thread -1479334208 (LWP 5273)]
0xa7d5d7c7 in raise () from /lib/tls/libc.so.6
(gdb) bt
#0  0xa7d5d7c7 in raise () from /lib/tls/libc.so.6
#1  0xa7d5f06b in abort () from /lib/tls/libc.so.6
#2  0xa7d94545 in __fsetlocking () from /lib/tls/libc.so.6
#3  0xa7d9ab97 in malloc_usable_size () from /lib/tls/libc.so.6
#4  0xa7d9b032 in free () from /lib/tls/libc.so.6
#5  0xa7f08f70 in snd_pcm_adpcm_decode () from /usr/lib/libasound.so.2
#6  0xa7ee75b9 in snd_pcm_hw_free () from /usr/lib/libasound.so.2
#7  0xa7f0e3ed in _snd_pcm_rate_linear_open () from /usr/lib/libasound.so.2
#8  0xa7ee75b9 in snd_pcm_hw_free () from /usr/lib/libasound.so.2
#9  0xa7ef1c2e in snd_pcm_close () from /usr/lib/libasound.so.2
#10 0x08051074 in main (argc=2, argv=0xafb26484) at aplay.c:611

And another one with debug enabled (which makes more sense to me...):

*** glibc detected *** free(): invalid pointer: 0x080821b0 ***

Program received signal SIGABRT, Aborted.
[Switching to Thread -1479620928 (LWP 21055)]
0xa7d177c7 in raise () from /lib/tls/libc.so.6
(gdb) bt
#0  0xa7d177c7 in raise () from /lib/tls/libc.so.6
#1  0xa7d1906b in abort () from /lib/tls/libc.so.6
#2  0xa7d4e545 in __fsetlocking () from /lib/tls/libc.so.6
#3  0xa7d54b97 in malloc_usable_size () from /lib/tls/libc.so.6
#4  0xa7d55032 in free () from /lib/tls/libc.so.6
#5  0xa7ed5f70 in snd_pcm_rate_hw_free (pcm=0x0) at pcm_rate.c:330
#6  0xa7eb45b9 in snd_pcm_hw_free (pcm=0x8068da0) at pcm.c:853
#7  0xa7edb3ed in snd_pcm_plug_hw_free (pcm=0x9) at pcm_plug.c:976
#8  0xa7eb45b9 in snd_pcm_hw_free (pcm=0x80690e8) at pcm.c:853
#9  0xa7ebec2e in snd_pcm_close (pcm=0x80690e8) at pcm.c:703
#10 0x08051074 in main (argc=2, argv=0xafa2a394) at aplay.c:611

I _think_ that the other aplay thats hangs without any message are
consequence of the first bug, but I'm not sure so I'm attacching other
information.

sysrq+t shows:

aplay         S C6D25E78  6884 15872  30769         16154       (NOTLB)
       c6d25e84 c6d25e4c b01063d4 c6d25e78 00000003 c6d24000 829c8700 0042ec48
       0000000a ec041178 ec041070 829c8700 0042ec48 00000000 00000000 00000000
       c6d24000 01e84800 00000000 c6d24000 b04046c8 00000000 c6d24000 b0304125
Call Trace:
 <b01063d4> do_gettimeofday+0x14/0xc0   <b0304125> schedule_timeout+0x75/0xc0
 <b0133235> get_futex_key+0x45/0x110   <f087192b> _snd_timer_stop+0x3b/0x170 [snd_timer]
 <b017006b> fasync_helper+0x5b/0xf0   <b012ec1e> add_wait_queue+0x3e/0x70
 <b013410d> do_futex+0x81d/0xa90   <f0872a10> snd_timer_user_ioctl+0x0/0xe10 [snd_timer]
 <b0117360> default_wake_function+0x0/0x10 <f0872a10> snd_timer_user_ioctl+0x0/0xe10 [snd_timer]
 <b017012b> do_ioctl+0x2b/0x90   <b01343dc> sys_futex+0x5c/0x120
 <b015dce1> sys_read+0x41/0x70   <b010301f> syscall_call+0x7/0xb

and the other one:

aplay         S B8E54000  6480 15874      1               14570 (NOTLB)
       b8e55bf0 b013c953 0000000b b8e54000 b01076ea b8e54000 d37a4500 0042ecd8
       0000000a b35fe138 b35fe030 d37a4500 0042ecd8 00000000 00000000 00000000
       b8e54000 00000000 00000000 b8e55c04 18b45eda 00000000 b8e55e9c b03040f9
Call Trace:
 <b013c953> handle_IRQ_event+0x33/0x60   <b01076ea> enable_8259A_irq+0x3a/0x70
 <b03040f9> schedule_timeout+0x49/0xc0   <b012ec1e> add_wait_queue+0x3e/0x70
 <b0124340> process_timeout+0x0/0x10   <b0170d30> do_sys_poll+0x2d0/0x420
 <b01719c0> __pollwait+0x0/0x100   <b0117360> default_wake_function+0x0/0x10
 <b0117360> default_wake_function+0x0/0x10 <b02a9393> __alloc_skb+0x53/0x110
 <b02a605f> sock_alloc_send_skb+0x18f/0x1e0 <b015e388> fget+0x58/0xa0
 <b01d48ed> copy_from_user+0x4d/0xa0 <b02a7705> sock_def_readable+0x45/0x80
 <b02fe63e> unix_stream_sendmsg+0x17e/0x340 <b01bab43> ipc_unlock+0x23/0x40
 <b01bc9d4> sys_semtimedop+0x3c4/0x800 <b02a9a44> __kfree_skb+0x34/0xc0
 <b02a9998> kfree_skbmem+0x8/0x80 <b0272152> e100_tx_clean+0x92/0x110
 <b01d48ed> copy_from_user+0x4d/0xa0 <b01d48ed> copy_from_user+0x4d/0xa0
 <b02a3811> sys_sendmsg+0x161/0x270 <b012066e> local_bh_enable+0x2e/0x90
 <b015b113> fd_install+0x53/0x90 <b01d4acd> copy_to_user+0x4d/0x90
 <b01be73a> sys_shmctl+0x2ca/0x6b2 <b01779f0> destroy_inode+0x20/0x40
 <b01cf9ba> _atomic_dec_and_lock+0x2a/0x50 <b0176052> dput+0xc2/0x1b0
 <b0107cf0> sys_ipc+0x50/0x260 <b0170ebd> sys_poll+0x3d/0x50
 <b010301f> syscall_call+0x7/0xb

A few more of them:

aplay         S 00000000  6988 16645      1               14570 (NOTLB)
       c0893bf0 00000000 00000000 00000000 00000000 c0892000 0cc29400 0042ee0c
       0000000a c1e89658 c1e89550 0cc29400 0042ee0c 00000000 00000000 00000000
       c0892000 003d0900 00000000 c0893c04 18b96771 00000000 c0893e9c b03040f9
Call Trace:
 <b03040f9> schedule_timeout+0x49/0xc0   <b012ec1e> add_wait_queue+0x3e/0x70
 <b0124340> process_timeout+0x0/0x10   <b0170d30> do_sys_poll+0x2d0/0x420
 <b01719c0> __pollwait+0x0/0x100   <b0117360> default_wake_function+0x0/0x10
 <b0117360> default_wake_function+0x0/0x10 <b02a9393> __alloc_skb+0x53/0x110
 <b02a605f> sock_alloc_send_skb+0x18f/0x1e0 <b015e388> fget+0x58/0xa0
 <b01d48ed> copy_from_user+0x4d/0xa0 <b02a7705> sock_def_readable+0x45/0x80
 <b011c1a9> profile_tick+0x29/0x70 <b0103a84> apic_timer_interrupt+0x1c/0x24
 <b01bab43> ipc_unlock+0x23/0x40 <b01bc9d4> sys_semtimedop+0x3c4/0x800
 <b01d48ed> copy_from_user+0x4d/0xa0 <b01d48ed> copy_from_user+0x4d/0xa0
 <b02a3811> sys_sendmsg+0x161/0x270 <b0103a84> apic_timer_interrupt+0x1c/0x24
 <b01d4acd> copy_to_user+0x4d/0x90 <b01be73a> sys_shmctl+0x2ca/0x6b2
 <b01779f0> destroy_inode+0x20/0x40 <b01cf9ba> _atomic_dec_and_lock+0x2a/0x50
 <b0176052> dput+0xc2/0x1b0 <b0107cf0> sys_ipc+0x50/0x260
 <b0170ebd> sys_poll+0x3d/0x50 <b010301f> syscall_call+0x7/0xb

aplay         S D086BE78  6764 16827  30769                     (NOTLB)
       d086be84 d086be4c b01063d4 d086be78 00000003 d086a000 f0c1bb00 0042edf2
       0000000a eb5c56d8 eb5c55d0 f0c1bb00 0042edf2 00000000 00000000 00000000
       d086a000 01e84800 00000000 d086a000 b04047a8 00000000 d086a000 b0304125
Call Trace:
 <b01063d4> do_gettimeofday+0x14/0xc0   <b0304125> schedule_timeout+0x75/0xc0
 <b0133235> get_futex_key+0x45/0x110   <f087192b> _snd_timer_stop+0x3b/0x170 [snd_timer]
 <b017006b> fasync_helper+0x5b/0xf0   <b012ec1e> add_wait_queue+0x3e/0x70
 <b013410d> do_futex+0x81d/0xa90   <f0872a10> snd_timer_user_ioctl+0x0/0xe10 [snd_timer]
 <b0117360> default_wake_function+0x0/0x10   <f0872a10> snd_timer_user_ioctl+0x0/0xe10 [snd_timer]
 <b017012b> do_ioctl+0x2b/0x90   <b01343dc> sys_futex+0x5c/0x120
 <b015dce1> sys_read+0x41/0x70   <b010301f> syscall_call+0x7/0xb

It's not 100% reproducible, but running something like:

        for i in `seq 1 100`; do aplay whatever.wav; done

is likely to leave a couple of hung processes.

Kernel is 2.6.17-rc1, this is the soundcard:

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 40)
	Subsystem: Unknown device 1695:3004
	Flags: medium devsel, IRQ 5
	I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2

(it'a VT8233A)

My ~/.asoundrc is empty, since now dmix is enabled by default.

Packages are from the Debian unstable:

ii  alsa-base                  1.0.11-1                   ALSA driver configuration files
ii  alsa-utils                 1.0.11-2                   ALSA utilities
ii  libasound2                 1.0.11-3                   ALSA library

and I've confirmed that going back to 1.0.10 (same kernel) makes the
problem disappear.

Any clue on what's going on?

Luca
-- 
Home: http://kronoz.cjb.net
K.R.O.N.O.S
Kinetic Replicant Optimized for Nocturnal Observation and Sabotage


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
