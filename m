From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Thu, 14 May 2015 00:03:40 +0800
Message-ID: <CAN8ccibLLMgrfEVOBQkbc8yWhTQyWSK2A4iHPgHJO3cKy8ZRtg@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201504201217.36477.gineera@aspect135.co.uk>
 <201505010836.47714.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id B6374265D05
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 18:03:41 +0200 (CEST)
Received: by oign205 with SMTP id n205so34852433oig.2
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 09:03:40 -0700 (PDT)
In-Reply-To: <201505010836.47714.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > > The following assert is being hit in pcm_params.c:
> > >
> > > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'
> > > failed."
> > >
> > > This is from a developer using Portaudio in his own application; I
have
> > > yet to ascertain full details, but it is trying successive sample
rates
> > > to see which are valid.
> >
> > Further info: this occurs with an Intel motherboard/soundcard,
attempting
> > to open and config the stream at 44100 using front, surround or hdmi
pcm,
> > having previously opened and tried at a lower, not-supported samplerate,
> > and closed. AFAIK other pcms work OK.
> >
> > The assert is hit with all current Debian and Ubuntu distros, for
example
> >      Debian 8 (jessie) 32 bit:  kernel 3.16.0-4-686-pae (Alsa 1.0.28)
> > but is not seen with Fedora 20 or OpenSuse 12.1 (do they have asserts
> > off?).
> >
> > > Does this point to a flaw in the configuration or possibly a bug in
> > > Alsa-lib or can it occur just as a result of misuse of the Alsa API?
> >
> > I will try to conceive some more tests.  How can we debug this further?
>
> A minimal self-contained demo program ('test-format') has been developed
and
> is attached, that demonstrates the issue 100% on the reporters machine
> (HDA-Intel, 6-ch I believe).  The output is:
>
> root@Xeon:/home/patest# ./test-format
> Testing device front
> Num channels 6
> Testing rate: 22050   Result:...Invalid Sample Rate
> Testing rate: 32000   Result:...Invalid Sample Rate
> test-format: pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err
>=
> 0' failed.
> Testing rate: 44100   Aborted
>
> Alsa-info is at:
>
> http://www.alsa-project.org/db/?f=19dfeee29f73007e61a00a8fabe3c958f7cb8e87
>
> This apparently happens with or without Pulseaudio running, with just the
> single 44100 rate, and also with surround devices.  Also, on all current
> Debian and Ubuntu - we have focused on Jessie.
>
> I do not have a machine with similar hardware, so cannot duplicate the
> results.

Cannot reproduce the assert

But the only plugin associated with front device is softvol

Do the assert still occur with hw device ?(without softvol plugin)

You need to provide debug output by  define RULES_DEBUG in pcm_params.c

What value do the distribution use for hda prealloc max size ?

snd_pcm_hw_params() may fail with invalid  argument even when
pa_isFormataupported return true
