From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] ASoC: cs35l35: Add multi-device synchronisation
Date: Mon, 29 May 2017 14:53:06 +0100
Message-ID: <20170529135306.ldn74fwvfa4ots6a@sirena.org.uk>
References: <1495121559-1063-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1495121559-1063-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d2vaxkr65qoxswv7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1495121559-1063-4-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--d2vaxkr65qoxswv7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2017 at 04:32:39PM +0100, Charles Keepax wrote:

> +	SOC_SINGLE_EXT("SYNC Audio", CS35L35_MULT_DEV_SYNCH2, 1, 1, 0,
> +		       snd_soc_get_volsw, cs35l35_put_sync),
> +	SOC_SINGLE_EXT("SYNC VPBR", CS35L35_MULT_DEV_SYNCH2, 2, 1, 0,
> +		       snd_soc_get_volsw, cs35l35_put_sync),
> +	SOC_SINGLE_EXT("SYNC OTW", CS35L35_MULT_DEV_SYNCH2, 3, 1, 0,
> +		       snd_soc_get_volsw, cs35l35_put_sync),

I can't tell how this works.  It feels like this shouldn't just be being
controlled from userspace but rather should be handled in some more
standard fashion, or possibly as part of the platform integration but
right now it's just some totally undocumented application managed
controls.

--d2vaxkr65qoxswv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlksJ8EACgkQJNaLcl1U
h9B8rgf+PyvVds5J2CnjxYc3K2vORzlaYvkQhoMxlYAfIR0I9P5qvEpu4tNZ1645
rMcgoNYZPz6mh7MzKn0EdCnbXob//RpmW4wBGgPbDJpoKVa6do6y3qi5RghpIJDX
nT3NYDHXI9qrWyym8BEQ0mh719tOxdkzJwXF3tc38BjZePiZDUoUwGVImt/XP9Zu
aioNf826nO3cMd5RS5fWdTuLfwMc9y2TDoTYzBcUxfkeJpgE2WGgMmbW+Z7PsI8I
70dVQULsT4cwgjrCIvHZ9Az+Wx+pYBz+04LDJweedWhIt27K0R/zYe5gj9YN1ELu
zUOEX5ZmP9Lg0uETC2S9C8VcPOFuJg==
=bEnA
-----END PGP SIGNATURE-----

--d2vaxkr65qoxswv7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
