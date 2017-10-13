From: "PaX Team" <pageexec@freemail.hu>
Subject: 4.13 regression: get_kctl_0dB_offset doesn't handle all possible callbacks
Date: Sat, 14 Oct 2017 00:46:25 +0200
Message-ID: <59E14241.8917.637DC9@pageexec.freemail.hu>
Reply-To: pageexec@freemail.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

hello devs,

upstream commit 99b5c5bb9a5435a5ae5d46445ac0f2bf6aa5ee52 removed the use
of set_fs in get_kctl_0dB_offset under the assumption that the only runtime
value of kctl->tlv.c was snd_hda_mixer_amp_tlv. alas, recently, the KERNEXEC
and UDEREF features in PaX reported a violation of this assumption as it
turns out that _snd_ctl_add_slave sets this callback to slave_tlv_cmd instead.

it seems to me that there're several other possible values for this callback
so it's not clear why it was assumed that get_kctl_0dB_offset would only be
called with only one of them in practice, but nevertheless, it happens here
so clearly something is wrong. the backtrace that shows how things go wrong
in this case:

 PAX: suspicious general protection fault: 0000 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 4 PID: 31 Comm: kworker/4:0 Not tainted 4.13.5-i386-pax #17
 Workqueue: events azx_probe_work
 task: eb61c880 task.stack: eb62a000
 EIP: 0060:[<009bbd2d>] init_slave_0dB+0x2d/0xa0
 EFLAGS: 00210202 CPU: 4
 EAX: 00991fd0 EBX: e9883a80 ECX: e9883a80 EDX: eb62bd74
 ESI: eb62bd74 EDI: e9098800 EBP: eb62bd08 ESP: eb62bcec
  DS: 0068 ES: 0068 FS: 00d8 GS: 0068 SS: 0068
 CR0: 80050033 CR2: 00000000 CR3: 03b2d100 CR4: 000406f0 shadow CR4: 000406f0
 Call Trace:
  [<009bb469>] map_slaves+0xb9/0xe0
  [<009bce0e>] __snd_hda_add_vmaster+0xde/0x110
  [<009c82f0>] snd_hda_gen_build_controls+0x1a0/0x1b0
  [<009d0a4d>] cx_auto_build_controls+0xd/0x70
  [<009bdf76>] snd_hda_codec_build_controls+0x186/0x1d0
  [<009b92ad>] hda_codec_driver_probe+0x6d/0xf0
  [<006a3be9>] driver_probe_device+0x289/0x420
  [<006a3ed6>] __device_attach_driver+0x76/0x100
  [<006a1edf>] bus_for_each_drv+0x3f/0x70
  [<006a3813>] __device_attach+0xa3/0x110
  [<006a3f9d>] device_initial_probe+0xd/0x10
  [<006a2d6f>] bus_probe_device+0x6f/0x80
  [<006a100f>] device_add+0x2cf/0x590
  [<009d8d8c>] snd_hdac_device_register+0xc/0x40
  [<009b90b4>] snd_hda_codec_configure+0x34/0x140
  [<009c2875>] azx_codec_configure+0x25/0x50
  [<009d8081>] azx_probe_continue+0x621/0x9e0
  [<009d84bd>] azx_probe_work+0xd/0x10
  [<0006fff2>] process_one_work+0x122/0x2a0
  [<000701a9>] worker_thread+0x39/0x390
  [<00074df2>] kthread+0xe2/0x110
  [<00cee619>] ret_from_fork+0x19/0x30
 Code: e5 57 89 c7 56 89 d6 53 89 cb 83 ec 10 8b 41 6c a9 00 00 00 10 74 09 81 79 58 90 bc 9b 00 74 4e a8 10 74 38 8b 43 58 85 c0 74 31 <83> 38 01 75 2c 8b 48 0c 81 e1 ff ff fe ff 74 21 8b 16 39 d1 
74
 EIP: [<009bbd2d>] init_slave_0dB+0x2d/0xa0 SS:ESP: 0068:eb62bcec

what KERNEXEC on i386 does is that it executes kernel code in its own 0-based
code segment hence the 'low' code addresses. due to the current logic that
checks for SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK in get_kctl_0dB_offset, this
callback address is instead treated as a data pointer (as apparently
SNDRV_CTL_ELEM_ACCESS_TLV_READ is also set) and since it's not a valid kernel
address, it causes a GPF under the UDEREF PaX feature (without UDEREF it'd
have been an oops since such low addresses are not mapped for kernel threads).

on vanilla kernels all this is a silent read of kernel code bytes that are
then interpreted as the tlv[] array content, which is probably not what you
want either.

as for fixing this, first the above mentioned assumption should be re-evaluated.
if it's considered correct then there is some logic bug in my case (i can help
debug it if you tell me what to do) otherwise the current pattern of

   if (SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK && callback == snd_hda_mixer_amp_tlv) {
     call wrapped function underneath snd_hda_mixer_amp_tlv
   } else if (SNDRV_CTL_ELEM_ACCESS_TLV_READ) {
     treat unrecognized callback address as data ptr
   }

should be changed to

   if (SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK( {
     if (callback == snd_hda_mixer_amp_tlv) {
       call wrapped function underneath snd_hda_mixer_amp_tlv
     } else if (callback == others) {
       handle others, WARN/BUG/etc
     }
   } else if (SNDRV_CTL_ELEM_ACCESS_TLV_READ) {
     no longer treat unrecognized callback address as data ptr
   }

and all other callbacks with userland access should be refactored the same
way as snd_hda_mixer_amp_tlv was. i'd also suggest that you at least do the
above suggested if/else pattern change in order to prevent the misuse of
unexpected callbacks in the future.

cheers,
  PaX Team
