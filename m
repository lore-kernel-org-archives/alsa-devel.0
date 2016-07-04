From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC: Atmel: ClassD: Simplify use of
 devm_ioremap_resource
Date: Mon, 4 Jul 2016 16:15:33 +0200
Message-ID: <20160704141533.GG6247@sirena.org.uk>
References: <20160704130352.GA16886@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiH5iyEqjK6f5lUg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160704130352.GA16886@amitoj-Inspiron-3542>
Sender: linux-kernel-owner@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: nicolas.ferre@atmel.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org


--IiH5iyEqjK6f5lUg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 06:33:52PM +0530, Amitoj Kaur Chawla wrote:
> Remove unneeded error handling on the result of a call to
> platform_get_resource when the value is passed to
> devm_ioremap_resource.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--IiH5iyEqjK6f5lUg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXem9WAAoJECTWi3JdVIfQCI4H/i/TwsSBbfxV8WtRQ3hNnKtj
AqqG0caQtTYWdsEUQTpMHMaR/JZ4hDa6JF5o2JmKXcrNPt3yPFmHH68RwPqAjOSj
mwLAyZs0Sf50SDjilHtiAshtQPvyt9YKRzzfbmopDgWQc16ywbryKeT+kC2F1pod
n+Jt1P6RPdLLh/F1RzXamDdztUo/4FhziorTsmfeZa1ikeZ/O4rCKHSPibt/nO+B
5pGBdV3Etu4LlZCLljRWFrufyoJ/3YjQ81IGqdEoRzDQ4YW40eKKGmS4ecpMgPhF
ZWz22QP8lqnqw9K6IJtbCXYDGgbzg5CfoXQsIFR50DkZxJC9cxSGzIgBzMaAXhA=
=kLKx
-----END PGP SIGNATURE-----

--IiH5iyEqjK6f5lUg--
