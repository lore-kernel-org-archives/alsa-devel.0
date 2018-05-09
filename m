From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: omap-pcm: Use 'snd_pcm_format_t'
	type
Date: Wed, 9 May 2018 17:33:41 +0900
Message-ID: <20180509083341.GS13402@sirena.org.uk>
References: <1525621665-11022-1-git-send-email-festevam@gmail.com>
 <1525621665-11022-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3614996994712131116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 07E0926775C
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:29:23 +0200 (CEST)
In-Reply-To: <1525621665-11022-3-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3614996994712131116==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7jIye1Ygp5H0AIi"
Content-Disposition: inline


--e7jIye1Ygp5H0AIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 12:47:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> 'snd_pcm_format_t' type is better suited for iterating through the
> SNDRV_PCM_FORMAT members.

Peter (who you didn't CC on this or the DaVinci patch) is just in the
process of removing the omap-pcm driver so it'll just cause hassle to
apply this.

--e7jIye1Ygp5H0AIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrysmQACgkQJNaLcl1U
h9D9bQf/W9sP17B+K5pZUUTDDxDu+UlMCf/5nX2P1mlgekZNFSqkDjmiYRvGHojl
FsbRlaeuqF2H+G9KxIyNi7E979ayjLlEVvobsJEOWlbKwtVo1F8HJ/SmxKEamun7
mtBi14hFMkmkOoqlGHg5eCPI5Jym1yG9srvDaI588yAoFClxOYcN2Dd8rOXz0Zyz
RD/M8N1THNat9bXINYLYV4kvEU1JZWohQ7vQhGDrQqtmuQw2vQY2y9YDxiC+Z1Tl
4GwfCMM7c1ylFOZMKq9OkfFPH376jaIRf7J3e0E5RuikACa/Dpbql9lGYVQMq2Oy
hwsJOl6N1rJB+7mcqGcKHS6DPahMGQ==
=mDhW
-----END PGP SIGNATURE-----

--e7jIye1Ygp5H0AIi--

--===============3614996994712131116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3614996994712131116==--
