From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2] ASoC: sun4i-codec: use consistent names
 for PA controls
Date: Sun, 1 Nov 2015 10:36:25 +0100
Message-ID: <20151101093625.GO6114@lukather>
References: <1445979645-1664-1-git-send-email-ats@offog.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4600948297354416283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BF5F260421
 for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2015 10:36:33 +0100 (CET)
In-Reply-To: <1445979645-1664-1-git-send-email-ats@offog.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Sampson <ats@offog.org>
Cc: alsa-devel@alsa-project.org, emilio@elopez.com.ar, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4600948297354416283==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sMkrXc3gAYLRVOjR"
Content-Disposition: inline


--sMkrXc3gAYLRVOjR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, Oct 27, 2015 at 09:00:45PM +0000, Adam Sampson wrote:
> The power amplifier for the headphone output is called "the PA" and "the
> headphone amplifier" in Allwinner's documentation for the A10 and A20.
> sun4i-codec calls it "PA" in some places and "Pre-Amplifier" (which
> isn't really accurate) in others, leading to user-visible controls with
> different names referring to the same device.
>=20
> When this driver implements audio input, it'll also need to expose
> controls for the line and mic input preamps, so just referring to "the
> Pre-Amplifier" will be ambiguous.
>=20
> Change it to use "Power Amplifier" consistently for the power
> amplifier's controls.
>=20
> Signed-off-by: Adam Sampson <ats@offog.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--sMkrXc3gAYLRVOjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWNd0ZAAoJEBx+YmzsjxAg0wcQAKofJWu5i6YKRJ52SxUsacXm
WhUR0DGn21NCBN81AsRdAk189oYR5VRz4bEsgbwd5vjQwLXObhYDggKMtBLL+9aK
sYaONJS1im7EqRZ/4O4x4sH1oC8H55hm7sy1eAEQK0gKtunn5770Haz96Oi3AOXb
EkFxusErJBCee9VBIYIzCdkSDb+FCkug388wzgxDtBdwjokndPPnICPIRiC4GNq2
XV44ObeVmoHBOpg/8/unkQ9rXj8X9MYNh1022dj0hJrbN6mGFFOs71KTy//yoLsJ
gCM/UoVEQZt9dRbvX4Wj1HUBjfozWVSFhRGc+Ym7a/vxrVO14me5xRsGNeSQEonH
f+Ktrmimsnd9duJU3qfjjGKhTDyssGH0CCrjb8MUYtBtcGD+phMvMocRxfYmDmvk
Gl2wEvKJkjRyzK9I2fdzusOcwWk8wgigVDppI8nu9mMmETSaDF/tfNIJwZ1PY6LL
J/t+7+FGtVTspBqgtg4L3xsNWgR0RToueClkGPAXYR/bFBzok9FHdnhe1QficxdL
pjaMFRd9Y7kQBg1u6loGU3VPn2Ry/WBR5Non89kAUBXAZxrCi87SUqOIXTUXE3j6
jq9lb3knCUcynMx4urJltXMyT04FPgMaHFzsSrEWIKEdC3lL7p2dHBlCTa4Piep8
m4bOuxalah36O/lhZSj8
=XLfn
-----END PGP SIGNATURE-----

--sMkrXc3gAYLRVOjR--

--===============4600948297354416283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4600948297354416283==--
