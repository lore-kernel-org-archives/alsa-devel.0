From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8904: add CCF support
Date: Mon, 24 Mar 2014 11:06:16 +0000
Message-ID: <20140324110616.GG2269@sirena.org.uk>
References: <1395370262-23305-1-git-send-email-voice.shen@atmel.com>
 <20140321103747.GK23372@e106331-lin.cambridge.arm.com>
 <20140321115511.GM11706@sirena.org.uk>
 <532F9557.2000402@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <532F9557.2000402@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "b.brezillon.dev@gmail.com" <b.brezillon.dev@gmail.com>, "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2014 at 10:15:51AM +0800, Bo Shen wrote:
> On 03/21/2014 07:55 PM, Mark Brown wrote:
> >On Fri, Mar 21, 2014 at 10:37:47AM +0000, Mark Rutland wrote:
> >>On Fri, Mar 21, 2014 at 02:51:02AM +0000, Bo Shen wrote:

> >>>+  - wlf,sysclk-from-mclk: set the sys clock is driven from mclk,

> >>Why can the kernel not decide this?

> >It can.

> I really don't know how it decided by kernel (hardcode in machine driver ?),
> can you point me directly? Thanks.

It can just look to see if there is a suitable system clock present,
this shouldn't be hard.  If there's a clock connected at a suitable
rate it should use that, otherwise if there's a clock at an unsuitable
rate it should either change the rate of the clock or use the FLL.

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMBGlAAoJELSic+t+oim9YxMP/iffUyCyXX72fYi/Hvd0WMWU
GUCdAaQZIDjjlFEZvD8cy2LpkudLQaKQkxcdtgmcnvXzKa0Cofdf5LKgreOgWaAB
r2lKzm+2Otr/cFsxK8UW53uku2LWjLbv4WpzApuJzwSw19MGm7vFFZpqi+6O2M/f
mps7gmercWZ1M/j3AaNSOYp1uUx343P+ZMjbdWRfDrIrLQqrIZT996x0nmJzv04G
p/q+ajyboQvImSwLr0c92eC3sG8w1Jbl6CM2lak7CoGF/iFCeL9lrV7mGgOpozx7
wZF3no4oIi+Y4iJUvoPTR/qNv2kaYESL85f6kzVBlUG3YLUFgyWZhEG4MKed6TkC
2o7OlPHNAR2NxT4zuHbD3WVzh1jAsv2evgUBbFVNDAu09lUbKV99oSJRG+eVaYNS
qkfWwHCvr9SNtgHHyxKE47/MPT6u1Uz3Z+/PGQjDMboeZf8pTPWGxheD1XBiWPVa
ldKBdvNQVv8WWfjGErCwJGK3tYmZKOesfwH1JlrgoqzxHQypyDYwrhhxbUDCx3iv
NsJJEtcV5TR+ByELrruFNcyJZz/lHLv3+I2SQxmloUD3hTuyvg/7VuBEzZz1hssk
oczT52BT160fUFYKasFZ/KNR4pZ/Ga80G3G1kP+cMfXLzmMxGswSsoNYW8VtDWaW
OIiw7Vt6gih7AnBEhckh
=KYND
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
