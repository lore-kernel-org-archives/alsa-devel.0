From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for-4.11] ASoC: don't dereference NULL
	pcm_{new, free}
Date: Thu, 9 Mar 2017 12:09:18 +0100
Message-ID: <20170309110918.getjla6iawgjpfrq@sirena.org.uk>
References: <20170308231854.50167-1-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3440901540787222993=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 35CFB2671D3
 for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2017 12:10:38 +0100 (CET)
In-Reply-To: <20170308231854.50167-1-briannorris@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Norris <briannorris@chromium.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============3440901540787222993==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bkcchgg6exn7kagu"
Content-Disposition: inline


--bkcchgg6exn7kagu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 03:18:54PM -0800, Brian Norris wrote:
> Not all platform drivers have pcm_{new,free} callbacks. Seen with a
> "snd-soc-dummy" codec from sound/soc/rockchip/rk3399_gru_sound.c.
>=20
> Resolves an OOPS seen on v4.11-rc1 with Google Kevin (Samsung Chromebook
> Plus):
>=20
> [    2.863304] rk3399-gru-sound sound: HiFi <-> ff880000.i2s mapping ok
> [    2.886930] rk3399-gru-sound sound: rt5514-aif1 <-> ff880000.i2s mappi=
ng ok

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--bkcchgg6exn7kagu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljBN9sACgkQJNaLcl1U
h9ASZgf+Oo3xEmolDL/GoyNXNPpy/URBLFC2tWwUeat7sfLMFIhuHrvu2acx39y3
tcYEB0WJVDiCYX2QT1fa8L99LoJWYj43mH4bptwZUfLBzHuScVXWoeQaBS/dsxtm
wKs+mQZMDG4ieTSuwCqEGvfhf2E8KbOFlgu2RAUtSXNOa7rCpRHZdWQbJw9jG2pj
MR7ZlKbrq7FuVtRjU40g1GtsBc1i49CYnB4zY4DXnMvLGQOXNEnf4UL7TifPB0FG
5zPwonRmqygP5QY6yc5nyoTJB2xKVtKihUb8TBfRWD6nzRclhfIkpsfRKbIG3TNo
5oYn5NU7Cq3epIX93iF5XKnz2L8D9A==
=Q369
-----END PGP SIGNATURE-----

--bkcchgg6exn7kagu--

--===============3440901540787222993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3440901540787222993==--
