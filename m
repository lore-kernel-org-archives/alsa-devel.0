From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Thu, 4 Aug 2016 21:56:05 +0100
Message-ID: <20160804205605.GJ10383@sirena.org.uk>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <579A69EC.9060205@metafoo.de>
 <87popx2nbb.wl%kuninori.morimoto.gx@renesas.com>
 <4ad31e53-188a-8a40-cea9-b89df5f3535e@metafoo.de>
 <20160729144145.GF10376@sirena.org.uk>
 <87popt9n1w.wl%kuninori.morimoto.gx@renesas.com>
 <87y44fhdxt.wl%kuninori.morimoto.gx@renesas.com>
 <49dd216c-d63c-693e-92ed-6abf1865eeb0@metafoo.de>
 <87r3a5mfjd.wl%kuninori.morimoto.gx@renesas.com>
 <2c894b35-9c57-6212-c8c5-f97ec1e1d263@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="boAH8PqvUi1v1f55"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2c894b35-9c57-6212-c8c5-f97ec1e1d263@metafoo.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--boAH8PqvUi1v1f55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2016 at 10:21:10AM +0200, Lars-Peter Clausen wrote:

> To be honest I'd also get rid of DAIs has a top level concept. This image
> (http://metafoo.de/the_new_asoc.svg) is something I've put together awhile
> ago how I think we should lay things out if we do a major refactoring of the
> ASoC core.

I do think they have a useful purpose in representing the edges of chips
in a convenient bundle and inject configuration.  I too would like to
see them less prominent in the code internals but they are useful as an
interface.

> Obviously we can't convert everything at the same time and it will take a
> lot of time and effort to update all drivers to this new model. This is
> where the legacy bridge kicks in which still keeps the concept of 1 CPU, 1
> CODEC, 1 platform. If you want to use the advanced features of the new
> framework you have to update your driver, if you are OK with the current set
> of features just keep the drivers the way they are and use the legacy bridge
> that is automatically managed by the ASoC core.

I actually keep thinking that it might be easier to refactor the simple
CPU plus platform SoCs into components than anything else - there's
going to be gotchas in there but it seems like a useful string to pull
at.  Though realistically if we're going to get companies working on
this it's probably easier to get DPCM people started off.

--boAH8PqvUi1v1f55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXo6vkAAoJECTWi3JdVIfQyl0H/30g77a2RUp2Qq2YNWjn2TAk
BR8D7tcb5VZ6OwHQ3Zz0QNe+ll8Gjatfa+QXzFXTkcqBMnwLzuoP8y4CKKpKe8Pt
uaW0Hn1xfxdkc1lgc9vzHXfyNsGCkzr9/U7tgJvajBSHuTdOM2qgDL3PPVrD8Qfr
hWDhC2nEpGUnzzVdkL/rr1zA/J7zVFY0woyqLfGU/BRAU5LeGFj6gL2vPiPCfshl
v+U++t6pSAYTAM7+WA7ILS91btb9oxxVIlpg6i+PZkTzeSOZSvcJ7cClI07LVJCR
Y93Ck4Wqe/D84sQe4Psde8tt/lHigTWlDo/aTu0k8DZ0twGSf7OnW5VlAaJ5TEI=
=dg02
-----END PGP SIGNATURE-----

--boAH8PqvUi1v1f55--
