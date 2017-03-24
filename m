From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Fri, 24 Mar 2017 19:11:59 +0000
Message-ID: <20170324191159.wyikevxc7dmvkaup@sirena.org.uk>
References: <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
 <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
 <1bec6abc-c296-eb93-a096-e4b8f1c7e1a4@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9100130859344327384=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED2542669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 20:12:24 +0100 (CET)
In-Reply-To: <1bec6abc-c296-eb93-a096-e4b8f1c7e1a4@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Emmanuel =?iso-8859-1?Q?Fust=E9?= <emmanuel.fuste@laposte.net>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Eric Anholt <eric@anholt.net>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Matt Flax <flatmax@flatmax.org>, Matthias Reichl <hias@horus.com>, florian.kauer@koalo.de, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============9100130859344327384==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6nu5e7uincaexexa"
Content-Disposition: inline


--6nu5e7uincaexexa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2017 at 09:38:28AM -0600, Stephen Warren wrote:

> Now the BCM2835 I2S controller does appear to have a few features beyond
> plain I2S/DSP modes, that not all I2S controllers might have, such as:

> - Frame length, FS length, channel position, and channel width are specified
> at bit resolution rather than byte/sample/...

> - PDM mode (for digital mics).

> - Sign extension of RX data.

> So, the controller can generate/receive some formats beyond plain I2S/DSP,
> but to be honest I doubt that this level of detail needs to be exposed to
> the ALSA/ASoC core or user-space, nor is it required to interface to any
> typical HW, so it can be hidden in the driver's register programming
> implementation.

At the minute the driver doesn't even support these features, it just
supports plain stereo I2S mode and it *may* be that all that's needed
here is the addition of the DSP modes.

--6nu5e7uincaexexa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljVb34ACgkQJNaLcl1U
h9A+7gf/Z09mCdNg2pkW799BQSnFh6YN6IjW/zCIZtiHpMK02xphXWHQ7QjtDWta
3Wu6qTaa+Zh7huhKP2EiTCYyi2sF7H+sslRO9OQr0BjLPsA2T5p5vtbVxj7cyZ+a
SqrkMEiIjmvP/ydkGf2Zkf0DAFK2CmQDAMXTUpZc0MA68ZSCXz1NUFLmVyNqbCMd
1isM7ZMS/wlKcF4MLsihwq3SLLeDWe2cIgjzvTTkBd+8uw8I6BakVam0TJL8DonI
Ipco4CQRIi8cxGLdgebUuuo1Ukcn+XJHka4tqebXwYwro93SuyPkqDVZd3aN1T78
b58uBWDhNgS4xkeKwVlBt0SkKmWqfg==
=mt5r
-----END PGP SIGNATURE-----

--6nu5e7uincaexexa--

--===============9100130859344327384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9100130859344327384==--
