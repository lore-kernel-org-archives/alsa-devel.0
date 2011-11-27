From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/5] RFC v2 for snd-usb endpoint
	logic	rework
Date: Sun, 27 Nov 2011 21:32:47 +0100
Message-ID: <4ED29E6F.3010806@ladisch.de>
References: <1321646744-13656-1-git-send-email-zonque@gmail.com>
	<4ED25CE2.4010706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5263110384A
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 21:33:02 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1DDD320CE3
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 15:33:00 -0500 (EST)
In-Reply-To: <4ED25CE2.4010706@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Did anyone find some time to test this, also with 'regular' USB devices?

With an Edirol UA-1A (stereo, 16 bits, 44.1 kHz, adaptive), the first
attempt to start playback fails (no sound), but the program can be
exited:

5:1:1: add audio endpoint 0x1
5:2:1: add audio endpoint 0x82
usbcore: registered new interface driver snd-usb-audio
Creating new playback data endpoint #1
snd_usb_add_endpoint() calling usb_set_interface()
snd_usb_hw_params(): format changed
stop_endpoints(ffff880212680018,0,1)
 -- data ffff880213470000
 -- sync           (null)
is_playback? 1 impf 0, total_packs 24 urb_packs 8
 ep ffff880213470000:: buffer_size 1536 maxsize 192 packets 8
 ep ffff880213470000:: buffer_size 1536 maxsize 192 packets 8
 ep ffff880213470000:: buffer_size 1536 maxsize 192 packets 8
Setting params for ep #1 (type 0, 3 urbs) -> 0
Returning from snd_usb_hw_params() with 0
activate_endpoints(ffff880212680018)
snd_usb_endpoint_activate() calling usb_set_interface(1,1)
Starting data EP @ffff880213470000
snd_usb_endpoint_start(): pipein? 0, impl? 0
Submmiting urb 0/3 (in? 0 buf ffff8800df822000 len 1408) ret (0)
Submmiting urb 1/3 (in? 0 buf ffff8800df823000 len 1412) ret (0)
Submmiting urb 2/3 (in? 0 buf ffff8800df824000 len 1412) ret (0)

=================================
[ INFO: inconsistent lock state ]
3.2.0-rc2+ #319
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
mplayer/1605 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&(&ep->lock)->rlock){?.+...}, at: [<ffffffffa0088558>] prepare_outbound_urb_sizes+0x3f/0x9b [snd_usb_audio]
{HARDIRQ-ON-W} state was registered at:
  [<ffffffff810623e4>] __lock_acquire+0x6eb/0x8f7
  [<ffffffff81062a19>] lock_acquire+0x57/0x6d
  [<ffffffff81471905>] _raw_spin_lock+0x3b/0x4a
  [<ffffffffa0088c38>] snd_usb_endpoint_start+0x8d/0x3c4 [snd_usb_audio]
  [<ffffffffa008f509>] start_endpoints+0x54/0xb9 [snd_usb_audio]
  [<ffffffffa008f6ab>] snd_usb_pcm_prepare+0x13d/0x141 [snd_usb_audio]
  [<ffffffffa0069f84>] snd_pcm_do_prepare+0x16/0x28 [snd_pcm]
  [<ffffffffa0069bb6>] snd_pcm_action_single+0x2e/0x65 [snd_pcm]
  [<ffffffffa006ba88>] snd_pcm_action_nonatomic+0x4a/0x63 [snd_pcm]
  [<ffffffffa006e4cc>] snd_pcm_common_ioctl1+0x419/0xaf3 [snd_pcm]
  [<ffffffffa006f0a9>] snd_pcm_playback_ioctl1+0x25c/0x279 [snd_pcm]
  [<ffffffffa006f727>] snd_pcm_playback_ioctl+0x2a/0x2e [snd_pcm]
  [<ffffffff810d3c92>] do_vfs_ioctl+0x47f/0x4ce
  [<ffffffff810d3d23>] sys_ioctl+0x42/0x65
  [<ffffffff81472abb>] system_call_fastpath+0x16/0x1b
irq event stamp: 109796
hardirqs last  enabled at (109795): [<ffffffff8147238a>] retint_swapgs+0xe/0x13
hardirqs last disabled at (109796): [<ffffffff814722eb>] common_interrupt+0x6b/0x70
softirqs last  enabled at (109792): [<ffffffff8103c46e>] __do_softirq+0x135/0x14b
softirqs last disabled at (109787): [<ffffffff81473fec>] call_softirq+0x1c/0x30

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&ep->lock)->rlock);
  <Interrupt>
    lock(&(&ep->lock)->rlock);

 *** DEADLOCK ***

no locks held by mplayer/1605.

