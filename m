From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/5] Sound: SOC: TAS571x: added missing register
 literals
Date: Tue, 29 Mar 2016 14:33:05 -0700
Message-ID: <20160329213305.GO2350@sirena.org.uk>
References: <1459237178-12920-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oDT6ON1uLKeoILhE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459237178-12920-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--oDT6ON1uLKeoILhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 09:39:34AM +0200, Petr Kulhavy wrote:

> The list of TAS571x registers was incomplete.
> Added the missing register definitions up to register 0x25

According to the driver the device has registers up to 0xff?

>  /* device registers */
> +#define TAS571X_CLK_CTRL_REG		0x00
> +#define TAS571X_DEV_ID_REG		0x01
> +#define TAS571X_ERR_STATUS_REG		0x02
> +#define TAS571X_SYS_CTRL_1_REG		0x03

These look like volatile registers but the device has a register cache
and we're not adding a list of volatile registers (or readable registers
for that matter).

--oDT6ON1uLKeoILhE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+vSQAAoJECTWi3JdVIfQ0hcH/j2A1pw2/5YeT0kd8I67ZYvn
ZjgO+05xZlvbXk7pN3TsvlrbKLLmATUK8NUWwP8HiuU5fuPXNYSyzeKAwc6/6H2b
0Qn/2S6K3SiLIk7tfpM/eNUiK2k84RNvPl+HCis5QigWeAV9236Hox4lCc50gnFd
bM7TPPMzb1ZC/bm0oPQ7NtV9tHvTQ5lre6kbYHa1expIaAcD6BGrHu6ZdUavFNDu
cem5gJFLiEW/rMjgTSncySLmr2uU3gMnHsfQbYnI8kLlbafqsEi1/FyCG54FA7Bh
GUhHOYs47L1zU2y7VdzVRN+JVSibogfiBj3fygL/bluz/PnWL9eKdKsN59Hs9QI=
=j+1O
-----END PGP SIGNATURE-----

--oDT6ON1uLKeoILhE--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
