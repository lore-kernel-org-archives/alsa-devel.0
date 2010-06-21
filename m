From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Mon, 21 Jun 2010 08:47:06 +0800
Message-ID: <AANLkTikz9pqSvylmKfUPVHRvZtFx4pwzFeRbDWjO9Z8w@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8327610382F
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 02:47:08 +0200 (CEST)
Received: by vws18 with SMTP id 18so350584vws.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2010 17:47:06 -0700 (PDT)
In-Reply-To: <1277043970.22889.45.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/20 David Dillow <dave@thedillows.org>

> Please keep me on the cc list, I'll see your message sooner in my Inbox
> than my mailing list folders.
>
> On Sun, 2010-06-20 at 08:20 +0200, Hans Schou wrote:
> > > On Sat, 2010-06-19 at 16:13 +0200, Hans Schou wrote:
> > >> Hi
> > >>
> > >> I have a problem with recording sound when using the sound chip
> > >> SIS7019 with both kernel 2.6.26 and 2.6.34. After recording about 42
> > >> minutes it kind a stops recording, more precisely it is taking a pause
> > >> of exactly 10 seconds between each reading.
> > >>
> > >> As recorder I have tried several programs and all of them fails after
> > >> 42 minutes. Some programs uses Alsa and some uses the old deprecated
> > >> method. In this example I have logged sox rec.
> > >>
> > >> Recording method in a script:
> > >>   strace -tt -o strace.log rec -c 1 -r 44100 -2 sox.wav &
> > >>   sleep 3000
> > >>   kill $?
> > >
> > > I think the answer is no, but to be sure -- are you talking directly to
> > > the hardware device, or are you going through pulseaudio?
> >
> > Eh? No to what? Alsa?
>
> Pulseaudio.
>

what is the default device ?  dsnoop, hw or pulse

Please use alsa "hw" device first , and then pulseaudio

if you are using pulseaudio , you need to provide a full pulseaudio.log (
pulseaudio -vvvvv ) and cc PA developer with your result


>
> >  I am not really sure. In strace I can see 'rec'
> > uses ioclt which could implies that it is talking directly to
> > hardware.
>
> Probably, but I'm not familiar enough with the library/user-space side
> of alsa to know how it talks to plugins. I expect you are correct,
> though.
>
> > > While rec is running, can you capture the configuration using
> > > head -1000 /proc/asound/card0/pcm0c/sub0/*
> >
> > Below was captured while running:
> >    arecord -c 1 -r 44100 -f S16 arec01.wav
>

Please specify  -D hw:0,0 and -v to get output of snd_pcm_dump()


>
> You caught the correct files, yes. Did that command produce 10 second
> pauses? If not, then I need to see the same information from the rec
> command you were using to reproduce the issue before. It may be easier
> to just run the rec command for a moment to collect the data rather than
> wait the 40+ minutes to see if arecord also demonstrates the issue.
>
> > I got a strange error message from arecord while recording at rate 44100:
> > overrun!!! (at least 0.188 ms long)
> > overrun!!! (at least 0.190 ms long)
> > overrun!!! (at least 0.191 ms long)
> >
> > Could this be a clue?
>

Are you getting this result when using "hw" device or "pulse" device ?

what buffer size and period size are arecord using ?



>
> Perhaps; I'm guessing that rec (sox) is using the mmap interface, and
> I've not done much with that -- though perhaps there is a bug in sox's
> overrun handling. You could enable SND_PCM_XRUN_DEBUG to see if overruns
> are happening when sox starts taking 10 seconds.
>
> Getting overruns on SiS 550 based devices isn't entirely surprising, as
> it doesn't have a huge amount of horsepower or memory. If you have too
> much going on in the background, it is very easy to not have enough time
> to processes all of the captured data, especially if you are running
> short period/buffer sizes.
>
> > The error does occur with rate 8000 8bit (the default).
>
> Do you mean 'does not occur'? That may be more expected -- 8khz/8bit has
> approximately 9% of the data as 44.1khz/16bit.
>
> > > Can you try using arecord? You can use options to tell it how to
> > > configure the PCM. Especially interesting will be to configure 2
> periods
> > > per buffer vs whatever rec uses. 2 periods per buffer uses the hardware
> > > interrupts to clock out periods, where as 3+ uses a more complex
> > > mechanism. You can also use -M to use mmap vs not.
> >
> > Options like this?
> > strace -tt -o arec.log arecord -c 1 -r 44100 -f S16 -M arec.wav
>
> AFAIK , pulse device did not support MMAP


> Yes, for testing if the mmap interface is the problem. You can also use
> -v to have it print more information, including the source of the data
> (hw vs Pulseaudio). To check 1 period vs 2, you can use the
> --period-size/--buffer-size options. I seem to recall that there is a
> bug lurking around there somewhere, so you should check that you got 1
> period using -v or the proc files. You may have to fallback to the -F/-B
> options and convert samples to microseconds.
>
> Dave
>
>
