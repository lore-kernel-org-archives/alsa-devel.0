From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5645: Wait for 400msec before concluding on
 value of RT5645_VENDOR_ID2
Date: Mon, 6 Nov 2017 16:24:22 +0000
Message-ID: <20171106162422.vhurovalfxztf6ma@sirena.co.uk>
References: <1509741345-1589-1-git-send-email-alexander.deucher@amd.com>
 <1509741345-1589-4-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0178174262=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1509741345-1589-4-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Akshu Agrawal <akshu.agrawal@amd.com>, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0178174262==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rxwgg2fphhzmpdwe"
Content-Disposition: inline


--rxwgg2fphhzmpdwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 04:35:45PM -0400, Alex Deucher wrote:

> Minimum time required between power On of codec and read
> of RT5645_VENDOR_ID2 is 400msec. We should wait and attempt
> before erroring out.

So the description says we have to wait 400ms before attempting a
read...

> BUG=3Db:66978383

What does this mean?

> @@ -3786,6 +3789,15 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>  	}
>  	regmap_read(regmap, RT5645_VENDOR_ID2, &val);
> =20
> +	/*
> +	 * Read for 400msec, as it is the interval required between
> +	 * read and power On.
> +	 */
> +	while (val !=3D RT5645_DEVICE_ID && val !=3D RT5650_DEVICE_ID && --time=
out) {
> +		msleep(1);
> +		regmap_read(regmap, RT5645_VENDOR_ID2, &val);
> +	}
> +

=2E..but what we actually do is try to read up to 400 times starting well
before that 400ms is up.  This directly contradicts what the commit
message said we needed, may take a lot longer if the chip misbehaves on
the I2C bus while it's not ready (which wouldn't be that much of a
surprise), might lead to us reporting before the chip is really stable
(if the read happens to work while the chip isn't yet stable) and could
cause lots of noise on the console if the I2C controller gets upset.
What are we actually waiting for here?

If we really need 400ms of dead reckoning time (which is a lot for a
modern chip, that feels more like a VMID ramp) then it's going to be
safer to just do that.

--rxwgg2fphhzmpdwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloAjLYACgkQJNaLcl1U
h9BtnQf/a2uONbzWtC0XwNza98smNFt1sP+V3Zsny8kLbcyhp2SNldSk4Iq5lwMJ
HlN54MzFTlgaQFXwxGuL5Ui3wVfMZu3K2zc5BCje0nLuyBura0/YdFboehUinWNT
h0GG56vUqJEAlPZUWGsk1386DZR2L+8poHD3zs/gVeGo9z0w0Iz4sRV1PGTqBPo3
sScISwGVS41mTQCVrYDuQ4dYwXV9mYqZ7RYCl4bH/545Bdb9oXYAWtnBDgOxCDsP
izfW0ZskMYI+xDiiOGFlNYZP9gTpGe0P4YBNWRMQKXXBqwy1WM7EtRV30nZRFmSX
zAUUAWGNaMeS4DICUvq6NC42imuw9w==
=RnXa
-----END PGP SIGNATURE-----

--rxwgg2fphhzmpdwe--

--===============0178174262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0178174262==--
