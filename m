From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Kernel Oops with latest CCRMA Alsa (1.09rc1) (EMU10K1)
Date: Thu, 07 Apr 2005 09:02:43 +1000
Message-ID: <42546A93.5090307@machinehasnoagenda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

been having a few problems with ALSA on the latest edge kernel from
Planet CCRMA - Fernando thought i should post this here, just in case
it's been overlooked, or not fixed in CVS:

>On Wed, 2005-04-06 at 08:23, Shayne O'Connor wrote:
>  
>
>>>> >On Mon, 2005-04-04 at 16:25, Shayne O'Connor wrote:
>>>      
>>>
>>>>>> >>> On Mon, 2005-04-04 at 12:57 -0700, Fernando Lopez-Lezcano wrote:
>>>>>          
>>>>>
>>>>>>>> >>>> > On Mon, 2005-04-04 at 04:56, Shayne O'Connor wrote:
>>>>>>>              
>>>>>>>
>>>>>>>>>> >>>>> > > this is pretty vague, but i've been getting sporadic hanging of - i
>>>>>>>>>> >>>>> > > think - the jack daemon with the latest CCRMA edge kernel for fedora
>>>>>>>>>> >>>>> > > core 3.
>>>>>>>>>                  
>>>>>>>>>
>>>>>>>> >>>> > 
>>>>>>>> >>>> > Have you looked at /var/log/messages or the output of dmesg? I smells
>>>>>>>> >>>> > like something is causing a kernel oops, and after that happens all bets
>>>>>>>> >>>> > are off in terms of how usable the system remains. 
>>>>>>>              
>>>>>>>
>>>>>> >>> 
>>>>>> >>> i've dug through the system logs, but didn't find any explicity mentions
>>>>>> >>> of a "kernel oops" (i've been wondering - what the heck *is* a "kernel
>>>>>> >>> oops"?),
>>>>>          
>>>>>
>>>> >
>>>> >Basically it is a "crash" internal to the kernel, it finds some internal
>>>> >inconsistency that should not happen, reports an error (grep -i oops to
>>>> >find them) with a stack dump and shuts down a portion of the kernel. In
>>>> >extreme cases the machine hangs completely - the kernel is so confused
>>>> >that nothing else is allowed to happen. In other cases just a driver
>>>> >crashes and then anything having to do with that driver hangs, which may
>>>> >mean the whole thing hangs or just weird things happen. 
>>>      
>>>
>>>
>>> ok, i managed to catch the output of an Oops! just now using dmesg after
>>> jackd hung again ... this is using the latest edge kernel for FC3. i
>>> think i'll have to leave planetedge and take it easy on planetnormal for
>>> a bit  :) 
>>    
>>
>
>You may want to post the oops to the alsa developers list, at this point
>this may be fixed in cvs but you never know, may be something new.
>
>  
>


BUG: Unable to handle kernel paging request at virtual address 75ecff50
 printing eip:
c01e3c8e
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: md5(U) ipv6(U) snd_seq_oss(U) snd_seq_dummy(U)
nvidia(U) realtime(U) commoncap(U) snd_seq_midi(U) snd_emu10k1_synth(U)
snd_emux_synth(U) snd_seq_virmidi(U) snd_seq_midi_event(U)
snd_seq_midi_emul(U) snd_seq(U) parport_pc(U) lp(U) parport(U)
autofs4(U) dm_mod(U) video(U) container(U) button(U) battery(U) ac(U)
ohci_hcd(U) ehci_hcd(U) snd_emu10k1(U) snd_rawmidi(U) snd_seq_device(U)
snd_ac97_codec(U) snd_pcm_oss(U) snd_mixer_oss(U) snd_pcm(U)
snd_timer(U) snd_page_alloc(U) snd_util_mem(U) snd_hwdep(U) snd(U)
soundcore(U) nvnet(U) ext3(U) jbd(U)
CPU:    0
EIP:    0060:[<c01e3c8e>]    Tainted: P      VLI
EFLAGS: 00010012   (2.6.11-0.3.rdt.rhfc3.ccrma)
EIP is at memcpy+0x1e/0x40
eax: 00000002   ebx: c99fbea0   ecx: 00000002   edx: 00000008
esi: 75ecff50   edi: c99fbea0   ebp: 03020100   esp: c99fbe5c
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process jackd (pid: 11113, threadinfo=c99fa000 task=c16acdd0)
Stack: c174c014 3dc67fff 75ecff50 c174c014 75ecff50 e0904e8f 00000000
00000068
       bfffca50 00000216 00000001 00000000 df05c814 00000000 00000000
