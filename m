From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
Date: Sat, 2 Apr 2016 09:34:12 -0700
Message-ID: <20160402163412.GC2350@sirena.org.uk>
References: <1459498877-5810-1-git-send-email-pc.liao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KXlsDDyIxzhAJBYd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459498877-5810-1-git-send-email-pc.liao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: PC Liao <pc.liao@mediatek.com>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com
List-Id: alsa-devel@alsa-project.org


--KXlsDDyIxzhAJBYd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 01, 2016 at 04:21:17PM +0800, PC Liao wrote:

> +Optional properties:
> +- mediatek,audio-codec-dai-capture: audio codec dai on capture path
> +  rt5645-aif1: Default setting. Connect rt5650 I2S1 for capture
> +  rt5645-aif2: Connect rt5650 I2S2 for capture

No, this has exactly the same issue as the previous version.  To repeat
what I said last time I would expect that the driver should just specify
the links between the DAIs.  Look at how other devices reference DAIs.

--KXlsDDyIxzhAJBYd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW//SDAAoJECTWi3JdVIfQDHYH/iWJfsoX7UzQYq2useXZkJhC
/FcMRcYMhpwjzJgeWbm8B2Ux98cfogyAglS8b8yAo3wCkvD4O8u9M4Nru2O42j/y
SUd+VdjywrYF/4WYNlbe/9GHmf6b2iiRLixjv/2eeuT58vjF903RyifamH7NswUb
aurGtspPu38YvdeirdDYzK3DFtzq0RcHJItdXxnKi24+Gvs+564ueUDtKuG6XRkm
PWifK+CzZmbqvwsciQmABwWxUPz3yfOX/S2YwkRia8wV7vKprdpg6Glx4hg6kRZz
XGYVQt8bEYNcsMxVwT+ZOh/DIKCyGe7yq9fZkpNik5sAUleqLVZGJLX8qVP7MJU=
=mcvv
-----END PGP SIGNATURE-----

--KXlsDDyIxzhAJBYd--
