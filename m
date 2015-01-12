From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rsnd: add recovery support for
 under/over flow error on SRC
Date: Mon, 12 Jan 2015 13:03:12 +0000
Message-ID: <20150112130312.GK4160@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87k30yt4zn.wl%kuninori.morimoto.gx@renesas.com>
 <87iogit4vq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1359333430633867398=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F29826054E
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 14:03:17 +0100 (CET)
In-Reply-To: <87iogit4vq.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1359333430633867398==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2015 at 01:52:36AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> L/R channel will be switched if under/over flow error happen on
> Renesas R-Car sound device by the HW bugs. Then, HW restart is required
> for salvage. This patch add salvage support for SRC.

Applied, but please don't send new patches in reply to old serieses - it
makes it harder to follow what's going on and results in things being
less noticable.

--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUs8YPAAoJECTWi3JdVIfQiAYH/jyN6bCFBPJOTD2oHEq9SOOd
shldYDP8V6h+oc4iaqnOvRLMAdd7LRaIBBX8RebSiHuP1y8xqa7vNfsk3mJv2IAR
AhjVUN5StDTU7ZuEy/F9JiP4ljTRzYcNLZb9Yzjgug94z5Q7KDKpGUOpzobYvR57
SRQh/vKShvjGL1hGCnHpmYvS6zv4LVib95HH978XUr6swhWS4pw1oKz+a37D6Z3J
/Dyrya6+qLFEqnF7h332vMiQgjZbCf9tTReCji3HWetfvuE0mZe71LKABlSynFtT
dkqMqIA0FJzsFcIslbO6x6HpVRpqc4BzXBbgkKnmWRSGuRDtdb+OOu5cY4hKPkc=
=q5hu
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--

--===============1359333430633867398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1359333430633867398==--
