From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: kirkwood: fix loss of external clock at probe time
Date: Thu, 19 Sep 2013 12:06:42 +0100
Message-ID: <20130919110642.GK21013@sirena.org.uk>
References: <20130919114957.1fede091@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gphVtybrzJJtG9bX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130919114957.1fede091@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--gphVtybrzJJtG9bX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2013 at 11:49:57AM +0200, Jean-Francois Moine wrote:

>  	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
> -	if (!IS_ERR(priv->extclk)) {
> +	if (IS_ERR(priv->extclk)) {
> +		if (np && of_property_match_string(np, "clock-names", "extclk") >= 0)
> +			return -EPROBE_DEFER;
> +	} else {

This one really does seem like something the clock API ought to be
doing, either as standard or with a separate helper - essentially every
driver ought to be doing this for robustness.  Doing it on general
failures is more tricky but in the specific case where we know the clock
should be present but we don't have the driver loaded yet.

--gphVtybrzJJtG9bX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOtq/AAoJELSic+t+oim9wjoP/RmbQAo77BoNulLzF6nWnauP
/OorEo0B/3OQHUdjMMLESzcYV0FDtaa939w+/oBZ+S8kvB7HL+VxM6XCEibyddyR
r279IsfuWETIFiUzmzquAjAHtYIiGC7iMSMpZ/Rxg9UHki73X8BghBhnJe1AL2gR
h3pWdsbpExbW02UGbG4f65519au4dHSCQOJmzVHSjCleB/MgrNhpwcfatrQw4Nc5
jV0JK83j1gDx9TRmFQWNCjiySP2Ne4ZMPiqO/rx4Qf34Rz4iLghPHj7eCJxC2CIn
ELAHl52gDIljuJ56SJ1ZFq/tNV8enTPlPgFQBAT9rQ6kXGpZLenzkZnY1PuKimRk
hbcl3JtLO7CVw+KM5YIAf9pMCO3AYHGnOc4eGBcpDQqzvzUyUhyQnw51y3xdysYT
Tb8o1kJigrB5aKtXL0HZFf1so0rYXsHkksy2LEEyXid51JL7P6y2j/rhLM4kouLk
Aqeixw+Nciia9XxwVjsRPTBqPZfAdhZ8AXRp/JjWAfleUPf94ylhPd7igQ8syrbZ
y62V9NVYmzGu4fARbC05qMqCXfm10B2KASNe6GuyNoXW9VG7aKmkaf7AZmTHeR9N
83BJysfJhRGjrv/MqbLmVKI2rmgcArzIxfEvbN90kgTv8cLKIrR08ixDPA47PAnb
KI+EWuovNyVUF2aOV+gw
=zYFh
-----END PGP SIGNATURE-----

--gphVtybrzJJtG9bX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
