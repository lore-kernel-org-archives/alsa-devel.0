From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mmp-pcm: config pcm slave via
	generic dmaengine
Date: Tue, 17 Dec 2013 12:49:54 +0000
Message-ID: <20131217124954.GY3185@sirena.org.uk>
References: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7432616666892159364=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C53FE261178
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 13:49:57 +0100 (CET)
In-Reply-To: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: alsa-devel@alsa-project.org, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7432616666892159364==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="20Lf8O5TUnq2EaQf"
Content-Disposition: inline


--20Lf8O5TUnq2EaQf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 04:22:24PM +0800, Qiao Zhou wrote:
> use snd_dmaengine_pcm_prepare_slave_config to set slave config,
> and remove the max_burst_size =3D 4 hard code.
>=20
> select SND_SOC_GENERIC_DMAENGINE_PCM for mmp-pcm.

Applied, thanks.  Can you also convert to use snd_dmaengine_pcm_register()=
=20
and remove this file completely?

--20Lf8O5TUnq2EaQf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsEhuAAoJELSic+t+oim90zIP/2BF0Pa8xafw1iInjxrrqoVe
pQBiekxJyRDjx/jdQORcOuwa00yhRzScLkkOUGCOAm9kCl16hdqY+IgC+fKYARtd
kjmy+DgMwkAO213DjT8NkPneHq0Z4rmcTSIz4Tun7t/+lqG8Yzh1C1X3EypvSTvD
cjnc4989M3SnUYyEM7zAMupebWrsswBvU3B0ipOPjTzMqiDgT3nta7lUsGXYG2kH
PfKqOyjnsoVPu6XBLa3z5z3+o8GGG7AlN/4On0OgpTWUI0Y0nBj6YouTgpTwNzxV
6pxhwaDWv+tCKoDTRoo3o3ZFqEAR+zXW4fVmBwTiHmDTLj6BoDZ3G0Xqkkg2KDFs
fC3elQFWD27jmLUGA0aI9qjM4e4wwjiK4M0XhSzK2YnUheo+kmknaiXUajLmXrOR
Z7D9E6DUYD6ESwS7h0ik59w86PBNUMJPkseQ/1BI4/cQOUPSWxWPPnXCCcPE3iZx
YXsnjhW5iFLbXmth2hj5/pCw2zAXp1m+XH6xixV+GDb/G06KqEwhTJ45e7+k3LsO
/hCBeL9lPm+cBFtFzpKNaZXYUrHOyb7LPIznpWQlwJhcwh38Kc+GDk51vcwS/xa+
hW8k5Ez3MTsjJoyRUen6c4pZEnhK5iLy0HQUOao6Xq4WNrnBRRRlCWb9dOJfATSR
1a0XjWcBscqgsQ/p0/y7
=K5YS
-----END PGP SIGNATURE-----

--20Lf8O5TUnq2EaQf--

--===============7432616666892159364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7432616666892159364==--
