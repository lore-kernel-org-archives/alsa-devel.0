From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Protect hw_params
 callback against race
Date: Mon, 12 Aug 2019 12:57:51 +0100
Message-ID: <20190812115751.GI4592@sirena.co.uk>
References: <20190812095304.19030-1-peter.ujfalusi@ti.com>
 <20190812111332.GH4592@sirena.co.uk>
 <20154773-1cf8-4e2e-a248-f3dfb29a5024@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4978923993485447109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FE89F801EB
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 13:57:53 +0200 (CEST)
In-Reply-To: <20154773-1cf8-4e2e-a248-f3dfb29a5024@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4978923993485447109==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2019 at 02:46:33PM +0300, Peter Ujfalusi wrote:

> to card level could substitute (new mutex on the card for pcm operations
> probably) the need to handle this in drivers.

> We would need to change soc-core/pcm/compress for this.

Yeah, it'd be a reasonably substantial change.

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RVD8ACgkQJNaLcl1U
h9DFIAf+K2a9CAkyqTBP+EIREoRYCCAkiVjlc7z7ZtkSefkrKUuZRKaTrO7YKrKC
xuZJHFLxwFcW4Q9mS4ooHM35l2oW94GyHBBRqLTbXzIRppYE8BzhZqouF4yKvxY0
IBhNPEPlsy24jSEydGAUTL7K6UaI+BgQNqAyTMIqWsYwoRkSba63fD70ZOo30mhR
9ZghIp4bQIAXAAmXcwCbtSr1kVuxFbt2pYukitcj11fzOJebI+2cXS8EbJ/bXe4A
/9PsML9nABNJkfP/1UoxIr08HMN5DVapAhaO5VUWAJJUZigICAMgcWoW6cg9ZuWL
88T+j1n9ML0s7cTQwBPv/MHVy+1jew==
=OXKu
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--

--===============4978923993485447109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4978923993485447109==--
