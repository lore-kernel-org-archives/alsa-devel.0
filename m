From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Thu, 4 Aug 2016 21:37:55 +0100
Message-ID: <20160804203755.GI10383@sirena.org.uk>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <579A69EC.9060205@metafoo.de>
 <87popx2nbb.wl%kuninori.morimoto.gx@renesas.com>
 <4ad31e53-188a-8a40-cea9-b89df5f3535e@metafoo.de>
 <20160729144145.GF10376@sirena.org.uk>
 <87popt9n1w.wl%kuninori.morimoto.gx@renesas.com>
 <87y44fhdxt.wl%kuninori.morimoto.gx@renesas.com>
 <49dd216c-d63c-693e-92ed-6abf1865eeb0@metafoo.de>
 <87r3a5mfjd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87r3a5mfjd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 04, 2016 at 02:38:33AM +0000, Kuninori Morimoto wrote:

> I agree to your opinion.
> OTOH, we would like to use/keep existing current all drivers.
> Thus, I think we need super many small and slow steps.
> Or, we need new ASoC2 ?

Small steps is how we do things in the kernel. =20

> OTOH "driver" side can use existing CPU/Codec/Platform and/or AUX/compr
> etc as helper ? (I'm not sure detail of AUX/compr actually...)
> And each "component" has "dai".

Auxiliary devices are just CODECs that don't have DAIs hooked up.
Compressed DAIs are just DAIs for compressed audio.

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXo6eiAAoJECTWi3JdVIfQOlQH/A8hMPzXGDrbjFiS6yJsk+bF
0WUPwIzpgWx35mFAVohZmg9eejJ/uLnyIARcLEbGuWL00C8a4sQF1tYy9leamGCG
VdDPEU0gwHs10ktzTcbU5HHVtV9aM1EGqYC5UvSCVGin0JwBE3bagy95lodyWVYy
Qk0OvGAusYweFGRitW6X0dAo6pjwori7TWmaN4fn1qyAKlwgBwzbm8tuxghCH3XZ
XfcdOMcUojjLlz1TPi0j4apPgtNtzE9+9tS1TjSkGJgILAo11rMf1kgGjGGkbuKX
F3RQhrzQHkvV9qFRHwMTfFpGMkAAZla/ztTFD9uQYH15twuHyvoXm8ZKBxnT4pI=
=Tbwi
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
