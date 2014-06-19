From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4 3/3] ASoC: fsl: add imx-es8328 machine
 driver
Date: Thu, 19 Jun 2014 16:13:00 +0100
Message-ID: <20140619151300.GP5099@sirena.org.uk>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com>
 <1403063242-20840-4-git-send-email-xobs@kosagi.com>
 <20140618100233.GE5099@sirena.org.uk>
 <53A1687C.9010705@kosagi.com>
 <20140618103111.GH5099@sirena.org.uk>
 <53A23E1B.3070008@kosagi.com>
 <20140619142737.GD3412@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cQx5fYD6zrLPRXWY"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140619142737.GD3412-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--cQx5fYD6zrLPRXWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 19, 2014 at 03:27:37PM +0100, Charles Keepax wrote:

> You mention that your power gate might only exist on some
> hardware. This hardware differences are what device tree is there
> to describe. So lets say your CODEC has a main power supply called
> AVDD as in my example above:

FWIW the datasheet I just googled appears to say there are power
supplies AVDD, DVDD, PVDD and HPVDD - all four of them should appear in
the driver.

--cQx5fYD6zrLPRXWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTov35AAoJELSic+t+oim9jsEQAIIye70TYli1ZpaQbXkZqAVe
mzerDDtrjl0TGjjka+gb0HIMVGt8tLwWNqOa63EPBGKodhEe7tUwjjQOrqaJVAt6
bQin/ajMmaGjKngsULqzZZ/sLRUNvTRSB7KJBAIiOMiUOW+KJ8e0obVsilkgoRPs
32lUGs5+Re5LkoVELLVKYhFb6iJ4HMkIory0W+8fJ67RHfz1Gco2p2E+Ir6kuX6O
9PNBfzOG5HmoVfImPWRBt7HXIimODy/g3INAPZIDMOBdD2+aMrZmtJKJht51lCi0
1FpxnX3N4e8cisedI4jAqjenS3BTkScJMU+rTz6F3XHC2QrqP7EqMuz/Pe+tyDlX
uym7F8Je//reoBfoRzzO+vlMrkf0HPUCDjuuf/FoKcZqStD8zQZAxjSS3pcRMnmE
rT148ubnS/S/o9dlhX6hT2uxG+i1YBFdvLmqD4RXiKKRwGK2Nsh+OU6qKKiITgpE
Wlo81KwQDIQVJUM30pDLYC/lyIBIVoEQlaHDUDoeWlLo2g4L4E5JivFOEbHY4RpO
QX9PDRUTjzqxyG7A47r4Jh8Py98uxgX5rp0XLXUZc1GpcGct+rJX8gj+0P06Lpq4
mxCgh5zXBq1XGELEhISucdzQge0+rD2BnxiSplmKroE+cw8Op5wLN5OhxvlKEdun
R/JZ1hpzD8Uyzc2kEZBr
=3UnD
-----END PGP SIGNATURE-----

--cQx5fYD6zrLPRXWY--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
