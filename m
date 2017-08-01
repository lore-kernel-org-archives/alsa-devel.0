From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about soc_bind_dai_link()
Date: Tue, 1 Aug 2017 14:27:59 +0100
Message-ID: <20170801132759.avulrza2s3wmucyx@sirena.org.uk>
References: <87k22nyelk.wl%kuninori.morimoto.gx@renesas.com>
 <1501576394.5647.21.camel@nxp.com>
 <87bmnzy92z.wl%kuninori.morimoto.gx@renesas.com>
 <1501577664.5647.25.camel@nxp.com>
 <878tj3y6p1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2892097927821884247=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E818026691A
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 15:28:11 +0200 (CEST)
In-Reply-To: <878tj3y6p1.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============2892097927821884247==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dxkj7be2hhrno4oo"
Content-Disposition: inline


--dxkj7be2hhrno4oo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 01, 2017 at 09:38:34AM +0000, Kuninori Morimoto wrote:

> > No, because we only do the assignment rtd->platform = platform if
> > platform_of_node == dai_link->platform_of_node OR platform->name == platform_name.

> > In case we are registering 2 platforms (like you said: own platform and dmaengine)
> > they will be having different names/of_nodes.

> I can't find concrete driver now, but I found
> the driver which "own platform" and "dmaengine platform" are using same "dev".
> Because of this, I confused about this.

That doesn't ring any bells for me...

--dxkj7be2hhrno4oo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmAgd8ACgkQJNaLcl1U
h9Dnngf9E1PXv1c6LFlsGaUk3ksgkmHODklqOpnWm68B/8yktoikG1jySQ3WMzXO
X6FAzKNPI2Zzys8IK4/XqBXd+0bZpKFUaOOU41oxeReM1qYuENVPQ+vi1S3zKXep
0xou4vPOGQlmruti5CT8ymLYa6Tu3DlMl5zOXh3guWG/BZHmsNTZGrd8/zbRSNnc
03adkAvPGi7JbzcwKI1bZZGWVq9of2jfBGotCCBmoWWKC2+4P1+G6PP001fwaYZ5
7TXXclbV47+qi0IgJFjWS6v56unFgdBGqfjKWNq7/icvUTDkb8f+lZFGCcCuwHUF
jMfKGQgItKs6wezdNy4FscLtPCSVUQ==
=C5fO
-----END PGP SIGNATURE-----

--dxkj7be2hhrno4oo--

--===============2892097927821884247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2892097927821884247==--
