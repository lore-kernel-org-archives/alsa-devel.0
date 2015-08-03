From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about Component and Card
Date: Mon, 3 Aug 2015 16:58:12 +0100
Message-ID: <20150803155812.GV20873@sirena.org.uk>
References: <87zj29uei7.wl%kuninori.morimoto.gx@renesas.com>
 <55BF09CB.6060307@metafoo.de>
 <87wpxcvl5n.wl%kuninori.morimoto.gx@renesas.com>
 <55BF55D4.5010007@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1038701083911044010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CD926531B
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 17:58:22 +0200 (CEST)
In-Reply-To: <55BF55D4.5010007@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1038701083911044010==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ptMYGWplstB9CqWP"
Content-Disposition: inline


--ptMYGWplstB9CqWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2015 at 01:51:48PM +0200, Lars-Peter Clausen wrote:

> Yeah, it's difficult. I guess this is a case where the control path (e.g.
> memory mapped register region, irq, etc.) is shared, but the data paths are
> independent. In theory this means you can use each DAI in a different sound
> card. But in practice they still share the same DAPM context, even though
> there are no connections in the DAPM graph between them. I don't know how to
> solve this issue. The easiest way out would be to register a different
> component for each DAI. But that might not be possible depending on how the
> system is structured.

Alternatively combining everything into a single sound card might be
simpler than trying to deal with it.

--ptMYGWplstB9CqWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVv4+TAAoJECTWi3JdVIfQLyMH/1Qozv0zwbM7iutbp/nEvkA8
YMQtAyGqVKGwnZwmUW84vIMMziWmg9+n4QFTlE4kRodKEyFB88vQSegoadmpnKcw
U8S2QTK4u24gamVd1Q1A2oQjtWtA/R3SgXrqBdwIKlUZOnt4m80LIazWk00dznal
sFgRq0Z8r1AarAmobNaC1JF8X/Oh8fWh6zFWaiFfwT0Rt/vbw/odvz7Iqzw5kFR3
6otGzEPUiQxN0lH2FgmFELCqdOyk3LMcz6fn194DE6qoUdpUz5rFKt363BMHBgWy
4iEiJNOpICAdc4wMfj5WwtjBlCNh29XiEBUYb+lZYGyL7qmaLhY0hcxjLV6zDxE=
=R0oS
-----END PGP SIGNATURE-----

--ptMYGWplstB9CqWP--

--===============1038701083911044010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1038701083911044010==--
