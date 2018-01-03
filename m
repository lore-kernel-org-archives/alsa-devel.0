From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98373: Added Amplifier Driver
Date: Wed, 3 Jan 2018 16:57:42 +0000
Message-ID: <20180103165742.GH28713@sirena.org.uk>
References: <1513907030-18441-1-git-send-email-ryans.lee@maximintegrated.com>
 <87a7ybo6em.wl%kuninori.morimoto.gx@renesas.com>
 <BY2PR11MB0837C049BCA0C1B5103EA3FBE7010@BY2PR11MB0837.namprd11.prod.outlook.com>
 <87k1xah0e5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6862417343412140646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F3F62676AB
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 17:58:00 +0100 (CET)
In-Reply-To: <87k1xah0e5.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "bryce.ferguson@rockwellcollins.com" <bryce.ferguson@rockwellcollins.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, Ryan Lee <RyanS.Lee@maximintegrated.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "m-stecklein@ti.com" <m-stecklein@ti.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "afd@ti.com" <afd@ti.com>, "romain.perier@collabora.com" <romain.perier@collabora.com>, "dannenberg@ti.com" <dannenberg@ti.com>, "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>, "supercraig0719@gmail.com" <supercraig0719@gmail.com>, "jbrunet@baylibre.com" <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============6862417343412140646==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 25, 2017 at 11:17:29PM +0000, Kuninori Morimoto wrote:

> Having private regmap seems a little bit duplicate for me,
> because we can get it from component or dev.
> But sometimes, in some drivers, it seems can be difficult.
> Sorry for my noise.

It is duplication but if you've only got the dev then it makes things a
bit faster as the call to look up a regmap from a dev is relatively
expensive.  That's not the case for components though where it's just a
straight variable lookup so it's more a case of how clean the code looks
and preference there.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpNC4UACgkQJNaLcl1U
h9DchAf+K//qDiMdvPETFCGUD8vlISwBkx92UcOWA+y0F93S0GxJhkY9ESmvytG7
phG32QYyleebdKkDH/TVki7w/euPwYo0Ea4tztL25+P6PCoYT9zQZNV1saDjiFwA
uis0BfcBpgub8Sii839M5/mpOCalvyX2ZGeBuEteoX0JmhTELT3s3VpwM5mWsHAe
KFQ1i8r4EcqYfrIvzO3ah6ft45dI1XVJRBrqhin4JjDN+YBp0VOVyxXo0DDjxUVK
gtM8w1wdriggVbAhFRF9qChFeN6MQfSkjxU+ZO7HF8fWnQtFmdXGSsjGC3oAuoY5
new2CGwZ4ncMHaoeVSM+SqHPslxeiQ==
=l45t
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

--===============6862417343412140646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6862417343412140646==--
