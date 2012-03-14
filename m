From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/16] arm: ux500: Add support for MSP
	I2S-devices
Date: Wed, 14 Mar 2012 11:44:44 +0000
Message-ID: <20120314114443.GB3133@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-11-git-send-email-ola.o.lilja@stericsson.com>
	<20120313214034.GH3177@opensource.wolfsonmicro.com>
	<CACRpkdaO7LByWy3HyoOnio6O9d6nKO-g0UNGEaNujcpXVJ+LsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5837214331049953344=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BACC103A85
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 12:44:45 +0100 (CET)
In-Reply-To: <CACRpkdaO7LByWy3HyoOnio6O9d6nKO-g0UNGEaNujcpXVJ+LsQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5837214331049953344==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2012 at 10:39:03AM +0100, Linus Walleij wrote:
> On Tue, Mar 13, 2012 at 10:40 PM, Mark Brown
> >> =A0arch/arm/mach-ux500/board-mop500-msp.c | =A0194 +++++++++++++++++++=
+++++++++++++
> >> =A0arch/arm/mach-ux500/board-mop500.c =A0 =A0 | =A0 =A07 +-
> >> =A0arch/arm/mach-ux500/board-mop500.h =A0 =A0 | =A0 =A01 +

> > Perhaps this is somehow idiomatic for the port but why is this in what
> > looks like a board specific rather than SoC specific file?

> Basically because it includes GPIO's which are board-specific.

> But with some cleverness I guess it'd be possible to split just
> the board-dependent stuff (i.e. GPIO) to board-mop500-msp.c
> and all SoC-specific stuff into say cpu-db8500-msp.c or
> even cpu-dbx500-msp.c if it's generic across all families
> of DBx500.

It doesn't even need to be particularly clever - the SoCs that need it
are all succesfully splitting the pin configuration from the basic
device registration so there's plenty of patterns to follow.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYIQlAAoJEBus8iNuMP3dm0oP+wcN/hc+TeZWjxEhSZS0hIZo
wP6z/vt7P8CCX0OOZrM/DktEO8p9cF97RRqMVTgUAqXMKo2xv43OgoybOzUsaSoY
YGpjMCdW4wWsVAvty2VM3tcy4TFdhO/28Fb6C86ecVTyjJ0YuerEEhLH1iuvpA+u
7syIBDGJZ13pE7fNK3KkFm7jKACR2l2DMVUHA+CMlIzQA8bMsb8dCupqs1kUUEtQ
y7AgokFwnf+cUWYmkEq9fHSwQmIin8YI/PSyHHQpOxNbWSBzTOx8sTmtSj9D9E2i
I5R6oOCbMlAgYqnOoVdVCMIdLlNrWXyJinP/tzOCuh7EDcCG6xO2WVRkGqH4YF9R
53jFR8YtZ2zTDZnxkHu1HxC9M03CVoXiTc2c7uVVK8arKa7IblsQUFPn6yE1VX7d
44G1TPGx9xwpWGno/c9yd0sm4x6q5BSUEmwUqC8cTT6kf+PR73bxKMsv9o79tYim
vUozc0uhhC2mgdErBHH64sFEouqBj+tTXbe+TCkHn6JTCX8IH6ORHTpCyT07CELk
BmoTHhYP7xcMxRPbbYO8VdyIkTYVIzPC9xhqgao7lG1VopKKsRzoXpf378S8f1lm
VDzQ1y1jp935L+yVchyFZKxuMtvjJ61LfypK4DgQoHj/TkOurE/c8yeTV1pR0hub
lFUsLUJdaIRGnGiNH58+
=Fsxo
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

--===============5837214331049953344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5837214331049953344==--
