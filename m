From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for PLL and SRM
Date: Mon, 16 Apr 2012 13:59:31 +0100
Message-ID: <20120416125930.GB3219@opensource.wolfsonmicro.com>
References: <1334122120.3991.13.camel@matrix>
	<20120413093012.GK3168@opensource.wolfsonmicro.com>
	<1334578993.26734.6.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0432482725610115042=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C3976243D1
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 14:59:36 +0200 (CEST)
In-Reply-To: <1334578993.26734.6.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============0432482725610115042==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2012 at 05:53:13PM +0530, Ashish Chavan wrote:
> On Fri, 2012-04-13 at 10:30 +0100, Mark Brown wrote:
> > On Wed, Apr 11, 2012 at 10:58:40AM +0530, Ashish Chavan wrote:

> > > +	/* for MASTER mode, fs =3D 48Khz */
> > > +	{ 12000000, 0xF3, 0x12, 0x7, },		/* MCLK=3D12Mhz */

> > This *still* has magic number problems.

> OK, will replace frequency values with defines. That is what you are
> pointing, right?

No!  As with *all* the other times you've submitted this you're relying
on magic array indexes to find stuff in the table which I've *repeatedly*=
=20
pointed out is terrible for readability and maintainability.  It's very
disappointing to see the same problem coming back repeatedly.

> > These defines now need to be kept in sync with the table and are going
> > to be *very* painful to review.

> Yes, these defines need to be kept in sync with the table. Can you
> suggest any other, preferred way to do this?

Yes.  For example, you could use the same technique you're using for the
frequencies.

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPjBSmAAoJEBus8iNuMP3dXpwP/AnQdA3Em1GXCYVfeduIv0vd
jUe1KoovXw5+/Zwoz72EaUG05/Z+rTQe1+EWDIvInK7B90GaT9MYteWaejbtlxai
Cea/93S/F9IxtR+yaKlcNePFkzoOWs/fpapWr9hl2qcFotmjpXdU/2cQ9Z2vRawe
5fQ1aLMRMS9018PRxNB6bIwl613WOVmnj9rOZLnxlq5SM2nRzvHyJQlPwdilZA7a
SbHLTM7xC6NSrWvQyNoVzJ18SftKBiixNCGiiCI2zMd4WE9XI7cXDE+QhxUuEB6v
cWWy8EobHuP7JkIv6Y19Tr0lp9n+hOFqwRTOg+2RhfTGhHz2Y8DkYTLREfgH8rOu
gKpw1fFyCSz/nln7sltmI+alMJe4L4ZCH3/f0xowL++fo74npWNR8sTDar1TOQ4+
PmTJRoEsMGgOxcAGSVUlDMirBAixETV36QfqfBz3JmK4/WJYJMaEEM5Cv6Bbx26y
HWTbu6y5PY2EFxEUCO1aCIF4MuNCkqUMW9c0gA/WzqY9nEmrGesdzQt7keK8Hjpe
LgksNnBtTAdvPTs/bah8C18d1NqESHrptWwCHxJkO5rsAIVpcHC5s1Gm69gdkoTL
w1du0+sBA6tuwVYk9jF9XG6lUf1wQapM4itXlB+dltoATEi8jWZQWv6nFVRiFqCo
p2f2uY2KlanoPo2uw1ty
=R63J
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--

--===============0432482725610115042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0432482725610115042==--
