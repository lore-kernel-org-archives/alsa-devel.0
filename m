From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: pxa: zylonite: Convert to table
 based DAPM setup
Date: Mon, 3 Mar 2014 10:04:22 +0800
Message-ID: <20140303020422.GT2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
 <1393685300-5307-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7878301443476848972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C78265580
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 04:36:16 +0100 (CET)
In-Reply-To: <1393685300-5307-8-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7878301443476848972==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BVQ1RKc6+nLPB5pT"
Content-Disposition: inline


--BVQ1RKc6+nLPB5pT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:20PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes. This on one hand
> makes the code a bit cleaner and on the other hand the board level DAPM elements
> get registered in the card's DAPM context rather than in the CODEC's DAPM
> context.

Applied, thanks.

--BVQ1RKc6+nLPB5pT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+MjAAoJELSic+t+oim91F8P/RgPoEPdYteHKUpVpP/6VWLG
hkSJSJ5laKXBGopSwkX3+3qhZjD6mFHsaL1wa/lVpkQf01zY7xBMCQiXg6nXthVn
mwP+dPrM8mwK6DMVz71WlLlwDw/T+f0NaE2SMgDmZEJ5QA21vsXXPdm6UNk4GaJ9
F2/LCin7iHBC8bD1YbINmZUST519xt+U6YaUsS5eKRk6aWe6xq2fTRBZMrkxA3+Q
luS2nCEWEFbUxlQqbWBhQWNg2j7b9zZGW9ZQLeihEXRF1ABzCGqEwQttDBMhvXKn
cVWT2MLvDSFaNmdXwMplBFTAIp5dbMpB7xEJirAlIjxedoSA0j4vkHXCiR4G9SZU
9Cl5HcNMpuI+vSGMtHceTXwFQec8/ya94uuk+G2K/NVPyp2UKm/D0y9YdViEVgl9
BKIsszj3rUhlYCqJj7BpYCUS3uRmPSeaFVCgqnb1MAwAd1vjCpczx1zweHGOAIjv
KhlUwvyEz+rDMK6JhJsHuPrIebzCwEyOxX2su8S4rWU4odxYiqW0Z6aW8IZWX18Q
Ma1g7v1Zb0zYVav86MGBeY1uiJJJrVs9TK71ByadLS6ro4+tDnRF8ezN1YOZVkas
VF3+921Vab9NrAGdGkFd4utVKcNcG6TV8noz2QQv83fn0mf2Mas+ZDHri1I/z2Ep
p9sZEs80xJoZb9wXK44E
=uCi4
-----END PGP SIGNATURE-----

--BVQ1RKc6+nLPB5pT--

--===============7878301443476848972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7878301443476848972==--
