From: Nicolai Stange <nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB Sound oops in Linus's latest tree
Date: Fri, 18 Mar 2016 23:43:43 +0100
Message-ID: <871t77o19c.fsf@gmail.com>
References: <20160318222625.GA1200@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160318222625.GA1200-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> (Greg KH's message of "Fri, 18
	Mar 2016 15:26:25 -0700")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:

> Hi,
>
> I'm getting the following oops with my USB sound device using Linus's
> latest tree of the moment, which has the sound tree pull in it.  Anyone
> seen this before?

Yes, and a fix is on its way:

  http://lkml.kernel.org/g/1458045306-4170-1-git-send-email-nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Thank you,

Nicolai


>
> [  +0.002298] input: Schiit Audio USB Modi Device as /devices/pci0000:00/0000:00:14.0/usb2/2-10/2-10.1/2-10.1:1.2/0003:0D8C:1319.0001/input/input17
> [  +0.000056] hid-generic 0003:0D8C:1319.0001: input,hidraw0: USB HID v1.00 Device [Schiit Audio USB Modi Device] on usb-0000:00:14.0-10.1/input2
> [  +0.008749] BUG: unable to handle kernel NULL pointer dereference at 0000000000000014
> [  +0.001151] IP: [<ffffffffc0e79921>] usb_audio_probe+0x1e1/0x8f0 [snd_usb_audio]
> [  +0.001142] PGD 0 
> [  +0.001114] Oops: 0000 [#1] PREEMPT SMP 
> [ +0.001115] Modules linked in: snd_usb_audio(+) hid_generic
> snd_usbmidi_lib usbhid snd_rawmidi snd_seq_device hid media arc4 fuse
> btusb btrtl btbcm btintel bluetooth rt2800usb rt2x00usb rt2800lib
> rt2x00lib mac80211 crc_ccitt cfg80211 rfkill nls_cp437 vfat fat
> iTCO_wdt iTCO_vendor_support mxm_wmi x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
> crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel
> aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd
> psmouse serio_raw pcspkr firewire_ohci firewire_core crc_itu_t
> xhci_pci ehci_pci xhci_hcd ehci_hcd mei_me usbcore mei lpc_ich
> mfd_core usb_common wmi evdev ip_tables x_tables
> [  +0.004079] CPU: 4 PID: 615 Comm: systemd-udevd Not tainted 4.6.0-rc1+ #103
> [  +0.001382] Hardware name:                  /        , BIOS KLZ8711D.86A.0457.2015.0713.1319 07/13/2015
> [  +0.001387] task: ffff880098ec0e00 ti: ffff880251920000 task.ti: ffff880251920000
> [  +0.001417] RIP: 0010:[<ffffffffc0e79921>]  [<ffffffffc0e79921>] usb_audio_probe+0x1e1/0x8f0 [snd_usb_audio]
> [  +0.001414] RSP: 0018:ffff880251923af0  EFLAGS: 00010246
> [  +0.001409] RAX: 0000000000000000 RBX: ffff88024d602000 RCX: 0000000000000000
> [  +0.001404] RDX: ffff880254e0b340 RSI: ffff8802559b99f8 RDI: ffffffff82181030
> [  +0.001413] RBP: ffff880251923b50 R08: 0000000000019d00 R09: ffffffff81385837
> [  +0.001431] R10: ffffea0009461200 R11: ffff880253b3fe72 R12: 0000000000000000
> [  +0.001411] R13: 0000000000000000 R14: 0000000000000001 R15: ffff88025338c212
> [  +0.001436] FS:  00007f7a8db567c0(0000) GS:ffff88025fb00000(0000) knlGS:0000000000000000
> [  +0.001431] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.001445] CR2: 0000000000000014 CR3: 0000000251854000 CR4: 00000000001406e0
> [  +0.001451] Stack:
> [  +0.001433]  ffff880253302e88 ffff88024d602054 ffff88009879d000 ffff880253302e88
> [  +0.001480]  ffff880255f7e000 386430425355d030 ff00393133313a63 ffff8800984f4098
> [  +0.001466]  ffff8800984f4000 ffffffffc0e95728 ffff88009879d030 ffffffffc0e955a0
> [  +0.001497] Call Trace:
> [  +0.001295]  [<ffffffffc0067cfd>] usb_probe_interface+0x1bd/0x300 [usbcore]
> [  +0.001427]  [<ffffffff815987e9>] driver_probe_device+0x249/0x450
> [  +0.001400]  [<ffffffff81598a74>] __driver_attach+0x84/0x90
> [  +0.001398]  [<ffffffff815989f0>] ? driver_probe_device+0x450/0x450
> [  +0.001417]  [<ffffffff815963e4>] bus_for_each_dev+0x64/0xa0
> [  +0.001369]  [<ffffffff81597ede>] driver_attach+0x1e/0x20
> [  +0.001396]  [<ffffffff815979ab>] bus_add_driver+0x1eb/0x280
> [  +0.001365]  [<ffffffff81599390>] driver_register+0x60/0xe0
> [  +0.001369]  [<ffffffffc0066834>] usb_register_driver+0x84/0x140 [usbcore]
> [  +0.001422]  [<ffffffffc0e9d000>] ? 0xffffffffc0e9d000
> [  +0.001370]  [<ffffffffc0e9d01e>] usb_audio_driver_init+0x1e/0x20 [snd_usb_audio]
> [  +0.001472]  [<ffffffff8100211b>] do_one_initcall+0xab/0x1d0
> [  +0.001547]  [<ffffffff8115e732>] do_init_module+0x5f/0x1cd
> [  +0.001469]  [<ffffffff810f9ec8>] load_module+0x1368/0x1510
> [  +0.001542]  [<ffffffff810f75d0>] ? symbol_put_addr+0x50/0x50
> [  +0.001468]  [<ffffffff810fa2a8>] SyS_finit_module+0xc8/0xf0
> [  +0.001451]  [<ffffffff81003c6e>] do_syscall_64+0x5e/0xc0
> [  +0.001538]  [<ffffffff817fb425>] entry_SYSCALL64_slow_path+0x25/0x25
> [ +0.001397] Code: f8 01 00 44 89 e6 48 89 df e8 dc 73 00 00 85 c0 89
> c1 0f 88 99 00 00 00 48 8b 7b 10 e8 c9 0b 80 c0 85 c0 89 c1 0f 88 86
> 00 00 00 <41> 80 7d 14 00 0f 85 90 04 00 00 48 63 03 48 89 1c c5 40 90
> e9
> [  +0.001513] RIP  [<ffffffffc0e79921>] usb_audio_probe+0x1e1/0x8f0 [snd_usb_audio]
> [  +0.001468]  RSP <ffff880251923af0>
> [  +0.001576] CR2: 0000000000000014
> [  +0.010610] ---[ end trace c9cdd61401b8f1d9 ]---
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
