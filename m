From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/13] ASoC: rsnd: fixup not to call
 clk_get/set under non-atomic
Date: Mon, 3 Sep 2018 14:36:59 +0100
Message-ID: <20180903133659.GJ10302@sirena.org.uk>
References: <87d0tvf4q0.wl-kuninori.morimoto.gx@renesas.com>
 <87va7ndpxu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6506691531922793720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ECD672676C6
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:37:02 +0200 (CEST)
In-Reply-To: <87va7ndpxu.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Jiada Wang <jiada_wang@mentor.com>, Timo Wischer <twischer@de.adit-jv.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Dragos Tarcatu <dragos_tarcatu@mentor.com>
List-Id: alsa-devel@alsa-project.org


--===============6506691531922793720==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Content-Disposition: inline


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 07:08:58AM +0000, Kuninori Morimoto wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
>=20
> Clocking operations clk_get/set_rate, are non-atomic,
> they shouldn't be called in soc_pcm_trigger() which is atomic.

Generally bugfix patches like this should go at the start of the series
to make sure they don't have any dependencies on other patches and can
be applied separately and sent to Linus before the merge window.

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNOPoACgkQJNaLcl1U
h9Buvwf/ay9ubKKquoxBYXJ76chPALhR/GpFmm43UXx51qUFp+LsYqYdwL2A8vjT
TKLWVhXNHFNNsE21qRAW74LUnMTHE1yY5EEv3sWHg4xWeoEQmOecpyW+UG9cc+Zh
kJObdnbg7H1CYTmVJnCuki59H3pEvyTi3HYAvOarFk4e8Q0s0BHLgbdhV0kXZBBg
0ZiJXF1gVroFN1MGJPY51QlMiSK6Pj7JX/oezXs5n5Ln4X3HF1xD4tYRgU4xMWPK
KADT54usmdTHjBRZUHrpEkR8p8EuC4ShZTENUNAb4T+hYyqaASu5HaqM44FcQBI+
1OMlFHK0krDX7ULJRkJNe1VUBepPZg==
=bjuz
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--

--===============6506691531922793720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6506691531922793720==--