stack backtrace:
Pid: 1605, comm: mplayer Not tainted 3.2.0-rc2+ #319
Call Trace:
 <IRQ>  [<ffffffff810375d4>] ? console_unlock+0x1b2/0x200
 [<ffffffff8105f568>] print_usage_bug+0x296/0x2a7
 [<ffffffff8100c74d>] ? save_stack_trace+0x2a/0x47
 [<ffffffff810603bd>] ? print_irq_inversion_bug+0x1d6/0x1d6
 [<ffffffff8105f86a>] mark_lock+0x2f1/0x528
 [<ffffffff8106236b>] __lock_acquire+0x672/0x8f7
 [<ffffffff81062a19>] lock_acquire+0x57/0x6d
 [<ffffffffa0088558>] ? prepare_outbound_urb_sizes+0x3f/0x9b [snd_usb_audio]
 [<ffffffff81471a08>] _raw_spin_lock_irqsave+0x46/0x58
 [<ffffffffa0088558>] ? prepare_outbound_urb_sizes+0x3f/0x9b [snd_usb_audio]
 [<ffffffffa0088558>] prepare_outbound_urb_sizes+0x3f/0x9b [snd_usb_audio]
 [<ffffffffa0089162>] snd_complete_urb+0x1f3/0x209 [snd_usb_audio]
 [<ffffffff8137b1f4>] usb_hcd_giveback_urb+0x8c/0xc0
 [<ffffffffa0000d02>] ehci_urb_done+0xf7/0x10c [ehci_hcd]
 [<ffffffffa0003b58>] ehci_work+0x7e3/0x9c0 [ehci_hcd]
 [<ffffffffa0005abf>] ehci_irq+0x317/0x348 [ehci_hcd]
 [<ffffffff8105fe62>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff81472043>] ? _raw_spin_unlock_irq+0x2b/0x40
 [<ffffffff81041210>] ? run_timer_softirq+0x288/0x29a
 [<ffffffff8106257f>] ? __lock_acquire+0x886/0x8f7
 [<ffffffff810544c5>] ? sched_clock_local+0x1c/0x82
 [<ffffffff8137a746>] usb_hcd_irq+0x2f/0x7a
 [<ffffffff8107bf0d>] handle_irq_event_percpu+0x29/0x124
 [<ffffffff8107c044>] handle_irq_event+0x3c/0x5c
 [<ffffffff8107e6ad>] handle_edge_irq+0xc7/0xec
 [<ffffffff81003633>] handle_irq+0x83/0x8c
 [<ffffffff81002e70>] do_IRQ+0x48/0xaf
 [<ffffffff814722f0>] common_interrupt+0x70/0x70
 <EOI>  [<ffffffff8147238a>] ? retint_swapgs+0xe/0x13
cannot submit urb (err = -27)
cannot submit urb (err = -27)
cannot submit urb (err = -27)
snd_usb_substream_playback_trigger(): cmd 1
START!
snd_usb_substream_playback_trigger(): cmd 0
stop_endpoints(ffff880212680018,0,0)
stop_endpoints(ffff880212680018,0,1)
stop_endpoints(ffff880212680018,0,1)
stop_endpoints(ffff880212680018,1,1)
deactivate_endpoints(ffff880212680018)
snd_usb_endpoint_deactivate() calling usb_set_interface(1,0)


The following attempt succeeds at playing, but when I seek in the file
(stop/prepare/start without hw_params), sound becomes somewhat corrupted
(wrong packet sizes I'd guess), and the computer hangs when I attempt to
exit the program:

Re-using EP 1 in iface 1,1 @ffff880213470000
snd_usb_hw_params(): format changed
stop_endpoints(ffff880212680018,0,1)
 -- data ffff880213470000
 -- sync           (null)
is_playback? 1 impf 0, total_packs 24 urb_packs 8
 ep ffff880213470000:: buffer_size 1536 maxsize 192 packets 8
 ep ffff880213470000:: buffer_size 1536 maxsize 192 packets 8
 ep ffff880213470000:: buffer_size 1536 maxsize 192 packets 8
Setting params for ep #1 (type 0, 3 urbs) -> 0
Returning from snd_usb_hw_params() with 0
activate_endpoints(ffff880212680018)
snd_usb_endpoint_activate() calling usb_set_interface(1,1)
Starting data EP @ffff880213470000
snd_usb_endpoint_start(): pipein? 0, impl? 0
Submmiting urb 0/3 (in? 0 buf ffff8800df85d000 len 1408) ret (0)
Submmiting urb 1/3 (in? 0 buf ffff8800df85e000 len 1412) ret (0)
Submmiting urb 2/3 (in? 0 buf ffff8800df85f000 len 1412) ret (0)
snd_usb_substream_playback_trigger(): cmd 1
START!
[...]
INFO: rcu_sched detected stalls on CPUs/tasks: { 4 5} (detected by 2, t=15002 jiffies)
Pid: 0, comm: kworker/0:1 Not tainted 3.2.0-rc2+ #319
Call Trace:
 <IRQ>  [<ffffffff8108129d>] __rcu_pending+0x228/0x34e
 [<ffffffff8105c293>] ? tick_nohz_handler+0xcc/0xcc
 [<ffffffff8108147e>] rcu_check_callbacks+0xbb/0xed
 [<ffffffff810415c9>] update_process_times+0x3c/0x73
 [<ffffffff8105c300>] tick_sched_timer+0x6d/0x8d
 [<ffffffff810526ad>] __run_hrtimer+0x75/0xd0
 [<ffffffff8105294e>] hrtimer_interrupt+0xdb/0x1b6
 [<ffffffff81027caf>] ? account_system_vtime+0x88/0x96
 [<ffffffff810182a9>] smp_apic_timer_interrupt+0x81/0x94
 [<ffffffff81473570>] apic_timer_interrupt+0x70/0x80
 <EOI>  [<ffffffff8105ba26>] ? tick_broadcast_oneshot_control+0x5f/0x10a
 [<ffffffff8105abd9>] ? clockevents_register_device+0xbb/0x138
 [<ffffffff81008cee>] ? default_idle+0x27/0x43
 [<ffffffff81008cf0>] ? default_idle+0x29/0x43
 [<ffffffff81008cee>] ? default_idle+0x27/0x43
 [<ffffffff81008e55>] amd_e400_idle+0xcd/0xf4
 [<ffffffff81001430>] cpu_idle+0x73/0xb3
 [<ffffffff81469d8b>] start_secondary+0x225/0x227


Regards,
Clemens
