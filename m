From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing
Date: Tue, 5 Jun 2018 17:06:05 +0100
Message-ID: <20180605160605.GD25374@sirena.org.uk>
References: <CAL_JsqKhkVOYf+XEA3MYpK4JYfMrZTbHZtoXgaH=wCBRoU6cfQ@mail.gmail.com>
 <1526640409.3948.5.camel@pengutronix.de>
 <20180523165352.GA6187@rob-hp-laptop>
 <20180525094724.3f4edofopk52i3v6@pengutronix.de>
 <20180525102609.GK4828@sirena.org.uk>
 <20180525114253.jj6akdazsbxqkbfu@pengutronix.de>
 <20180525145245.GM4828@sirena.org.uk>
 <1527261489.4938.9.camel@pengutronix.de>
 <20180525172441.GN4828@sirena.org.uk>
 <1528192731.4074.7.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8964478305204842190=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F1976267A6C
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 18:06:12 +0200 (CEST)
In-Reply-To: <1528192731.4074.7.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============8964478305204842190==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 11:58:51AM +0200, Philipp Zabel wrote:
> On Fri, 2018-05-25 at 18:24 +0100, Mark Brown wrote:

> > If this is varying so drastically per board/system that it's relevant
> > then we're already into problematic territory.  For most devices we just
> > have a number for the part, not something that varies so wildly that
> > each system needs to configure it.

> I'm not arguing this should be configured per individual device, just
> per board DT.

Even per board is a very surprising amount of variability TBH. =20

> It's just that my experience of one datapoint consists of a board where
> I had to increase the delay to about three times the delay calculated
> from the nominal capacitance according to the datasheet before audible
> artifacts disappeared reliably on multiple devices.
> Putting the extended delay into the device tree with a comment
> explaining its empirical nature seemed more straightforward than putting
> a bogus capacitance value, that differs from the schematics, and that I
> have never measured.

The thing that's surprising me here is that there's even a board to
board variance that's so bad that it needs to be configured like this -
usually these things are just hard coded into the driver so they work
for everyone rather than needing per-board tuning.  It seems entirely
possible that the formula quoted in the datasheet is just nonsense in
general and that the driver would be better off using your number for
all systems for example.  If we do have to hard code something in the DT
it seems better to hard code something that is at least coming from a
spec rather than a measured number that needs to come from an average
over a batch of boards since at least we can revise how we handle the
number without needing to do something that shows up in the ABI.

> Also, by using the capacitance we are guaranteed to end up with a codec
> specific property name (adi,vmid-decoupling-capacitance ?) as opposed to
> the possibility of defining a common delay property that could be used
> for different codecs.

That's actually something I want to avoid since the delays tend to need
to come in the middle of write sequences which makes a general property
a lot more complicated, and obviously some devices have multiple delays
too.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsWtOwACgkQJNaLcl1U
h9CwyQf+J/2JXioJSW2xKqHWmiGHoTj94Ag9qPe+WT5oihx5QPqkMwf/9TiLG623
74YzSuZ+Vjoz6GEaU6XfKvxtr1MUhv9swR/ZLuInZlaw62FBCpGA516TEfqeyLP0
nuCVDRyD5sSdMXSsxmtBbZuV5FbNcXAKfbKoJC9ksqVSDJQOsnjYUD+KP4B04wbG
+5xhNHS+DQDB/CSPm8CpwamAmVyjKksDlHzQ8vGHCutdQxJnV+h6CjitBvB37Cqm
lAEVqHc+gx3SrxN4U58L+LKv93ofmsaFJ5KHQuNRclxubKfEe/sz9aMTQHu0jWt3
qEejzZMOIGk5eQZ9lnZQijP1T+ttYw==
=sNLM
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--

--===============8964478305204842190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8964478305204842190==--
