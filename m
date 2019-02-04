From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: sh: Avoid passing NULL to memory
	allocators
Date: Mon, 4 Feb 2019 22:00:37 +0100
Message-ID: <20190204210037.GM23441@sirena.org.uk>
References: <20190204134222.9560-1-tiwai@suse.de>
 <20190204134222.9560-5-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7150316110195410031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D65E26746F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 22:00:38 +0100 (CET)
In-Reply-To: <20190204134222.9560-5-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org


--===============7150316110195410031==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 02:42:21PM +0100, Takashi Iwai wrote:
> We should pass a proper	non-NULL device	object to memory allocators
> although it was accepted in the past.  The card->dev points to the
> most appropriate device object in such a case, so let's put it.

Acked-by: Mark Brown <broonie@kernel.org>

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYp/QACgkQJNaLcl1U
h9BG+Qf8DhpjemNpEYtQ5A7g16t9MaMewwv/nPIketNHm3UELvMZUxiRr1fNUqw+
E/SDCmCsTTu5r8ozjBAHyNLG8dr8JqGWIzt3qN7aLox8/OhYWWU72Q5c2Vrv/jw0
SGn4zTjhm0YiTDXc4P9Uueo2ZXPi92BrNSXNf7in1+4/vmKqHBpeho+/H2mJwgIy
uSK5EKJ/dDdcIVTbAgmzS0cQlPiTygucBtMOMqx/T7CrTyDAzajtdJHJKw9M1T+g
jmLFxDzRS9QM/sbqSJ7T01X9sFPTtW5PRJazG115Eh/O+GLpmtOVYK+JSHUHzvdt
JPePnLz1lgeQL/y0ZNdvcosQRbptVA==
=ny7g
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--

--===============7150316110195410031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7150316110195410031==--
