From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: da7219: Update REFERENCES reg default, in-line
 with HW
Date: Wed, 23 Dec 2015 00:10:19 +0000
Message-ID: <20151223001019.GG16023@sirena.org.uk>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
 <5233faeef4073f33e2826866eae35e8c9502c35f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5233faeef4073f33e2826866eae35e8c9502c35f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 22, 2015 at 06:27:53PM +0000, Adam Thomson wrote:
> In current AB silicon, BIAS_EN field is enabled by default in the
> REFERENCES register, so the regmap default value should reflect
> this.

This is the sort of thing where a register patch would normally be used
- if you put in a register patch for the older silicon then the driver
can correct for the register default automatically.

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeeZqAAoJECTWi3JdVIfQvXUH/0BCBYVlvn9/FvHt83e3hI+r
15hGFZUcdjrDD7FFia5yDUDhE1YEQtlvOffrlPuOYH3WYwdVBbaG0uykvwPbifOb
0gBz4M1snfO9S7ov+3c1bAWbMSn7v2rUcywgyG7/MpSgV0GIDeqImrMauQ8sJvHX
XFIiP9MhMFIK1fnrgZwo11gWmQmuFjuUanXtnwv8g6AmkzVITFRATnuFHpG/oqji
CIq3xKhnkbNp2JlD57HW7TK+j/wBdmpqDC+LUxeUa2wseEjj2EGh0fD2K94M+b4R
ZyMHNmcf4mO4bg7nDBAAkFCQ739c7rWMfGIXAIKDAQy5WlW9K1DvMyvE/c2n9ZQ=
=FpM+
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
