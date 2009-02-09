From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Re: Juli@ ICE1724 and 24 bit audio
Date: Mon, 9 Feb 2009 13:54:19 -0800
Message-ID: <47A687F571094A7F827250BBE602F100@DemianM1330>
References: <366C228A7F9A4AAF9EE7190DC4C0EE68@PDSDesktop>
	<49909186.4050902@insite.cz>
	<67FF030CD7BA4BFB9ACE52B69F56D69D@DemianM1330>
	<fd3eb9bf0902091338i7ffa51d6t5a62d82a6b48ada3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp105.prem.mail.sp1.yahoo.com
	(smtp105.prem.mail.sp1.yahoo.com [98.136.44.60])
	by alsa0.perex.cz (Postfix) with SMTP id 28A42103833
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 22:54:21 +0100 (CET)
In-Reply-To: <fd3eb9bf0902091338i7ffa51d6t5a62d82a6b48ada3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-2?Q?'Vedran_Mileti=E6'?= <rivanvx@gmail.com>
Cc: alsa-devel@alsa-project.org, 'Pavel Hofman' <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

Thanks, I'll try that. I guess this e-mail will serve as more documentation
on that feature (bug). I had not seen that factoid anywhere.

Demian Martin
PDS


> -----Original Message-----
> From: Vedran Mileti=E6 [mailto:rivanvx@gmail.com]
> Sent: Monday, February 09, 2009 1:39 PM
> To: Demian Martin
> Cc: Pavel Hofman; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Juli@ ICE1724 and 24 bit audio
> =

> The plughw part is what makese it resample to 16-bit. You should just use
> hw.
> =

> On Mon, Feb 9, 2009 at 10:29 PM, Demian Martin <demianm_1@yahoo.com>
> wrote:
> > Pavel:
> > Thanks for all your help and work on this project.
> >
> > I'm using the Juli@ card because it supports 176.4KHz. The only other
> > candidates are much more expensive and bring their own problems.
> >
> > I'm using Xine set for dolby/dts passthrough which seems to send the
> audio
> > data at its native rate. The resampling is bypassed (Dolby Digital would
> be
> > trashed otherwise).
> >
> > I will try playing the files from the command line when I am next in
> front
> > of the system, tomorrow.
> >
> > This is the Asound.conf:
> > Asound.conf  (/etc)
> >
> > pcm.asym_spdif {
> >
> >       type asym
> >
> >       playback.pcm "plughw:0,1"
> >
> >       capture.pcm "plughw:0"
> >
> > }
> >
> >
> > pcm.!default asym_spdif
> >
> > Demian Martin
> > PDS
> >
> >> -----Original Message-----
> >> From: Pavel Hofman [mailto:pavel.hofman@insite.cz]
> >> Sent: Monday, February 09, 2009 12:27 PM
> >> To: Demian Martin
> >> Cc: alsa-devel@alsa-project.org; pavel.hofman@insite.cz
> >> Subject: Re: [alsa-devel] Juli@ ICE1724 and 24 bit audio
> >>
> >> Demian Martin napsal(a):
> >> > I have the driver working fine for sample rates from 44.1K to 196K
> >> however
> >> > it seems to be truncating the data to 16 bits. I wasn't sure until I
> >> started
> >> > testing with the HRx 176.4K 24 bit files that have an embedded HDCD
> flag
> >> in
> >> > the LSB. The files work OK on Windoze systems (with a lot of low
> level
> >> > settings tweaked) and they play fine but the flag isn't detected by a
> >> system
> >> > that can detect them. Further looking at the data stream with a scope
> it
> >> > seems the last 8 bits aren't changing. Is there anything I can do to
> >> control
> >> > the driver to confirm this problem or change the playback settings to
> >> make
> >> > it work?
> >> >
> >> >
> >>
> >> How do you play the files? Do you use the hw or plug:hw device? IIRC,
> >> the standard-setup dmix resampler is 16-bit only.
> >>
> >> I did tests with SPDIF OUT/IN and found it bit-perfect, for 24bit too.
> >>
> >> Regular ICE1724 cards do not output 176.4kHz SPDIF, only 88.2kHz. But
> >> Juli is not affected by that bug.
> >>
> >> Regards,
> >>
> >>
> >> Pavel.
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> =

> =

> =

> --
> Vedran Mileti=E6
