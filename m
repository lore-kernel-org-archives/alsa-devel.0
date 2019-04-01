From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] max98357a:add dai without triggered by pcm
Date: Mon, 1 Apr 2019 10:24:46 +0700
Message-ID: <20190401032446.GC2059@sirena.org.uk>
References: <1553824319-2155-1-git-send-email-tony.zou.hq@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553824319-2155-1-git-send-email-tony.zou.hq@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony.zou.hq@gmail.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, dbasehore@chromium.org, Tony Zou <zoutao@huaqin.corp-partner.google.com>
List-Id: alsa-devel@alsa-project.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2019 at 09:51:59AM +0800, tony.zou.hq@gmail.com wrote:

> max98357a's enable pin need setting independently
> when max98357a is shared I2S with other codec.

> add dai "max98357a-hifi" without pcm trigger,
> and use "Spk PA Switch" to set the enable pin.

This sounds like a really bad idea - if you have multiple CODECs on a
single DAI link tell the core about it, don't try to bodge around it.
There's support for multiple CODECs on a DAI link already.

> +static const char * const ext_spk_text[] = {
> +	"Off", "On"
> +};

Simple on/off switches should be normal switch controls, not enums.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhhH0ACgkQJNaLcl1U
h9A7fQf/TGuwFPOLhzC1e1gDmXDsj0NA96/Oa+cFlvnMd17vFxuOQGPBwlzy99hN
khhn6GBVGwfLdyuclW9mnF5lYJ32j16ldn+dIo2mYqadACyJO+S5S//LdqnMytry
nxRvZSBxgKRf0WMXRaU9IdujR9zn8Ioc0EnfjCPuoFjIYrpoipBEqwqBQH9/ZQZN
/A8SeMiEKyViTrKEY5OHFbEkypoBcJ7vaxRSymE69AOZSBzeFWaLSFk8paIdGhLE
xpt6ueKQQco6+NBCkAnzwcIG7ClZdCCOjpNo3Z89LIlUNh6TH9jmgGzlK/l5/K7C
lZLorfIPFx8P+9o/RmGE6iu6xx6PHQ==
=t5bB
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
