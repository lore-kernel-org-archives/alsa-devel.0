From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume" inverted
Date: Tue, 1 May 2012 18:12:07 +0100
Message-ID: <20120501171207.GC4089@opensource.wolfsonmicro.com>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<20120430192258.GA15188@local>
	<20120430214332.GA4414@opensource.wolfsonmicro.com>
	<20120430234458.GB15188@local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0829895531965303939=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5A6E243FE
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 19:12:10 +0200 (CEST)
In-Reply-To: <20120430234458.GB15188@local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0829895531965303939==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 01, 2012 at 01:44:58AM +0200, Hans J. Koch wrote:
> On Mon, Apr 30, 2012 at 10:43:33PM +0100, Mark Brown wrote:

> > I'm not entirely sure you've looked at the code here...

> Oh yes, sorry. I got distracted by your mentioning of the suppressed writes.
> Actually, we have suppressed reads. ac97_read() does a "return cache[reg];"
> for most registers, assuming the hardware register cannot change after a
> ac97_write(). That might or might not be true, to me it looks dangerous.

The driver knows exactly which registers are volatile and takes
advantage of this - this is entirely idiomatic for devices like this and
not really that hard to get right.

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoBiUAAoJEBus8iNuMP3dS4AP/iYVxyWnje6hkYLKSggnUKFF
hFG2LZmI20ce1cwqVuwsPbaD+rDXZzSKt8PET9Gw1MVOuW/2ZXRUcDcXRfG3Cbq1
VHGRjwxvCFmwMww6vHbsdj5wJoiL0/4gyldTkHC6e2kFv+4f4Rkx9A5vuGApFkmM
RESBOFKIsmw5ntg247Z33GP0TqWV0VAv7cmN85VHalXSMh6Gt4O4CaJZM2j59xfH
okUaMo6lwCENYoXppKUvT/WhMVVznsEZ3VuNmPfP848XEkPb0qbdCPmb7IC3grUa
Tgvh4F2Lc9OZbMywJRdIro2VgUlGSjKfBUwQ6d5U4MU4GuHlEYhhTuJikwQLK1sZ
Q5OnhfGPMPj1dADScBRjShZBGtRFzidmGUvt/T1oJCySKbRnQ96l/inDHhQAfEIE
AR0/MHIBjM4nh1GQzqShNq5Plfr4sMsx5TH0iQyuhdLQkbmLogw6uBrJozOUFC9y
QYg2AJ+vr3vJR0EQ2ICfRZiH1BYN+JHPTjgGcCp11xe0gu9bZC19XspKOGATEVJr
heY5GRh1/rc3pEHnKacHwp1LjxTWKP2jBQ9Sr7HQXsI8xz7qhUDJzhFDW1lF3Y/W
B+fWYwCSnvxxOZ+hV68xLltLG98gyU99fTfRh875+VVBxvXu3hOajbMgQUQWEJm3
R1X0i7mOldWxI9DhAx2+
=myzW
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--

--===============0829895531965303939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0829895531965303939==--
