From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: atmel_ssc_dai: Allow more rates
Date: Sat, 7 Feb 2015 07:09:51 +0800
Message-ID: <20150206230951.GL31311@finisterre.sirena.org.uk>
References: <1423050745-6372-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oY1uq2ONqt5kuovO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423050745-6372-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: alsa-devel@alsa-project.org, Peter Rosin <peda@axentia.se>, Bo Shen <voice.shen@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--oY1uq2ONqt5kuovO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2015 at 12:52:25PM +0100, Peter Rosin wrote:

> One thing remains a bit unclear, and that is the 500ppm deduction. Is
> that really warranted? The number was just pulled out of my hat...

I don't really get what this is supposed to be protecting against.

> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		t.min = 8000;
> +		t.max = ssc_p->mck_rate / mck_div / frame_size;
> +		/* Take away 500ppm, just to be on the safe side. */
> +		t.max -= t.max / 2000;
> +		t.openmin = t.openmax = 0;
> +		t.integer = 0;
> +		ret = snd_interval_refine(i, &t);

As I understand it this is a straight divider rather than something
that's doing dithering or anything else more fancy.  Given that it seems
as well just to trust the clock rate we've got - we don't do any error
tracking with the clock API (perhaps we should) and for many
applications some degree of divergence from the nominal rate is not
*too* bad for audio systems (for application specific values of "some"
and "too" of course).  If it is just dividers I'm not sure the situation
is really improved materially by knocking off the top frequency.

If we are doing something more fancy than divididing my analysis is off
base of course.

--oY1uq2ONqt5kuovO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1Um+AAoJECTWi3JdVIfQLU0H/33cg4ihNGi1mNycZGR2xc2c
z3XXAg6iYOIyAFXHeUR9TZ+2pD+odzBKAZiFFhmcj2Vt+omIq3wrHDLT9/FDAX+H
kfT4AjwrST1rvWn/pNORxtV4PC7ieLi/RLa4UrTKV8MHd/bmknBTaX4YxTH1gGIV
+IXLXOaVfleReivPUX7l69KF50Q/mAXl2TN+UvnU9sWVuHyNJRJDBBWtmkAHAYEt
4cAMxvcc540vAjrRzC9jmxhI9FOMwHHtaD1bvXORc6KSVsIrNiTAAdm8AK0rgGv8
W7b5h/8ZBGSndBSOAKL/o2a2FDFW1sclyX7cye1RG59LXaaQ7cJq3DpA3Xqdzxw=
=tvq8
-----END PGP SIGNATURE-----

--oY1uq2ONqt5kuovO--
