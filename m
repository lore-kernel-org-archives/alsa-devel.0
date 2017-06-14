From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: firewire: process packets in
 'struct snd_pcm_ops.ack' callback
Date: Wed, 14 Jun 2017 23:34:32 +0900
Message-ID: <d76f910b-45e7-cf6c-96c7-25ade0cd0257@sakamocchi.jp>
References: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
 <20170607003806.27196-2-o-takashi@sakamocchi.jp>
 <s5hd1ag5oef.wl-tiwai@suse.de> <s5hvao7337g.wl-tiwai@suse.de>
 <670e0d81-5f91-4b2a-1d07-3376f33abfb2@sakamocchi.jp>
 <s5hd1a85c2e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8D4C22671E6
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 16:34:38 +0200 (CEST)
In-Reply-To: <s5hd1a85c2e.wl-tiwai@suse.de>
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

On Jun 13 2017 21:03, Takashi Iwai wrote:
> Thanks for the analysis.  Yes, the cost by the explicit calls is
> known, and it's what was mentioned in the commit log as a further
> optimization.  I bought this cost as good enough for better appl_ptr
> accuracy, but you thought differently on that.
>
> One thing to be noted is that user-space doesn't have to call sync_ptr
> at all, and even no period IRQ is triggered depending on the setup
> (e.g. PA prefers it).  This is the case we want to solve.  That is,
> the situation is worse than you thought -- things don't work as
> expected unless we enforce the sync_ptr notification from user-space.
>
> Then, the question is how to enforce it.  The easiest option is to
> disable status/control mmap.  That's how the patch was developed.
> As an option,
> 1) Selectively disable mmap by a new flag, or
> 2) Selectively disable mmap by the presence of ack callback.
>
> And (2) seems too aggressively applied, from your opinion.
>
> Now you might thing another option:
> 3) Add a new PCM info flag and let alsa-lib behaving differently
>     according to it
>
> But this is no-go, since it doesn't work with the old alsa-lib.
>
> So, IMO, we need to go back to (1), which is my original patch, as a
> start.  It affects only the driver that sets (in this case, it's SKL+
> driver) and it works with the old user-space, at least.
>
> Then we can improve the performance in alsa-lib.  alsa-lib has some
> inefficient implementation regarding the hwptr/appl_ptr update.  In
> may places, it calls hwsync, then do avail_update that again calls
> sync_ptr, for example.  I guess we can halves the amount of sync_ptr
> calls by optimizing that.
>
> Since the sync_ptr is used for all non-x86 architectures (i.e.
> nowadays majority of devices in the market), the optimization is a
> good benefit for all.  Worth to try, in anyway.
>
>
> And yet another obvious optimization would be to allow only the status
> mmap and disallow the control mmap.  Currently, both are paired and
> the control mmap can't fail if the status mmap succeeds.  But, for
> the case like this, we want to suppress only the control mmap.
>
> Unfortunately, changing this behavior requires both alsa-lib and
> kernel codes.  And keeping the behavior compatibility, we'd need to
> introduce something new, e.g. an ioctl to set the compatible protocol
> version from alsa-lib.  For now, alsa-lib inquires the protocol
> version the kernel supports (SNDRV_PCM_IOCTL_PVERSION).  The newly
> required one is the other way round, alsa-lib telling the supported
> protocol version to kernel.  Then the kernel can know whether this
> alsa-lib version accepts the status-only mmap, and gracefully returns
> -ENXIO for the control mmap.

Hm, I have no objections to the changes of both kernel/userspace, but
from different reasons. Therefore I have different solution for this issue.

I recognize this issue as a change of programming model for new design
of devices. (Advantages for drivers for audio and music units on IEEE
1394 bus and the others is its sub-effect, a minor bonus.)

Current ALSA PCM interface is designed based on an idea for data
transmission; hardware is unaware of how many PCM frames are already
queued or dequeued on PCM buffer in system memory. Hardware can transfer
PCM frames to a part of the buffer with un-dequeued PCM frames (at
capture) or from a part of the buffer without enough queued PCM frames
(at playback). This design doesn't require kernel stuffs to maintain the
application-side position on PCM buffer.

If my understanding is correct, Intel's recent hardware can aware of
the application-side pointer and maintain the data transmission,
according to relative position of the application-side and the
hardware-side on the PCM buffer. As Pierre-Louis said, this could
satisfy Intel's convenience; e.g. reduce power comsumption. I guess
that it can decrease frequency to drive hardware for the data
transmission, or do the data transmission as better timing.

This model of data transmission is new in this subsystem. I think it
reasonable to add enough stuffs in both update kernel/userspace and
update version of the interface for this design.

A several years ago, no-period-wakeup programming model was introduced,
and this subsystem got large changes for both kernel/user land. I
believe this issue also has the similar impact. In my taste, in this
case, it's better to give up to keep full backward compatibility, and
renew related stuffs. When working with old userspace stuffs, drivers
run with old mode (namely, run for current interface). The difference
of interface version is absorbed in alsa-lib as much as possible, then
application runs without large changes.


Regards

Takashi Sakamoto
