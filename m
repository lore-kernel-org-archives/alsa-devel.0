From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/3] ALSA: pcm: conditionally avoid mmap of
	control data
Date: Tue, 16 May 2017 15:54:17 +0900
Message-ID: <a263c517-df5b-dd0a-6873-4780f7e95152@sakamocchi.jp>
References: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
 <1494896518-23399-4-git-send-email-subhransu.s.prusty@intel.com>
 <50e717b2-2a88-08d7-7560-e80a7c43540c@sakamocchi.jp>
 <s5hlgpx1hif.wl-tiwai@suse.de>
 <a0f670c6-1ec5-5dbf-06bd-15f67c98bd75@sakamocchi.jp>
 <s5hfug51g0x.wl-tiwai@suse.de>
 <8778c2f1-440e-a622-fd38-6eeac2669f8b@sakamocchi.jp>
 <s5hd1b91f9g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 042F6267480
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 08:54:19 +0200 (CEST)
In-Reply-To: <s5hd1b91f9g.wl-tiwai@suse.de>
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

On May 16 2017 15:34, Takashi Iwai wrote:
>>> IIRC, the problem isn't about the forward / rewind but about the
>>> normal data transfer.  In mmap mode, we transfer data on the mmap
>>> buffer, and update appl_ptr via mmap control.  Both are done without
>>> notification to the driver (which is intentional for avoiding the
>>> context switching).
>>>
>>> So we want to disable this optimization and always notify to the
>>> driver.  Disabling mmap status/control is the straight hack as it
>>> falls back to ioctl and then the driver can know the change.
>>
>> There's SNDRV_PCM_IOCTL_HW_SYNC command. In kernel land
>> implementation, this command is handled with a call of 'struct
>> snd_pcm_ops.pointer'.
>>
>> In alsa-lib, this command is often executed in most cases to handle
>> PCM frames.
>
> The HWSYNC or SYNC_PTR ioctls are used only as the fallback when mmap
> failed.  It's the exact goal of this patch :)

Although SYNC_PTR is in the fallback mechanism of alsa-lib, HWSYNC is 
not in.

(alsa-lib)
ioctl(SNDRV_PCM_IOCTL_HWSYNC)
<-snd_pcm_hw_hw_sync()
= struct snd_pcm_fast_ops.hwsync
   <-__snd_pcm_hw_hwsync()
     <-snd_pcm_hwsync()
     <-snd_pcm_avail()
       <-snd_pcm_read_areas()
         <-snd_pcm_mmap_readi()
         <-snd_pcm_mmap_readn()
     <-snd_pcm_avail_delay()
     <-snd_pcm_write_areas()
       <-snd_pcm_mmap_writei()
       <-snd_pcm_mmap_writen()

For a case that applications execute ioctl(2) with 
SNDRV_PCM_IOCTL_READN/READI/WRITEN/WRITEI, in kernel land 
snd_pcm_lib_read1()/snd_pcm_lib_write1() should have calls of 'struct 
snd_pcm_ops.pointer', I think.


Regards

Takashi Sakamoto
