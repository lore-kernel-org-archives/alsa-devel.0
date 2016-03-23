From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau1701: Reset codec based on
	sample rate changes
Date: Wed, 23 Mar 2016 13:42:48 +0000
Message-ID: <20160323134248.GP2566@sirena.org.uk>
References: <1458734303-16307-1-git-send-email-pascal.huerst@gmail.com>
 <20160323124849.GL2566@sirena.org.uk> <56F29C06.3090004@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4823574919609083233=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE50E266850
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 14:42:57 +0100 (CET)
In-Reply-To: <56F29C06.3090004@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, pascal.huerst@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4823574919609083233==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AZ3TfZx6WW1DY2Jl"
Content-Disposition: inline


--AZ3TfZx6WW1DY2Jl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2016 at 02:37:10PM +0100, Lars-Peter Clausen wrote:
> On 03/23/2016 01:48 PM, Mark Brown wrote:

> > Why does this mean we have to reset the CODEC rather than just
> > reprogramming it?

> Quoting from the datasheet:

> 	The clock mode should not be changed without also resetting
> 	the ADAU1701. If the mode is changed during operation, a
> 	click or pop can result in the output signals. The state of the
> 	PLL_MODEx pins should be changed while RESET is held low.

That should be in the commit log and/or code since that's *extremely*
unusual and is likely to surprise people.

--AZ3TfZx6WW1DY2Jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8p1XAAoJECTWi3JdVIfQXugH/jXplurdzwwNrt5AtzUFXOi2
l+b9AO11gV1vcyaNWK5UdbMWkaq4qwBf3iQv7c2bPklm5nRNBkxy8XXFIp0HpuNe
7JZLWIdmy7sCc7PWsEFT9ADzPU6j7zvhMlyMHeL1y4rslAPCMmIFewS9Oo8zDbTB
l5v1DaJtGPY68OMgNG+PXtY0Hv04hqQo+f66HiGhoYPYcdtqirs+uI824PktFYRX
wsd+B9kxxJDEj/J5QvI4XblReYqZSoRg6h7/3eTbsXI3S5Ylm8mH8nilMq3Cz8oR
lfyA2Gr4rNuR3YQRYNp18S9QjQ7j5v4r/iqzeUUkW2WBVJgCnUfCXLRN1GGgnFg=
=PB/2
-----END PGP SIGNATURE-----

--AZ3TfZx6WW1DY2Jl--

--===============4823574919609083233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4823574919609083233==--
