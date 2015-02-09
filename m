From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V4 03/10] ASoC: qcom: Document LPASS CPU bindings
Date: Mon, 9 Feb 2015 16:08:44 +0800
Message-ID: <20150209080844.GB2593@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <1423169626-22166-4-git-send-email-kwestfie@codeaurora.org>
 <20150206221823.GF31311@finisterre.sirena.org.uk>
 <20150209063822.GA19870@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150209063822.GA19870-VfhoOQ2zEbNBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 08, 2015 at 10:38:23PM -0800, Kenneth Westfield wrote:

> So I add a machine driver that selects the clocking freq in hw_params
> and calls set_sysclk in the DAIs.

> The DT node for the machine driver would look something like:
>         default_system_clock_frequency = < xxxxxx >;
>         alternate_system_clock_frequency = < xxxxxx >;
>         cpu_dai = < &cpu >;
>         codec_dai = < &codec >;
>         pinctrl... ?

Why are the system clock frequencies being specified in the DT at all -
can't we either figure out the constraints from something else or just
set the rates to something sensible that the driver knows (allowing for
improvements in the driver in the future).

> Does this sound ok?  Also, would it make sense to move the pinctrl back
> to the machine driver?

Why would we want to do that?

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2GsLAAoJECTWi3JdVIfQpbwH/jr9XJAh7m+JsbMEksYi34eJ
ztZb4tetzS8+37MtvQ3YaD9qVv+vAHCkCAHwvt99I+jA/1gfQ4Sr1Pw9nEJDjA4U
BaA29lK0k6Ylu05Z7evuZxTZMd/liwzy96iAAytkX1/MWIIzt7ZqaSx7jtewdYu1
7UodBPwp10+NOENlJR8TcmxFahdxRJkXfqftQLbDCyjDC7hHAvPwrotEScLv50h1
2vLrhUhgbu08DL5wkIS5+4NfksubFeAfQmgNLHCEFR0R7vSlf9QtAINKcEBteBSs
D/x73oMvhUL4vxsczRAE/vkjBPSuJcMoi55lgDY5d3pF4urYQD1RkVElZYlwylI=
=Hrvj
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
