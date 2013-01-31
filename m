From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device
	Tree support
Date: Thu, 31 Jan 2013 09:35:02 +0800
Message-ID: <20130131013500.GA4759@opensource.wolfsonmicro.com>
References: <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2206422297862230303=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DEDA265115
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 02:35:17 +0100 (CET)
In-Reply-To: <51097F0F.2030501@wwwdotorg.org>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2206422297862230303==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 30, 2013 at 01:14:07PM -0700, Stephen Warren wrote:

> > +CPU / CODEC DAI is represented as a sub-node.
> > +Then, sub-node name should be "simple-audio,cpu" or "simple-audio,codec".

> Why require sub-nodes? it seem over-complex.

I suggested this because it seemed more legible to repeat the properties
by having a named structure for each property rather than by repeating
them all with slightly different names.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCco9AAoJELSic+t+oim983IP/RjRLT1qppfCvXILB0oBVk0k
/H+UTHEURUpACVItD+MNG3L9PCZOEd1tMffrV7rBIqXqposwPvfSOp0Wvq6DA/Ze
MbQYWR0R2Qg9K0ARBokcz5WLvejlEebMBXFTfzSnlWaiqPfIJnKNSndW9a8akEkj
aS+6Z/6ifW3M+lHB3rfi2eNO57Cluf0Su8SKJH8pOpIPf3Bs8zhyzjK+T+2dS6rz
2b1WiaG6ZB12KS8Bt4Vf6JvjMY1uR6HANdPCr829vYt9ee8B+kR6N4GaANPHSIVf
23kllsGcsrXgtcNli/ML/LnjCZrCZLwLR7SsgnQMGoDzKz8E9i91EGNfT/D4MdOo
fu8n3P3W7M6te6M9Ccv3KG1KgX1vDxPsyLvPYTQ97Jgdi0Svh13mfD+jCgMnjzTR
Ndxu6LKBPPvYdqUZ5UWaLWAp82VpYkX+FKfPpo+8GxBJVAPHcN51znmgO3jFXfdy
fwb1DoiFcUNf6uNbO8/Z+MrB+uy63sP3AjxYMGw+lL5DqKmBGYRQs4yu8sIi/mNT
nYWJ5fHRxM9Jog6Sc7QI8yNwp8RarX22ewq7DeT4dobKK+3FUfiixJLAt/pQwSOX
mVyeb1j56pmV7o6jBKPX8LhiZ6gTb3tALLmKuh3tDHXNBOtwqWrVUvHnT9cUgpij
lI1QZGkLJZBE1FpV2f4s
=vCAk
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--===============2206422297862230303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2206422297862230303==--
