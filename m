From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels capture and
 lrck-mode support
Date: Wed, 30 Sep 2015 19:46:55 +0100
Message-ID: <20150930184655.GX15635@sirena.org.uk>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk>
 <5608F74C.3000104@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S5Rg6oz6PtEXgjQf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5608F74C.3000104@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sugar <sugar.zhang@rock-chips.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--S5Rg6oz6PtEXgjQf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2015 at 04:16:12PM +0800, sugar wrote:
> =E5=9C=A8 9/24/2015 00:24, Mark Brown =E5=86=99=E9=81=93:

> >My initial thought here is that the machine driver should be responsible
> >for setting this and then the DAI driver should check to see if
> >symmetric_rates are in use and configure itself appropriately.  Is there
> >a reason why this won't work here?

> It's for i2s ip configuration, in the most situation, there is no need
> to use this property, except one case:

> In order to save gpio pins for other function use, we may use single
> lrck(tx or rx) pin. of course, it depends on product design. when in i2s
> slave mode, we need to configure this to share lrck with tx/rx inside i2s
> logic.

> symmetric_rates flag works fine on rockchip platform, but it can't cover =
the
> above case.

> Do you have any suggestion about this or maybe there is no need to upstre=
am
> this special part?

What makes you say that the symmetric_rates flag can't be used to cover
this case?  What you describe above is hte normal reason for needing to
enforce symmetric_rates.  The driver should be able to check if the flag
has been set just as well as the core is.

--S5Rg6oz6PtEXgjQf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDC4eAAoJECTWi3JdVIfQj44H/2wgbEmUmiYb8lMThRoRwA9Q
VonDFwEMzc+auUjGDJ5dL43HR5E9hyMNKa1jBx43VRN6MicY9d74i/orL+es1Tuu
KIOTTShYUCDyOxlBPNcvUrhJ5Va8niMHIVNgLvaa6EuOLTdYRkWa4oSbSC6hWv60
Rg3WEpf76jvNArO1cWbLf1CjF302fkoDz+SAvvmzjgIHyKRB4lztkGhnseQIbqvR
k1BPKsEMohN07vEZyCejtMDuDjQor9/xQr2639tegv711LUqZs2yYZd+6Dnl+3uv
mWp+Sl28Ww5kRcTj1za9jKNwVPUKvVUQKpNfE4lzLGMcQwoWXPM3BaSXZa/0Jrs=
=+9+O
-----END PGP SIGNATURE-----

--S5Rg6oz6PtEXgjQf--
