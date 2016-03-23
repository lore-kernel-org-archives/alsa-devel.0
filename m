From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau1701: Reset codec based on
	sample rate changes
Date: Wed, 23 Mar 2016 12:48:49 +0000
Message-ID: <20160323124849.GL2566@sirena.org.uk>
References: <1458734303-16307-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9065404009247602688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46323260534
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 13:49:01 +0100 (CET)
In-Reply-To: <1458734303-16307-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9065404009247602688==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uuwIKJs7er60DmzI"
Content-Disposition: inline


--uuwIKJs7er60DmzI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2016 at 12:58:23PM +0100, pascal.huerst@gmail.com wrote:

> Instead of checking if mclk/lrclk ratio has changed, check if
> sample rate has changed. In certain cases, the mclk might be
> changed in the machine driver, which can lead to the same
> mclk/lrclk ration, eventhow the sample rate has changed.

> Since the codec has to be programmed differently for every
> sample rate, its better to check for samplerate changes instead
> of mclk/lrclk ration changes.

Why does this mean we have to reset the CODEC rather than just
reprogramming it?

--uuwIKJs7er60DmzI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8pCwAAoJECTWi3JdVIfQlNQH/jm4bjMXaYth2opBNPS5jPh0
mq2KFklmr2p1oayGt19wDhJBvL+aE4WS8xebJwWORW0Zr+n9DaidlEzTTafoHZaz
mKH33TuPcY0RgjsVYBTOcmgV8kiOFqZXG7EcPpP+D77SP1YS8MF9zSUq8Fkt7NLx
n0OJDpvdT/5Qcz5V01X3b/gJ+ssZEWp5bYzE3DOHrsIDNAmVhlTU8nopewaVcSDq
5UGfDLnlSrJrovXvDt6YQbYGeKXb+wihRArO3V5cCjoC37Vs1uQXltWwOKY1r4Hu
SI9PRHMJ8Q8wRigtyHIHNY0iGbBOdrgnVpYwGphOUMQUfl+DhXb00a7yKXXDZqc=
=DNFk
-----END PGP SIGNATURE-----

--uuwIKJs7er60DmzI--

--===============9065404009247602688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9065404009247602688==--
