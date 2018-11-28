From: "Chanho Min" <chanho.min@lge.com>
Subject: RE: [PATCH] ALSA: pcm: Fix starvation on down_write_nonblock()
Date: Thu, 29 Nov 2018 08:48:20 +0900
Message-ID: <046401d48774$d7d1e440$8775acc0$@lge.com>
References: <1543210597-6717-1-git-send-email-chanho.min@lge.com>       <s5hin0k6xqy.wl-tiwai@suse.de>  <1aaf01d486ab$8017a5b0$8046f110$@lge.com> <s5hwoox61ic.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwoox61ic.wl-tiwai@suse.de>
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'Jaroslav Kysela' <perex@perex.cz>, 'Takashi Iwai' <tiwai@kernel.org>, 'Vinod Koul' <vkoul@kernel.org>, 'Daniel Mentz' <danielmentz@google.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 'Seungho Park' <seungho1.park@lge.com>, 'Jongsung Kim' <neidhard.kim@lge.com>, 'Wonmin Jung' <wonmin.jung@lge.com>, 'Jaehyun Kim' <jehn.kim@lge.com>, 'Hyonwoo Park' <hyonwoo.park@lge.com>
List-Id: alsa-devel@alsa-project.org

> > > On Mon, 26 Nov 2018 06:36:37 +0100,
> > > Chanho Min wrote:
> > > >
> > > > Commit 67ec1072b053 ("ALSA: pcm: Fix rwsem deadlock for non-atomic
> > > > PCM
> > > > stream") fixes deadlock for non-atomic PCM stream. But, This patch
> > > causes antother stuck.
> > > > If writer is RT thread and reader is a normal thread, the reader
> > > > thread will be difficult to get scheduled. It may not give chance
> > > > to release readlocks and writer gets stuck for a long time if they
> > > > are
> > > pinned to single cpu.
> > > >
> > > > The deadlock described in the previous commit is because the linux
> > > > rwsem queues like a FIFO. So, we might need non-FIFO writelock,
> > > > not non-
> > > block one.
> > > >
> > > > My suggestion is that the writer gives reader a chance to be
> > > > scheduled by using the minimum msleep() instaed of spinning
> > > > without blocking by writer. Also, The *_nonblock may be changed to
> > > > *_nonfifo appropriately
> > > to this concept.
> > > > In terms of performance, when trylock is failed, this minimum
> > > > periodic msleep will have the same performance as the tick-based
> > > schedule()/wake_up_q().
> > > >
> > > > Suggested-by: Wonmin Jung <wonmin.jung@lge.com>
> > > > Signed-off-by: Chanho Min <chanho.min@lge.com>
> > >
> > > Hrm, converting unconditionally with msleep() looks too drastic.
> >
> > Yes, it looks drastic. But, IMHO, I can't say busy-spin is not non-
> drastic.
> > To fix the root cause, We may need another rwsem that does not work as
> > a FIFO.
> 
> Right, but applying msleep(1) unconditionally is really bad.
> 
> > > I guess you've hit this while not explicitly using the linked PCM
> > > streams, i.e. in the call of snd_pcm_unlink() at close, right?
> > >
> > > Then this can be worked around by checking the link before calling it.
> > > Could you check the patch below?
> >
> > More testing is needed, but it seems to be fixed by your patch.
> > We may not use the linked PCM.
> 
> Then I'm sure that my patch papers over.
Thanks, Plz let me know when the patch is merged.

> 
> > But, If the linked PCM is enabled,  Can snd_pcm_unlink() be called?
> > This also seems to be a workaround.
> 
> Yes, for the linked streams, something else is needed *in addition*.
> 
> The original fix with busy loop also assumed that this code path (via
> snd_pcm_link() and snd_pcm_unlink()) is the rare occasion, and it didn't
> consider that it were called for regular use cases.  So the fix to make
> things just works for regular use cases without any artifact must be
> implemented in the first place.  The fix for the linked streams comes at
> next.  It might be like your msleep() change as a workaround, but in
> anyway it's far less urgency.

msleep is worst, but If it is harmless, can I apply my patch to the private
tree
temporarily until your next fix comes?
We may use the linked streams in the near future. It makes our product
unstable.
It's urgency for us. How is your opinion?

Thanks
Chanho
