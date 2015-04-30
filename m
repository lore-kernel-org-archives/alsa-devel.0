From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
Date: Thu, 30 Apr 2015 21:12:07 +0100
Message-ID: <20150430201207.GK22845@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
 <20150420204849.GJ14892@sirena.org.uk>
 <1429672640.14162.55.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zc0AcwaKuEyWL+br"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429672640.14162.55.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--Zc0AcwaKuEyWL+br
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 11:17:20AM +0800, Koro Chen wrote:

> If using DPCM, it seems the most suitable FE DAIs will be memif, and
> external interface like I2S should be BE DAIs. Do you think it is
> suitable for our memif to be FE DAIs? Then which memif to used can be
> described in a machine driver's FE DAIs. But I think this has a problem
> that our memif is one-direction, playback or capture. So the binded pcm
> device cannot have playback and capture capability together. May it
> cause trouble for user space apps that assumes there will be pcmC0D0p,
> pcmC0D0c?

I think the only userspace application you really have to worry about
here is PulseAudio which (at least with UCM) should be able to cope
since it needs to handle things like USB microphones.  I think
everything else I can think of can either cope or has to handle the same
use cases as PulseAudio does so should have support.

--Zc0AcwaKuEyWL+br
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQoyWAAoJECTWi3JdVIfQ39IH/0AcULgyvIUMLo5A+Zi5EOD2
8LdacMZp5UHIr7/EeNyssa6C3uzrFPxZ95YAbq1wCOtKYtEZbw9XYh2EzzocEvRk
C+RyzqX1yNs8IxkPsTFRQU7Upo+W3Q1SzjaVcTnJBYlrB5tAsYGuODhW51LQZZgf
M9BH9hQ0sBKm6SJkshpE7i3D/AJDHSSW54ntIJIV+7PkLJYZ3LIEQAGPOzQZoYNj
2BCtSg0LzuZKLzbBEbjgMKIgyzdtFsbXsr7mBpjsQuNpgR6+YjXYimWWhVJTqQdx
qm713NAaJA0bYH1cE55JJ1j0KAwUA58a1lGRZYuiVgBSP77wylnvsdPsi5hNQR0=
=go0X
-----END PGP SIGNATURE-----

--Zc0AcwaKuEyWL+br--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
