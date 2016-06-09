From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoc: wm8731: add 32bit mode and normal
 mode with 12MHz XTAL
Date: Thu, 9 Jun 2016 15:26:37 +0100
Message-ID: <20160609142637.GX7510@sirena.org.uk>
References: <57595463.2070700@flatmax.org>
 <20160609115624.GP20422@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1420284215355806415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3B5B26070C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 16:26:46 +0200 (CEST)
In-Reply-To: <20160609115624.GP20422@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org


--===============1420284215355806415==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bPWyEuR5EuEA2EVk"
Content-Disposition: inline


--bPWyEuR5EuEA2EVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 09, 2016 at 12:56:24PM +0100, Charles Keepax wrote:
> On Thu, Jun 09, 2016 at 09:34:59PM +1000, Matt Flax wrote:

> > I have ensured that this does not effect the db1200.c machine driver
> > (the only other driver to use a 12 MHz crystal in USB_MODE). It also
> > does not effect the other machine drivers which use the wm8731 codec
> > as they don't use USB_MODE nor 12 MHz crystals.

> Probably best to split these into two patches, I know they are
> both simple changes but they appear unrelated and if they arn't
> you probably need to explain why they need to go in a single
> patch.

Yes.

--bPWyEuR5EuEA2EVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWXybAAoJECTWi3JdVIfQjPUH/RwKpe77nH/K63l3TuCfPVj1
v/hVa8tNTrAoLhnllvBHHSkmbBTdqKQOfs7w55I4A+n3MhiM4lMjheCAv1KAlvhd
9nbtUkDaUCVpYR1nMdZIvg/6in318K5y6RIu0eW48m3ezDJL/h2qQ7UxbPD/PFAq
lJ7SI+VK6h0zkVBd7rcTY+jqspRZUNENt2hAiA0ZcUN8xRPRIdPERSnOfS911Uci
RK+LCeVxgGKB7qkVw16n8LLeZ05f6gVIE9jwD6qwVbdgBoiSUpBH4Iry9DlY22Ha
96dGFIkBBxrlvo/JBeO7UVT7J1Md5b9i4nUsLlm1ktSFVKQa/FTr/dY1AwfT50g=
=riqm
-----END PGP SIGNATURE-----

--bPWyEuR5EuEA2EVk--

--===============1420284215355806415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1420284215355806415==--
