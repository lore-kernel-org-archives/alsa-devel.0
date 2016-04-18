From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Add SPI support
Date: Mon, 18 Apr 2016 16:14:58 +0100
Message-ID: <20160418151458.GF3217@sirena.org.uk>
References: <1460745059-5737-1-git-send-email-nh6z@nh6z.net>
 <20160418103554.GR3217@sirena.org.uk>
 <35635C45-EDA1-43C3-86DF-9C6DBEA27846@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0222445547553358963=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4743626154C
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 17:15:08 +0200 (CEST)
In-Reply-To: <35635C45-EDA1-43C3-86DF-9C6DBEA27846@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeremy McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0222445547553358963==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aPOcx+xoD6gZZHnz"
Content-Disposition: inline


--aPOcx+xoD6gZZHnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 07:45:35AM -0700, Jeremy McDermond wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > On Apr 18, 2016, at 3:35 AM, Mark Brown <broonie@kernel.org> wrote:

> > Instead of putting everything in one file please split the driver so it
> > has separate core and I2C modules and then add a SPI module like we do
> > for newer drivers.

> No problem.  Thanks Mark.  Would you like the separation of the I2C
> code to be in a separate patch set, or is one patch set with two
> separate patches fine?

Separate patch please.

--aPOcx+xoD6gZZHnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFPnyAAoJECTWi3JdVIfQu38H+wQJG09g+GI3Cg103hcyj00D
HWMhzMy9pPVfhEMNV2WYf5K5FneS8E5PBFyqQtJeGG+/zwL5LQOuA4lQ6K37IOsC
ukINqn4ZERypXn3Nwpy+RMpKAPeexszZ4HO1rxn4WcXCw6T5VHbvdB5YLZvfYRO1
bii50gKO2giP/0C9ES5lAf5fqjkdPluVGjRjq8rqZRVFKQqLes55lJAe/zxGoyqC
IET9pmVmx3AnL2Ygk7+04vMGJCtyEEn56eJA3YPwgNVxuA/4yd9p4AbtBpHw/A+b
fUHkn5gRWxPq88EkS+dmZP61d70mwLC01tCtDzlzyFZwnt4o0QClnGq9dSjIxTc=
=XETE
-----END PGP SIGNATURE-----

--aPOcx+xoD6gZZHnz--

--===============0222445547553358963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0222445547553358963==--
