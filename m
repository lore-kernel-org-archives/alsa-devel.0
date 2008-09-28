From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: Re: Driver: EMU USB 0404 driver development
Date: Sun, 28 Sep 2008 18:14:44 +0200
Message-ID: <d9690f190809280914l5c3b1d63me99d61d7faaa2a8a@mail.gmail.com>
References: <d9690f190809221113p1b410102oa733628ccfe8fc95@mail.gmail.com>
	<fd3eb9bf0809260320r71a9f46bp30be1a2535b0c557@mail.gmail.com>
	<d9690f190809260644q48897b4drdcaf2418dc7784b2@mail.gmail.com>
	<fd3eb9bf0809260804p6ae3ef30ieb70ee00063ee1c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 1752D243C0
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Sep 2008 18:14:45 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so515831yxh.2
	for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2008 09:14:44 -0700 (PDT)
In-Reply-To: <fd3eb9bf0809260804p6ae3ef30ieb70ee00063ee1c3@mail.gmail.com>
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
To: =?ISO-8859-2?Q?Vedran_Mileti=E6?= <rivanvx@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Vedran.

How can I get in touch with him?
I looked up responsibilities for EMU10k1. Takashi and Jaroslav seem to be in
charge for that EMU product.

THX
Cheers

On Fri, Sep 26, 2008 at 5:04 PM, Vedran Mileti=E6 <rivanvx@gmail.com> wrote:

> James Courtier-Dutton has been making drivers for E-mu PCI cards, so
> there is a chance that he might be the guy who got the datasheets or
> know who did. Maybe you should ask him.
>
> 2008/9/26 Klaus Schulz <kls.schlz@googlemail.com>:
> > Yep.  But rather by coincidence ( at least a quirk to recognize the card
> and
> > a small routine (usbaudio.c) to handle the samples properly has been
> > implemented).
> >
> > First you need to upgrade the  firmware via Windows - which is a must.
> After
> > that the card defaults to 44,1/16 after power up.
> > This is the reason why 44.1/16 playback works.
> >
> > What's missing, is the complete control of the card modes, register
> settings
> > etc.
> >
> > If the registers are known, which I assume, according to EMU statement,
> it
> > shouldn't be a big deal to get it working.
> >
> > Now it would be interesting to know who sits on these information. I'd =
be
> > happy to get in touch with him to support the design process.
> >
> > Cheers
> >
> >
> >
> >
> > On Fri, Sep 26, 2008 at 12:20 PM, Vedran Mileti=E6 <rivanvx@gmail.com>
> wrote:
> >>
> >> Doesn't it already sort of work with limited functionality?
> >>
> >> 2008/9/22 Klaus Schulz <kls.schlz@googlemail.com>:
> >> > Hi folks.
> >> >
> >> > I learned that EMU handed over specs related to the EMU 0202/0404 USB
> to
> >> > you guys some time ago.
> >> >
> >> > http://ubuntuforums.org/showpost.php?p=3D4892734&postcount=3D157
> >> >
> >> > Is anybody assigned to the task?
> >> >
> >> > Cheers
> >> > _______________________________________________
> >> > Alsa-devel mailing list
> >> > Alsa-devel@alsa-project.org
> >> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >> >
> >>
> >>
> >>
> >> --
> >> Vedran Mileti=E6
> >
> >
>
>
>
> --
> Vedran Mileti=E6
>
