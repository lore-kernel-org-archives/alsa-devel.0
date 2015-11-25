From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: img: i2s in: Add AIF widgets
Date: Wed, 25 Nov 2015 12:33:57 +0000
Message-ID: <20151125123357.GQ1929@sirena.org.uk>
References: <1448379288-2347-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4111982130559974889=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 254F726052F
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 13:34:09 +0100 (CET)
In-Reply-To: <1448379288-2347-1-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--===============4111982130559974889==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jigfid2yHjNFZUTO"
Content-Disposition: inline


--jigfid2yHjNFZUTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 03:34:47PM +0000, Damien Horsley wrote:
> From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
>=20
> Add AIF widgets to i2s input controller
>=20
> This allows connections to this component in the dapm graph

We should have widgest being created for all DAIs automatically - we
shouldn't need noop widgets.  Is that broken for components?

--jigfid2yHjNFZUTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVaq0AAoJECTWi3JdVIfQ5DYH/1ZXZIEKXpTdG1sUJZMulkJf
lxEnrs2Zqb+LtG1zDp1ejXQnl5aGunQfE3XF2Iv8gIibL3zs1fAre7QzMshzfiha
35JyVIsfUyedRNOD/hGgs6xwJy97LrZ3ZAZFOTb6CSZaTx/lC/++gYbZE+DmtNSL
fz8arFShTO8E1D83a2+ArfdZfhmNF01ef3CSi/Zvs0htw3w6irmCSF4x5D2VjcJw
8Vfs0DUke11TuuVBVHs1uzXxjgHlrSHedeF9hYzhf/v+4YUca1+5Uy9Wnb8WBRhb
b4Vm7hUNmY4sztImE7rJakdXDdaD7F38XrcAFMrSHvO5ALR6fAK+x1YESaLFVog=
=FLHq
-----END PGP SIGNATURE-----

--jigfid2yHjNFZUTO--

--===============4111982130559974889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4111982130559974889==--
