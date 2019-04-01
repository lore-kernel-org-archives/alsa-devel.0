From: Victor L <victor910@gmail.com>
Subject: Re: alsa kernel panic
Date: Mon, 1 Apr 2019 20:27:42 +1000
Message-ID: <CAAz5HLbfn00TXPugh+xg5TLAD4RmuP1tBZ7naF2gg8bnxMLD9Q@mail.gmail.com>
References: <CAAz5HLaSWhF1NobrufjwiLrWv3jO6w+8XGZvt1f6cB8sNKSSvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D714BF8075C
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 12:27:55 +0200 (CEST)
Received: by mail-ot1-x343.google.com with SMTP id m10so8155503otp.2
 for <alsa-devel@alsa-project.org>; Mon, 01 Apr 2019 03:27:55 -0700 (PDT)
In-Reply-To: <CAAz5HLaSWhF1NobrufjwiLrWv3jO6w+8XGZvt1f6cB8sNKSSvQ@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

I have additional information, I wanna informed you.
Probably I found what is generate this bug.
Kernel panic does not happen and the sound is working with this
setting on the device.

AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000


But if, I change bmAttributes to MaxPacketsOnly this make kernel panic:

AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x80
            MaxPacketsOnly
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000

On Mon, 1 Apr 2019 at 12:41, Victor L <victor910@gmail.com> wrote:
>
> Hi ,
>
> I have Linux panic when started play music with one of my USB audio device.
> first please see this logs:
>
> [   71.684730] usbcore: registered new interface driver snd-usb-audio
> [   73.835355] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000008
> [   73.835412] IP: [<ffffffffc0b45d3c>]
> snd_usb_endpoint_start+0x23c/0x2f0 [snd_usb_audio]
> [   73.835414] PGD 0
> [   73.835415]
> [   73.835418] Oops: 0000 [#1] PREEMPT SMP
> [   73.835482] Modules linked in: snd_usb_audio snd_usbmidi_lib
> snd_hwdep snd_pcm_oss snd_mixer_oss snd_
> pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device
> snd_timer snd soundcore coretemp
> iwl3945 iwlegacy i915 ehci_pci iTCO_wdt ehci_hcd pcmcia
> iTCO_vendor_support kvm usbcore mac80211 e1000e
> yenta_socket sr_mod pcmcia_rsrc cfg80211 pcmcia_core lpc_ich mfd_core
> drm_kms_helper cdrom rfkill ata_ge
> neric irqbypass ptp pps_core joydev sg pcspkr i2c_i801 drm battery
> i2c_algo_bit ata_piix i2c_smbus usb_c
> ommon shpchp rng_core ac acpi_cpufreq video button nls_utf8 cifs
> sha256_ssse3 cmac md4 des_generic arc4
> dns_resolver fscache sunrpc loop ip_tables x_tables autofs4 ext4 crc16
> jbd2 crc32c_generic fscrypto ecb
> glue_helper lrw gf128mul ablk_helper cryptd aes_x86_64 mbcache sd_mod
> ahci libahci
> [   73.835486]  evdev libata psmouse serio_raw scsi_mod thermal
> [   73.835491] CPU: 1 PID: 1099 Comm: output:oops Not tainted 4.9.144-rt93 #1
> [   73.835492] Hardware name: LENOVO 636962M/636962M, BIOS 7IET38WW
> (1.19 ) 03/22/2011
> [   73.835494] task: ffff8beb97502c40 task.stack: ffffac1901068000
> [   73.835505] RIP: 0010:[<ffffffffc0b45d3c>]  [<ffffffffc0b45d3c>]
> snd_usb_endpoint_start+0x23c/0x2f0 [
> snd_usb_audio]
> [   73.835507] RSP: 0000:ffffac190106bcc0  EFLAGS: 00010246
> [   73.835508] RAX: 00000000ffffffea RBX: ffff8beb96c00000 RCX: 00000000ffffffea
> [   73.835509] RDX: 0000000000000000 RSI: ffffffffc0b5bf98 RDI: ffff8beb99a18000
> [   73.835511] RBP: 0000000000000002 R08: ffffffffc0b5a8d3 R09: 0000000000000000
> [   73.835512] R10: 00000000fffffe00 R11: 0000000000000200 R12: ffff8beb96c80070
> [   73.835513] R13: ffff8beb99a18000 R14: 0000000000000002 R15: 0000000000000000
> [   73.835516] FS:  00007fdfedc66700(0000) GS:ffff8bebbf300000(0000)
> knlGS:0000000000000000
> [   73.835518] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   73.835519] CR2: 0000000000000008 CR3: 00000000b4ab6000 CR4: 0000000000000670
> [   73.835520] Stack:
> [   73.835525]  ffff8bebb8888c18 ffff8beb96c00000 0000000000000000
> 0000000000008002
> [   73.835528]  00007fdfe40197d0 ffffffffc0b4e7cd ffff8bebb8888c18
> ffff8beb974b2400
> [   73.835531]  ffffffffc0b5088a ffff8beb0000ac44 ffff8bebb206d300
> 0000000000000000
> [   73.835531] Call Trace:
> [   73.835545]  [<ffffffffc0b4e7cd>] ? start_endpoints+0x3d/0x150
> [snd_usb_audio]
> [   73.835555]  [<ffffffffc0b5088a>] ? snd_usb_pcm_prepare+0x2ea/0x520
> [snd_usb_audio]
> [   73.835577]  [<ffffffffc0b0c176>] ?
> snd_pcm_sw_params_user+0x56/0x90 [snd_pcm]
> [   73.835584]  [<ffffffffc0b0b2d9>] ? snd_pcm_do_prepare+0x19/0x30 [snd_pcm]
> [   73.835591]  [<ffffffffc0b09ea6>] ? snd_pcm_action_single+0x36/0x80 [snd_pcm]
> [   73.835598]  [<ffffffffc0b0a311>] ?
> snd_pcm_action_nonatomic+0x61/0x70 [snd_pcm]
> [   73.835606]  [<ffffffffc0b0e219>] ?
> snd_pcm_common_ioctl1+0x3a9/0xc60 [snd_pcm]
> [   73.835674]  [<ffffffffc03a73ce>] ? ext4_file_write_iter+0x22e/0x370 [ext4]
> [   73.835682]  [<ffffffffc0b0ecaa>] ?
> snd_pcm_playback_ioctl1+0x1da/0x240 [snd_pcm]
> [   73.835690]  [<ffffffffb9736a38>] ? __seccomp_filter+0x78/0x2a0
> [   73.835698]  [<ffffffffc0b0ed33>] ?
> snd_pcm_playback_ioctl+0x23/0x30 [snd_pcm]
> [   73.835702]  [<ffffffffb982c9c4>] ? do_vfs_ioctl+0xa4/0x620
> [   73.835706]  [<ffffffffb96033b4>] ? syscall_trace_enter+0x144/0x300
> [   73.835709]  [<ffffffffb982cfb4>] ? SyS_ioctl+0x74/0x80
> [   73.835711]  [<ffffffffb9603c56>] ? do_syscall_64+0x76/0x100
> [   73.835717]  [<ffffffffb9c38b4e>] ? entry_SYSCALL_64_after_swapgs+0x58/0xc6
> [   73.835747] Code: c0 d3 a8 b5 c0 83 f8 a6 74 15 83 f8 e0 49 c7 c0
> 8c a8 b5 c0 48 c7 c2 74 a8 b5 c0 4c
>  0f 45 c2 48 8b 13 89 c1 48 c7 c6 98 bf b5 c0 <48> 8b 7a 08 89 ea 48
> 81 c7 98 00 00 00 e8 e2 7b f4 f8 f0
>  80 63
> [   73.835757] RIP  [<ffffffffc0b45d3c>]
> snd_usb_endpoint_start+0x23c/0x2f0 [snd_usb_audio]
> [   73.835758]  RSP <ffffac190106bcc0>
> [   73.835759] CR2: 0000000000000008
>
> I give you more detail, I have Debian Linux 4.9.144-rt93. I tested
> under Debian 4.19 and Ubuntu same panic present.
> Please help me to fix this problem, this device working fine under
> Windows. I believe this problem in Linux audio driver.
> I ready to provide any additional details if needs.
> --
> Regards,
> Viktor L



-- 
Regards,
Viktor L
+6142 554 0881
