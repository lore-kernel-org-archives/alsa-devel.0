From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/3] ALSA: pcm: conditionally avoid mmap of
	control data
Date: Tue, 16 May 2017 19:55:09 +0900
Message-ID: <72a06723-c071-dc8e-6fc9-a6cac4a87019@sakamocchi.jp>
References: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
 <1494896518-23399-4-git-send-email-subhransu.s.prusty@intel.com>
 <50e717b2-2a88-08d7-7560-e80a7c43540c@sakamocchi.jp>
 <s5hlgpx1hif.wl-tiwai@suse.de>
 <a0f670c6-1ec5-5dbf-06bd-15f67c98bd75@sakamocchi.jp>
 <s5hfug51g0x.wl-tiwai@suse.de>
 <8778c2f1-440e-a622-fd38-6eeac2669f8b@sakamocchi.jp>
 <s5hd1b91f9g.wl-tiwai@suse.de>
 <a263c517-df5b-dd0a-6873-4780f7e95152@sakamocchi.jp>
 <s5h4lwl1dzo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id CCE34266F0D
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 12:55:16 +0200 (CEST)
In-Reply-To: <s5h4lwl1dzo.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On May 16 2017 16:02, Takashi Iwai wrote:
> On Tue, 16 May 2017 08:54:17 +0200,
> Takashi Sakamoto wrote:
>>
>> On May 16 2017 15:34, Takashi Iwai wrote:
>>>>> IIRC, the problem isn't about the forward / rewind but about the
>>>>> normal data transfer.  In mmap mode, we transfer data on the mmap
>>>>> buffer, and update appl_ptr via mmap control.  Both are done without
>>>>> notification to the driver (which is intentional for avoiding the
>>>>> context switching).
>>>>>
>>>>> So we want to disable this optimization and always notify to the
>>>>> driver.  Disabling mmap status/control is the straight hack as it
>>>>> falls back to ioctl and then the driver can know the change.
>>>>
>>>> There's SNDRV_PCM_IOCTL_HW_SYNC command. In kernel land
>>>> implementation, this command is handled with a call of 'struct
>>>> snd_pcm_ops.pointer'.
>>>>
>>>> In alsa-lib, this command is often executed in most cases to handle
>>>> PCM frames.
>>>
>>> The HWSYNC or SYNC_PTR ioctls are used only as the fallback when mmap
>>> failed.  It's the exact goal of this patch :)
>>
>> Although SYNC_PTR is in the fallback mechanism of alsa-lib, HWSYNC is
>> not in.
>>
>> (alsa-lib)
>> ioctl(SNDRV_PCM_IOCTL_HWSYNC)
>> <-snd_pcm_hw_hw_sync()
>> = struct snd_pcm_fast_ops.hwsync
>>   <-__snd_pcm_hw_hwsync()
>>     <-snd_pcm_hwsync()
>>     <-snd_pcm_avail()
>>       <-snd_pcm_read_areas()
>>         <-snd_pcm_mmap_readi()
>>         <-snd_pcm_mmap_readn()
>>     <-snd_pcm_avail_delay()
>>     <-snd_pcm_write_areas()
>>       <-snd_pcm_mmap_writei()
>>       <-snd_pcm_mmap_writen()
>>
>> For a case that applications execute ioctl(2) with
>> SNDRV_PCM_IOCTL_READN/READI/WRITEN/WRITEI, in kernel land
>> snd_pcm_lib_read1()/snd_pcm_lib_write1() should have calls of 'struct
>> snd_pcm_ops.pointer', I think.
>
> It's about the less-optimized code path with snd_pcm_mmap_read/write.
> For the code path calling snd_pcm_mmap_begin() /
> snd_pcm_mmap_commit(), there is no hwsync ioctl call.

Indeed. I recalled it from my memory just after posting the previous 
message. In a case of the fallback, ioctl(2) with SYNC_PTR is surely 
executed:

ioctl(SNDRV_PCM_IOCTL_SYNC_PTR)
<-snd_pcm_hw_hw_mmap_commit)
= struct snd_pcm_fast_ops.mmap_commit()
   <-__snd_pcm_mmap_commit()
     <-snd_pcm_mmap_commit()

Now I agreed with the aim of this patch. In alsa-lib, 0 is passed as a 
'flags' option to ioctl(2) with SYNC_PTR in the call of 
snd_pcm_mmap_commit(). In kernel land, overhead to handle the ioctl is 
lighter than HWSYNC because hwptr is not synchronized.

However, in my opinion, disabling mmap the status and control data is 
exaggerated to the aim. SYNC_PTR ioctl is still available when page 
frame of these data is mapped. I can assume an idea to take alsa-lib to 
execute this command in snd_pcm_mmap_commit() when the NO_REWIND flag is 
enabled. Here, I assume that the flag and SYNC_PTR are tight coupling. 
(but we should concern about backward compatibility of relevant stuffs...)


By the way, at present, I think that this patchset may also be 
convenient to IEC 611883-1/6 engine and drivers in ALSA firewire stack. 
The engine is programmed to execute packetization in both of irq context 
of OHCI1394 isochronous context and process context of HWSYNC, to reduce 
packetization delay for PCM data substream. However, to the process 
context, this design expects applications to call ioctl(2) periodically 
with some commands; e.g. HWSYNC. As Iwai-san said, this ioctl command is 
not executed in snd_pcm_mmap_begin()/snd_pcm_mmap_commit() loop and I 
had concerns about it. (For example, PulseAudio is programmed to execute 
snd_pcm_avail() in the loop, but jackd isn't.) But I forgot it, oops :p


Thanks

Takashi Sakamoto
