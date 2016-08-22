From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rsrc-card: rename rsrc-card to
 simple-dpcm-card phase2
Date: Mon, 22 Aug 2016 17:49:07 +0100
Message-ID: <20160822164907.GQ22076@sirena.org.uk>
References: <87vaz8t4bu.wl%kuninori.morimoto.gx@renesas.com>
 <87shuct48p.wl%kuninori.morimoto.gx@renesas.com>
 <20160817105603.GK9347@sirena.org.uk>
 <874m6dv60c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4857166389550201629=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7F062657B6
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 18:49:18 +0200 (CEST)
In-Reply-To: <874m6dv60c.wl%kuninori.morimoto.gx@renesas.com>
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


--===============4857166389550201629==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i/CQJCAqWP/GQJtX"
Content-Disposition: inline


--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2016 at 03:34:23AM +0000, Kuninori Morimoto wrote:

> This driver was used for Renesas SCU (Sampling Rate Converter Unit) which
> is including SRC (Sampling Rate Converter), CTU (Channel Transfer Unit), MIX (Mixer),
> 1 or more CPU and 1 Codec system.
> (Original was only for SRC, rsrc = Renesas SRC)

> Can I use simple-scu-audio-card ? If OK, I can send such patch.

Yes, that seems fine.

--i/CQJCAqWP/GQJtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXuy0CAAoJECTWi3JdVIfQjgMH/2SNCntG/HPTDqC7hM/NEhJo
zyDTlr1b48a+Sz5t81n0+5JIC0p1cVElZwwT3w4wgVqzOGS/L53P2EqunkOCInP5
UP8BLIjD0hnD9AY7pHGGtrAwpYuIReI47112SuTRpLkcL26qjmHC/0NfhTroRGOL
o8DsTYKELbIzb0WfyKPRvERaJMdFaKbNCl9VY3yyaBaB1Vo0Lvi5d7tydW+HtD1L
qHuybMgk6ZPz3TX6ybDBRerHLc95SGcB2zVDQqPRaRPxPmGsGl4mlMVUAshKxhr7
RChV4854Me9kEoBvLEQzaS+2EO3eAVna7QxoDcBDNimFTaS/1c/px9ytyd9w7Kk=
=MKSr
-----END PGP SIGNATURE-----

--i/CQJCAqWP/GQJtX--

--===============4857166389550201629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4857166389550201629==--
