From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Thu, 3 Jul 2014 11:44:32 +0100
Message-ID: <20140703104432.GV410@sirena.org.uk>
References: <20140702183841.7c964832@armhf>
 <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
 <20140703074959.7c489912@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="thwsKKN5whlRGe6j"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140703074959.7c489912@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--thwsKKN5whlRGe6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2014 at 07:49:59AM +0200, Jean-Francois Moine wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I'd expect this to return an error for the busy DAI rather than just
> > silently ignore it failing to start or (better) implement some control
> > to let the user select which of the DAIs is active.

> This is not an error. If the audio subsystem (DPCM, not the user)
> chooses to activate both I2S and S/PDIF, this means the HDMI audio may
> be taken either from I2S or from S/PDIF: both inputs have the right
> format and rate.

Your board happens to only be able to present the same input on both I2S
and S/PDIF but that might not apply to other boards, they may be able to
route different signals to each which would present a practical problem.

--thwsKKN5whlRGe6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtTQNAAoJELSic+t+oim9kCYP/1PZRjnVbG8twwFDebfaR2P9
l/MsRKR4D68eHTLCkU1BzRNefr42P9v2ZiWmWVwBG/agQvpKp9MltfbR7AbUR4aS
tYZtY+mkJ5DC7vwrNSMoUa2TcQdOJe6coqYk4qFO0SYDq/jXljajA4jYUrvX+LQa
KomDovrCFWNDoliDHTSzinyk3zHYrDRH2t4HrRu0huIXiRBVLD1ipF20+kbTdsJu
a0/2cyntUYOLJVwNBzp+egoEoreET8+4+02bb0SSoSk+XT5jv7EegtTtJEY3DBYN
wP46S4OvtlpR0bI0nB5/UfamKD2GsccGO8gKzVpmeJghUcAgr1Rvkf5pKEZNW+8t
3CoRCZr9ubaWiSAJ8cNT8FnrtIE6c3Tf480q/cfDLF6+bp5kJ0bzv/TRH3ZVrzyN
Tetx3ifdnK9ciwRvESyw4ZdYn6KaZeG9lyiJv+EOVzvCbK1GRP8tdIc9lVf27AL7
W9fYzlpuQ3SZQAJvUMiImIvucGvFSU5UjD0u8z1BuDK5NVDp0GYPphXseZvm1yaP
1mVlBe5vpMESBmkseA08vtwg3zKTj3s3Y6qzeNAfRoRmIWVa8wtFc62eVo23nn+G
NTRrU5YsSJtxG6DgEOXoXtSoIvNmaZxt70TlCI48Rm4JxAkWDyFK5qP17SYtdsG5
lhIhHjGXg0wmUJMAggrk
=r83t
-----END PGP SIGNATURE-----

--thwsKKN5whlRGe6j--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
