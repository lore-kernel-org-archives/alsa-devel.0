From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: 4.13 regression: get_kctl_0dB_offset doesn't handle all possible callbacks
Date: Sat, 14 Oct 2017 14:31:20 +0900
Message-ID: <20171014053120.8352-1-o-takashi@sakamocchi.jp>
References: <59E14241.8917.637DC9@pageexec.freemail.hu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59E14241.8917.637DC9@pageexec.freemail.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 14 2017 07:46, PaX Team wrote:
> what KERNEXEC on i386 does is that it executes kernel code in its own 0-based
> code segment hence the 'low' code addresses. due to the current logic that
> checks for SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK in get_kctl_0dB_offset, this
> callback address is instead treated as a data pointer (as apparently
> SNDRV_CTL_ELEM_ACCESS_TLV_READ is also set) and since it's not a valid kernel
> address, it causes a GPF under the UDEREF PaX feature (without UDEREF it'd
> have been an oops since such low addresses are not mapped for kernel threads).

There're two ways to use 'struct snd_kcontrol.tlv'; constant array (=.p) an
a handler (= .c). An 'access' flag in each member of
'struct snd_kcontrol.vd' represent which way is used for the member.
Therefore, as long as checking the flag, the 'get_kctl_0dB_offset()' doesn't
handle a pointer to the handler as a pointer to array of TLV container.

> on vanilla kernels all this is a silent read of kernel code bytes that are
> then interpreted as the tlv[] array content, which is probably not what you
> want either.

Yes. Current code include a bug of inappropriate condition statement for the
above. As a result, it allows to handle a pointer to the handler as a
pointer to TLV data. 

> as for fixing this, first the above mentioned assumption should be re-evaluated.
> if it's considered correct then there is some logic bug in my case (i can help
> debug it if you tell me what to do) otherwise the current pattern of
> 
>     if (SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK && callback == snd_hda_mixer_amp_tlv) {
>       call wrapped function underneath snd_hda_mixer_amp_tlv
>     } else if (SNDRV_CTL_ELEM_ACCESS_TLV_READ) {
>       treat unrecognized callback address as data ptr
>     }
> 
> should be changed to
> 
>     if (SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK( {
>       if (callback == snd_hda_mixer_amp_tlv) {
>         call wrapped function underneath snd_hda_mixer_amp_tlv
>       } else if (callback == others) {
>         handle others, WARN/BUG/etc
>       }
>     } else if (SNDRV_CTL_ELEM_ACCESS_TLV_READ) {
>       no longer treat unrecognized callback address as data ptr
>     }

Good enough as a solution. Please test a patch in the end of this message.

> and all other callbacks with userland access should be refactored the same
> way as snd_hda_mixer_amp_tlv was. i'd also suggest that you at least do the
> above suggested if/else pattern change in order to prevent the misuse of
> unexpected callbacks in the future.

This suggestion is better for safety. Do you have some ways to detect the
pattern on current vanilla kernel? Or we should find it by eye-grep?


Thanks

Takashi Sakamoto

======== 8< --------

>From 85896b50aa22bf2f2b5e45456daa16d386602edc Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Sat, 14 Oct 2017 14:08:51 +0900
Subject: [PATCH] ALSA: hda-intel: Fix to handle a pointer to TLV handler
 as a pointer to TLV data

In a design of ALSA control core, an 'access' flag on each entry of
'struct snd_kcontrol.vd' represents the type of 'struct snd_kcontrol.tlv'
for the corresponding element; a pointer to TLV data
(!=SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) or a pointer to handler
(==SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK).

In current implementation of 'get_kctl_0dB_offset()', condition statement
is not proper to distinguish these two cases. As a result, it handles
a pointer to the handler as a pointer to TLV data for some control element
sets. This bug brings invalid references to kernel space. A reporter shows
a sample of backtrace.

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
4
EIP: [<009bbd2d>] init_slave_0dB+0x2d/0xa0 SS:ESP: 0068:eb62bcec

This commit fixes the bug.

Reported-by: PaX Team <pageexec@freemail.hu>
Fixes: 99b5c5bb9a54 ('ALSA: hda - Remove the use of set_fs()')
Cc: <stable@vger.kernel.org> # 4.13+
---
 sound/pci/hda/hda_codec.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3db26c451837..e32a59c42577 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1809,28 +1809,39 @@ static int get_kctl_0dB_offset(struct hda_codec *codec,
 {
 	int _tlv[4];
 	const int *tlv = NULL;
-	int val = -1;
+	int step;
 
-	if ((kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) &&
-	    kctl->tlv.c == snd_hda_mixer_amp_tlv) {
-		get_ctl_amp_tlv(kctl, _tlv);
-		tlv = _tlv;
-	} else if (kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_READ)
-		tlv = kctl->tlv.p;
-	if (tlv && tlv[0] == SNDRV_CTL_TLVT_DB_SCALE) {
-		int step = tlv[3];
-		step &= ~TLV_DB_SCALE_MUTE;
-		if (!step)
+	if (kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+		/* TLV data for DB_SCALE is available for amp element only. */
+		if (kctl->tlv.c != snd_hda_mixer_amp_tlv)
 			return -1;
-		if (*step_to_check && *step_to_check != step) {
-			codec_err(codec, "Mismatching dB step for vmaster slave (%d!=%d)\n",
--				   *step_to_check, step);
+
+		get_ctl_amp_tlv(kctl, _tlv);
+		tlv = (const int *)_tlv;
+	} else {
+		if (!(kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_READ))
 			return -1;
-		}
-		*step_to_check = step;
-		val = -tlv[2] / step;
+
+		tlv = kctl->tlv.p;
 	}
-	return val;
+
+	if (tlv[0] != SNDRV_CTL_TLVT_DB_SCALE)
+		return -1;
+
+	step = tlv[3];
+	step &= ~SNDRV_CTL_TLVD_DB_SCALE_MUTE;
+	if (!step)
+		return -1;
+
+	if (*step_to_check && *step_to_check != step) {
+		codec_err(codec,
+			  "Mismatching dB step for vmaster slave (%d!=%d)\n",
+-			  *step_to_check, step);
+		return -1;
+	}
+
+	*step_to_check = step;
+	return -tlv[2] / step;
 }
 
 /* call kctl->put with the given value(s) */
-- 
2.11.0
