From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] ASoC: alc5623: Add device tree binding
Date: Fri, 18 Apr 2014 19:44:37 +0100
Message-ID: <20140418184437.GZ12304@sirena.org.uk>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-2-git-send-email-andrew@lunn.ch>
 <20140418163351.GI12304@sirena.org.uk>
 <20140418181735.GB32580@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yMZc7XcoawI0pdam"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140418181735.GB32580-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--yMZc7XcoawI0pdam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 18, 2014 at 08:17:35PM +0200, Andrew Lunn wrote:

> The driver already has:

> static const struct i2c_device_id alc5623_i2c_table[] = {
>         {"alc5621", 0x21},
>         {"alc5622", 0x22},
>         {"alc5623", 0x23},
>         {}
> };
> MODULE_DEVICE_TABLE(i2c, alc5623_i2c_table);

> which is enough for the i2c layer to load the driver when it walks the
> nodes under the i2c bus driver in the DT.

You still need to add the compatible strings to the driver explicitly,
device names can be and are duplicated between manufacturers sometimes
and it makes things directly greppable.

--yMZc7XcoawI0pdam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUXKSAAoJELSic+t+oim9CdMP/j30k6OYmgbHRF5+TwtXJSnO
hGX/oVq5jimp6nziNlM8btCJWB1h9E3Y71nNZyGpllM+XVpzJlqYreI2/sO/PVIA
/HFBbB/VaJcCExNIBNFk7Lm7qVgg8Sq30Wo0b5LmBciBF4AoJkywVzHHMjqgLWy+
Lx/sfKuQWCyUASQ95coJOKLrrwuqMcISw9V/9xOqkmQfMLiuIqB1wI7ee4qkMscE
aajUgzJ6GNyvnnV9ufnUfLNa0n4uipmvBt683IHWMiCLwW4xAIqFLpvEM7wnWi/N
TE463mu6yeA6yDFCYz0gqQ2G1Uue4kYfhmRwSTa9cDJQXYLvxNWEDXMaHYMLf+gY
4wY0vMDvUawIrwpufD4PQWHh9dSXA1N6+yvVk6KpyPRTJ859RAg713vffnXxmvHL
3ojfocBPD5Lv8ObEQ1wZxt6SIQaA2h3dU2TTFxwABUTla1jFbbyJV1fxfzJOOaDV
JtynZB+FZTxiNEuB6Umla2tgHRT8gvdmXbeXj28akHh98lQhq7eGsOSAeG+WSCR0
h3e1sYU/MJAjB5snVQC8eWuuX9NR2sx64INfNnduwDUaxMuvy6NIJbzJsJcOfqwV
Og25lmizmZVUyQhk3UL0aTUH26VAa9aTJmvWgn1R2UMf+5Bii3IXc7WiFPOiPdS/
brbm+5Ctd/L1ziYC4aCU
=SHJk
-----END PGP SIGNATURE-----

--yMZc7XcoawI0pdam--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
