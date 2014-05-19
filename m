From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs42xx8: Do not use rtd->codec
Date: Mon, 19 May 2014 17:14:14 +0100
Message-ID: <20140519161414.GY12304@sirena.org.uk>
References: <1400479384-19108-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4488444885283989466=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 010082607C8
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 18:14:42 +0200 (CEST)
In-Reply-To: <1400479384-19108-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4488444885283989466==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jgKy7pbvBiUftTGC"
Content-Disposition: inline


--jgKy7pbvBiUftTGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 08:03:03AM +0200, Lars-Peter Clausen wrote:
> rtd->codec does not necessarily point to the CODEC instance for which the
> callback was called (e.g. for CODEC<->CODEC or multi-CODEC links). Use
> dai->codec instead.

Applied, thanks.

--jgKy7pbvBiUftTGC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTei3TAAoJELSic+t+oim9My4P/2D84AgGGraD/R0NpVosQEN2
DUB9dxe5ADTmCPHW5oKfzhAXx7mZhAaPI92igPOsv7qM4utLghVyY9i0D4J7gxsz
JjjjONwP95rnMIArXPVkYcFGZgMgfZ/d7iVVDIHbBvvrOquAed7OB6WuLj9qwZCv
17sB9Hwq8r1c0Jos7R+JEssLdRobcLP2fPgqOrgf6VqOumKN4kmrv7k1MYcXUKu4
P0reWZQF/qtNeQTaV4tAYdXG3FhZKefBMjO53xG9nyQcC1oGgWqCNzbeLyt3M5tf
XRDwEUy+NvYqEdMxdm5M2ejR+q5FEuCvaIHFZ0CzalgkSWUdPlfjPk1U6V5Q4RsV
vCJZA76Lbsk4s5fQ46oIwTNg0YCWxKVR/hA/fTNqRRgVsc3W4k+HqY2oJJDNKFKs
VYeVro0DfEZc1LFTsBemuFoQW2IB9U/viaLCKRB2QdKWFxOi6/Kiz+c5M41RV1L6
zThBsUazysBRgSNzFrRkXwEhE7jgxz+U3UkLe0CnwnIATSwefPLKt8WQhVT/mXV3
wEHGWZ34caPICxLpbOlIHXGpHnyf9+4HpHp00JavorrF90LT7QtatqNX/Z8PEwrK
W2sKoq+Rro5N3+LfZC9WrbCW2QDs3M94BKuk/b0WxF0KFYKH04iZo82nYK9pqsBG
Y9Ki40y2KXdyiiG1gH2P
=/NaZ
-----END PGP SIGNATURE-----

--jgKy7pbvBiUftTGC--

--===============4488444885283989466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4488444885283989466==--
