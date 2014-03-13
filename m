From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 04/12] ASoC: omap-abe-twl6040: Register
 machine level DMIC DAPM routes with the card
Date: Thu, 13 Mar 2014 19:10:33 +0000
Message-ID: <20140313191033.GH366@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7644191908431642399=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F47526547F
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 20:10:55 +0100 (CET)
In-Reply-To: <1394634460-15889-5-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7644191908431642399==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZMT28BdW279F9lxY"
Content-Disposition: inline


--ZMT28BdW279F9lxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:32PM +0100, Lars-Peter Clausen wrote:
> Machine level DAPM widgets and routes should be registered in the card's DAPM
> context, rather than in the CODEC's context.

Applied, thanks.

--ZMT28BdW279F9lxY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIgKlAAoJELSic+t+oim9Y/wP/23PW9ymfTzoZDyu1HDE4fJN
vOVdjjF/RWNLEHejwsVDFLmiG369GoflrczIfgePRIr3q7rTYk/GgEUnoHZyy2Mp
4DtXSYR5ISuDjOaPrc3595lumVUZ/D4P6+tfnQP978JCULn7NJEmxyUCBrErwoml
iJGW5D0fvB2pdc5UH1aSQ5gruu+9VbH9db4bbZ6K9y2kxutN9XEPcIspjvr/kNT/
10W8DXf11Bt3zN4ds7l5PYK4bAtzMMNHK8oX9Nv0m4qEdpnK7tCxhT4cUfLOlAG8
eI3mtiEhRmdgmayNgC/Gy54G4u8DfmkRVdeWcKNBNeBoIO7yQk/GYOeiO4JszAoi
FL24mOSjClUsVoeH8POSg8L4LfK7hLXp+3WrYzyXffEMdo/nYkWQTtq3yT5WKA84
WpvDE8ZDeas7lqJj0bUIBI9fkorNlTACOR20eyD17WxnIbZ7aAVX5aTTwJiBwrvm
ubu9Fd5bdoyeeBJAcTDhCRE9FRt5soXKYuc/sC+9liOaoDmKxYV+k2Os003aBsDC
2dCErP9NxegmetFQ3+wh305xv55ys7x7v6D7uRP8u2p115MxUive1PMFZlXmsd5y
Av7tTh4hxxTiGBV+EDG7p24+dHveYaaaNjF5AqBxCwt+BJRvojAiKC4fHNFBTH69
lwlr4JD2rxwrx7mZps/u
=0+BI
-----END PGP SIGNATURE-----

--ZMT28BdW279F9lxY--

--===============7644191908431642399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7644191908431642399==--
