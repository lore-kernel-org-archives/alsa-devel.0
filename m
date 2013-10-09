From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Wed, 9 Oct 2013 14:20:04 +0100
Message-ID: <20131009132004.GL21581@sirena.org.uk>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
 <20131008104457.GA21581@sirena.org.uk>
 <20131009130553.GD19005@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2386603064172879091=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E94D12610A3
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 15:20:10 +0200 (CEST)
In-Reply-To: <20131009130553.GD19005@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2386603064172879091==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GTjM2GI4zMe3xHZ5"
Content-Disposition: inline


--GTjM2GI4zMe3xHZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 03:05:53PM +0200, Markus Pargmann wrote:
> On Tue, Oct 08, 2013 at 11:44:57AM +0100, Mark Brown wrote:

> > Right, but then _STOP will be called without the clock having been
> > successfully enabled so you'll have an unbalanced clk_disable().

> _STOP is only called as long as the error handling is not working
> properly. Otherwise STOP should not be called for a failed START.

I'm not sure what you mean here.  How would the error be handled without
calling _STOP?

--GTjM2GI4zMe3xHZ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVVgBAAoJELSic+t+oim9A3cP/1oJaXa7mwBwu0IwNDuKyDCK
VF+7ccB1pzVGQCoUKFjZh3YltlUHW/V/w8mcd3jJnaeaL7oOexGKvXLSh/wqBO1j
RqZeSdV5RmlZdk1qOf9rw7Nslrya9+lQK9DdFl4BfYxJqG04Nvv63DXFJIRgrN54
CDhAM3A/WYyu5LoWWEfeJhbCqaCEqA9vRZttUJUVTTWxsSRY1R4QjA78R2Y5AmHw
t9sdceAEKu2Y1FvfpYpFG9xS8/fz/KRTT4MtKpLDg/vMRJfpuMiIXuh0sIlOax5R
NKhnFleX96ZqZ/4bqm+HpHK/+ogYsGKOpHApOE3oW7Box9GHdMxX6l0hGtgtdiAP
GB+UXQ3VoBkREIo4my7spM8mm0vnAEewuGrBsX+iTuEZr4EdDIuK1MehvzLuNSMy
m05L5QNAIakcAPTexL3/IgXqGUUkjiuQRqMcRzBE1YF2IhkhvFFFFDuT/tOotlx4
JPJmKja8W/oEzDq7yxz/2jLn/ho2cyO4KmOaXvgWi/24siB+wyuwtvfPkwcuGChR
Taxro/af/M574CLUBFVLFb8H3TX1ScAN0CnHQSXmqSx2gsdsRwhz6skysTTBa6kc
c1RxFGHotMCpPNwWk4OU7opX766x5uQIt/4SZl+OHnpBvfU3H7XRK/dtlVjZAZ4I
NM30h7G3EVT8MNwlGogJ
=aWBS
-----END PGP SIGNATURE-----

--GTjM2GI4zMe3xHZ5--

--===============2386603064172879091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2386603064172879091==--
