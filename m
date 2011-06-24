From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: M-Audio FTU issues
Date: Fri, 24 Jun 2011 13:27:36 +1000
Message-ID: <BANLkTikibKts7Cbr8xJeVstReuY==cnA=Q@mail.gmail.com>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FC1E2480B
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 05:27:40 +0200 (CEST)
Received: by eyg5 with SMTP id 5so792905eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 20:27:36 -0700 (PDT)
In-Reply-To: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 24, 2011 at 11:14 AM, Daniel Mack <zonque@gmail.com> wrote:

> So, I've looked into this today and as expected, the device normally
> operates in implicit feedback mode. After installing a proprietary
> driver on Mac OS X (that regularily crashed my kernel), the analyzer
> shows that for every inbound packet, an out packet is sent back with
> the same amount of data in it. And there are no feedback endpoints.
>
>
> yeah m-audio can't write software or design hardware we know ;)



> On Tue, Jun 14, 2011 at 11:21 AM, Aur=E9lien Leblond <blablack@gmail.com>
> wrote:
> > There are still the issue of samples dropping.
> >
> > Tto reproduce it:
> > - Open Audacity and set it up to be using Jack.
> > - Click Generate -> Tone -> Ok.
> >
> > "Normally" you should hear very regular pops...
> >
>
> What surprises me though, is that I can't hear the clicks and pops you
> guys describe. Instead, I hear a quite annoying distortion for both
> 44100 and 48000 Hz which I can't explain either. My spontanous guess
> is that there is a resampler in the chain which compensates the sample
> drift and notably reduces the audio quality.
>
>
eww that's uncool.

Silly question In the mac controlcentre ensure you've turned off/bypassed
the reverb/dsp capabilities?

I've previously replicated this with audacity and jack. (at 24bit 96kHz) but
when I get home I'll give aplay a go after generating the sine.

I'll see if I can capture it and make some waveform's or something and I've
tested my other usb soundcard and it doesn't have the clicking.

Grant.



> Daniel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
