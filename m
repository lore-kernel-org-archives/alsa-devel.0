From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 31/32] ASoC: wm9712: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:43:34 +0000
Message-ID: <20141124184334.GY7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-31-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1674174586012387926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 572672656FB
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:45:29 +0100 (CET)
In-Reply-To: <1416746269-4935-31-git-send-email-lars@metafoo.de>
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


--===============1674174586012387926==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5FSjmmofnIBL+CP8"
Content-Disposition: inline


--5FSjmmofnIBL+CP8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:47PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend. This makes the code a bit shorter and cleaner.

Applied, thanks.

--5FSjmmofnIBL+CP8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3xVAAoJECTWi3JdVIfQwoAIAIG0++KHr13vZaen8ROJ3P+U
BfnuVAwp/BxojedXiBorM0G19jFApew/vSabIZbgg0VXYEwJQd/Kahc9q0lRtCHf
3gbRmrEhuixQ1xJIhhYgkRpvXLjFrsu4SN7U5vfq5AW5+L+Y8KzbCsLsGpGM0RdZ
qHWO/qFafX9KVqDUHwQJQy+eEWRR8Mkpjv6h/K48t0ZfPaFsbNOlaSy5ozhuOrKa
jlYOWYZhpwr+Bux+ypYvaSh3Q25yBmmr7Wab0DijQr9tAIMKfTEN6SLtPMXxYB+7
EHTMHTL+M0gH8WOZp5IqFoxzXPZOx4Tftsc8EV5jYyo0/l8e0PbudDJJ50LZza4=
=S7nT
-----END PGP SIGNATURE-----

--5FSjmmofnIBL+CP8--

--===============1674174586012387926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1674174586012387926==--
