From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4642: Replace mdelay function to
	msleep
Date: Sat, 31 Dec 2016 18:52:34 +0000
Message-ID: <20161231185234.ahriajbvhdrla37d@sirena.org.uk>
References: <HK2PR06MB123504946F7D9CBFA0445A74BE900@HK2PR06MB1235.apcprd06.prod.outlook.com>
 <HK2PR06MB1092F11AFF71BCF6CFE41CE6C5900@HK2PR06MB1092.apcprd06.prod.outlook.com>
 <HK2PR06MB1235B6435DA88D1DEEFF37FBBE900@HK2PR06MB1235.apcprd06.prod.outlook.com>
 <874m1zay9v.wl%kuninori.morimoto.gx@renesas.com>
 <HK2PR06MB1092376B43150072E37148DBC5900@HK2PR06MB1092.apcprd06.prod.outlook.com>
 <HK2PR06MB10928AA734902EC15D19EE50C5900@HK2PR06MB1092.apcprd06.prod.outlook.com>
 <87k2auxk40.wl%kuninori.morimoto.gx@renesas.com>
 <HK2PR06MB109231252C5BD2F3CD6A7E93C5930@HK2PR06MB1092.apcprd06.prod.outlook.com>
 <HK2PR06MB1235B7DA8F97119F90296F4ABE930@HK2PR06MB1235.apcprd06.prod.outlook.com>
 <87bmw6x7ih.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2983084367128132839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA7E12670B3
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2016 19:52:41 +0100 (CET)
In-Reply-To: <87bmw6x7ih.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Hisao Munakata <hisao.munakata.vt@renesas.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Simon <horms@verge.net.au>, YOSHIYUKI ITO <yoshiyuki.ito.ub@renesas.com>, Tsuyoshi Tsumuraya <tsuyoshi.tsumuraya.zy@renesas.com>, HARUNOBU KUROKAWA <harunobu.kurokawa.dn@renesas.com>, RYO KODAMA <ryo.kodama.vz@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2983084367128132839==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nkrzp4nkrba7alrn"
Content-Disposition: inline


--nkrzp4nkrba7alrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2016 at 03:55:11AM +0000, Kuninori Morimoto wrote:
> From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
>=20
> Replace mdelay to msleep to avoid busy loop on ak4642_lout_event().
> Otherwise, sometimes playback doesn't work correctly when pulseaudio
> was used.
>=20
> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> ---

I can't do anything with this without a signoff from you Morimoto-san as
it is required for licensing reasons, please see SubmittingPatches for
full details.

--nkrzp4nkrba7alrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhn/nEACgkQJNaLcl1U
h9B0cQf+OJgzOwqSjND1SQzcjfYphfYtsvHRAlEEk3dIRgCuHBnn/vpTEOCxKv2a
uKJXiN2JTRB6k4dt/JTERNu6j+ZErNGw8BWKdbDB4YTmGay/mDlZLtcpIxHdndzY
nN70QXi5dS6iD/t4jALvmgZhPVKDuGas4OKYIXL44tRs1U7fImAMfwPkwqEN/ZeO
SxwJIGhZUtM3j1TCuj6uSxBEHzuT3AmuMkDeWJ4Xqo0sJNJV7sny3NNZGMcbKgkg
rfYK5964K4mmeyB2QtswJKOkGYysudjVWvCuHtWBOzdQoYJndrlVcBmjMqC16+/+
32QmCu//0kEPamPSPxz6SNM/Y8qyBw==
=mVyL
-----END PGP SIGNATURE-----

--nkrzp4nkrba7alrn--

--===============2983084367128132839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2983084367128132839==--
