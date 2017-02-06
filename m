From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 0/8] Add sun8i A33 audio driver
Date: Mon, 6 Feb 2017 08:49:13 +0100
Message-ID: <20170206074913.7ih2m3hndxqcrehd@lukather>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5arloaihipryvnkb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170202092422.5588-1-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--5arloaihipryvnkb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 10:24:14AM +0100, Myl=E8ne Josserand wrote:
> Hello everyone,
>=20
> This a V4 of my Allwinner A33 (sun8i) audio codec driver.
>=20
> Tested on "for-next" branch of ASoC repository with some patches
> to apply before this series:
> https://patchwork.kernel.org/patch/9447631/
> https://patchwork.kernel.org/patch/9423999/
> and one of my previous patch (from V2):
> https://patchwork.kernel.org/patch/9521121/
>=20
> Changes since V3:
> 	- Rebased my patches under Mark Brown's repo on "for-next" branch.
> 	- Removed the .owner from sun8i-codec driver, reported by KBuild robot
> 	- Updated patch 05/08 according to Rob Herring's review.
>=20
> Changes since V2:
> 	- Removed patches from v2 already merged:
> 	commit ebad64d193779 ("ASoC: sun4i-i2s: Increase DMA max burst to 8")
> 	commit 603a0c8af9cb2 ("clk: sunxi-ng: a33: Add CLK_SET_RATE_PARENT to ac=
-dig")
> 	- Removed "reset-names" from sun4i-i2s driver
> 	- Fixed the build warning from sun8i-codec
> 	- Fixed some various topics such as subject line
> 	for dt bindings patch, renamed the simple-card
> 	and disabled the simple-card.
>=20
> Changes since V1:
> 	- Remove the analog codec driver as a better version has been
> 	committed by Chen-Yu Tsai and is already merged.
> 	- Remove the audio-card as simple-card can be used
> 	- The DMA maxburst is set to 8 in the sun4i-i2s instead of
> 	adding the maxburst of 4 in Sun6i dma engine.
> 	- Create a new compatible for sun4i-i2s to handle the reset
> 	line.
> 	- Fix various problems in sun8i-codec driver according to V1's
> 	reviews
> 	- Add the pm_runtime hooks in sun8i-codec driver to prepare/
> 	unprepare clocks.
> 	- Update the DTS according to Chen-Yu's analog codec driver.
> 	- Rename sun8i-codec's clocks to "bus" and "mod"
> 	- The first "delay" issue from V1 is fixed by using a delay
> 	when enabling the headphone amplifier to let the amplifier
> 	being up.
>=20
> Patches 1 and 2 add a new compatible "allwinner,sun6i-a31-i2s"
> to handle the reset line for sun4i-i2s driver. It uses a quirk to
> use a version with or without reset lines.
>=20
> Patch 3 adds the sun8i codec driver which represents the digital part
> of the A33 codec. It supports only playback features.
>=20
> Path 4 fixes the previous issue of a "first time delay" in V1 (see cover
> letter). Do not hesitate if you have comments on this patch.
>=20
> Patches 5 adds the dt-bindings documentation for new audio driver
> added in this serie (sun8i-codec).
>=20
> Patch 6 adds the cpu DAI, codec and audio nodes to sun8i-a33 device tree.
>=20
> Patches 7 and 8 enable the audio on Parrot and Sinlinx's boards.
>=20
> The DAI for this A33 codec is the same than for A20: "sun4i-i2s".
> Currently, the sun8i-a33 codec driver handles only the playback feature.
> The other ones (such as capture) and all other interfaces except
> headphone are not supported. I will send a patch to handle the
> capture with microphones in next few weeks.
>=20
> Examples of amixer commands:
> 	amixer set 'Headphone' 75%
> 	amixer set 'Headphone' on
> 	amixer set 'DAC' on
> 	amixer set 'Right DAC Mixer RSlot 0' on
> 	amixer set 'Left DAC Mixer LSlot 0' on
>=20
> It was tested on Parrot and Sinlinx boards.
>=20
> Let me know if you have any comments on this serie.
>=20
> Thank you in advance,
> Best regards,
>=20
> Myl=E8ne Josserand (8):
>   ASoC: sun4i-i2s: Update binding documentation to include A31
>   ASoC: sun4i-i2s: Add quirks to handle a31 compatible
>   ASoC: Add sun8i digital audio codec
>   ASoC: sun8i-codec-analog: Add amplifier event to fix first delay
>   ASoC: codecs: Add sun8i-a33 binding documentation
>   ARM: dts: sun8i: Add audio codec, dai and card for A33
>   ARM: dts: sun8i: parrot: Enable audio nodes
>   ARM: dts: sun8i: sinlinx: Enable audio nodes

Applied the last three. There was a conflict in the last one that I
fixed.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5arloaihipryvnkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYmCp1AAoJEBx+YmzsjxAgnVwP/jFoWt/T7NTMmS+WN0wScgVY
nfn7iomCN090kuw5gz+cNuuEPzUxvxSPYYqxv6cCIPM1unbzz6oPbiTomVVMMfkt
fkEPCEjsRVKzM+9C6MkTmjuDfb+x+rWbt546ZZo3VaHjLmqWYDi3zKK7h3EDj0RB
vQz7WKQ9mJBXYEGvtR1JwekFlnTdCcyu8IIQass8GLG9xw5Fku++0Y3SpZpYFwMF
2dFYrEym3zTqffy/7kxzIjx3FL4z7uKrSoHDi6uEJanOq7ZcUV6FqTMw+7i/3OZ4
aWDWFjX7jHDlbWd763TWrsjITF0FzoWrHujL85FDnCnBn5WR0aAkpt/77I01l9FG
pIa3rIwHAQxWWf4/uZgKlG7hYmCv+wJhO7+uwU5AMuDEFQvtC1LN6+1X3RVu9lKn
p8rYQ/KsjiJ2/6S5hxrObxAgCPLO58Gtyj9oSi2JoQ8Z1GqKeOVXxGVQ4b38zqJS
6ApOivG0JtvN00SXa37y7gx8CgLwvWHbhlmZ0Gs6k8m4W/r6JLaogyjcrZMfEHjh
pdnWnBaD2JAfpR1ytD+N8abxLJGzf83TrJCJ14Qn9vrHfvNPg22ivKQSotj2PtoN
MhTAWWpLQuC4Kmh90C/2GmVSePRePKQ3tqppp8mQ1lEjiuTv+k60C3fT/93MnAN3
JrISDK3OpZyWyDiR5+O/
=KiSQ
-----END PGP SIGNATURE-----

--5arloaihipryvnkb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
