From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 00/10] ALSA: usb-audio: fix
 playback/capture concurrent usage
Date: Thu, 22 Aug 2013 21:36:52 +0200
Message-ID: <52166854.2040208@gmail.com>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
 <5215AB8D.8020001@gmail.com> <alpine.LNX.2.00.1308221932490.1343@heraclitus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 21A6A2608E9
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 21:36:56 +0200 (CEST)
Received: by mail-ea0-f179.google.com with SMTP id b10so1095279eae.10
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 12:36:55 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1308221932490.1343@heraclitus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 22.08.2013 19:43, Eldad Zack wrote:
> On Thu, 22 Aug 2013, Daniel Mack wrote:
>> On 21.08.2013 23:37, Eldad Zack wrote:
>>> Hi,
>>>
>>> This patch series attempts to fix a long starting problem with the concurrent
>>> usage of playback and capture on implicit feedback devices.
>>>
>>> Applies against current for-next (HEAD b43dd416be21bc8ad60984e13def032f01aaaa18 ).
>>
>> Thanks a lot for working on this! I'll give that series a test run tonight.
> 
> That's great, thanks!

So, with your patches applied, I'm getting the NULL pointer Oops below
just by plugging in a UAC2 sound card.

Note that on this system, pulseaudio is running and grabs the new card
immediately, then closes it again. That might be different on your machine.

Do you want me to dig deeper or do you have an idea already?


Best regards,
Daniel


(sorry for the broken formatting):

Aug 23 03:32:46 glossy kernel: [  511.728348] BUG: unable to handle
kernel NULL pointer dereference at 00000018
Aug 23 03:32:46 glossy kernel: [  511.728559] IP: [<f90631a2>]
snd_usb_pcm_close.isra.13+0x42/0x70 [snd_usb_audio]
Aug 23 03:32:46 glossy kernel: [  511.728773] *pde = 00000000
Aug 23 03:32:46 glossy kernel: [  511.728859] Oops: 0002 [#1] SMP
Aug 23 03:32:46 glossy kernel: [  511.728959] Modules linked in:
snd_usb_audio snd_usbmidi_lib arc4 brcmsmac mac80211 bcma brcmutil
cfg80211 cordic rfcomm bnep parport_pc ppdev snd_hda_codec_realtek
snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq_midi snd_rawmidi
snd_seq_midi_event snd_seq snd_timer joydev snd_seq_device btusb
bluetooth snd i915 soundcore snd_page_alloc samsung_laptop psmouse
mac_hid serio_raw drm_kms_helper drm i2c_algo_bit video binfmt_misc lp
parport sky2
Aug 23 03:32:46 glossy kernel: [  511.730307] CPU: 1 PID: 1673 Comm:
pulseaudio Tainted: G        W    3.11.0-rc5-custom+ #22
Aug 23 03:32:46 glossy kernel: [  511.730510] Hardware name: SAMSUNG
ELECTRONICS CO., LTD. N150P/N210P/N220P          /N150P/N210P/N220P
     , BIOS 01KY.M008.20100430.RHU 04/30/2010
Aug 23 03:32:46 glossy kernel: [  511.730844] task: f50772c0 ti:
f4d92000 task.ti: f4d92000
Aug 23 03:32:46 glossy kernel: [  511.730980] EIP: 0060:[<f90631a2>]
EFLAGS: 00010286 CPU: 1
Aug 23 03:32:46 glossy kernel: [  511.731134] EIP is at
snd_usb_pcm_close.isra.13+0x42/0x70 [snd_usb_audio]
Aug 23 03:32:46 glossy kernel: [  511.731307] EAX: 00000000 EBX:
f6b64e10 ECX: f9061fc0 EDX: ffffffff
Aug 23 03:32:46 glossy kernel: [  511.731461] ESI: f6b64e00 EDI:
d97a0540 EBP: f4d93f18 ESP: f4d93f10
Aug 23 03:32:46 glossy kernel: [  511.731619]  DS: 007b ES: 007b FS:
00d8 GS: 00e0 SS: 0068
Aug 23 03:32:46 glossy kernel: [  511.731760] CR0: 80050033 CR2:
00000018 CR3: 34fc4000 CR4: 000007d0
Aug 23 03:32:46 glossy kernel: [  511.731918] Stack:
Aug 23 03:32:46 glossy kernel: [  511.731977]  ecf13e00 ecf13e00
f4d93f20 f9063202 f4d93f30 f8426fcc f6b64800 ecf13e00
Aug 23 03:32:46 glossy kernel: [  511.732025]  f4d93f50 f842705b
00000000 d9623d50 f6b648e8 d97a0540 00000008 f4f1f7a4
Aug 23 03:32:46 glossy kernel: [  511.732025]  f4d93f80 c11463b6
00000001 00000000 00000000 d97a0548 f60c8d90 d43b3900
Aug 23 03:32:46 glossy kernel: [  511.732025] Call Trace:
Aug 23 03:32:46 glossy kernel: [  511.732025]  [<f9063202>]
snd_usb_playback_close+0x12/0x20 [snd_usb_audio]
Aug 23 03:32:46 glossy kernel: [  511.732025]  [<f8426fcc>]
snd_pcm_release_substream+0x5c/0xb0 [snd_pcm]
Aug 23 03:32:46 glossy kernel: [  511.732025]  [<f842705b>]
snd_pcm_release+0x3b/0xa0 [snd_pcm]
Aug 23 03:32:46 glossy kernel: [  511.732025]  [<c11463b6>]
__fput+0xc6/0x1f0
Aug 23 03:32:46 glossy kernel: [  511.732025]  [<c114651d>]
____fput+0xd/0x10
Aug 23 03:32:46 glossy kernel: [  511.732025]  [<c1059fa1>]
task_work_run+0x81/0xa0
Aug 23 03:32:46 glossy kernel: [  511.732025]  [<c1002189>]
do_notify_resume+0x49/0x70
Aug 23 03:32:46 glossy kernel: [  511.732025]  [<c159b113>]
work_notifysig+0x24/0x29
