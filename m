From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
Date: Sat, 2 Apr 2016 10:04:04 -0700
Message-ID: <20160402170404.GG2350@sirena.org.uk>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk>
 <1459258103.3747.7.camel@mtksdaap41>
 <20160329160703.GN2350@sirena.org.uk>
 <1459479052.24414.3.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nkinyqrdwMuqz198"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459479052.24414.3.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: PC Liao <pc.liao@mediatek.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Koro Chen =?utf-8?B?KOmZs+aAnee/sCk=?= <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--nkinyqrdwMuqz198
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 01, 2016 at 10:50:52AM +0800, PC Liao wrote:
> On Wed, 2016-03-30 at 00:07 +0800, Mark Brown wrote:

> > This sort of arrangement is very common - it's often needed to get
> > different sample rates for playback and capture.  Normally it'd be
> > represented in the DT by having the two DAI links specified normally and
> > then having the driver look at the DT to see what's connected to work
> > out what mode to use.

> Could you please suggest the reference driver about this?

Any driver that can identify an individual DAI within a device by using
sound-dai references, even simple-card does this.

--nkinyqrdwMuqz198
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW//uDAAoJECTWi3JdVIfQ3FgH/ROWaWYBI6mXxYWyU5oMGv7i
4MVhEw44JPUNK5ubVWZLwtYodggkzPs+oRruHKwjnxsmFV8eczbnez2/2YgZSjkL
v5yMTYtSJut7FTfYmPN1KTFyQYoLw+W3HA9j8Z2ZVsjY+grCeItvo7zdZ6wDL3LE
BQTbvBuwzRafJvxjef1rN3RfDjamCEjhs+Nv6T0NF26o60WM6HMBHztq+KPJRvl1
1pnzOK/qMliv6wCjd1V2IwVXGVeWLw0gg2rNNGqadENK+AfaYv2J3NXeZrU4KlpC
iiAXZ34B7YpzbhuL8V/xZQQY6K0riKnIbEpjF0ln28njaXyApmgTKaBOijRn/oY=
=TA0z
-----END PGP SIGNATURE-----

--nkinyqrdwMuqz198--
