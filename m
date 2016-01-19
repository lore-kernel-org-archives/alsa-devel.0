From: Mark Brown <broonie@kernel.org>
Subject: Re: DAPM core: update bits in the same i2c operation
Date: Tue, 19 Jan 2016 00:47:39 +0000
Message-ID: <20160119004739.GK6588@sirena.org.uk>
References: <CAES_P+9cv+1YdKB+DwD+nHGLqQVE7iUhh4ZQM_CdWXK=qwLiRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2927831052021088759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09CAF2604AA
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 01:47:51 +0100 (CET)
In-Reply-To: <CAES_P+9cv+1YdKB+DwD+nHGLqQVE7iUhh4ZQM_CdWXK=qwLiRQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============2927831052021088759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eEmDdn31p7UZm7Rj"
Content-Disposition: inline


--eEmDdn31p7UZm7Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2016 at 03:16:39PM -0800, noman pouigt wrote:

> I have two DAC's: left and right and I have made this two as dapm control=
s.
> However left and right dac needs to be enabled in the same I2C write oper=
ation.
>=20
> I can easily make a callback and can enable both left and right bits in o=
ne
> operation however wondering if ALSA dapm core would have a better way
> to handle this.

> Where is the relevant code to handle this i.e. merging two dapm widgets
> writes to the same register in one? I looked through the code and found
>  that every widget gets added in the up and down list which is individual=
ly
> powered on/off.

You're looking for dapm_seq_run() which coalesces any writes it can.

--eEmDdn31p7UZm7Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWnYerAAoJECTWi3JdVIfQutoH/2c9tmtdYz2zg4iZY56/zATn
aq+JaRr+vVmtnrqvwI2TN0e7M/SELMjT0tYhfq3VLnPXnjcG+YQeBIl+2mH0dhSP
3JyRyo89n/V5T3AFypv/LZO8g/dexi3r8YQ6oDnWcof63kOEx33me215aSF5U8+Y
SVTNMdHpM3X7Yt18A+Z5ESmOFK6BfTl4BwAZUZRo4wLH3awaGohwQbOGAxpJDU/J
yxmfu8eQNyrJGGfkToZaF19rW7AvFhz463c/Z/o10YuvkVMbJHlc96/sBVKVmMVc
ajvHi7dunJzUNf/Qz+5lgYH2MTMybUuZVGEiXHTUMWNsaph6/tT4fEJgykCP+Tc=
=f6av
-----END PGP SIGNATURE-----

--eEmDdn31p7UZm7Rj--

--===============2927831052021088759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2927831052021088759==--
