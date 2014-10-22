From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/12] ASoC: dapm: Remove always true path
 source/sink checks
Date: Wed, 22 Oct 2014 12:02:54 +0100
Message-ID: <20141022110254.GT2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4385984637676771178=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C458265163
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 13:03:05 +0200 (CEST)
In-Reply-To: <1413826604-3212-3-git-send-email-lars@metafoo.de>
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


--===============4385984637676771178==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nx8xdmI2KD3LNVVP"
Content-Disposition: inline


--Nx8xdmI2KD3LNVVP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 07:36:34PM +0200, Lars-Peter Clausen wrote:
> A path has always a valid source and a valid sink otherwise we wouldn't add
> it in the first place. Hence all tests that check if sink/source is non NULL
> always evaluate to true and can be removed.

Applied, thanks.

--Nx8xdmI2KD3LNVVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR47dAAoJECTWi3JdVIfQOlYH/07YIr4uxp5wvL6MO4JrSIqS
1mxZVba3xZTP/8g6M/K6kSb3BBhqNwRHwaDv4hvbtkbZE2uENAlZC1ZtrGDoVyS4
EtK/laHZEPeU2F2LMyn8A2FqQSvZ3YXwZ0NgCuxQ5duimEQ8/87KU/2Cn4ja/bfc
jf5OqavWVfZx/mN94YkcVbufjZIv+q4+OUeZ5HEW4HUUi7FznVrmfLxhAZ1CZm//
P2CdTAYn95hgJn5Yxkb8DAieCa13aFf2zJ0mkQJY9DrERXxzvSm/mT3BleNCQn17
i3HeRZxftPsnvFQsXaMqwvxfl5y6jCKa1BLoCt/4EW4rgqddrR0XohS+U+aFH0A=
=k2PM
-----END PGP SIGNATURE-----

--Nx8xdmI2KD3LNVVP--

--===============4385984637676771178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4385984637676771178==--
