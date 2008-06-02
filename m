From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: playback write error (DMA or IRQ trouble)
Date: Mon, 2 Jun 2008 15:06:03 +0530
Message-ID: <827ad74d0806020236q44e56903ke806a0eb30d662a3@mail.gmail.com>
References: <827ad74d0806020009l5b666eaex4ce2a2a0a0e42c58@mail.gmail.com>
	<s5h7id8b8bw.wl%tiwai@suse.de>
	<827ad74d0806020056r486cd83ke7bf137f45af71bd@mail.gmail.com>
	<s5h3anwb6q0.wl%tiwai@suse.de>
	<827ad74d0806020203v63f4769dkcac281012f417118@mail.gmail.com>
	<s5htzgc9ok7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FE3F245BE
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 11:36:04 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so246764and.80
	for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2008 02:36:03 -0700 (PDT)
In-Reply-To: <s5htzgc9ok7.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Say if my hardware is such that it shall interrupt only after it has
processed entire sample and not ever period or sample. What will ensure that
i get my next buffer down? Will calling the snd_pcm_period_elapsed in the
interrupt function help?

On Mon, Jun 2, 2008 at 2:54 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 2 Jun 2008 14:33:14 +0530,
> Harsha priya gupta wrote:
> >
> > Quick question
> >
> > From my copy function after I pass the buffer to HW, what would happen if
> i
> > call snd_pcm_period_elapsed.
>
> It's invalid and a misdesign.
>
> I guess you are misunderstanding about when to
> callsnd_pcm_period_elapsed().  snd_pcm_period_elapsed() is called when
> one period of samples on the hardware is *processed*.  It doesn't mean
> that the samples are transferred to the hardware.
>
> Suppose that you have period_size = 48000 (frames) for 48kHz samples.
> Then, the first snd_pcm_period_epased() shall be called just one
> second after starting the PCM stream.  The second call be another one
> second later, and so on.  It doesn't matter how quick the copy to h/w
> is done (via copy callback).
>
>
> Takashi
>
> >
> > On Mon, Jun 2, 2008 at 1:37 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> >     At Mon, 2 Jun 2008 13:26:01 +0530,
> >     Harsha priya gupta wrote:
> >     >
> >     > I implemented the copy function and immediately transfered the user
> block
> >     data
> >     > to the hardware.
> >     >
> >     > Correct me if am wrong;
> >     > .pointer implementation - passes the current buffer pointer. When
> the
> >     .pointer
> >     > function returns the size of the buffer = user buffer size
> logically I
> >     need to
> >     > expect the hardware to send an interrupt because buffer is consumed
> and I
> >     > should call snd_pcm_period_elapsed after that.
> >     >
> >     > what would happen if i call the snd_pcm_period_elapsed from the
> pointer
> >     > function once the buffer is consumed from hardware. Would that be
> right?
> >      This
> >     > is what i am trying to do
> >
> >     The logic is reversed.
> >     The pointer callback is a passive one that does nothing but returning
> >     the current h/w buffer position.  This is called either from
> >     snd_pcm_period_elapsed() or at the PCM status update.
> >
> >     You must call snd_pcm_period_elapsed() somewhere in your driver
> >     *explicitly* at the timing that one period is finished.  Usually,
> this
> >     is done in an IRQ handler the h/w generates at the period
> ("fragment",
> >     "half-buffer", or whatever) boundary.
> >
> >     And note that the valid value from the pointer callback is between 0
> >     and buffer_size-1 as it handles the buffer as a ring-buffer.  The
> >     value buffer_size is invalid.
> >
> >     Takashi
> >
> >     > On Mon, Jun 2, 2008 at 1:02 PM, Takashi Iwai <tiwai@suse.de>
> wrote:
> >     >
> >     >     At Mon, 2 Jun 2008 12:39:31 +0530,
> >     >     Harsha priya gupta wrote:
> >     >     >
> >     >     > Can anyone give me a clue as to when i would get such an
> error?
> >     >
> >     >     ... only if you give more clue what exactly you did.
> >     >
> >     >     In general, it implies that an interrupt isn't issued properly
> at PCM
> >     >     period boundary.
> >     >
> >     >     Takashi
> >     >
> >     > --
> >     > -Harsha
> >     >
> >     >
> >
> > --
> > -Harsha
> >
> >
>



-- 
-Harsha
