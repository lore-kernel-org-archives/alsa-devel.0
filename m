From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
Date: Wed, 20 Apr 2016 17:11:22 +0100
Message-ID: <20160420161122.GM3217@sirena.org.uk>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
 <20160420082917.GH3217@sirena.org.uk>
 <1461145190.3774.5.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+7qMzvEgojnlfQ4q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461145190.3774.5.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: PC Liao <pc.liao@mediatek.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Koro Chen =?utf-8?B?KOmZs+aAnee/sCk=?= <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--+7qMzvEgojnlfQ4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2016 at 05:39:50PM +0800, PC Liao wrote:
> On Wed, 2016-04-20 at 16:29 +0800, Mark Brown wrote:
> > On Wed, Apr 20, 2016 at 02:40:47PM +0800, PC Liao wrote:

> > > +Optional properties:
> > > +- capture-dai: audio codec dai on capture path
> > > +  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
> > > +  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)

> > I sugggested changing this to use a subnode but you've ignored my
> > suggestion...

> Sorry.... It's my mistake.

> You mean that using a subnode.
> This is my example:

>   codec-capture {
> 	  sound-dai = <&rt5650 1>;
>   };

> Does this is your suggestion?

Yeah.  Having refreshed my mind about the APIs a bit the idea is that if
you do things this way then any additional parameters that are needed
for the DAI can be added within the subnode.

--+7qMzvEgojnlfQ4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXF6opAAoJECTWi3JdVIfQhv8H/jVFqEH3vg/d+Eh4FAm8P5tj
05018hEbU/l8+nGh9XbhddJKEiynxtGaZXZZll+ZJC5fa/44W68WINGDULfM5/K8
dpfvbBdyOlRFUPRvFf+gOaDr0Kb4wR/OQO4DBUKndlhjB/M2lZknFSkT7v3evXiL
CJK7ZzNLFBMbdIuqTVgAvmNlyfh7z2Wi3LbrDc/XYy9YDZENvISekbh//uGryn94
N8/8xiXek6LXgyi5DzaurojH2VqLZtBFIvcJGKS9U2Fojs+G8CbKx60tITQzCZR0
oLbKMxpq+Mv00idJfPngO+cWm7mSSBxZGTT8/tuaMPJvRP3O5GrykXoOdbhfgT0=
=2Vcu
-----END PGP SIGNATURE-----

--+7qMzvEgojnlfQ4q--
