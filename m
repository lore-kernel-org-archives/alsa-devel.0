From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: Add second I2S on
 mt8173-rt5650 machine driver
Date: Wed, 6 Apr 2016 10:17:50 -0700
Message-ID: <20160406171750.GR1924@sirena.org.uk>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk>
 <1459258103.3747.7.camel@mtksdaap41>
 <20160329160703.GN2350@sirena.org.uk>
 <1459479052.24414.3.camel@mtksdaap41>
 <20160402170404.GG2350@sirena.org.uk>
 <1459951105.28748.12.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0170839267829057710=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E398326070F
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 19:18:12 +0200 (CEST)
In-Reply-To: <1459951105.28748.12.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: PC Liao <pc.liao@mediatek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srv_heupstream <srv_heupstream@mediatek.com>, "tiwai@suse.de" <tiwai@suse.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koro Chen =?utf-8?B?KOmZs+aAnee/sCk=?= <koro.chen@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0170839267829057710==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A7FgPGrDEcSmmdo/"
Content-Disposition: inline


--A7FgPGrDEcSmmdo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 06, 2016 at 09:58:25PM +0800, PC Liao wrote:
> On Sun, 2016-04-03 at 01:04 +0800, Mark Brown wrote:

> > Any driver that can identify an individual DAI within a device by using
> > sound-dai references, even simple-card does this.

> Thanks for suggestion.
> This machine driver is based on DPCM.
> Should I add BE DAI and use DAPM, then using ucm-config(mixer control)
> to control the path?
> Or, do I think the wrong direction?
> Thanks!

It sounds like the configuration is fixed in these systems and can't
be usefully varied at runtime?  If that's the case then there's no need
for a userspace control.

--A7FgPGrDEcSmmdo/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBUS9AAoJECTWi3JdVIfQdMkH/3qAMy7SCagHopGhdG+LP6j/
UjTRE/Vds/kW2oyX6QXf7gAbxKFksxeKtoQlV0YmSV1mSK1JjeEr7oexK4aEw1Fe
1TMS0QvuFrpOr1KM5RHrGNXWRvv1jfJ+VvQ9+vondOU7uautK3kj4OAUKRF0Aiz2
hipszhnnZq6/Ry+ybJw+ZEqW5qTMVzxkUiHrVH5y8atGO7eyV4D1eCvSrmlJalr7
fYngsEByXu2me5JVT5sIwAmDBDXAWax31cnfDy1IeivzqHvKpV/E1CboDbJchVoP
XfTn+/luDzBBoY9AfLO97iJlPh0rEOVkfhcYBq6Ngxho3wuUOUWESlppVk+934Y=
=2tQn
-----END PGP SIGNATURE-----

--A7FgPGrDEcSmmdo/--

--===============0170839267829057710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0170839267829057710==--
