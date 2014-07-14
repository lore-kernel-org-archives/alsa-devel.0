From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Mon, 14 Jul 2014 16:58:52 +0100
Message-ID: <20140714155852.GG6800@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-4-git-send-email-arnd@arndb.de>
 <53C153FF.4090705@metafoo.de> <20140712194903.GB6800@sirena.org.uk>
 <53C28B74.6010401@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1504671808442560697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA1B261A96
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 17:59:15 +0200 (CEST)
In-Reply-To: <53C28B74.6010401@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1504671808442560697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Content-Disposition: inline


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 13, 2014 at 03:36:52PM +0200, Lars-Peter Clausen wrote:
> On 07/12/2014 09:49 PM, Mark Brown wrote:

> >OTOH that's a more invasive change that's harder to do mechanically -
> >I'm not sure it's sensible to insist on someone doing it for generic
> >cleanups (rather than actively working with the particular platform).

> I don't think it is more invasive than using platform data. I did the same
> recently for jz4740 qi-lb60[1] and the changes in the patch are fairly
> trivial. The non-descriptor API is deprecated, so this even if this patch is
> applied as is sooner or later somebody will mechanically convert it to the
> descriptor API.

> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=218e18a3728507ee82ed2eb10c789671a00e34bd

The translation into the GPIO_LOOKUP() macros isn't sufficiently direct,
with platform data it's just a case of putting the same data in a
different file but with this you need to figure out what the GPIO bank
is called which won't appear in the diff typically.  Someone will
doubtless want to finish up the gpiod_ transition at some point but it's
not yet at the point where it's worth blocking unrelated cleanups for
it.

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTw/44AAoJELSic+t+oim9KgYP/A+aFUsP/MXqXDzZ0eCK9C0X
GZ/5GiU7RH48wEjp+akkCpgbKaaIxn1ZSzvsAGohSZgo7L1tQJBGdYEWAqzSssP5
fEBni/eOsA/ZwFwgnLPwgxKGpOEBpj0y3FpbWgwsvd2TZeCfc4nrQc4mXM7E33oy
DhRYChTG1LAkUOmR6Ak7LAR6YZ/0nXiOBRFmWQabJN2zMcPYgo7sFFLzTgk6dHiD
KnjKYWn/2mNr1DBOtK3hO24FIVXhjrd07N9RS7O6B5zWb2tsb8bu80DTVzi4q5u0
uWKqKFy7eWdVjuTNbUsaGe41adyn47zy3B7ULpMP2LPo8Th5PEGA3LKw1jIRLMhG
UDUYQr08xAcc7ZARCiTj//QoSKmDSltIbKHS8qL24D7hC/0+VgNC2BMvriMXjWcU
Jn6NAhWru4Sp8Gw6quythS6SkSbTIPRcdoRM7AiZYo/8ns4VW6lV9TVXNxXEm2fD
xVio6sokIJ/dyJG9xm3TAo4PyM+UFZKWb67DCTZtXANyw9RU1cIKv10xdP2aUSkP
P4Zx1wiPOPwMLg97Nngk41xe5pd1B8f3g1R2McyPWri2rKfzFk3Y+bDqiw7ErXZJ
F+ssmS/4oBCU5pwNB3O15oScn8QAqoAnQDuYDQvZmeoPUXOudIFix3d8epJJ8H04
NnMKjHwHDwaf7MjQ9DK9
=8yDL
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--

--===============1504671808442560697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1504671808442560697==--
