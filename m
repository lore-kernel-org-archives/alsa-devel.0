From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add generic simple-amplifier
 support
Date: Mon, 25 Jun 2018 12:44:45 +0100
Message-ID: <20180625114445.GG9413@sirena.org.uk>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
 <20180625112144.GB9413@sirena.org.uk>
 <1529926289.2900.26.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6153986651707280225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D2A4267783
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 13:44:46 +0200 (CEST)
In-Reply-To: <1529926289.2900.26.camel@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6153986651707280225==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 25, 2018 at 01:31:29PM +0200, Jerome Brunet wrote:

> Same comment as on IRC, you driver looks very similar to the one I posted a
> while back (sound/soc/codecs/dio2125.c)

> Could you just add your compatible to the list in the existing driver ?
> Is there anything I missed which makes them incompatible ?

It's probably a good idea to rename that driver so it's a bit more
discoverable - you're absolutely right that it's very similar and doing
basically the same thing but I'd completely forgotten that it existed :/

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw1a0ACgkQJNaLcl1U
h9DnKgf+LkePrdTrZCOvwHUMtfBIFKO6eY9IPovXrVLYTbfyNm8Eh0NlNGGIFaHr
Ia5srtQDeIr+RwCAR+r534bmck63tg+FnJ7ipDVnbMIw8aYgPq057FwtHAG1pQF0
7J3iXaYxg2oRLhIiZprs/zEjyCDbQQJgtWw+Hd/hfqhuopYld65r4d0RVRJyelLL
1POT1AihAXM/Enw3aNcWaZ1gWvnr3BPcJ2hWUQ5Bi2wfLfrtz0q/B+V+qXUQBXTH
4GOqomMDg2tjCAAEYcZKayj5tTH09F7Gi9Btqqi9SxhnRyQY5zNpLawfPtBsILIn
i2UhWtlS1JLoo6/dqwcZ4S9uqrSexQ==
=zqPi
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--

--===============6153986651707280225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6153986651707280225==--
