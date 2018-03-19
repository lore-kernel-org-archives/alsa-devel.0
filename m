From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Fix SND_SOC_TPLG_INDEX_ALL
 for freeing soc topology.
Date: Mon, 19 Mar 2018 15:08:11 +0800
Message-ID: <20180319070811.GE2186@sirena.org.uk>
References: <20180314204722.14144-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8675390503209234754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01E96267294
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 08:08:15 +0100 (CET)
In-Reply-To: <20180314204722.14144-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Yan Wang <yan.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8675390503209234754==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QN0KHc3254GHvltB"
Content-Disposition: inline


--QN0KHc3254GHvltB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 08:47:22PM +0000, Liam Girdwood wrote:
> From: Yan Wang <yan.wang@linux.intel.com>
>=20
> In snd_soc_tplg_component_remove(), it should compare index and
> not dobj->index with SND_SOC_TPLG_INDEX_ALL for removing all
> topology objects.
>=20
> Signed-off-by: Yan Wang <yan.wang@linux.intel.com>
> ---

This is missing your signoff...

--QN0KHc3254GHvltB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqvYdsACgkQJNaLcl1U
h9B0FQf9EbtcGcn520k0yFEbDEHZpYGSK8AbxSCnHPLQVCNPZXDiDbzBmDLwsq7a
VbXPRiyng7Y6Vbd/51Z/sKkI1NQz5LSXaWKnwn7fCjcRH4BYIrdAyAO1KsXwKhKi
75eM7VW0k6olHtIpJ89ql6/keSRc845LWZFE4F6WF2mrk4/VM4KGYdyAiim6nx2j
tiYuPS8nDaYcwW9ABy8DrFuST6sl3v6YL+HrcY4adaLK8G8yw7/9ahd/kpMyVvTY
a4gH3VEceLKZq2mdOoXLPcnVsL0Bw9lnXP1fiOysyGNnhy0DZwmsY83Rb+ukiAiP
vitA9iSnEHZzC/m5ohokT3+vWZKgHQ==
=Umkv
-----END PGP SIGNATURE-----

--QN0KHc3254GHvltB--

--===============8675390503209234754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8675390503209234754==--
