From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] ASoC: add xtensa xtfpga I2S interface and platform
Date: Mon, 22 Dec 2014 13:48:23 +0000
Message-ID: <20141222134823.GP17800@sirena.org.uk>
References: <1417914095-26553-1-git-send-email-jcmvbkbc@gmail.com>
 <CAMo8BfJCPU_ZM0w2Ry9kjU3O+HcWEmp_wgZ44oC7gBLW8DV5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/6IVfYouxg+lu1D"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMo8BfJCPU_ZM0w2Ry9kjU3O+HcWEmp_wgZ44oC7gBLW8DV5jw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--5/6IVfYouxg+lu1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 22, 2014 at 11:39:40AM +0300, Max Filippov wrote:
> On Sun, Dec 7, 2014 at 4:01 AM, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > XTFPGA boards provides an audio subsystem that consists of TI CDCE706
> > clock synthesizer, I2S transmitter and TLV320AIC23 audio codec.

> > I2S transmitter has MMIO-based interface that resembles that of the
> > OpenCores I2S transmitter. I2S transmitter is always a master on I2S
> > bus. There's no specialized audio DMA, sample data are transferred to
> > I2S transmitter FIFO by CPU through memory-mapped queue interface.

> Ping?

Don't send contentless quoted pings; they only add noise - if the patch
has been lost they can't be applied, if it's waiting for review then
a nag is just yet more e-mail to read.

--5/6IVfYouxg+lu1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmCEmAAoJECTWi3JdVIfQ4lEH/1VozZEL0nqvPHrMlH4eDs82
hYxbairXMdVhdcUY0uKrCyve6XVWYhCKwSODlWoDKTUaaPmzSTNLj8wHC6vh1xEL
ta2GJdKcE8JBW1dTlGNi3qjE6I+apvfleg36bDLfGZOm3Gy4G51OHoO3gbxGsMtb
hpFZJc/yvLTiawJ/rXlpHPTIg1o7zW2d8bd6Jip9XkGTKSD4kMWS4yW9hSYxDT+N
TLF7kJBnEprf3Xycv3EyK7xRm6Y/f59xtb7thhCwdLH/6dqax0TRjkbp/d7bl0H7
KIgOnlJxSmX8sm0Ha8aB1F/VjVWaGgjlpneCxnMRgFAqEjZsgzQWZRDjgT0+A74=
=Nabw
-----END PGP SIGNATURE-----

--5/6IVfYouxg+lu1D--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
