From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2][RFC] ALSA: firewire-lib: change packet
 processing timing in process context
Date: Thu, 13 Sep 2018 18:31:34 +0900
Message-ID: <8409a8cb-29a8-d390-3206-ef77f76d527d@sakamocchi.jp>
References: <20180912150450.16334-1-o-takashi@sakamocchi.jp>
 <s5hk1nq4dkp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C8692676EB
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 11:31:38 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id g2-v6so2353937plo.2
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 02:31:38 -0700 (PDT)
In-Reply-To: <s5hk1nq4dkp.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 13 2018 06:21, Takashi Iwai wrote:
> On Wed, 12 Sep 2018 17:04:48 +0200,
> Takashi Sakamoto wrote:
>>
>> In IEC 61883-1/6 engine in ALSA firewire stack, a work to process packet
>> is done in three places:
>> 1. bottom-half of handler for interrupts scheduled on 1394OHCI controller
>> 2. a callback of struct 'snd_pcm_ops.pointer()'
>> 3. a callback of struct 'snd_pcm_ops.ack()'
>>
>> This patchset adds optimization for 3., and remove 2. for efficiency.
>>
>>
>> In Linux kernel v2.6.39, 1. and 2. was committed in initial implementation
>> of this engine at a commit 31ef9134eb52('ALSA: add LaCie FireWire
>> Speakers/Griffin FireWave Surround driver'). This engine schedules hardware
>> interrupts 16 packets (=INTERRUPT_INTERVAL) thus 1. appears in software IRQ
>> context every 2 msec (= 16packets * 1sec / 8,000cycle).
>>
>> In Linux kernel v3.5, an idea of 2. was introduced at a commit
>> e9148dddc3c7('ALSA: firewire-lib: flush completed packets when reading
>> PCM position') to reduce timing gap between queueing/dequeueing PCM
>> frames and scheduling packet transmission. Additionally, it has an
>> effect to reduce load of the software IRQ context. It's done in a call
>> of ioctl(2) with SNDRV_PCM_IOCTL_HWSYNC. As a result, in mmap programming
>> scenario, a call of snd_pcm_hwsync() can process packets for recent
>> isochronous cycle.
>>
>> while (1):
>>    snd_pcm_hwsync()
>>      ->ioctl(HWSYNC)
>>        ->struct snd_pcm_ops.pointer()
>>        = amdtp_stream_pcm_pointer()
>>          ->fw_iso_context_flush_completions()
>>    snd_pcm_mmap_begin()
>>    (queue/dequeue PCM frames here.)
>>    snd_pcm_mmap_commit()
>>
>> In Linux kernel v4.13, ALSA PCM core was improved in an aspect of
>> updating appl_ptr at a commit 9027c4639ef1('ALSA: pcm: Call ack()
>> whenever appl_ptr is updated'). This commit ensures callback of
>> 'struct snd_pcm_ops.ack()' when updating appl_ptr. This callback
>> can be done in below ioctl(2) requests:
>>   - SNDRV_PCM_IOCTL_REWIND
>>   - SNDRV_PCM_IOCTL_FORWARD
>>   - SNDRV_PCM_IOCTL_SYNC_PTR
>>   - SNDRV_PCM_IOCTL_READ[I|N]_FRAMES
>>   - SNDRV_PCM_IOCTL_WRITE[I|N]_FRAMES
>>
>> As I notes in a commit 875becf8412c('ALSA: firewire: process packets
>> in 'struct snd_pcm_ops.ack' callback'), 3. works less efficiently because
>> in usual PCM operation the above ioctl(2) requests are not used in event
>> loop.
>>
>> At the same time of the appl_ptr improvement, a new flag of PCM
>> hardware definition was added at a commit 42f945970af9('ALSA: pcm: Add
>> the explicit appl_ptr sync support'), and relevant changes were added
>> to ALSA PCM core and alsa-lib v1.1.5. This flag expects userspace to
>> call ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR request per iteration of PCM
>> frame queueing/dequeueing in mmap programming scenario below:
>>
>> while (1):
>>    snd_pcm_hwsync()
>>      ->ioctl(HWSYNC)
>>        ->struct snd_pcm_ops.pointer()
>>        = amdtp_stream_pcm_pointer()
>>          ->fw_iso_context_flush_completions()
>>    snd_pcm_mmap_begin()
>>    (queue/dequeue PCM frames here.)
>>    snd_pcm_mmap_commit()
>>      ->ioctl(SYNC_PTR)
>>
>> This patchset aims to support the new flag, SNDRV_PCM_INFO_SYNC_APPLPTR,
>> to tell userspace to call ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR after
>> queueing/dequeueing PCM frames in each iteration of event dispatcher. As
>> a result:
>>
>> while (1):
>>    snd_pcm_hwsync()
>>      ->ioctl(HWSYNC)
>>        ->struct snd_pcm_ops.pointer()
>>        = amdtp_stream_pcm_pointer()
>>          ->fw_iso_context_flush_completions()
>>    snd_pcm_mmap_begin()
>>    (queue/dequeue PCM frames here.)
>>    snd_pcm_mmap_commit()
>>      ->ioctl(SYNC_PTR)
>>        ->struct snd_pcm_ops.ack()
>>        = amdtp_stream_pcm_ack()
>>          ->fw_iso_context_flush_completions()
>>
>> This patchset also adds optimization for timing to process packets in
>> process context. As the above call graph shows, support of the flag brings
>> closest two calls to process packet against intervals of isochronous cycle
>> and it is not enough efficient. This patchset also cancel packet processing
>> in .pointer() callback. As a result:
>>
>> while (1):
>>    snd_pcm_hwsync()
>>    snd_pcm_mmap_begin()
>>    (queue/dequeue PCM frames here.)
>>    snd_pcm_mmap_commit()
>>      ->ioctl(SYNC_PTR)
>>        ->struct snd_pcm_ops.ack()
>>        = amdtp_stream_pcm_ack()
>>          ->fw_iso_context_flush_completions()
>>
>> Takashi Sakamoto (2):
>>    ALSA: firewire-lib: adopt SYNC_APPLPTR flag to flush packets after
>>      queueing/dequeueing PCM frames
>>    ALSA: firewire-lib: cancel processing packets in struct
>>      snd_pcm_ops.pointer() call
> 
> Both look like a good improvement.  Looking forward to seeing the
> official patches once after tests by others pass.

Thanks for your positive feedback.

To ease the others to test this patchset, I prepare for a remote branch
in github.com.
https://github.com/takaswie/snd-firewire-improve/tree/topic/applptr

 From the branch, whole codes relevant to ALSA firewire stack can be
backported to Linux kernel v4.17 or later.

This patchset allows userspace applications to queue isochronous packet
with PCM frames without waiting for software IRQ of 1394 OHCI
controller. In this development cycle I have a plan to allow
applications to have a smaller PCM intermediate buffer than current one
(=period-time greater than 5msec). Users look it as 'improvement in a
point of latency', if things go well.


Thanks

Takashi Sakamoto
