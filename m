From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 24 Feb 2010 15:30:53 +0800
Message-ID: <4f3252891002232330q15a67b2csc2c44ccb84ced3d1@mail.gmail.com>
References: <20100216154015.GA612@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<ad2655cb1002190347m5ae42684ic4de989f5f35eb84@mail.gmail.com>
	<alpine.LNX.2.00.1002200938561.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EA3E10387D
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 08:30:54 +0100 (CET)
Received: by pwi9 with SMTP id 9so4099074pwi.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 23:30:53 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002200938561.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/20 Jaroslav Kysela <perex@perex.cz>

> On Fri, 19 Feb 2010, James Courtier-Dutton wrote:
>
> > On 19 February 2010 08:17, Jaroslav Kysela <perex@perex.cz> wrote:
> >> On Thu, 18 Feb 2010, Lennart Poettering wrote:
> >>
> >>>> For the Mic Boost +20dB case , how PA handle this +20dB switch in the
> "Flat
> >>>> Volume" model if you did not expost the Mic Boost switch to the user
> in the
> >>>> mixer control ?
> >>>>
> >>>> +20dB is quite significant in with the Capture Volume control
> >>>
> >>> We currently don't cover boost switches, simply because tehre is no dB
> >>> data queriable for them.
> >>>
> >>> I'd really prefer if those boost switches would be turned into binary
> >>> volume elements which carry normal dB information like any other
> >>> volume element. After all they are just a volume element, with only
> >>> two steps.
> >>
> >> I like this idea.
> >>
> >
> > Seems like a good idea but what should we call it.
> > If we already have a mic capture gain control, what shall we call the
> > mic boost gain control so as not to confuse it with each other?
> > Would keeping its current name be OK?
>
> I would keep the Boost suffix. It's easy to understand.
>
>                                        Jaroslav
>
> -


Some HDA codec has Front Mic Boost and Mic Boost  and three sets of input
sources

it is not easy to know the exact audio path

Card hw:1 'Intel'/'HDA Intel at 0xff9f4000 irq 22'
  Mixer name    : 'Analog Devices AD1988'
  Components    : 'HDA:11d41988'
  Controls      : 48
  Simple ctrls  : 26


    control.25 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 3'
        comment.dbmin 0
        comment.dbmax 3000
        iface MIXER
        name 'Front Mic Boost'
        value.0 0
        value.1 0
    }
    control.26 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 3'
        comment.dbmin 0
        comment.dbmax 3000
        iface MIXER
        name 'Mic Boost'
        value.0 0
        value.1 0
    }

    control.27 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 54'
        comment.dbmin -5850
        comment.dbmax 2250
        iface MIXER
        name 'Capture Volume'
        value.0 39
        value.1 39
    }
    control.28 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 2
        iface MIXER
        name 'Capture Switch'
        value.0 false
        value.1 false
    }
    control.29 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 54'
        comment.dbmin -5850
        comment.dbmax 2250
        iface MIXER
        name 'Capture Volume'
        index 1
        value.0 39
        value.1 39
    }
    control.30 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 2
        iface MIXER
        name 'Capture Switch'
        index 1
        value.0 false
        value.1 false
    }
    control.31 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 54'
        comment.dbmin -5850
        comment.dbmax 2250
        iface MIXER
        name 'Capture Volume'
        index 2
        value.0 39
        value.1 39
    }
    control.32 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 2
        iface MIXER
        name 'Capture Switch'
        index 2
        value.0 false
        value.1 false
    }
    control.33 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 'Front Mic'
        comment.item.1 Line
        comment.item.2 Mic
        comment.item.3 CD
        comment.item.4 Mix
        iface MIXER
        name 'Input Source'
        value Mic
    }
    control.34 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 'Front Mic'
        comment.item.1 Line
        comment.item.2 Mic
        comment.item.3 CD
        comment.item.4 Mix
        iface MIXER
        name 'Input Source'
        index 1
        value 'Front Mic'
    }
    control.35 {
        comment.access 'read write'
        comment.type ENUMERATED
        comment.count 1
        comment.item.0 'Front Mic'
        comment.item.1 Line
        comment.item.2 Mic
        comment.item.3 CD
        comment.item.4 Mix
        iface MIXER
        name 'Input Source'
        index 2
        value 'Front Mic'
    }