00000000
       00000000 00000000 00000000 00925800 00925800 00000006 cf05bbf4
e09052e6
Call Trace:
 [<e0904e8f>] snd_emu10k1_pcm_init_voice+0x48f/0x550 [snd_emu10k1] (24)
 [<e09052e6>] snd_emu10k1_efx_playback_prepare+0xb6/0xd0 [snd_emu10k1] (72)
 [<e09a8269>] snd_pcm_do_prepare+0x9/0x20 [snd_pcm] (40)
 [<e09a760b>] snd_pcm_action_single+0x2b/0x90 [snd_pcm] (8)
 [<e09a785b>] snd_pcm_action_nonatomic+0x8b/0x90 [snd_pcm] (20)
 [<e09a82f6>] snd_pcm_prepare+0x46/0x60 [snd_pcm] (24)
 [<e09ab810>] snd_pcm_playback_ioctl+0x0/0x20 [snd_pcm] (4)
 [<e09ab15f>] snd_pcm_playback_ioctl1+0x5f/0x3c0 [snd_pcm] (8)
 [<c0155e6a>] do_mmap_pgoff+0x57a/0x790 (40)
 [<e09ab810>] snd_pcm_playback_ioctl+0x0/0x20 [snd_pcm] (20)
 [<c0178a9b>] do_ioctl+0x8b/0xa0 (16)
 [<c0178cde>] vfs_ioctl+0x5e/0x1d0 (28)
 [<c0165709>] fget_light+0x89/0xa0 (8)
 [<c0178ec7>] sys_ioctl+0x77/0x90 (20)
 [<c0103099>] sysenter_past_esp+0x52/0x75 (28)
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<e0904aae>] .... snd_emu10k1_pcm_init_voice+0xae/0x550 [snd_emu10k1]
.....[<00000000>] ..   ( <= 0x0)
.. [<c0104176>] .... die+0x36/0x180
.....[<00000000>] ..   ( <= 0x0)
.. [<c013613d>] .... print_traces+0xd/0x40
.....[<00000000>] ..   ( <= 0x0)

Code: ff ff ff c3 90 90 90 90 90 90 90 90 90 83 ec 14 89 5c 24 08 89 c3
89 c8 89 74 24 0c c1 e8 02 89 d6 89 7c 24 10 89 ca 89 df 89 c1 <f3> a5
f6 c2 02 74 02 66 a5 f6 c2 01 74 01 a4 89 d8 8b 74 24 0c
 <6>note: jackd[11113] exited with preempt_count 1
BUG: sleeping function called from invalid context jackd(11113) at
kernel/fork.c:460
in_atomic():1 [00000001], irqs_disabled():0
 [<c011c5e9>] __might_sleep+0xd9/0xf0 (8)
 [<c011cd69>] mm_release+0x69/0xd0 (40)
 [<c011fd8a>] release_console_sem+0xea/0x100 (8)
 [<c012128b>] exit_mm+0x1b/0x1b0 (32)
 [<c0121e1c>] do_exit+0x9c/0x3e0 (28)
 [<c01042bb>] die+0x17b/0x180 (40)
 [<c0118360>] do_page_fault+0x0/0x588 (48)
 [<c0118360>] do_page_fault+0x0/0x588 (12)
 [<c0118712>] do_page_fault+0x3b2/0x588 (4)
 [<e09a8f74>] snd_pcm_hw_rule_format+0x54/0x110 [snd_pcm] (16)
 [<c011af5a>] scheduler_tick+0x16a/0x310 (64)
 [<c011a318>] recalc_task_prio+0x88/0x150 (16)
 [<c011a972>] finish_task_switch+0x42/0x90 (16)
 [<c033bcab>] __schedule+0x2ab/0x620 (24)
 [<c011a5c5>] try_to_wake_up+0x135/0x140 (8)
 [<c0118360>] do_page_fault+0x0/0x588 (56)
 [<c0103b03>] error_code+0x2b/0x30 (8)
 [<c01e3c8e>] memcpy+0x1e/0x40 (44)
 [<e0904e8f>] snd_emu10k1_pcm_init_voice+0x48f/0x550 [snd_emu10k1] (32)
 [<e09052e6>] snd_emu10k1_efx_playback_prepare+0xb6/0xd0 [snd_emu10k1] (72)
 [<e09a8269>] snd_pcm_do_prepare+0x9/0x20 [snd_pcm] (40)
 [<e09a760b>] snd_pcm_action_single+0x2b/0x90 [snd_pcm] (8)
 [<e09a785b>] snd_pcm_action_nonatomic+0x8b/0x90 [snd_pcm] (20)
 [<e09a82f6>] snd_pcm_prepare+0x46/0x60 [snd_pcm] (24)
 [<e09ab810>] snd_pcm_playback_ioctl+0x0/0x20 [snd_pcm] (4)
 [<e09ab15f>] snd_pcm_playback_ioctl1+0x5f/0x3c0 [snd_pcm] (8)
 [<c0155e6a>] do_mmap_pgoff+0x57a/0x790 (40)
 [<e09ab810>] snd_pcm_playback_ioctl+0x0/0x20 [snd_pcm] (20)
 [<c0178a9b>] do_ioctl+0x8b/0xa0 (16)
 [<c0178cde>] vfs_ioctl+0x5e/0x1d0 (28)
 [<c0165709>] fget_light+0x89/0xa0 (8)
 [<c0178ec7>] sys_ioctl+0x77/0x90 (20)
 [<c0103099>] sysenter_past_esp+0x52/0x75 (28)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<e0904aae>] .... snd_emu10k1_pcm_init_voice+0xae/0x550 [snd_emu10k1]
