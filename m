From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Thu, 21 May 2015 08:15:39 +0800
Message-ID: <CAN8cciazyYGLwudnNw29eCmPGhyu8qv=Q8wJPOKjYrMuVjZVHQ@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201505010836.47714.gineera@aspect135.co.uk>
 <s5hbnhgzsh4.wl-tiwai@suse.de>
 <201505192022.50591.gineera@aspect135.co.uk>
 <s5h4mn7u54s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 132302614FB
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 02:16:04 +0200 (CEST)
Received: by oihb9 with SMTP id b9so48871501oih.3
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 17:16:02 -0700 (PDT)
In-Reply-To: <s5h4mn7u54s.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, leif@sm5bsz.com
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > > > A minimal self-contained demo program ('test-format') has been
developed
> > > > and is attached, that demonstrates the issue 100% on the reporters
> > > > machine (HDA-Intel, 6-ch I believe).  The output is:
> > > >
> > > > root@Xeon:/home/patest# ./test-format
> > > > Testing device front
> > > > Num channels 6
> > > > Testing rate: 22050   Result:...Invalid Sample Rate
> > > > Testing rate: 32000   Result:...Invalid Sample Rate
> > > > test-format: pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion
`err
> > > > >= 0' failed.
> > > > Testing rate: 44100   Aborted
> > > >
> > > > Alsa-info is at:
> > > >
> > > >
http://www.alsa-project.org/db/?f=19dfeee29f73007e61a00a8fabe3c958f7cb8e8
> > > >7
> > > >
> > > > This apparently happens with or without Pulseaudio running, with
just the
> > > > single 44100 rate, and also with surround devices.  Also, on all
current
> > > > Debian and Ubuntu - we have focused on Jessie.
> > > >
> > > > I do not have a machine with similar hardware, so cannot duplicate
the
> > > > results.
> > > >
> > > > Any comments, ideas etc would be appreciated.
> > >
> > > I also can't reproduce this.  So this must be pretty specific to the
> > > setup.
> > >
> > > Could you give the exact condition to trigger the problem?  Also, this
> > > happens certainly with the latest alsa-lib?
> >
> > Thanks for taking a look.  Just compiling and running that test
program, on
> > the reporter's machine, which has some sort of multi-channel HDA-Intel,
is
> > 100% reproducible. The Alsa-lib must be the one provided by Debian
Jessie
> > (which was released 25.4.2015); 1.0.28 I think.  Does the Alsa-info give
> > enough details - I can ask any specific questions.
> >
> > However, Raymond seems to have some ideas of a possible cause, in
connection
> > with arbitrary period size and softvol; is that plausible?
>
> Possibly, but I wonder why I couldn't see it when I tried with
> different module options.
>
> In anyway, the fix would be simple, the patch like below.  Could you
> check whether it actually fixes your issue?
>

http://music.columbia.edu/pipermail/portaudio/2015-May/016773.html

i7 test # ./test-format
Testing device front
Num channels 6
Testing rate: 22050   Result:...Invalid Sample Rate
Testing rate: 32000   Result:...Invalid Sample Rate
Testing rate: 44100   Result:...Unexpected Result???
Testing rate: 48000   Result:...Unexpected Result???
Testing rate: 96000   Result:...Unexpected Result???
i7 test # uname -r
3.13.0-sabayon

Your program should show snd_strerror(err) instead of Unexpected Result ???

It is strange that it fail at 48000Hz and 96000Hz

What is snd_hda_prealloc_size used by 3.13.0-sabayon ?

You need to define RULES_DEBUG in pcm_params.c to provide debug output
