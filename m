From: The Source <thesourcehim@gmail.com>
Subject: Re: snd-ctxfi
Date: Sat, 30 May 2009 20:22:46 +0400
Message-ID: <4A215D56.7080601@gmail.com>
References: <4A20A683.9010102@gmail.com> <s5hr5y7hy77.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C10924854
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 18:23:02 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so199546fge.21
	for <alsa-devel@alsa-project.org>; Sat, 30 May 2009 09:23:01 -0700 (PDT)
In-Reply-To: <s5hr5y7hy77.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30.05.2009 11:00, Takashi Iwai wrote:
> At Sat, 30 May 2009 07:22:43 +0400,
> The Source wrote:
>    
>> Hello. I tested the snd-ctxfi driver and found no problems (except no
>> support for 5.1 and external console, but original ctxfi does not
>> support them either). A minor problem: kernel oops reporter periodically
>> pops up with message about using a timer in a wrong place.
>>      
> Oh, that's bad.
>
>    
>> I'll post
>> here this message when I get it next time.
>>      
> Yes, please, that'll be helpful.
>
>
> thanks,
>
> Takashi
>
>    
Here's the message:

BUG: sleeping function called from invalid context at mm/slub.c:1599
in_atomic(): 0, irqs_disabled(): 1, pid: 32065, name: xine
Pid: 32065, comm: xine Tainted: P           2.6.29.4-75.fc10.x86_64 #1
Call Trace:
  [<ffffffff81040685>] __might_sleep+0x105/0x10a
  [<ffffffff810c9fae>] kmem_cache_alloc+0x32/0xe2
  [<ffffffffa08e3110>] ct_vm_map+0xfa/0x19e [snd_ctxfi]
  [<ffffffffa08e1a07>] ct_map_audio_buffer+0x4c/0x76 [snd_ctxfi]
  [<ffffffffa08e2aa5>] atc_pcm_playback_prepare+0x1d7/0x2a8 [snd_ctxfi]
  [<ffffffff8105ef3f>] ? up_read+0x9/0xb
  [<ffffffff81186b61>] ? __up_read+0x7c/0x87
  [<ffffffffa08e36a6>] ct_pcm_playback_prepare+0x39/0x60 [snd_ctxfi]
  [<ffffffffa0886bcb>] snd_pcm_do_prepare+0x16/0x28 [snd_pcm]
  [<ffffffffa08867c7>] snd_pcm_action_single+0x2d/0x5b [snd_pcm]
  [<ffffffffa08881f3>] snd_pcm_action_nonatomic+0x52/0x6a [snd_pcm]
  [<ffffffffa088a723>] snd_pcm_common_ioctl1+0x404/0xc79 [snd_pcm]
  [<ffffffff810c52c8>] ? alloc_pages_current+0xb9/0xc2
  [<ffffffff810c9402>] ? new_slab+0x1a5/0x1cb
  [<ffffffff810ab9ea>] ? vma_prio_tree_insert+0x23/0xc1
  [<ffffffffa088b411>] snd_pcm_playback_ioctl1+0x213/0x230 [snd_pcm]
  [<ffffffff810b6c20>] ? mmap_region+0x397/0x4c9
  [<ffffffffa088bd9b>] snd_pcm_playback_ioctl+0x2e/0x36 [snd_pcm]
  [<ffffffff810ddc64>] vfs_ioctl+0x2a/0x78
  [<ffffffff810de130>] do_vfs_ioctl+0x462/0x4a2
  [<ffffffff81029cef>] ? default_spin_lock_flags+0x9/0xe
  [<ffffffff81374647>] ? trace_hardirqs_off_thunk+0x3a/0x6c
  [<ffffffff810de1c5>] sys_ioctl+0x55/0x77
  [<ffffffff8101133a>] system_call_fastpath+0x16/0x1b
