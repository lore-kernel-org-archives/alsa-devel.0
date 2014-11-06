From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6 v3] ASoC: rsnd: control DVC_DVUCR under
 rsnd_dvc_volume_update()
Date: Thu, 6 Nov 2014 17:04:46 +0000
Message-ID: <20141106170446.GR8509@sirena.org.uk>
References: <87egtp2g05.wl%kuninori.morimoto.gx@gmail.com>
 <87egti46j7.wl%kuninori.morimoto.gx@gmail.com>
 <87d29246hz.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1282610470410877201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D2E0265275
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 18:05:01 +0100 (CET)
In-Reply-To: <87d29246hz.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1282610470410877201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdxaWYUQIlOfL+ny"
Content-Disposition: inline


--fdxaWYUQIlOfL+ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2014 at 08:26:53PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> rsnd_dvc_volume_update() is main function to control
> DVC feature like Digital Volume / Mute / Ramp etc.
> DVC_DVUCR should be controlled under this function.

Applied, thanks.

--fdxaWYUQIlOfL+ny
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW6otAAoJECTWi3JdVIfQH+8H/ixT7Ta39WDX95CU5XDCWLmC
ABfFPAl1RQmNDLl+UogSNIxgkPiriT5hwOAnNzDVn/K5XYns35R443hwn5bz9AfI
yeyvNJz8fl3Bqb353gm/7ajQfTyn+ob8t8AuiSOyvilQC63/dmZ8NUMcaGglV5if
tbX6wTm+lrAUdQNakFR+zLeAmL0l78zoNRQawZ02ZzY39eBg8nMSYjPzUiToch5B
yLWmZlBON6CBCeWVSjtfn+QtK82huOprnwTTaRneLbOluv+6NdKstIXAIBZCKeSF
ZHqf1Zii1d0ZDVbMkB3s8w7qB3KVRZ+rw+1eHmq3G1mSqsJ8og23uYLLi+p1law=
=LrCN
-----END PGP SIGNATURE-----

--fdxaWYUQIlOfL+ny--

--===============1282610470410877201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1282610470410877201==--
