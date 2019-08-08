From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date: Thu, 8 Aug 2019 20:27:43 +0100
Message-ID: <20190808192743.GL3795@sirena.co.uk>
References: <20190808123655.31520-1-stefan@agner.ch>
 <20190808124437.GD3795@sirena.co.uk>
 <s5hlfw3izhl.wl-tiwai@suse.de>
 <20190808130217.GE3795@sirena.co.uk>
 <s5hftmbiyuc.wl-tiwai@suse.de>
 <cd3fd8b9ce6e4f9820197c70dfc42b67@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cd3fd8b9ce6e4f9820197c70dfc42b67@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, Stefan Agner <stefan.agner@toradex.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 03:16:53PM +0200, Stefan Agner wrote:
> On 2019-08-08 15:14, Takashi Iwai wrote:
> > Mark Brown wrote:

> > I guess we can use dev_printk() with the conditional level choice.

> How about use dev_info always? We get a dev_err message from
> soc_init_dai_link in error cases...

> 		ret = soc_init_dai_link(card, dai_link);
> 		if (ret && ret != -EPROBE_DEFER) {
> 			dev_info(card->dev, "ASoC: failed to init link %s: %d\n",
> 				 dai_link->name, ret);
> 		}

Well, if there's adequate error reporting in init_dai_link() it's a bit
different - we can just remove the print entirely regardless of what the
return code is.  The point is to ensure that we don't just silently
fail.  Unfortunately there's no prints in the probe deferral case there
so they need adding, that'll actually improve things though since we can
make it print the name of the thing it's mising which will be useful to
people trying to figure out what's going on (we used to do that but it
got lost in reshufflings).

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Md64ACgkQJNaLcl1U
h9AMagf+L43HuMa/NUgOlEHZm98nUtKAaX8K47V2+fZA8apI3qs/jrwjcUoIfhMU
CZMT7n2i3X520n100poQubrce5JFTbXLd5Mm7H5E77Fs5zoZ5W53jL6ts5DoyQ5E
UYpoxkg4bMQXmSgAlihHpjLRubteVsS3+07FhrSdGlvwlpGYSBrh+IOMtZes3I7W
b7xTa6denXXkrx8sg6tznkI7q6xweTy+B3gc9GpIEA1CQek6a3WYq6DV+1C+t8dN
Ps0f2A39s+UVOaHpPgtwb9V3DwlBGnUis0vdrET8JpfK7whAEaw1D58ADRW77QiS
o6jc4CTInKtvwwipe0OcMO4Dn9jssQ==
=mPEe
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--
