From: Dave Young <dyoung@redhat.com>
Subject: [snd-usb-audio] BUG: NULL pointer dereference at 0000000000000070
Date: Sun, 25 Dec 2016 16:50:23 +0800
Message-ID: <20161225085023.GA2729@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

With recent mainline kernel, I see a BUG, it is easy to reproduce,
just plugging the usb microphone, bisected the first bad commit is:
16200948d8353fe29a473a394d7d26790deae0e7 is the first bad commit
commit 16200948d8353fe29a473a394d7d26790deae0e7
Author: Takashi Iwai <tiwai@suse.de>
Date:   Mon Dec 5 11:19:38 2016 +0100

    ALSA: usb-audio: Fix race at stopping the stream

    We've got a kernel crash report showing like:

      Unable to handle kernel NULL pointer dereference at virtual
address 00000008 pgd = a1d7c000

[snip]

The BUG dmesg itself is below:

[54029.102610] input: Samson Technologies Samson Meteor Mic as
/devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3:1.3/0003:17A0:0310.0003/input/input19
[54029.154424] hid-generic 0003:17A0:0310.0003: input: USB HID v1.00
Device [Samson Technologies Samson Meteor Mic] on
usb-0000:00:14.0-3/input3
[54029.202035] usbcore: registered new interface driver snd-usb-audio
[54029.242705] BUG: unable to handle kernel NULL pointer dereference at
0000000000000070
[54029.271667] IP: retire_playback_urb+0x5/0xd0 [snd_usb_audio]
[54029.300462] PGD 0 
[54029.300462] 
[54029.355691] Oops: 0000 [#1] SMP
[54029.383215] Modules linked in: snd_usb_audio snd_usbmidi_lib
snd_rawmidi macvtap macvlan tun ccm rfcomm fuse snd_hda_codec_hdmi cmac
bnep kvm_intel kvm irqbypass i915 arc4 intel_gtt drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops drm snd_hda_codec_realtek
snd_hda_codec_generic iwlmvm mac80211 rtsx_pci_sdmmc iwlwifi
snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core cfg80211 snd_seq
snd_seq_device btusb btrtl thinkpad_acpi btbcm pcspkr input_leds btintel
serio_raw bluetooth snd_pcm e1000e snd_timer ptp rtsx_pci snd i2c_i801
pps_core rfkill mfd_core soundcore video nfsd auth_rpcgss nfs_acl lockd
grace sunrpc
[54029.480514] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
4.9.0+ #209
[54029.514169] Hardware name: LENOVO 20ARS1BJ02/20ARS1BJ02, BIOS
GJET91WW (2.41 ) 09/21/2016
[54029.548395] task: ffff9c2894a18bc0 task.stack: ffffa69dc0cd0000
[54029.582630] RIP: 0010:retire_playback_urb+0x5/0xd0 [snd_usb_audio]
[54029.617049] RSP: 0018:ffff9c289f243cd0 EFLAGS: 00010086
[54029.651439] RAX: ffffffffc031bac0 RBX: ffff9c2868a8a000 RCX:
0000000000000001
[54029.686222] RDX: 0000000000000000 RSI: ffff9c288e3e3a00 RDI:
0000000000000000
[54029.721046] RBP: ffff9c289f243d00 R08: 0000000000000001 R09:
ffff9c289e803b00
[54029.755850] R10: ffff9c28848f3380 R11: ffff9c289038d0b0 R12:
ffff9c2868a8a140
[54029.790482] R13: ffff9c288e3e3a00 R14: 0000000000000000 R15:
ffff9c288e3e0390
[54029.824649] FS:  0000000000000000(0000) GS:ffff9c289f240000(0000)
knlGS:0000000000000000
[54029.859458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[54029.894609] CR2: 0000000000000070 CR3: 000000021e008000 CR4:
00000000001406e0
[54029.929476] Call Trace:
[54029.963968]  <IRQ>
[54029.998291]  ? snd_complete_urb+0x80/0x260 [snd_usb_audio]
[54030.033359]  __usb_hcd_giveback_urb+0x76/0x100
[54030.068352]  usb_hcd_giveback_urb+0x3c/0xc0
[54030.103167]  xhci_giveback_urb_in_irq.isra.23+0x6f/0xa0
[54030.138683]  finish_td.constprop.39+0x175/0x260
[54030.173733]  xhci_irq+0x9f0/0x1450
[54030.208790]  ? try_to_wake_up+0x1f2/0x390
[54030.243696]  ? usb_hcd_poll_rh_status+0x190/0x190
[54030.278521]  xhci_msi_irq+0x11/0x20
[54030.313376]  __handle_irq_event_percpu+0x7e/0x1a0
[54030.348615]  handle_irq_event_percpu+0x32/0x80
[54030.383917]  handle_irq_event+0x2c/0x50
[54030.419012]  handle_edge_irq+0x9f/0x120
[54030.454042]  handle_irq+0x73/0x130
[54030.488522]  ? _local_bh_enable+0x21/0x50
[54030.522777]  do_IRQ+0x46/0xd0
[54030.556882]  common_interrupt+0x90/0x90
[54030.591095] RIP: 0010:cpuidle_enter_state+0x134/0x2a0
[54030.625661] RSP: 0018:ffffa69dc0cd3e60 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff2c
[54030.660438] RAX: 0000000000000000 RBX: 00003123a9d13159 RCX:
000000000000001f
[54030.695705] RDX: 00003123a9d13159 RSI: ffff9c289f254f98 RDI:
0000000000000000
[54030.731113] RBP: ffffa69dc0cd3e98 R08: cccccccccccccccd R09:
0000000000000018
[54030.766539] R10: 000000000000019c R11: 00000000000000a7 R12:
0000000000000004
[54030.802207] R13: 0000000000000004 R14: ffff9c289f25db08 R15:
00003123a9c9b583
[54030.837897]  </IRQ>
[54030.873227]  cpuidle_enter+0x17/0x20
[54030.908827]  call_cpuidle+0x23/0x40
[54030.944343]  do_idle+0x189/0x200
[54030.979754]  cpu_startup_entry+0x71/0x80
[54031.015166]  start_secondary+0x142/0x160
[54031.050630]  start_cpu+0x14/0x14
[54031.085944] Code: e9 03 41 5e 5d f7 f1 89 c0 c3 41 8b 76 64 4c 89 e7
e8 f0 fe ff ff eb c4 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
00 00 <48> 8b 4f 70 31 d2 8b 86 88 00 00 00 f7 b1 98 15 00 00 85 c0 75 
[54031.124608] RIP: retire_playback_urb+0x5/0xd0 [snd_usb_audio] RSP:
ffff9c289f243cd0
[54031.162852] CR2: 0000000000000070
