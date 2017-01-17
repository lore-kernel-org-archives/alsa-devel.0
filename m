From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 06/10] ASoC: sun8i-codec-analog: Add
 amplifier event to fix first delay
Date: Tue, 17 Jan 2017 17:49:04 +0100
Message-ID: <20170117164904.c22f7tmtu67l23dd@lukather>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-7-mylene.josserand@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sh5nscmqg2dbm6ci"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBC4W7HBQKGQECFOPDTI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170117140230.23142-7-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--sh5nscmqg2dbm6ci
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 03:02:26PM +0100, Myl=C3=A8ne Josserand wrote:
> When playing a sound for the first time, a short delay, where the audio
> file is not played, can be noticed.
> On a second play (right after), the sound is played correctly.
> If we wait a short time (~5 sec which corresponds to the aplay
> timeout), the delay is back.
>=20
> This patch fixes it by using an event on headphone amplifier.
> It allows to keep the amplifier enable while playing a sound.
> A delay of 700ms allows to wait that the amplifier is powered-up
> before playing the sound.
>=20
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--sh5nscmqg2dbm6ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfksAAAoJEBx+YmzsjxAgmvcP/iyTTH7UECcmmXmjr8IurRLT
wziep6YhieePCllWYnYj97xEfXsQ2h6ydb7Iiwfy82vCCZL9+KV/qmMIYEPZDMZu
22cJa304UchxUFiYRyEBEvnU8UqC59m7T7KnSK3XWnFfil3zWcMbAhf43n+Yn2C2
imd/fsl1hpEV5GMpGV4qh63OKNrBiQrgNPEBf/qFE8rXe58iAbkN46J73hA8NBaf
eyp59QmRGD0ISKODuZX7StX6Pw/LL27OXV27LUxsYCMiFZVdY4M+AODabZZkwAB1
4DT2l4Cnhrat5JsTAma02w6Q1qD1Q/I9nO6g2WiKtr6a8Ua7OxuYnFHpjIDLBqKV
+RPNRaGIF5e49y5r4RyZEwfsqQm3TfOdFBGmvtMOnJgaFUm9Z2QdTUMb4Y8HakEL
yDd/2iyfG+6tyPBRWZ7t3/pCNxHKYzpIqlsD0twFO6y2l8OIeQKLSTYdYLlWwx50
qJaAJ2dCFjSt+OVSn8dgWESp3RskuvDrdZVGHOLnTqA51ciIPPVDDv2df/aS+j2Q
E49QuRk2BodC048+jrD/lbLjJaBtx2onbP2tnFXrcfUSqVcdaiY2BeW1naQLC77J
JpDuhCa/uc3MtH90l62ABOduq6ustoQPJgBRJOdB/emJYgwh0D/Git9Wm8RItMP+
egdkzqfxBHhsz2Uxa69V
=nhSU
-----END PGP SIGNATURE-----

--sh5nscmqg2dbm6ci--
