From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-i2s: don't try to start up or
 shut down DAI if it's active
Date: Fri, 12 Oct 2018 18:09:05 +0200
Message-ID: <20181012160905.GA2340@sirena.org.uk>
References: <20181012153254.10844-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8474863737700097021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C693267845
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 18:09:11 +0200 (CEST)
In-Reply-To: <20181012153254.10844-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Yong Deng <yong.deng@magewell.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8474863737700097021==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 12, 2018 at 08:32:54AM -0700, Vasily Khoruzhick wrote:
> Otherwise we may end up with shutting down I2S if shutdown() was
> called for capture substream, but playback is still running.

Would it be cleaner and more robust to use runtime PM?  I'm wondering
what happens if some of the configuration stuff turns out to also need
some of the clocks for example.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvAxx4ACgkQJNaLcl1U
h9A/zAf/di1m1GcHe+mMW1RoAmwDmFHKJhQS3vlHN4B5dZgzYiRtURIpahmC7KYE
2chHKM2+XFqyPsKfkvi6UGWA3ABB6tYlVRcgby2ww5l3TPBbo+hCEjdLTRKPxAnx
okGb5etRQE6u6Q366+6MNqt/Or4sAM5A88Iibt1yKm+NSuCvCmn/zId/NxmJxjx2
RrpVEaa/t9cbyHZCJ8G+rmbFYpd7cwQk3cGW5nlKg9tKJk2vD/jdaKxHeUMmDJdM
wP51+L+T/lILvJRWfxWg62h9FV51CBjEAq8jok0X4ZnTwwHjMEXnsjXEaw30Urmc
0LN//hWnSvhw3BsOCVoiGNC4wplvMw==
=Qf76
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--

--===============8474863737700097021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8474863737700097021==--
