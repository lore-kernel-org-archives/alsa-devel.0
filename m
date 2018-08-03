From: Yu-hsuan Hsu <yuhsuan@google.com>
Subject: Re: A question about period
Date: Fri, 3 Aug 2018 18:04:34 +0800
Message-ID: <CAEy1m_Ax7ZvvXF__4Qr_bt0mbAa8Z+8zFuzyQrQSC8PbDBVU-A@mail.gmail.com>
References: <CAEy1m_DhdnfaRQADr4DaurCNnCi0fmCna5tJXEk9dA+KQ8jfcw@mail.gmail.com>
 <s5ha7q3x5wy.wl-tiwai@suse.de>
 <CAEy1m_CgOCi4sUcju7Ydzt+iGHHg+0ZHjc-m2W2QJdKVSaHVCg@mail.gmail.com>
 <s5hlg9nkg2x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CF2D9267763
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 12:04:47 +0200 (CEST)
Received: by mail-oi0-f46.google.com with SMTP id 8-v6so8918502oip.0
 for <alsa-devel@alsa-project.org>; Fri, 03 Aug 2018 03:04:47 -0700 (PDT)
In-Reply-To: <s5hlg9nkg2x.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For example, we can set period_size 32 to one device. But the device
consumes 40 frames each time. Can we said it support period_size 32? I
found many devices have this situation.

On Fri, Aug 3, 2018 at 4:30 PM Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 03 Aug 2018 10:09:30 +0200,
> Yu-hsuan Hsu wrote:
> >
> > Thank for your answer!
> >
> > The other question is if we set period_size to N, but the frames it
> > consumes once is 5N.
>
> Then the assumption is wrong.  How the hardware can issue an IRQ at N
> consumption while it processes for 5N in once?
>
>
> Takashi
>
> > Can it said it supports period_size N? How do we check
> > whether the period_size can be set correctly?
> >
> > On Fri, Aug 3, 2018 at 3:31 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > On Fri, 03 Aug 2018 08:28:37 +0200,
> > > Yu-hsuan Hsu wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I have a question about the period we set in hw_params. I found
> different
> > > > boards may have different explanations about it. I have two guesses
> about
> > > > its meaning.
> > > >
> > > > 1. The period_size is the size of each hardware's consumption. If we
> set
> > > > period size to N, the pcm will consume N frames each time.
> > > >
> > > > 2. The period_size is the size to control when hardware call
> interrupt.
> > > If
> > > > we set period size to N, the pcm consume frames in its step. When the
> > > > number of frames it consumes more than N, it will call interrupt.
> > >
> > > 2 is the correct answer.
> > >
> > >
> > > HTH,
> > >
> > > Takashi
> > >
> > > > We can use snd_pcm_avail function to check the real available frames
> in
> > > > the device. If guess 1 is correct, the size of consumption should be
> > > fixed.
> > > > Else, setting period_size is nothing to do with hardware's
> > > > consumption. I've checked some boards and found that each board has
> > > > different behavior (Most of them meet guess 2). I'm confuse which
> one is
> > > > correct. Thanks!
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > >
> > >
> > [2  <text/html; UTF-8 (quoted-printable)>]
> >
>
