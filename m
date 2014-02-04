From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Add ADAU1977 driver
Date: Tue, 4 Feb 2014 14:10:17 +0000
Message-ID: <20140204141017.GB22609@sirena.org.uk>
References: <1391439428-3198-1-git-send-email-lars@metafoo.de>
 <1391439428-3198-2-git-send-email-lars@metafoo.de>
 <20140203184026.GL22609@sirena.org.uk> <52F0CC16.50302@metafoo.de>
 <20140204121224.GW22609@sirena.org.uk>
 <52F0EBA7.7000501@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8232761625747720940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB5A4261987
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 15:10:27 +0100 (CET)
In-Reply-To: <52F0EBA7.7000501@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8232761625747720940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="50WZftmI8KrtQkml"
Content-Disposition: inline


--50WZftmI8KrtQkml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2014 at 02:31:19PM +0100, Lars-Peter Clausen wrote:

> currently find in drivers with more than one interface. And there is
> the thing that you can actually build a config that results in a build
> error which triggers the occasional randconfig build failures for
> for ASoC. Once the last three drivers that still soc-io have been

Those randconfig failures are for configurations that no human would
ever generate, it's really hard to care.

> converted to regmap I think we should move the selection of
> REGMAP_I2C and REGMAP_SPI to the individual drivers rather letting
> the core select them unconditionally. Using this new scheme will

That's the idea, it does need the drivers handling first though.  The
fact that not everything works through select (there's the ignored
dependencies thing and I think some other stuff) isn't helpful with this
stuff either, it makes it all too fragile.

> make it easier to avoid the situation where you end up selection
> REGMAP_I2C or REGMAP_SPI even though I2S or SPI_MASTER is not

The core only enables the regmap code if the bus is being built, we
don't have a problem with that bit - that bit at least is fine.

> selected. I don't have a problem with updating the other drivers to
> use the new scheme, but it's not like we have to update them all at
> once in one atomic step. And you have to start somewhere.

Right, but that somewhere shouldn't be doing it in a new driver without
even mentioning that it's being done - it's not something that should be
coming as a surprise in the middle of a review of something that should
be unrelated.  That's the biggest problem here, it wasn't even called
out in the changelog so people wouldn't be able to figure out why this
driver was being different. =20

An explicit conversion patch for at least one driver (possibly even this
one on the end of the series) would be ideal, or adding a note in the
changelog saying something like "We should do this in general because X
but I didn't get round to starting yet" so that it's visible.

--50WZftmI8KrtQkml
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8PTGAAoJELSic+t+oim9RA0P/i2MJY6oL2SRWS6jmYHp/g8r
6Rwcdq9x7iuU8BoxklBcnpxrkVDHIXnDjHjUdOdaATkBGerQ4vVYcDR04axLbNm7
20ZPGozspIUDIsrIrf4PPO2BbHU5NZ/NI/siM9OLrXXLshsYiY/vEhiNTdVaFc5L
y9vCFzmWCOO/EwVM2SHKEBMl72e82pvCtoTtWm1G8ly3qSIKGSB/idqWyYEN3UoD
+Muez2KFuJQI95tuc0sax41TQhHPGoV2KkeVjzmciIo8H1uUd1VOqk9vNuSrHS4A
bJpDyRpwR0Y3qe8vA9v0AtkT6AGqNVoEO6oq8QvdT68SNX3uBBDJtJnHdISKo/jB
AsfNr3KZ5IvaQtSqqy4T3ndN43LtRNs8QC9TOs6oXm20R3Qxgm2EdskLLq2tEjMK
qjJS4n//+1GfPrzD6CxDqAbPO7BhTwy5LA+mPCmZS9OywIb5HVYHphTcGyx2e6mH
LkWdIWOfHYWQ61sQXpZZCnszZrzQOKCwNOvgbv5OkcUDoUl9z+D7aCiXGgJN69Rd
jWKylt+X2evUGaPo2tOLlsufyAgiQRBaqZZlh15yqGFBf+FXoMZ5RomfIi4MNIkw
RW0Olt/fRWFbjCvSoaGwpUniWxFNJ40IScCoZSUSK78AGAgXo8CkQNrV+eWVOE0K
q+ibOyj8MzWjLTf4uKmh
=Wwor
-----END PGP SIGNATURE-----

--50WZftmI8KrtQkml--

--===============8232761625747720940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8232761625747720940==--
