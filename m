From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rsrc-card: rename rsrc-card to
 simple-dpcm-card phase2
Date: Mon, 22 Aug 2016 17:51:49 +0100
Message-ID: <20160822165149.GR22076@sirena.org.uk>
References: <87vaz8t4bu.wl%kuninori.morimoto.gx@renesas.com>
 <87shuct48p.wl%kuninori.morimoto.gx@renesas.com>
 <20160817105603.GK9347@sirena.org.uk>
 <874m6dv60c.wl%kuninori.morimoto.gx@renesas.com>
 <87wpj9473x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1970167661415116372=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F9452657B6
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 18:51:56 +0200 (CEST)
In-Reply-To: <87wpj9473x.wl%kuninori.morimoto.gx@renesas.com>
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


--===============1970167661415116372==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline


--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2016 at 07:12:50AM +0000, Kuninori Morimoto wrote:

> > > > -					    - "renesas,rsrc-card,lager"
> > > > -					    - "renesas,rsrc-card,koelsch"

> I can keep "renesas,rsrc-card" compatible,
> but I would like to remove above "board" specific compatible,
> because it exists in my test environment only. No one is using it.
> And it makes this driver very complex.

I thought Lager and Koelsch were quite widely available?  But if the
boards you're removing really are just specials on your desk then it's
fine, just make sure you provide a separate patch doing that with a
clear explanation as to why.

--gMqNd2jlyJQcupG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXuy2kAAoJECTWi3JdVIfQ+CAH/jphi3OV925MXc/inl31zt+v
1KNDu+8/eTjFc1sWF8esqtFNBnP1b468AE7v9tntYgUOc6zEtFDHlHZfvnA2ZZOy
tL8woLj55BVZen3oLMTczHg8qAolaiol6xfWNk+e+Bjlz4CTr5Z/bmw/7oE35GRW
1e0R+9j+8x6QARaqTz0YZDhys4YQr8heRArdnXQtRrKlLVjfBwe0bwihqXMio/kG
OoEzKQSMpHcbHUxibwe0rhEHfUVz5LehhLA/CBdTMRNZJnDDEJzBkKkK6rNSsPtL
xF/j3w9cPSx2Xzi4u8LMPAYFcc7y7PGAEa9i9jO3wHLt3VZ/RH1Bz6jEZ5xU9uo=
=DTl4
-----END PGP SIGNATURE-----

--gMqNd2jlyJQcupG/--

--===============1970167661415116372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1970167661415116372==--
