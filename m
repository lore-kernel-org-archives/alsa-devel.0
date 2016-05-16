From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
Date: Mon, 16 May 2016 14:12:27 +0100
Message-ID: <20160516131227.GL2953@sirena.org.uk>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <s5hk2j38tmf.wl-tiwai@suse.de>
 <87twi1hssl.fsf@belgarion.home>
 <s5hy47c7jvd.wl-tiwai@suse.de>
 <87mvnrhux4.fsf@belgarion.home>
 <s5hoa867e6v.wl-tiwai@suse.de>
 <87inyeidsr.fsf@belgarion.home>
 <s5h1t526ty2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h1t526ty2.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2016 at 02:58:13PM +0200, Takashi Iwai wrote:
> Robert Jarzmik wrote:

> > Even if I'd like to not have these in bus operations, the struct snd_ac97 had a
> > need for a 'caps', 'ext_id', ... fields for example. Yet these could be
> > contained in the ac97_codec_device structure and not exposed to bus operations.

> Do we have any example of such exceptions?  For AC97, we don't need to
> think of future extensions at all.

I can't think of any, even for some of the more fancy CODECs used in
embedded systems.

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXOcc5AAoJECTWi3JdVIfQ0YoH/Ao2wL7bqpBVFHhdXFpp1d6N
5gQYBRJr9vrBsAW8vn7xvhRrvFR324wDb5Y7NdCAArzOkdfTiq732qracu5sdWz2
8754/+HyS1iHA1PrC90dBc9m9YH4EqQcVikejl7RzDc+QGtsfkwOkOmbR5bh0hDP
vphdnBt6VDLF4nHdMwXeaYvDljhhzNSExWtNgudXdm24ue4SrERoBR1SrXAesmte
U0ewDMb4AJMxIE75tyFnvoeuU3jOQusKrc/OPfQKgmk5Vg2SIpVsYCyNGKfuMlo1
3V72Jl6DcyhkC/djU9n9+EYiDBAEw6iuMWNYwWrffULvunZdtpqveg3krD4ItnI=
=tmcV
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
