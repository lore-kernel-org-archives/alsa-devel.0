From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: firewire: process packets in
 'struct snd_pcm_ops.ack' callback
Date: Tue, 13 Jun 2017 07:49:37 +0900
Message-ID: <670e0d81-5f91-4b2a-1d07-3376f33abfb2@sakamocchi.jp>
References: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
 <20170607003806.27196-2-o-takashi@sakamocchi.jp>
 <s5hd1ag5oef.wl-tiwai@suse.de> <s5hvao7337g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 528A4266AF1
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 00:49:47 +0200 (CEST)
In-Reply-To: <s5hvao7337g.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, clemens@ladisch.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, ffado-devel@lists.sf.net, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 8 2017 06:20, Takashi Iwai wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: pcm: Suppress status/control mmap when ack ops is
>   present
> 
> The drivers using PCM ack ops require the notification whenever
> appl_ptr is updated in general.  But when the PCM status/control page
> is mmapped, this notification doesn't happen, per design, thus it's
> not guaranteed to receive the fine-grained updates.
> 
> For improving the situation, this patch simply suppresses the PCM
> status/control mmap when ack ops is defined.  At least, for all
> existing drivers with ack, this should give more benefit.
> 
> Once when we really need the full optimization with status/control
> mmap even using ack ops, we may reconsider the check, e.g. introducing
> a new flag.  But, so far, this should be good enough.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_native.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 2bde07a4a87f..b993b0420411 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3189,6 +3189,10 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
>   			       struct vm_area_struct *area)
>   {
>   	long size;
> +
> +	/* suppress status/control mmap when driver requires ack */
> +	if (substream->ops->ack)
> +		return -ENXIO;
>   	if (!(area->vm_flags & VM_READ))
>   		return -EINVAL;
>   	size = area->vm_end - area->vm_start;
> @@ -3225,6 +3229,10 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
>   				struct vm_area_struct *area)
>   {
>   	long size;
> +
> +	/* suppress status/control mmap when driver requires ack */
> +	if (substream->ops->ack)
> +		return -ENXIO;
>   	if (!(area->vm_flags & VM_READ))
>   		return -EINVAL;
>   	size = area->vm_end - area->vm_start;

Let me evaluate this patch in a point of overhead at kernel/userspace 
interaction.

When considering about shape of ALSA PCM applications, I can show it by
below simple pseudo code:

```
while:
   poll(2)
   calculate how many PCM frames are available.
   memcpy(2)
```

To satisfy requirements of some drivers, we need to find a way to take
userspace applications to commit the number of handled PCM frames to
kernel space after the memcpy(2). For this purpose, in ALSA PCM
interface, SNDRV_PCM_IOCTL_SYNC_PTR is available.

```
while:
   poll(2)
   calculate how many PCM frames are available.
   memcpy(2)
   ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR
```

Well, as an actual solution, this patch disallows userspace applications
to map page frame for the status/control data of PCM substream, because
alsa-lib has fallback mode for this case to utilize
SNDRV_PCM_IOCTL_SYNC_PTR. This is a similar situation to ARM platform.
As I described in a commit fccf53881e9b ("ALSA: pcm: add 'applptr' event
of tracepoint"), ALSA PCM core doesn't perform page frame mapping for
the status/control data[1].

In the commit message, I compared tracing data of tracepoints and log of
strace. In the case, the number of calls for ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR in a loop with a call of poll(2) is seven. One
of the sevel calls is actually used to commit the number of PCM frames.
There's 6 extra system calls. These 6 calls are just used to check
current status of runtime of PCM substream, and on cache coherent
architecture, they can be suppressed by the page frame mapping. The poll
loop repeats during runtime, thus it's important to analyze overhead of
the extra system calls.

I suggest 3 points to evaluate this patch.

1. CPU time for the system call
2. disabling kernel preemption and local IRQ
3. backward compatibility

Here, I describe my opinion to this patch for each of these points.

1. CPU time for the system call
System calls cost expensive than usual API calls. As long as
investigated on x86_64 architecture on perf-stat, additional 6 call of
ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR increases 5,000-15,000
instructions in program execution. Recent hardware is enough fast. It
might not be so large disadvantage.

However, when drivers implement 'struct snd_pcm_ops.ack' callback, I
have different opinion; it's too frequent. In either drivers with
indirect layer and packet-oriented drivers, the callback is used to
process PCM frames in intermediate buffer for userspace. The frequent
call of the callback is not enough effective because the applications is
programmed with a manner to be accurate for actual time somehow, thus
they don't process more PCM frames in one poll loop.

2. disabling kernel preemption and local IRQ
In kernel land, service routine for SNDRV_PCM_IOCTL_SYNC_PTR partly runs
with acquired PCM stream lock, which disables kernel preemption and
local IRQ usually for running CPU. This lock is required because the PCM
stream is handled in any handler for hardware events, but this situation
can reduce realtime performance because no process or service routine for
interrupt can't use the CPU. If we have the other options, it's worth to
reconsider.

Intel SST-based drivers use nonatomic flag for the lock. In this case,
kernel preemption is enabled but IRQ is disabled. I think Intel
developers work is for their embedded solution. The care of realtime
performance might be good for their work, too.

3. backward compatibility
For backward compatibility, this patch is a simple solution. Even if
patched kernel runs with old version of relevant stuffs, tinyalsa or
alsa-lib, things work well as expected.

However, without this patch, things still work well. In either drivers
with indirect layer or packet-oriented drivers, queued PCM frames are
transferred according to any hardware events. For such drivers, commit
notification from applications just expands their probability to
improve performance; e.g. latency between queueing and transmission.

I think it better to back to your initial direction; adding info flag,
let stuffs in userspace parse it, perform the commit for the number of
handled PCM frames in 'snd_pcm_hw_mmap_commit()'.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=fccf53881e9b564321326f62ed5f85130fa6e569


Regards

Takashi Sakamoto
