From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/11] ASoC: cq93vc: Cleanup manual bias
	level transitions
Date: Thu, 27 Nov 2014 11:11:59 +0000
Message-ID: <20141127111159.GL7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1641891072842973664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30ADC265DC5
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:14:05 +0100 (CET)
In-Reply-To: <1417031880-11364-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1641891072842973664==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="81QuOO+3cNKYbCh5"
Content-Disposition: inline


--81QuOO+3cNKYbCh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:51PM +0100, Lars-Peter Clausen wrote:
> Remove the manual transition back to SND_SOC_BIAS_STANDBY in resume. This
> is already be automatically handled by the ASoC core.

Applied, thanks.

--81QuOO+3cNKYbCh5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwb+AAoJECTWi3JdVIfQqD8H/1+SLO4cD7vGQuEg9R7scwnP
LFL+jagzng0MV3h1B0pKOBnU0+MstGvMfnYwcOsfzFHg6Hdqi9R1xcfOLNmZswtL
MRSPbhhHlE/feuU0znXudeoBnWf4jxYtJ2+DKiYVgFuFuOp9A4eAYtGJNgQHfNPB
3r1LrxDw6SxKxwqMPTw5R9YMUpYlZO9x/atLuBwjFDgQri1/EdqulloQwivMBSCy
viOUgavV5BGFlih9iosorWnBlFTc4qP07BWWwgC7n79dNbJb6qMsaWYGp4MdhA3k
l23SYxYiHQQgXEymcqkm5SRSxVcjyTbddNDB27/QV9iv8JiuvhgxN8w9zbBrdkA=
=KeH6
-----END PGP SIGNATURE-----

--81QuOO+3cNKYbCh5--

--===============1641891072842973664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1641891072842973664==--
