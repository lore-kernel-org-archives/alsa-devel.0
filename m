From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about TDM "slot"
Date: Wed, 18 Nov 2015 11:30:12 +0000
Message-ID: <20151118113012.GH31303@sirena.org.uk>
References: <87fv05hv7b.wl%kuninori.morimoto.gx@renesas.com>
 <20151117105233.GM31303@sirena.org.uk>
 <87h9kjrce6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0755617726586928360=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46318260A5D
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 12:30:21 +0100 (CET)
In-Reply-To: <87h9kjrce6.wl%kuninori.morimoto.gx@renesas.com>
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


--===============0755617726586928360==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lo/yIdJSCXpBJBdU"
Content-Disposition: inline


--lo/yIdJSCXpBJBdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2015 at 07:37:51AM +0000, Kuninori Morimoto wrote:

> Thanks. We can have total channel number.
> Then do we have common DT settings/method to indicate below ?

There's some stuff already supported for simple-card - see
snd_soc_of_parse_tdm_slot().  This won't cover all uses but it should be
good for simple uses.

> I guess we need this settings on both CPU/Codec.

Yes.

> I guess I need this settings on both CPU/Codec too.
> Do we have common settings/method ?

Well, the current API should be consistent over all

--lo/yIdJSCXpBJBdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTGFEAAoJECTWi3JdVIfQiBoH/Asw/NoTbHGjPQRp7rfxgyMr
hSLQE+/Q1FLXbQWGbD+Yxy4O3QrW87XRiTZCrKlD0OtDtLAZ7REECKO17BFvY/PB
CZB36Cqru/UV3YQB5FMhldtrj0iH7VFKK4NyXomHEpw/oU3t0z1/Ww4sNiOPhotJ
sVbWBxp9NgVOzE03y84N8XUBrYPDxjVWX0HnQeOiZY0t9uQbWRjLvQVj+y4aa9N9
aFWEi77+c8HhoV0sWkwRKKMBXf+YSfL44lxRdGBsavclzvi6LskQBKyEJbR/CmLo
qlUZT08H2KQ23zbE0QJkrzmXf67C4j/ApWR6AflLcpzf7rUzD1v/7SR0cMfIqjE=
=Dma1
-----END PGP SIGNATURE-----

--lo/yIdJSCXpBJBdU--

--===============0755617726586928360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0755617726586928360==--
