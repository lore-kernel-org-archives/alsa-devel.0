From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Input/output error while playing a file using aplay
Date: Tue, 26 Jun 2007 16:34:05 +0530
Message-ID: <61445c750706260404o4c2abf51q38e0f8c134e226d5@mail.gmail.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<1182754597.9211.1196859135@webmail.messagingengine.com>
	<61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
	<1182769239.15228.1196888507@webmail.messagingengine.com>
	<61445c750706250504k23d02f75y52619c6cd081a5a8@mail.gmail.com>
	<61445c750706250635i61be8752lbf7a7b1930a8ca79@mail.gmail.com>
	<61445c750706251138r290c2a7br6b911be6da7e53ce@mail.gmail.com>
	<1182842511.3512.1197069785@webmail.messagingengine.com>
	<61445c750706260351v2ef766bbrb8685275a0451cec@mail.gmail.com>
	<61445c750706260355s7421394ase2e89f161e3a11ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A43324445
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2007 13:04:07 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1510129nzf
	for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2007 04:04:06 -0700 (PDT)
In-Reply-To: <61445c750706260355s7421394ase2e89f161e3a11ab@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

static snd_pcm_uframes_t audio_get_dma_pos(struct audio_stream *s)
{
        snd_pcm_substream_t *substream = s->stream;
        snd_pcm_runtime_t *runtime = substream->runtime;
        unsigned long flags;
        dma_addr_t count;
        unsigned long offset;
        dma_addr_t src,dest;

         if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
                spin_lock_irqsave(&s->dma_lock, flags);
                dest = omap_get_dma_dst_pos(s->lch[s->dma_q_head]);
                offset = dest - runtime->dma_addr;
                spin_unlock_irqrestore(&s->dma_lock, flags);
                printk("dest is %u and offset is %u\n",dest,offset);
         } else {
                spin_lock_irqsave(&s->dma_lock, flags);
                src = omap_get_dma_src_pos(s->lch[s->dma_q_head]);
                offset = src - runtime->dma_addr;
                spin_unlock_irqrestore(&s->dma_lock, flags);
                printk("src is %u and offset is %u\n",dest,offset);
         }

        return bytes_to_frames(substream->runtime, offset);
}

and the log is as same....still no joy..

First time

snd_omap_alsa_pointer start
src is 3246792928 and offset is 3296722944
Returning pos = 18874368
Inside snd_pcm_update_hw_ptr_pos, pos is 18874368
ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x1200000,
buffer size = 0x4000, period size = 0x800
returning pos 18874368

.......
.......
Second time

snd_omap_alsa_pointer start
src is 3246792928 and offset is 3296722944
Returning pos = 18874368
Inside snd_pcm_update_hw_ptr_pos, pos is 18874368
ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x1200000,
buffer size = 0x4000, period size = 0x800
returning pos 18874368

......

then it hangs in the omap_request_dma function.

On 6/26/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> wait..wait.....I need to use locking here...let me send you log after
> doing locking appropriately .....
>
> On 6/26/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> > >It would really help if you'd show us the code of the version of the
> > >driver that you're currently talking about.
> >
> > Hi Clemens...
> >
> > I had sent you the source file having pcm callbacks yesterday, now I
> > have modified the pointer function as follows, I am just giving the
> > pointer function here to avoid duplication, but please let me know in
> > case you want to have look at the entire file.
> >
> >
> > static snd_pcm_uframes_t snd_omap_alsa_pointer(snd_pcm_substream_t
> > *substream)
> > {
> >
> >         struct omap_eac *chip = snd_pcm_substream_chip(substream);
> >         snd_pcm_uframes_t pos = 0;
> >
> >         FN_ENTER;
> >         pos = audio_get_dma_pos(&chip->s[substream->pstr->stream]);
> >         printk("Returning pos = %d\n", pos);
> >         return pos;
> >         FN_EXIT;
> > }
> >
> > static snd_pcm_uframes_t audio_get_dma_pos(struct audio_stream *s)
> > {
> >         snd_pcm_substream_t *substream = s->stream;
> >         snd_pcm_runtime_t *runtime = substream->runtime;
> >         unsigned long flags;
> >         dma_addr_t count;
> >         unsigned long offset;
> >         dma_addr_t src,dest;
> >
> >          if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> >                 dest = omap_get_dma_dst_pos(s->lch[s->dma_q_head]);
> >                 offset = dest - runtime->dma_addr;
> >                 printk("dest is %u and offset is %u\n",dest,offset);
> >          } else {
> >                 src = omap_get_dma_src_pos(s->lch[s->dma_q_head]);
> >                 offset = src - runtime->dma_addr;
> >                 printk("src is %u and offset is %u\n",dest,offset);
> >          }
> >
> >         return bytes_to_frames(substream->runtime, offset);
> > }
> >
> >
> > And the log is as follows.
> >
> > For the first time.
> >
> >
> > snd_omap_alsa_pointer start
> > src is 3246792928 and offset is 3304194048
> > Returning pos = 20742144
> > Inside snd_pcm_update_hw_ptr_pos, pos is 20742144
> > ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x13c8000,
> > buffer size = 0x4000, period size = 0x800
> > returning pos 20742144
> >
> > I can see things are horribaly wrong here....
> >
> >
> > On 6/26/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > > Pharaoh . wrote:
> > > > After rewriting the pointer function
> > >
> > > It would really help if you'd show us the code of the version of the
> > > driver that you're currently talking about.
> > >
> > > > I am not getting the input/output error but I am getting underruns.
> > > > ...
> > > > ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x1150000,
> buffer
> > > size = 0x4000, period size = 0x800
> > >
> > > Here, "pos" is the value returned by your pointer callback.  This value
> > > should have been a frame number somewhere in the buffer, i.e., in the
> > > range 0..0x3fff.  Apparently, the pointer callback doesn't correctly
> > > calculate this value.
> > >
> > > Please remove most printk()s, and add some in the pointer callback to
> > > show both the value that you get from the DMA controller, and the value
> > > that this function returns.
> > >
> > >
> > > Regards,
> > > Clemens
> > >
> >
>
