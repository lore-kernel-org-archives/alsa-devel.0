From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: sun4i-codec: playback stall and I/O error with DAPM paths
 all disabled
Date: Mon, 15 Aug 2016 12:42:11 +0100
Message-ID: <20160815114211.GI9347@sirena.org.uk>
References: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SR0DFWOzPg+ymaCV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wens Tsai <wens213@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--SR0DFWOzPg+ymaCV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 15, 2016 at 05:43:55PM +0800, wens Tsai wrote:

> What is unexpected is any attempt to play anything under this state makes
> the playback software (in my case mpg321) stall, and later report an I/O
> error. My guess is that the DAC is still disabled by DAPM, so it doesn't
> send any DRQs, and thus the DMA engine is not consuming any data from
> userspace.

This is normal for ASoC - like you say it'll be becasue the hardware
isn't powered up.

> I think we should just enable the digital bits of the DAC/ADC all the
> time. Or maybe transfer and then discard data if the DAC is off. Not
> sure if this is doable though. I expect playback software to work, and
> not block, regardless of the hardware status.

Powering things up all the time will have a major effect on battery life
for systems that care about that.  The expectation is that systems with
this sort of hardware won't normally be offering end users direct
control of the routing, it'll be something that's handled during system
integration.

--SR0DFWOzPg+ymaCV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXsaqSAAoJECTWi3JdVIfQi4AH/jWqPscNLFZz2nkGMDKaDym+
DRk35pXedAC5apLlT7Ep08sSk7taPecq0tzwmsyJTDNauYPDc73E9ED6gewAzgew
JA3xw8/cQYqI3Hz9G0l1MzO/mp4ygq1Xw6HHTktNK5y5d4KiXye5UmnBukho4Q5Z
kcKesiUeP0gsLxE27oALz+RIDYemoHGpGKViBadq4pBMTF6Ue0ADw/TDtipQSwNB
spGtl+3EL8r3mPjeehxDVcL3Ys35Iy/FSO4WHTNlRRZxUdo/EjKBFwNRoLuowhc1
/Z4sR8OYO27y1yJH+F6SODpLUuy8fP3QXeiRQATk1jPFHCcNc98+HL62H5MJgkU=
=clzO
-----END PGP SIGNATURE-----

--SR0DFWOzPg+ymaCV--
