From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: dwc: Ensure FIFOs are flushed to prevent
 channel swap
Date: Wed, 3 Dec 2014 17:38:54 +0000
Message-ID: <20141203173854.GE7712@sirena.org.uk>
References: <547F3CB2.5070306@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qRudkE5L6XDjsdFd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <547F3CB2.5070306@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <Andrew.Jackson@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>
List-Id: alsa-devel@alsa-project.org


--qRudkE5L6XDjsdFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 04:39:14PM +0000, Andrew Jackson wrote:
> If the FIFOs aren't flushed, the left/right channels may be swapped:
> this may occur if the FIFOs are not empty when the streams start.

>  	/* Iterate over set of channels - independently controlled. */
>  	do {
>  		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			i2s_write_reg(dev->i2s_base, TXFFR, 1);

This is an example of the problem with putting fixes at the end of the
series - this can't be applied without your previous change to add the
support for more channels (which is a new feature).

--qRudkE5L6XDjsdFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf0qtAAoJECTWi3JdVIfQRAsH/27TgFyUrg50dPyNwTQcAJ92
cSi9jkTbAZM+j6Q78f1ExylGk7yPksydf80TaBY26kjwpFC2tHQ9QIv0wpGqC7lw
wMlMkBpmFAcRE572Rou/t2wt4XYJcy0g+cXtmbRNdr/faLzTudumrO9c4tQcYmFE
tlSu7kyHRnw6Mi+4i0rGbtXxJTN34cpXk3/dv7o3z2GvykJgZhOdJMjO5ds5gZAz
KqQkLYGmzqw7/ZX83umNx3psVQsk8lfyjL3fWSMvG+W0/4hJXzXmvgLXWRZmHCJC
cE4Fj/7Qhlz687RyLD3q7tpWH+ahKjZppsWcHIb4X7T5OMtxkYZ6EHANmdaeoLE=
=GnW3
-----END PGP SIGNATURE-----

--qRudkE5L6XDjsdFd--
