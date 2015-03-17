From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/12 v2] ASoC: ak4642: tidyup DAPM route
	for playback
Date: Tue, 17 Mar 2015 12:22:41 +0000
Message-ID: <20150317122241.GL28806@sirena.org.uk>
References: <87egopk13d.wl%kuninori.morimoto.gx@renesas.com>
 <877fuhk0t1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2095804185757637987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 721E7260696
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 13:22:48 +0100 (CET)
In-Reply-To: <877fuhk0t1.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, shiiba <naoya.shiiba.nx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Das Biju <biju.das@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2095804185757637987==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X0jFZ9B+Xs9PGREg"
Content-Disposition: inline


--X0jFZ9B+Xs9PGREg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2015 at 04:45:54AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> It needs DAC -> Playback route instead of direct settings via
> SND_SOC_DAPM_DAC. otherwise, it can't find correct path if
> sound card used prefix name

applied, thanks.

--X0jFZ9B+Xs9PGREg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCByQAAoJECTWi3JdVIfQhu4H/2o3bvFII9DB09FsmIOdXd/V
7hJeQGhNpcPo+n26Nywyc16UfdvzjiIDifpR6yz+3gUNEQHkwjE8YqNQxLcOy0+e
26SELnzZFWtdh/CerAKJiCXg/r/mtuJ11gvpHicIA7La8+7GGnBONm/Zng7mfzQc
t9WOIEowQNYPVqtg/Re68vBrTEH1//vTOSa7E3ZCwp5xx36+iB3qOjFAoUgDZYHa
N2uMaZaaQR30nRRKRAbifuo9vzZ1EttLEeAetHTqdS8zn5z5M8olML2giyDkZCnb
fMDfegDgtBk3sV9XHJm6ksb2rSTKK6ejX8WMXZHxw1gXNzaCUUX2Xlz6M2XxM3g=
=4luJ
-----END PGP SIGNATURE-----

--X0jFZ9B+Xs9PGREg--

--===============2095804185757637987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2095804185757637987==--
