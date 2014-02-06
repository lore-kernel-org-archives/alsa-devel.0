From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: pcm512x: Add PCM512x driver
Date: Thu, 6 Feb 2014 13:07:35 +0000
Message-ID: <20140206130735.GP32298@sirena.org.uk>
References: <1391689575-4039-1-git-send-email-broonie@kernel.org>
 <s5hr47gv1yi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjOMJDssiV0CZSJH"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hr47gv1yi.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--tjOMJDssiV0CZSJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2014 at 01:51:33PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > +static const char *pcm512x_dsp_program_texts[] = {

> The numbers of items in pcm512x_dsp_program_texts[] and _values[]
> don't match.

Yeah, fixed.

> > +static const struct soc_enum pcm512x_clk_missing =
> > +	SOC_ENUM_SINGLE(PCM512x_CLKDET, 0,  7, pcm512x_clk_missing_text);

> Isn't it 8?

Hrm, it is but this points out an error in the control helpers which has
been there since forever - they call that parameter max but it's not a
maximum, it's the number of elements in the enumeration.  I bet we have
a bunch of other enumerations which miss the last element as a result.

--tjOMJDssiV0CZSJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS84kUAAoJELSic+t+oim9D7IP+gMWZwfq4Df9uFOUZYax3pg3
7/32UJikYrv72hXrF+rpMXoPamoWcS8cr8cMcyfi3LIrrgedqlxmdj6FGSIoVuLI
KW1+PIUV7Hmd9liL5tsmgFlIWJtiJxCFIuCmD3UoakvA+MKCuMkzm3YqMflHLYAk
QGayEFIAN9tYKw+pn9XyVieFf5bibpV0DzG4gRbT2ynBhTiMpMl+Ik8arl+k+m+o
OKzfjLPSFEdg27vZSvZoRl9cIUmMIEannIAo3pMhmINQ+negwocRIYpzrbUZLlvb
XjbHw2Kp4UJ5mwfkzYuD8D5xQOZI1zhjRewbW/5Ka5TmTVPoEHuf8sXisLYJso9G
m1u8GwfOB9ygSDAKA7YjUQqa6Ot6CQbz3I51zkqIYpNWstxD4jkg6vBMZN1Kyylk
u+Z8ywsnupKNsitDh+m353enccJUqrGPUY1smAxlvgsMSELw1ibLSBBiKkyAdjAS
kRK6J87GpOGisl1haDKkQo7MU/xJzZFfOXUuuSuf/dTJmBi0tSZktO+KtnS49RZV
wnlB/i5s8dpaK8kWch6dNrJqnjDkgYkhVBiMJDL/3jck4mP5vBeegZcHtKAvJj4Z
vf12R12Cw26koKg21ihOCLuTVEJlkUf0Kb2hfdzsyQ2qLfF8Y6jfRPI4/U9X23Pu
YkK8yCKFQ81N45W5UQ7d
=wp9Q
-----END PGP SIGNATURE-----

--tjOMJDssiV0CZSJH--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
