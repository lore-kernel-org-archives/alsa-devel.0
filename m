From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Thu, 18 Aug 2016 19:24:39 +0100
Message-ID: <20160818182439.GT9347@sirena.org.uk>
References: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
 <20160815140604.GK9347@sirena.org.uk>
 <57B28F1D.8070409@nuvoton.com>
 <20160816103854.GP9347@sirena.org.uk>
 <57B3B107.9080702@nuvoton.com>
 <20160817094221.GG9347@sirena.org.uk>
 <57B5098C.7020102@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1769641004749926717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D450266042
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 20:24:48 +0200 (CEST)
In-Reply-To: <57B5098C.7020102@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1769641004749926717==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hH+ZLLRw9aZ7+ob6"
Content-Disposition: inline


--hH+ZLLRw9aZ7+ob6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2016 at 09:04:12AM +0800, John Hsu wrote:
> On 8/17/2016 5:42 PM, Mark Brown wrote:

> > The whole point with raw read is that it isn't reformatting the value.

> I post the partial function. The format_val is not valid for our
> codec driver and we can't use the regmap_raw_read(). It's the reason
> that we need to make the function like regmap_raw_read().

Hrm, and you can't just make raw read work because other users are
relying on the native endianness for single reads so bulk_read() then
for the actual I/O?  At a bare minimum you need to provide comments in
the code explaining what's going on, at the minute it looks like
something that needs cleaning up.

--hH+ZLLRw9aZ7+ob6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtf1mAAoJECTWi3JdVIfQyS0H/ilFl92uc2jPKATI/rqRMiil
Ur5TGcD6IZu8mhvfYULeNR1wWqIcd4PNntfWY5s0JmVYrDx/Iczs+ZY7ZSwQBLtf
LHq7O/HlNF68F3LSxUAVO95WqhAsz1Iq5T/WL+Lmum2+vSxtuS9ol7jwHTkXsgwP
YbjIm+YNKeKCTNwpqfMLFt1DsSE1sLIGOhaLhoZmyf2g6/EBEh2YwKL/aVWjKei4
64A5VNDK4D6OewxWsrkPPvDrWBTS3WiB1QtSd/lRWgHnI2grKqd++TEYwMDzKzeR
R1a92MM+nRcGGjPPWl+SwTgTYOVt23S9R2+kdrZWMRwmAQjT+EApZiT6jYBbo+c=
=mAdg
-----END PGP SIGNATURE-----

--hH+ZLLRw9aZ7+ob6--

--===============1769641004749926717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1769641004749926717==--
