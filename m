From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
Date: Tue, 29 Mar 2016 09:07:03 -0700
Message-ID: <20160329160703.GN2350@sirena.org.uk>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk>
 <1459258103.3747.7.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459258103.3747.7.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: PC Liao <pc.liao@mediatek.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Koro Chen =?utf-8?B?KOmZs+aAnee/sCk=?= <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 09:28:23PM +0800, PC Liao wrote:

> - mediatek,rt5650_i2s: I2S mode of rt5650
> 0: Default setting. Playback and record path use same set of I2S.
> Playback/Record path using same I2S clock connect from MT8173 I2S1 to
> rt5650 I2S1.
> 1: Playback and record path use different set of I2S. Playback path
> connects from MT8173 I2S1 to rt5650 I2S1 and record path connects from
> MT8173 I2S2 to rt5650 I2S2.

> Because we use codec ASRC function and need to initialize on different
> setting about this parts:

This sort of arrangement is very common - it's often needed to get
different sample rates for playback and capture.  Normally it'd be
represented in the DT by having the two DAI links specified normally and
then having the driver look at the DT to see what's connected to work
out what mode to use.

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+qgjAAoJECTWi3JdVIfQ21wIAIOWMmSUX1lMPuCO3YXYzWuQ
lOwjgIjZVRybtFe+Y487Kf4Zz4VwvBBP8VR3fw1Rxy1dRk8OVtumKVj793spFDc+
FKLtqV9VtbJ6Vlc00vrnl0xYKm4bgo64RwbZhBKZ0Gx6CLfZQYIZz2pua+g8qhT6
Q93NzJJ2Rc7kqNyCTKvyPIF6q77dtFE33e6ABiSLxJS3sGolv8sCFZ1tJn8t/NON
2nusxAo5Fp9HmEp9Zo/mzIj6I5b0SAmM86O3dIt2C25uYTtyJ0UpM5seZvUh/U9a
9Mg7vR2KFeUvD0WDxdmpD2sTMYFXHR3/D4lIzqbeAYOeF4YPLBa2s0VN9NQQd2U=
=ltDx
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--
