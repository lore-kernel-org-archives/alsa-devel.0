From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v1 1/4] ASoC: codec: Inno codec driver for
 RK3036 SoC
Date: Mon, 19 Oct 2015 19:54:14 +0100
Message-ID: <20151019185414.GO32054@sirena.org.uk>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
 <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
 <alpine.DEB.2.02.1510190855250.4075@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f0PSjARDFl/vfYT5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1510190855250.4075@lnxricardw1.se.axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Shunqian Zheng <zhengsq@rock-chips.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "heiko@sntech.de" <heiko@sntech.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "benzh@chromium.org" <benzh@chromium.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--f0PSjARDFl/vfYT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2015 at 08:56:51AM +0200, Ricard Wanderlof wrote:
> On Tue, 13 Oct 2015, Shunqian Zheng wrote:

> > +static const struct of_device_id rk3036_codec_of_match[] = {
> > +       { .compatible = "rk3036-codec", },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, rk3036_codec_of_match);

> Isn't a compatible string normally in the form "rockchip,rk3036-codec" ?

Yes, it needs vendor namespacing.

--f0PSjARDFl/vfYT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJTxVAAoJECTWi3JdVIfQdf8H/0+TPUuLQaSrhGLWhHkSaTUY
yoSdLKSf52RidLRcyoWxpfi/k+DoV38OLOlR8o1jjbeqC6FCu1l8ueywb8tXh+Ca
fmhxmB24zvr7vcDOeY9ORX7KTOknJ+EeQkaWtDUvdYNAYPyADHYSbXSVaxrKqpzR
DZ3a4UItVRD3XEEGSZQERmImknPQLhkcFw2Ms1K725aEpHLLcrwLGLZg1nDw4kJ4
QK97C/kRUpSYUki3pAPh0HYH/e2t52PhwPrQcp+ztjPK0Zl9nSGMQcoOuUrMQL8Y
gdjHsE3Whjmhq/j0is9SgpJ+xrCYk5tM5XJVcLVlAIAGLs7CM36HAT7J9ej0Nrs=
=LnLC
-----END PGP SIGNATURE-----

--f0PSjARDFl/vfYT5--
