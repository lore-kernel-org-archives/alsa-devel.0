From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: wolfson: Improve compile
	test coverage
Date: Mon, 4 May 2015 12:40:34 +0100
Message-ID: <20150504114034.GC15510@sirena.org.uk>
References: <1430676815-10450-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1481824571927893884=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9459260502
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:14:14 +0200 (CEST)
In-Reply-To: <1430676815-10450-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1481824571927893884==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 03, 2015 at 08:13:35PM +0200, Lars-Peter Clausen wrote:
> While the the Wolfson machine drivers have a runtime dependency on a
> specific machine there is no compile time dependency. Allow to lets those
> drivers to be selected when COMPILE_TEST is selected to improve the compile
> time test coverage.

Applied, thanks.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR1qxAAoJECTWi3JdVIfQdPAH+wcIVdTXBfB1A7JXZTyjW7D1
T87kdfpgjTX5uNXQNdK3Nf49OUTPv6xbd4rWXMYh1BP9tP3ITaUAWgs61IUcMM1F
t5po914hVgwpFdY5H8lErUq5mIraCS9CWYWXM4mTYs6q7SgtBXjMK8E0crCmHZF6
y3KjRKqhZJt/ugCFfDRa9npIQI87nq4GFlo7cPNdxd+n7VOJi6bn1sUUORD70tWc
oECIqigz+L/yn4HfORtfqPCipRya3G7hpirHJIkLTnTbMeDih+NIo9AhytNaysiw
tIh+Le2bj9zk13Dxbi+LHcXu54WEzfDL4xPFwLInNlSUXakhpOVbWKCLA+jAFpA=
=cIUt
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

--===============1481824571927893884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1481824571927893884==--
