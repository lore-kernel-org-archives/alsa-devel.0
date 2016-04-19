From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver" to the asoc tree
Date: Tue, 19 Apr 2016 11:53:57 +0100
Message-ID: <20160419105357.GR3217@sirena.org.uk>
References: <E1asSQc-0004NY-44@debutante>
 <1461061984.28704.8.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvlH2BAVfmx8aXCn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461061984.28704.8.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: PC Liao <pc.liao@mediatek.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srv_heupstream <srv_heupstream@mediatek.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koro Chen =?utf-8?B?KOmZs+aAnee/sCk=?= <koro.chen@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--GvlH2BAVfmx8aXCn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2016 at 06:33:04PM +0800, PC Liao wrote:

> Thanks for your approval.
> But this patch depends on [1].
> I think it also needs to apply [1], otherwise this patch will build
> fail.
> Or, do I need to upload new version again?

> [1] https://patchwork.kernel.org/patch/5671961/ ("ASoC: core: export
> snd_soc_get_dai_name")

Ugh, dropped.  Please put administritive stuff like this after the ---
as covered in SubmittingPatches, that helps it get noticed.  What it
looks like you should be doing here is putting this in a subnode for
capture.

--GvlH2BAVfmx8aXCn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFg5EAAoJECTWi3JdVIfQRgsH/iizQgEHCFxRTNu1X2BzdFai
y87U+Ay+CyqvNSJUbu7LRqBANKF2FgGmO/UnHZbHFwjKUnLKBjwkLMOxgay2/jDw
EaaHV2Ks1zxBTwtaHnK78AwFrzaMUOJOPBNxO9yJnmuKzZFEQmvu2hYsO4W1gVkq
QjGl62mbj3vnsrKIJgvZBqZNg4rQZDo6kLmHY6l0yU/utBH2X8Enfig5eCB3cPQc
s0ChMC0taDg5aeZueDMLUbYE+W3bkwWcR8qdWa5O2hibA1I/PsyacV+sFbsDl63P
Kx1JzOtR2970l0VfvWXS/49rLEf4O5x0FoZAWcqvWoiwWy52l4CLBpF2Bc3SZpI=
=5qXk
-----END PGP SIGNATURE-----

--GvlH2BAVfmx8aXCn--
