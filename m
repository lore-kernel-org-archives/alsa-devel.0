From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Tue, 10 Apr 2012 20:52:18 +0200
Message-ID: <CAFz=ag5SPYk4fycCjK9WR82Rx1oOxWFCwaND+eZhk=KD03DRZQ@mail.gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag7_qzPJq44havp=EbFVKud5VvKaOLJk0i0dM43X3urp9Q@mail.gmail.com>
	<CAFz=ag6pqhfOvxv_ScbxJFs6OEZt18GM+Dgs1KWQMG7mdZO21g@mail.gmail.com>
	<CACckToXJAJxGo-LSM3X-q=6Vo=-KzuE2Om9bgFiDnWPFNWmnSQ@mail.gmail.com>
	<4F8336CA.9060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 29A172479C
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 20:52:19 +0200 (CEST)
Received: by yenl1 with SMTP id l1so97153yen.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2012 11:52:18 -0700 (PDT)
In-Reply-To: <4F8336CA.9060809@gmail.com>
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
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, Grant Diffey <gdiffey@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this time I can get the device to work. It produces clickless playback
at higher latencies. But trying to run JACK @44.1kHz with 128
frames/period (i.e. -p 128) I can reliably reproduce a kernel oops
which either completely freezes my system or at least blocks keyboard
an mouse. Here it is:

 Apr 10 20:25:43 weasel kernel: [  164.243214] usbcore: registered new
