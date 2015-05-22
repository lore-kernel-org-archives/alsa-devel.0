From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/13] sound/core: add IEC958 channel
	status helper
Date: Fri, 22 May 2015 13:40:10 +0100
Message-ID: <20150522124010.GU21391@sirena.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y3-0006lC-JP@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8303273953706988817=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59422265A81
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:05:42 +0200 (CEST)
In-Reply-To: <E1Yr1y3-0006lC-JP@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8303273953706988817==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aZ/0/p6gSDXwzas7"
Content-Disposition: inline


--aZ/0/p6gSDXwzas7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 09, 2015 at 11:26:47AM +0100, Russell King wrote:
> Add a helper to create the IEC958 channel status from an ALSA
> snd_pcm_runtime structure, taking account of the sample rate and
> sample size.

This also looks good to me from an interface point of view:

Reviwed-by: Mark Brown <broonie@kernel.org>

--aZ/0/p6gSDXwzas7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyOpAAoJECTWi3JdVIfQZ6sH/0yBruowITGzR8mK4Xv2u8VO
k4iowpN/VwFH169fBP1DGrj5frtOxnPWvJrM6IsLdx3NjXPz1iP5Ccy+jodLKh4u
+nOgqlsHKnT0TkcfWrnEA+8YDZwCbeOfhIQ2M5Kc8y2P3kI4DVSouRtYb1GKarnf
YfaOsZJ0nB3/HU8WxHOwTIF330WraUbIDjq7iZwZSLji5fefVes8jlTgvNg5voVT
oukMReg75sfeTKscWY2UitiOXWas6YwauS8yzJ3mn6tGxsOgPUAX8JdJ6nn20N9s
1798yus16Zeq5r6O2DJqCFblLyFexMAPcIEydGTXy7ayvCgBCaWQqbJuH7O2PV8=
=0cD9
-----END PGP SIGNATURE-----

--aZ/0/p6gSDXwzas7--

--===============8303273953706988817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8303273953706988817==--
