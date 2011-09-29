From: suresh gupta <sureshgupta189@gmail.com>
Subject: Re: LSI HDA Modem is not working on HP new Laptop
 which has IDT 7605 HDA codec and REDHAT installed on it with ALSA ver
 1.0.24.
Date: Thu, 29 Sep 2011 14:21:26 +0530
Message-ID: <CAJTbaX3QcB=WTbt19dMpoR9goxJr_4oqeS0TnDU0P9GWSiinwg@mail.gmail.com>
References: <B2FD678A64EAAD45B089B123FDFC3ED70166618A4C@inbmail01.lsi.com>
	<s5hipobc1it.wl%tiwai@suse.de>
	<B2FD678A64EAAD45B089B123FDFC3ED70166618A6E@inbmail01.lsi.com>
	<s5h8vp7by4m.wl%tiwai@suse.de> <s5h62kbbx1g.wl%tiwai@suse.de>
	<CAJTbaX3OiLNcL2hwJOROK4jLeLhAJKJE-zO5t=VYcP4sP03oUA@mail.gmail.com>
	<s5hy5x7ag8l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7562210387B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 10:51:48 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so396987bkb.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 01:51:48 -0700 (PDT)
In-Reply-To: <s5hy5x7ag8l.wl%tiwai@suse.de>
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
Cc: "Gupta, Suresh" <Suresh.Gupta@lsi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for answers,

 I will explore more our code to understand the issue and will come back.

Again thanks for help=85..
SuresH

On Thu, Sep 29, 2011 at 2:16 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 29 Sep 2011 14:01:40 +0530,
> suresh gupta wrote:
> >
> > Sorry for delay, I was out for Lunch.
> >
> > I believe we are in sink now, I seen the purity_inactive_streams part of
> > code and found this is totally new logic in 1.0.24 ver. Can you please
> > answer some question for my proper understanding?
> >
> > 1. Why this marking stream dirty come into picture and why ALSA code do
> not
> > directly clear the AC_VERB_SET_CHANNEL_STREAMID while closing?
>
> For keeping the same stream tag for the same device.
> A device is often shortly closed and reopened.  It'd be better to keep
> the same stream tag for such a case.
>
> > 2. Why Analog devices codec (patch_analog.c) clear
> > AC_VERB_SET_CHANNEL_STREAMID on close? (if (do_now)
> >    really_cleanup_stream(codec, p);
>
> It's because AD codecs (according to bug reports) don't like the
> sticky-tag feature by some reason.  It'll be removed, once when the
> real culprit is found.
>
>
> Takashi
>
> > )
>  >
> >
> > On Thu, Sep 29, 2011 at 1:27 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Thu, 29 Sep 2011 09:34:17 +0200,
> > >  Takashi Iwai wrote:
> > > >
> > > > At Thu, 29 Sep 2011 12:42:41 +0530,
> > > > Gupta, Suresh wrote:
> > > > >
> > > > > LSI Modem always checks the "opened" bit of "azx_dev" before
> opening
> > > the stream. Modem sets "opened" bit and
> > > > > use stream if and only if that "opened" bit was not set otherwise
> move
> > > to next stream "azx_dev".
> > > > >
> > > > > I found that the ALSA unset this "opened" bit on close but do not
> reset
> > >  AC_VERB_SET_CHANNEL_STREAMID of IDC codec.
> > > > > Due to which IDC Codec always get active and always sending data =
to
> > > stream 0. Now when LSI modem check the "opened"
> > > > > bit of stream 0, it found it is not set and open the stream 0 and
> start
> > > reading data from stream 0. As IDC codec
> > > > > still sending data on stream 0 the LSI Modem get this unexpected
> data
> > > and stop working.
> > > > >
> > > > > I believe the Code (below) which checks "no_sticky_stream" is the
> > > culprit due to which "really_cleanup_stream"
> > > > > function is not called. I found the Analog devices codec set
> > > "no_sticky_stream" while probing their codec.
> > > > > This is the reason, our modem works on HP laptop with Analog devi=
ce
> > > codec.
> > > > >
> > > > > According to me the IDC codec should stop sending data after
> closing
> > > the stream or otherwise they should always acquire the stream which is
> not
> > > right.
> > > > >
> > > > > I don't know why "no_sticky_stream" come into new code and what's
> it
> > > significance. Why only Analog devices use this "no_sticky_stream".
> > > >
> > > > The problem is that your driver steals the stream silently.
> > > > The stream is still assigned to the IDT codec driver even after the
> > > > PCM is closed.  It's just not used.  When the PCM is opened, the ve=
ry
> > > > same stream is used again without reassigning the stream tag.
> > > >
> > > > Now the modem driver grabs the stream and use the stream tag.  Of
> > > > course, the data will be fed.
> > > >
> > > > The stream must be allocated via azx_assign_device().  If you don't,
> > > > it's not guaranteed what happens.
> > >
> > > Looking back at the code, I think my previous analysis was incorrect.
> > > The problem is likely that your driver doesn't set up the stream via
> > > snd_hda_codec_setup_stream() or snd_hda_codec_prepare() isn't called
> > > properly by any reason.
> > >
> > > The logic is:
> > > - the inactive old streams conflicting with the newly prepared stream
> > >  are marked as dirty in snd_hda_codec_setup_stream(); this is
> > >  supposed to be called from the codec driver's prepare callback,
> > > - then the codecs with dirty streams are cleaned up in
> > >  purity_inactive_streams() called from snd_hda_codec_prepare().
> > >
> > >
> > > Takashi
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >
> > [2  <text/html; ISO-8859-1 (quoted-printable)>]
> >
>
