From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Thu, 8 Jan 2015 20:04:21 +0000
Message-ID: <20150108200421.GC2634@sirena.org.uk>
References: <cover.1420628786.git.moinejf@free.fr>
 <0084acea5a3475a77531d6a77483f36d3469111a.1420628786.git.moinejf@free.fr>
 <54AE99F5.1010404@ti.com>
 <20150108174257.557f7ea5@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJFyG9uzPui3fcuS"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150108174257.557f7ea5@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--eJFyG9uzPui3fcuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 05:42:57PM +0100, Jean-Francois Moine wrote:

> Examples:

> - for the Cubox:

> 	audio-inputs = "i2s", "spdif";

> - for some other board with I2S on the pins 3 and 4 only:

> 	audio-inputs = "none", "none", "i2s", "i2s";

> - for a fully wired TDA9983B (no driver yet):

> 	audio-inputs = "i2s", "i2s", "i2s", "i2s", "spdif";

I think that mostly works, though I do wonder if we need a way to
specify the ordering of the pins (if you can make pin 3 be the first two
I2S channels for example)?  Someone might choose a strange mapping for
board routing reasons for example.

--eJFyG9uzPui3fcuS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUruLFAAoJECTWi3JdVIfQnlIH/0UKnbIlsOmNDZ/HbhAVvaQO
oOdt2VBztvN6yIuRhRpVseGjLnOvq10eeI3YspLCSoz02DX2FVWEaDG5EXqy2+UZ
UrDPEJMei6hmq1pYXEu0sVvaklB4uQ7oN00Lw3zwVa0DPukikXAPqjfRvhYUgGv0
S4ZptpfWXRh1VD2mrEE53/U480XxRmY6LtIpCoDf/bBffRKerdDeFhHQIcNK+V9A
XZyVaYEGceo2+R0OTY8muTgtbcqHjFRHJEMaQDOaS18gQKf/nR8UVLZummU4xtkA
ksE+agV2KfXYE+0XGOkrvJjdRkxvjICOiVByMIyYwYo1gNK7MEsOQGJtHEHMLQ4=
=S+Zv
-----END PGP SIGNATURE-----

--eJFyG9uzPui3fcuS--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
