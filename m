From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 1/8] ASoC: sun4i-i2s: Update binding
 documentation to include A31
Date: Tue, 31 Jan 2017 11:30:41 +0100
Message-ID: <20170131103041.aau37qnm2wc5ug5m@lukather>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4070137487015829356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id C0C17267268
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 11:30:42 +0100 (CET)
In-Reply-To: <20170131100552.27949-2-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4070137487015829356==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cqcml476cmts32kv"
Content-Disposition: inline


--cqcml476cmts32kv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 11:05:45AM +0100, Myl=E8ne Josserand wrote:
> Add a new compatible for sun4i-i2s driver to handle some
> SoCs that have a reset line that must be asserted/deasserted.
>=20
> This new compatible, "allwinner,sun6i-a31-i2s", requires the
> property "resets" which should be a phandle to the reset line.
> Except these differences, the compatible is identical to previous one
> which will not handle a reset line.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--cqcml476cmts32kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYkGdNAAoJEBx+YmzsjxAgD28P/AwcwG5zf10BpFPPiZuTt6BK
3HboShNxcHaQGREZ1CiZsCl/LoXlJKM0M+mGvfJBbpq9L0jDy/HkuIUK6nr0LB5w
k+rLQ1VFutEjQ9ngesXTfmi8fbYYAPFq9bG9NAebC/MLQpnsa0qBkbjpHF2umDEn
Z9uRssoVcDw1RfIvwC70paC3CfW9/RQ47vCambyQuQ3cATrCq/TtagkEZKbilLee
iwvFLIJ80LMacOdBGm+MgN+MdWBzeHTNotaYKahoTFA1hywDpWBveTdFVRvPUP7/
Nt+DORZlgPPH9+OjRanc7ar22PFOWZpiQV4TQ7BUkCiJxlFTvwSZm9F7fPG6al30
wMD+l6f8wDprSAx9xX5p7muQVsnx6jkcWOjhH5NuFMSdSulSfiK0RgJMRhXxofLy
hN93N4DrH4L4+TBuVx5DXqqaoS4Cpfrb+WTefFsNMZ0uE7zrkz2xgo34qCaZCeD/
0L09pvq/jFjZQGHTkjKdNSlfaXmlq0+KKgr013bxrql3rjJi4Q20FZSMgPHOwGct
r/zui/W4kJgpG0LQZiAKdP/wi4dpSAr/M/rGHyy9losGUIiyxvSfPPAVwiuWaqJ0
ZQukhuDa2znSnlT37uIJiP+nzIsSwvEHWU6EuR3UlhrZq18M7gwl8CnCqvhNH4eS
/mi7cJs+SZWAhBubE8x3
=yRWu
-----END PGP SIGNATURE-----

--cqcml476cmts32kv--

--===============4070137487015829356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4070137487015829356==--
