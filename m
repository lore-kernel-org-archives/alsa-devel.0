From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/9] ASoC: TWL4030: Add PreDriv outupt mux
	and volume controls
Date: Tue, 25 Nov 2008 12:51:46 +0200
Message-ID: <200811251251.46575.peter.ujfalusi@nokia.com>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<200811241619.18786.peter.ujfalusi@nokia.com>
	<20081124145031.GH22394@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 75806243A0
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 11:52:02 +0100 (CET)
In-Reply-To: <20081124145031.GH22394@sirena.org.uk>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Monday 24 November 2008 16:50:31 ext Mark Brown wrote:
> On Mon, Nov 24, 2008 at 04:19:18PM +0200, Peter Ujfalusi wrote:
> > On Monday 24 November 2008 15:48:09 ext Mark Brown wrote:
 =

> > Do you have a pointer, where should I look for existing code?
> =

> At least WM8990 and WM8903 do this with separate controls.  Most of the
> drivers should be fine to look at for examples, it's just that this was
> done for some of the older drivers and it's never been worth changing
> them.

I'll take a look.

> Oh, ick.  There's a couple of ways I can think of to represent that to
> DAPM.  One would be to have a simple mixer with switches for everything
> and an extended event on the mixer which returns an error if multiple
> DAC inputs are enabled.  The other is to have the DAC selection be a
> custom mux like you've got and feed that into the mixer unconditionally.
> The voice input should certainly be a separate control here.

Not sure that I understand these, but I'll try to get the 'other' way
implemented.

> > On the side not: the voice path at the moment not in use -> the codec h=
as
> > to be in different mode to have the voice path enabled. But then lot's =
of
> > things will behave differently.
> =

> Could you go into more detail about these modes?  Sounds like it could
> get tricky...

Let's see... I might be the wrong person for this, but in short.
TWL can operate in two modes:
Option 1: two RX and TX stereo paths (four channel RX and four channel TX)
Option 2: Voice uplink (sterreo) and downlink (mono) +
          one RX and TX stereo paths (two channel RX and two channel TX).

At the moment the driver supports the Option 1. Adding the support for Opti=
on 2
is tricky, since I have not seen a HW which can support it. The SW support
can be added, but at least I can not verify, that it is working...
On the Option 1 side: in order to use all four channel the TDM support is
needed for twl4030 and for omap-mcbsp. Actually this is my long term plan...
This is one of the reasons to have as flexible routing and control for TWL =
as
possible.
When the Option 1 is ready, I think in theory it should not be that hard to
add support for the Option 2. Couple of new DAC, mixers, muxes, interconnec=
ts..

Hmm, after reading it back: probably this will just cause more confusion ;)

> > Initially I did not wanted to spread these controls - to make it simple
> > for myself, but I might separate the voice and DAC mux selections (sepa=
rated
> > enable for voice and mux the DACL/Rs selection).
> =

> Yes, that does sound like the best approach.
> =


-- =

P=E9ter
