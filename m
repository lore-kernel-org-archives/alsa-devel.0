From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: alsa cvs stability problems.
Date: Sat, 10 Jul 2004 19:52:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40F03AF9.8060906@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C87FC1AB
	for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2004 20:51:50 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-30.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BjMwv-000IBB-0U
	for alsa-devel@alsa-project.org; Sat, 10 Jul 2004 19:51:49 +0100
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

I am seeing a log to stability problems when using the latest alsa cvs.
Is anyone else seeing similar problems?

Cheers
James

Example stack trackes of the problem:
Jul 10 14:37:18 new kernel: kernel BUG at mm/page_alloc.c:208!
Jul 10 14:37:18 new kernel: invalid operand: 0000 [#1]
Jul 10 14:37:18 new kernel: PREEMPT SMP DEBUG_PAGEALLOC
Jul 10 14:37:18 new kernel: Modules linked in: snd_p16v snd_pcm 
snd_timer snd_ac97_codec snd soundcore snd_page_alloc nvidia md5 ipv6 
parport_pc lp parport usbhid uhci_hcd usbcore e1000 sg ide_cd sr_mod cdrom
Jul 10 14:37:18 new kernel: CPU:    0
Jul 10 14:37:18 new kernel: EIP:    0060:[<c013f552>]    Tainted: P
Jul 10 14:37:18 new kernel: EFLAGS: 00210002   (2.6.7)
Jul 10 14:37:18 new kernel: EIP is at free_pages_bulk+0x23b/0x276
Jul 10 14:37:18 new kernel: eax: 00000001   ebx: c0384ac0   ecx: 
00000000   edx: fff9c256
Jul 10 14:37:18 new kernel: esi: ffffffff   edi: 7ffce12b   ebp: 
d87f1d54   esp: d87f1d0c
Jul 10 14:37:18 new kernel: ds: 007b   es: 007b   ss: 0068
Jul 10 14:37:18 new kernel: Process speaker-test (pid: 12204, 
threadinfo=d87f0000 task=dc4a4a60)
Jul 10 14:37:18 new kernel: Stack: c0384700 c0384ac0 00000001 c038498c 
00000000 c0384ae0 fff9c257 c0384908
Jul 10 14:37:18 new kernel:        00000000 c1000000 c0384908 00200096 
ffffffff d87f1d54 c0116365 c0384700
Jul 10 14:37:18 new kernel:        c1008260 d87f0000 d87f1d84 c013fc28 
c0384700 00000000 c0384a90 00000000
Jul 10 14:37:18 new kernel: Call Trace:
Jul 10 14:37:18 new kernel:  [<c01052ff>] show_stack+0x80/0x96
Jul 10 14:37:18 new kernel:  [<c0105496>] show_registers+0x15f/0x1ae
Jul 10 14:37:18 new kernel:  [<c010563f>] die+0xc1/0x186
Jul 10 14:37:18 new kernel:  [<c0105a55>] do_invalid_op+0xb5/0xb7
Jul 10 14:37:18 new kernel:  [<c0104fa1>] error_code+0x2d/0x38
Jul 10 14:37:18 new kernel:  [<c013fc28>] free_hot_cold_page+0x12d/0x146
Jul 10 14:37:18 new kernel:  [<c01402e1>] __pagevec_free+0x1b/0x24
Jul 10 14:37:18 new kernel:  [<c0149559>] release_pages+0x83/0x25e
Jul 10 14:37:18 new kernel:  [<c015b893>] 
free_pages_and_swap_cache+0x64/0x88
Jul 10 14:37:18 new kernel:  [<c015383a>] exit_mmap+0x209/0x22f
Jul 10 14:37:18 new kernel:  [<c011b98a>] mmput+0x85/0xbf
Jul 10 14:37:18 new kernel:  [<c012124a>] do_exit+0x17d/0x62f
Jul 10 14:37:18 new kernel:  [<c01217be>] do_group_exit+0x3d/0x177
Jul 10 14:37:18 new kernel:  [<c012b118>] get_signal_to_deliver+0x38f/0x574
Jul 10 14:37:18 new kernel:  [<c0104276>] do_signal+0x6c/0xf1
Jul 10 14:37:18 new kernel:  [<c0104336>] do_notify_resume+0x3b/0x3d
Jul 10 14:37:18 new kernel:  [<c0104562>] work_notifysig+0x13/0x15
Jul 10 14:37:18 new kernel:
Jul 10 14:37:18 new kernel: Code: 0f 0b d0 00 71 97 34 c0 e9 0b ff ff ff 
0f 0b c3 00 71 97 34
Jul 10 14:37:18 new kernel:  <6>note: speaker-test[12204] exited with 
preempt_count 3
Jul 10 14:37:18 new kernel: Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
Jul 10 14:37:18 new kernel: in_atomic():1, irqs_disabled():0
Jul 10 14:37:18 new kernel:  [<c0105333>] dump_stack+0x1e/0x22
Jul 10 14:37:18 new kernel:  [<c011aee1>] __might_sleep+0xb2/0xd3
Jul 10 14:37:18 new kernel:  [<c011f222>] profile_exit_task+0x22/0x60
Jul 10 14:37:18 new kernel:  [<c0121148>] do_exit+0x7b/0x62f
Jul 10 14:37:18 new kernel:  [<c0105704>] do_divide_error+0x0/0xdd
Jul 10 14:37:18 new kernel:  [<c0105a55>] do_invalid_op+0xb5/0xb7
Jul 10 14:37:18 new kernel:  [<c0104fa1>] error_code+0x2d/0x38
Jul 10 14:37:18 new kernel:  [<c013fc28>] free_hot_cold_page+0x12d/0x146
Jul 10 14:37:18 new kernel:  [<c01402e1>] __pagevec_free+0x1b/0x24
Jul 10 14:37:18 new kernel:  [<c0149559>] release_pages+0x83/0x25e
Jul 10 14:37:18 new kernel:  [<c015b893>] 
free_pages_and_swap_cache+0x64/0x88
Jul 10 14:37:18 new kernel:  [<c015383a>] exit_mmap+0x209/0x22f
Jul 10 14:37:18 new kernel:  [<c011b98a>] mmput+0x85/0xbf
Jul 10 14:37:18 new kernel:  [<c012124a>] do_exit+0x17d/0x62f
Jul 10 14:37:18 new kernel:  [<c01217be>] do_group_exit+0x3d/0x177
Jul 10 14:37:18 new kernel:  [<c012b118>] get_signal_to_deliver+0x38f/0x574
Jul 10 14:37:18 new kernel:  [<c0104276>] do_signal+0x6c/0xf1
Jul 10 14:37:18 new kernel:  [<c0104336>] do_notify_resume+0x3b/0x3d
Jul 10 14:37:18 new kernel:  [<c0104562>] work_notifysig+0x13/0x15


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
