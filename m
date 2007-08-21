From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: ESI MAYA44 PCI - ESI wants to collaborate!
Date: Mon, 20 Aug 2007 22:17:54 -0500
Message-ID: <20070821031754.7E0F0102EC@ws1-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 0618D10382A
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 05:17:58 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	0499918001AB
	for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2007 03:17:55 +0000 (GMT)
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
To: Piotrek <oponek@gmail.com>, Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Piotrek,
Thanks for being so active in trying to improve ALSA support.
I've written a couple of these drivers too but someone better than me
should do this ;) especially if ESI is only willing to discuss this
matter with one developer. Besides, I don't fancy paying =A370 for the
opportunity. The people at ESI will know what they need to provide:
A full datasheet containing things like IO port layout, register
descriptions and commands.
Source code for current Windows drivers would be helpful but not
essential.

If the card needs firmware, then we'll need that too. It's also not
essential that the source code for the firmware is provided but I
think that's probably preferred as well. In either case, ESI will
need to give permission for the firmware to be distributed for it to
be well supported by ALSA. Otherwise, users will be responsible for
extracting the firmware from their Windows drivers, and that's just
not nice.

Like I said, ESI will know will they need to provide: that is to say
all the information they gave to their programmers to let them create
the current drivers for this device.

It is clear by the ESI response that they are willing to release the
information on the provision that a good driver will be produced
thereby making them look good. That is fair enough. I would suggest
to ESI, however, that to truly create the maximum possibility of this
happening, they could allow the datasheet to be held on the ALSA
server. By doing this, the relevant information would be available to
any developer who wanted to create the driver or make further
improvements. You can point them to the address below if they don't
think that sounds like something a sane company would do.

http://ftp.mj2.org/pub/alsa/datasheets/

Anyway, good luck and my advice would be to try and get the info
first and find a developer later. I don't know if ESI will do that
though. There will always be people, floating around, who will code
this up, but there's no guaranty that the company will always be as
happy and friendly as they were to you :)

Ash
> ----- Original Message -----
> From: Piotrek <oponek@gmail.com>
> To: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
> Subject: Re: [alsa-devel] ESI MAYA44 PCI - ESI wants to collaborate!
> Date: Mon, 20 Aug 2007 22:53:53 +0200
> =

> =

> 2007/8/20, Adrian McMenamin <adrianmcmenamin@gmail.com>:
> >
> > On 20/08/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Sat, 18 Aug 2007 09:28:34 +0200,
> > > Piotrek wrote:
> > > >
> > > >      Referring to the lack of the official ALSA support of ESI MAYA=
44
> > PCI
> > > > (in fact, the card does not work) I would like to ask I there are a=
ny
> > plans
> > > > to get this card working with ALSA? I would be thankful to be able =
to
> > run my
> > > > soundcard properly under Linux. There are also a lot of people that
> > would
> > > > appreciate your work and are waiting for maya44 pci drivers for lin=
ux:
> > > > http://www.esiforum.com/show.asp?db=3Desi&t=3Desi1&mode=3D3&msg=3D7=
93
> > > >     I wrote a letter to the UK ESI SUPPORT asking if they were going
> > to
> > > > write drivers for their products for Linux systems as well. There i=
s a
> > > > reply:
> > > >
> > > > "
> > > > Dear Piotr
> > > >
> > > > ESI do not provide and have no plans for Linux drivers for our
> > products
> > > > However
> > > > ESI are happy to provide /share information to an Individual develo=
per
> > > > within the Linux community
> > > > That is able and capable to develope drivers
> > > > and wishes to develope drivers
> > > >
> > > > Regards
> > > > UK Support
> > > > ESI Auditechnik
> > > > "
> > > >
> > > > It means that ESI will collaborate with developers who would like to
> > write
> > > > such driver and share the documentation.
> > > >
> > > > Again the question: Are there any plans to make ESI MAYA44 PCI card
> > working
> > > > with ALSA?
> > >
> > > AFAIK, no plan.  We don't have this hardware for developing.
> > >
> > >
> >
> > I have no idea what this card is like, but if they would be prepared
> > to send me one, I'd be happy to take the project on. I've written one
> > alsa driver - that will shortly be in the stable kernel - so can point
> > to that.
> >
> > Of course, other developers will probably be able to do the job at a
> > greater speed - but I would be happy to take it on as a pro bono
> > project.
> >
> > I am in the UK.
> >
> =

>      Thank you all for your replies. I think we should wait a while for t=
he
> response of the rest of the ALSA dev team and then we would be able to
> choose the best person for this quest and decide what to do with it
> together.
>     However, we need to
> specify what kind of information do we exactly need form ESI before we can
> start talking with them. Please write your suggestions.
>     When we will know what we need from ESI we can start working on the
> drivers. I will be glad to be able to test your work.
> =

> --
> Regards,
> Piotr Makowski
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

>


-- =

We've Got Your Name at http://www.mail.com !
Get a FREE E-mail Account Today - Choose From 100+ Domains
