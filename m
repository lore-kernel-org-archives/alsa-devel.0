From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Input/output error while playing a file using aplay
Date: Mon, 25 Jun 2007 17:34:07 +0530
Message-ID: <61445c750706250504k23d02f75y52619c6cd081a5a8@mail.gmail.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<1182754597.9211.1196859135@webmail.messagingengine.com>
	<61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
	<1182769239.15228.1196888507@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FFE91037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 14:04:08 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1193864nzf
	for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2007 05:04:08 -0700 (PDT)
In-Reply-To: <1182769239.15228.1196888507@webmail.messagingengine.com>
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

On 6/25/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Pharaoh . wrote:
> > >The ALSA framework will stop the stream and return the error code EIO
> > >when there was no interrupt for ten seconds, i.e., when
> > >snd_pcm_period_elapsed() was not called.
> >
> > I am getting the interrupts, but why there wont be any interrupt for
> > 10 seconds?
>
> I don't quite understand this sentence.  You do get interrupts?
> And snd_pcm_period_elapsed() is not called?
>
> > I am setting the periods in prepare as periods = runtime->period, so
> > interrupts should at period boundaries.
>
> runtime->periods is the number of periods.  I don't know how your
> hardware works, but I guess it wants to know the period size, i.e.,
> runtime->period_size converted to bytes.
>
>
> Regards,
> Clemens
>


Apologie for being ambiguous...

1. When I posted the question, I was not even getting the DMA
interrupts. The input/output error was present.

2. After modifying the code a little I started getting the DMA
interrupts, but the input/output error still persists. So I am
doubting I might have messed up with the
period size etc.

3. I am assigning s->periods = runtime->period i.e. without converting
them in bytes, in prepare (I have seen some standard omap drivers
doing the same, so I am not converting it to bytes, frames should be
okay, but I will check this in h/w manual) and I take care in trigger
too by updating the s->periods field.

4. Also, s->period is locked appropriately so dont think it is corrupted.

I am attaching the source file, I have attached only 1 file since I
think it is relevant. Will send the log once I get chance to test it
again.
