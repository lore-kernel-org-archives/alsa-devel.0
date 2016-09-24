From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tpa6130a2: fix volume setting when no stream is
 running
Date: Sat, 24 Sep 2016 19:31:10 +0100
Message-ID: <20160924183110.s4lxuigycpxegamq@sirena.org.uk>
References: <1474539040-25347-1-git-send-email-nikita.yoush@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5lza74ydcdml6yj6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474539040-25347-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Helen Koike <helen.koike@collabora.co.uk>, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org


--5lza74ydcdml6yj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 22, 2016 at 01:10:40PM +0300, Nikita Yushchenko wrote:

> -		ret = regulator_disable(data->supply);
> -		if (ret != 0) {
> +		ret2 = regulator_disable(data->supply);
> +		if (ret2 != 0) {
>  			dev_err(data->dev,
> -				"Failed to disable supply: %d\n", ret);
> -			return ret;
> +				"Failed to disable supply: %d\n", ret2);
> +			return ret ? ret : ret2;
>  		}

The ternery operator to save the error handling block is a bit too cute
to be clear, it'd be better to just handle each error directly.  Can you
please send a followup patch fixing this?

--5lza74ydcdml6yj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5sZtAAoJECTWi3JdVIfQ+J0H+wccpU8R59tkdgSS0jvbPCvt
8ItN3JUfdoXosH6sSOHKVYNcUTX3wgM9MFQm3pZmORbl+5xS4vgFnKxFeW4dtMK5
vW1FfvUgGP436sDxWDXIyKoIGPpbi2V2aFacXXjwMsy5jbM7N49rbq3Ux018L2cU
HJ215f0DP9Pscik/2CPaucTlqffCAStDlO7X4TCoaaKpDb3k2LrjUFerFLI19wvY
oMYv3p3omsWegXd0KxZlTm9L/8Xgu3MfpiF979cJFeleL8vOzb3XzDJB39O59isP
n4lKC/CB9808hDxtwoomS5I6/I5+4FvH1s5jQNhMnuiw4HCGxuZBV30FYZRxadY=
=kIGW
-----END PGP SIGNATURE-----

--5lza74ydcdml6yj6--
