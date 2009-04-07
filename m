From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/6] ASoC: TWL4030: Enable all audio paths
Date: Tue, 7 Apr 2009 13:30:22 +0300
Message-ID: <200904071330.22727.peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904070759.19600.peter.ujfalusi@nokia.com>
	<20090407094558.GA24788@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 60F61244F1
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 12:30:43 +0200 (CEST)
In-Reply-To: <20090407094558.GA24788@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 07 April 2009 12:45:59 ext Mark Brown wrote:
> On Tue, Apr 07, 2009 at 07:59:19AM +0300, Peter Ujfalusi wrote:
> > On Monday 06 April 2009 15:45:21 ext Mark Brown wrote:
> > > What does this mean by "enable" - I'm guessing it's powering blocks
> > > within the CODEC rather than connecting any audio paths?
> >
> > The TRM calls these as Audio/Voice digital filters.
> > In effect, they enable the shifting out bits from the Capture path to t=
he
> > bus and shifting in bits on the Playback side.
>
> Hrm, so this is a routing thing then - from your description I'm a bit
> surprised that this can be turned on unconditionally since it sounds
> like it'll give you a sidetone all the time which might not be what
> people want.

Not quite. The sidetone/loopback can be turned off inside of twl4030 with t=
he
'Left Digital Loopback' and 'Right Digital Loopback' set to 0.

With the current implementation the capture path is powered only when there=
 is =

need for it, which means that ADCs, TX PGAs are powered off. So even if the =

Digital filters are enabled on the capture end, you will not see data going=
 to =

the bus (from twl4030).

I think the twl4030 codec still holds some interesting 'features'...

>
> > But as I said, this is not so nice thing to do, so it need to be
> > revisited.
>
> It needs digital routing.  In the interim another option would be to
> provide switches to user space, possibly?

It is possible to add 8 switches, or 4 stereo switch - I have to check the =

code ;)
Placing them to the correct location in the paths might be possible.
I have to check it.

But than there is this Option selection... twl4030 has two modes: Option1 a=
nd =

Option2. In same cases the config is the same, but in most of the cases it =

behaves like two different codec...
Option1 has only HiFi interface with up to 4 channel RX/TX
The interface for the host processor in this case:
i2s, l_just, r_just or TDM (stereo or 4 channel).

Option2 has HiFi (up to 2 channel RX/TX) + Voice stereo uplink and mono =

downlink.
Than it has interface:
i2s, l_just, r_just (stereo only)
PCM
BT

Some of the bits in the OPTION register (and also in other registers) means =

totally different things (or not valid for the mode) in Option1 than in =

Option2...

-- =

P=E9ter