.....[<00000000>] ..   ( <= 0x0)
.. [<c013613d>] .... print_traces+0xd/0x40
.....[<00000000>] ..   ( <= 0x0)

BUG: scheduling while atomic: jackd/0x00000001/11113
caller is do_exit+0x231/0x3e0
 [<c033bec8>] __schedule+0x4c8/0x620 (8)
 [<c0121c57>] exit_notify+0x837/0x960 (24)
 [<c0121fb1>] do_exit+0x231/0x3e0 (56)
 [<c01042bb>] die+0x17b/0x180 (40)
 [<c0118360>] do_page_fault+0x0/0x588 (48)
 [<c0118360>] do_page_fault+0x0/0x588 (12)
 [<c0118712>] do_page_fault+0x3b2/0x588 (4)
 [<e09a8f74>] snd_pcm_hw_rule_format+0x54/0x110 [snd_pcm] (16)
 [<c011af5a>] scheduler_tick+0x16a/0x310 (64)
 [<c011a318>] recalc_task_prio+0x88/0x150 (16)
 [<c011a972>] finish_task_switch+0x42/0x90 (16)
 [<c033bcab>] __schedule+0x2ab/0x620 (24)
 [<c011a5c5>] try_to_wake_up+0x135/0x140 (8)
 [<c0118360>] do_page_fault+0x0/0x588 (56)
 [<c0103b03>] error_code+0x2b/0x30 (8)
 [<c01e3c8e>] memcpy+0x1e/0x40 (44)
 [<e0904e8f>] snd_emu10k1_pcm_init_voice+0x48f/0x550 [snd_emu10k1] (32)
 [<e09052e6>] snd_emu10k1_efx_playback_prepare+0xb6/0xd0 [snd_emu10k1] (72)
 [<e09a8269>] snd_pcm_do_prepare+0x9/0x20 [snd_pcm] (40)
 [<e09a760b>] snd_pcm_action_single+0x2b/0x90 [snd_pcm] (8)
 [<e09a785b>] snd_pcm_action_nonatomic+0x8b/0x90 [snd_pcm] (20)
 [<e09a82f6>] snd_pcm_prepare+0x46/0x60 [snd_pcm] (24)
 [<e09ab810>] snd_pcm_playback_ioctl+0x0/0x20 [snd_pcm] (4)
 [<e09ab15f>] snd_pcm_playback_ioctl1+0x5f/0x3c0 [snd_pcm] (8)
 [<c0155e6a>] do_mmap_pgoff+0x57a/0x790 (40)
 [<e09ab810>] snd_pcm_playback_ioctl+0x0/0x20 [snd_pcm] (20)
 [<c0178a9b>] do_ioctl+0x8b/0xa0 (16)
 [<c0178cde>] vfs_ioctl+0x5e/0x1d0 (28)
 [<c0165709>] fget_light+0x89/0xa0 (8)
 [<c0178ec7>] sys_ioctl+0x77/0x90 (20)
 [<c0103099>] sysenter_past_esp+0x52/0x75 (28)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<e0904aae>] .... snd_emu10k1_pcm_init_voice+0xae/0x550 [snd_emu10k1]
.....[<00000000>] ..   ( <= 0x0)
.. [<c013613d>] .... print_traces+0xd/0x40
.....[<00000000>] ..   ( <= 0x0)




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