interface driver snd-usb-audio
Apr 10 20:27:00 weasel kernel: [  240.453704] BUG: unable to handle
kernel paging request at 00100104
Apr 10 20:27:00 weasel kernel: [  240.457673] IP: [<f90a7409>]
queue_pending_output_urbs+0x89/0x130 [snd_usb_audio]
Apr 10 20:27:00 weasel kernel: [  240.457673] *pde = 00000000
Apr 10 20:27:00 weasel kernel: [  240.457673] Oops: 0002 [#1] SMP
Apr 10 20:27:00 weasel kernel: [  240.457673] Modules linked in:
snd_usb_audio snd_usbmidi_lib snd_seq_dummy rfcomm bnep parport_pc
dm_crypt ppdev binfmt_misc snd_hda_c
odec_hdmi snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep
snd_pcm snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq joydev
coretemp snd_timer snd_seq_devi
ce uvcvideo hid_multitouch videobuf2_core snd microcode videodev
videobuf2_vmalloc videobuf2_memops btusb soundcore bluetooth
snd_page_alloc psmouse serio_raw lp parpor
t usbhid hid atl1c ahci libahci i915 drm_kms_helper drm wmi i2c_algo_bit video
Apr 10 20:27:00 weasel kernel: [  240.457673]
Apr 10 20:27:00 weasel kernel: [  240.457673] Pid: 0, comm: swapper/0
Not tainted 3.4.0-rc2-daniel+ #2 Acer Aspire 1420P/JM12-MS
Apr 10 20:27:00 weasel kernel: [  240.457673] EIP: 0060:[<f90a7409>]
EFLAGS: 00010002 CPU: 0
Apr 10 20:27:00 weasel kernel: [  240.457673] EIP is at
queue_pending_output_urbs+0x89/0x130 [snd_usb_audio]
Apr 10 20:27:00 weasel kernel: [  240.457673] EAX: 00200200 EBX:
edb08000 ECX: edb097ac EDX: edb08028
Apr 10 20:27:00 weasel kernel: [  240.457673] ESI: edb082c0 EDI:
00100100 EBP: f380be64 ESP: f380be3c
Apr 10 20:27:00 weasel kernel: [  240.457673]  DS: 007b ES: 007b FS:
00d8 GS: 00e0 SS: 0068
Apr 10 20:27:00 weasel kernel: [  240.457673] CR0: 8005003b CR2:
00100104 CR3: 018af000 CR4: 000407d0
Apr 10 20:27:00 weasel kernel: [  240.457673] DR0: 00000000 DR1:
00000000 DR2: 00000000 DR3: 00000000
Apr 10 20:27:00 weasel kernel: [  240.457673] DR6: ffff0ff0 DR7: 00000400
Apr 10 20:27:00 weasel kernel: [  240.457673] Process swapper/0 (pid:
0, ti=f380a000 task=c1794020 task.ti=c1788000)
Apr 10 20:27:00 weasel kernel: [  240.457673] Stack:
Apr 10 20:27:00 weasel kernel: [  240.457673]  f380be44 f380be4c
c105dfd2 f380be50 00000096 edb0a9b4 edb0a950 edeb5f08
Apr 10 20:27:00 weasel kernel: [  240.457673]  edb0c2c8 edb097ac
f380be94 f90a86bf edb0c2c8 f7007300 f7007300 edeb5e00
Apr 10 20:27:00 weasel kernel: [  240.457673]  00000092 edb0a9b4
edb08000 edb0c000 edb0c2c8 edeb5e00 f380beb8 f90a882d
Apr 10 20:27:00 weasel kernel: [  240.457673] Call Trace:
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c105dfd2>] ?
resched_task+0x22/0x70
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<f90a86bf>]
snd_usb_handle_sync_urb+0x1ef/0x260 [snd_usb_audio]
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<f90a882d>]
snd_complete_urb+0xfd/0x200 [snd_usb_audio]
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c13dec0d>]
usb_hcd_giveback_urb+0x4d/0xc0
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c1551f6d>] ?
_raw_spin_lock+0xd/0x10
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c13f3571>]
ehci_urb_done+0xc1/0xf0
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c13f4afc>]
ehci_work+0x8ec/0xa10
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c13f4ea1>] ehci_irq+0x221/0x250
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c1080cb3>] ?
tick_do_periodic_broadcast+0x33/0x40
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c13de3b2>]
usb_hcd_irq+0x32/0x50

Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c10ad52c>]
handle_irq_event_percpu+0x4c/0x210
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c155219d>] ?
_raw_spin_lock_irqsave+0x2d/0x40
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c10ad72b>]
handle_irq_event+0x3b/0x60
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c10aff20>] ?
unmask_irq+0x30/0x30
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c10aff6e>]
handle_fasteoi_irq+0x4e/0xd0
Apr 10 20:27:00 weasel kernel: [  240.457673]  <IRQ>
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c1559432>] ? do_IRQ+0x42/0xc0
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c10084f8>] ?
sched_clock+0x8/0x10
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c1062e8b>] ?
sched_clock_local+0xcb/0x1c0
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c1559370>] ?
common_interrupt+0x30/0x38
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c10600d8>] ?
rt_mutex_setprio+0x98/0x200
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c131b5d6>] ?
arch_local_irq_enable+0x5/0xb
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c131c30f>] ?
acpi_idle_enter_bm+0x228/0x268
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c143b785>] ?
cpuidle_enter+0x15/0x20
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c143bd1c>] ?
cpuidle_idle_call+0x9c/0x260
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c100a10a>] ? cpu_idle+0xaa/0xe0
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c152e135>] ?
rest_init+0x5d/0x68
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c17f976c>] ?
start_kernel+0x367/0x36d
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c17f9186>] ? loglevel+0x2b/0x2b
Apr 10 20:27:00 weasel kernel: [  240.457673]  [<c17f9078>] ?
i386_start_kernel+0x78/0x7d
Apr 10 20:27:00 weasel kernel: [  240.457673] Code: 00 83 c0 01 8d 8c
13 28 15 00 00 89 c2 c1 fa 1f c1 ea 1d 01 d0 83 e0 07 29 d0 89 83 48
29 00 00 8b 46 04 8d 96 68 fd ff ff 8b 3e <89> 47 04 89 38 c7 06 00 01
10 00 c7 46 04 00 02 20 00 8b 81 80
Apr 10 20:27:00 weasel kernel: [  240.457673] EIP: [<f90a7409>]
queue_pending_output_urbs+0x89/0x130 [snd_usb_audio] SS:ESP
0068:f380be3c
Apr 10 20:27:00 weasel kernel: [  240.457673] CR2: 0000000000100104


After this messageand only ahter this oops I'm getting lots of ACPI errors:

Apr 10 20:27:06 weasel kernel: [  247.021871] ACPI Exception: AE_TIME,
Returned by Handler for [EmbeddedControl] (20120320/evregion-501)
Apr 10 20:27:06 weasel kernel: [  247.024423] ACPI Error: Method
parse/execution failed [\_SB_.BAT1._BST] (Node f382b2d0), AE_TIME
(20120320/psparse-536)
Apr 10 20:27:06 weasel kernel: [  247.025805] ACPI Exception: AE_TIME,
Evaluating _BST (20120320/battery-455)
Apr 10 20:27:07 weasel kernel: [  248.178058] ACPI Exception: AE_TIME,
Returned by Handler for [EmbeddedControl] (20120320/evregion-501)
Apr 10 20:27:07 weasel kernel: [  248.180657] ACPI Error: Method
parse/execution failed [\_SB_.BAT1._BST] (Node f382b2d0), AE_TIME
(20120320/psparse-536)
Apr 10 20:27:07 weasel kernel: [  248.182039] ACPI Exception: AE_TIME,
Evaluating _BST (20120320/battery-455)


Any ideas?

Regards,

Felix
