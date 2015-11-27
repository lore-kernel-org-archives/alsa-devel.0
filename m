From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about TDM "slot"
Date: Fri, 27 Nov 2015 11:36:12 +0000
Message-ID: <20151127113612.GL1929@sirena.org.uk>
References: <87fv05hv7b.wl%kuninori.morimoto.gx@renesas.com>
 <20151117105233.GM31303@sirena.org.uk>
 <87h9kjrce6.wl%kuninori.morimoto.gx@renesas.com>
 <20151118113012.GH31303@sirena.org.uk>
 <87poz6j0in.wl%kuninori.morimoto.gx@renesas.com>
 <871tbbsu27.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3854036465923552002=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB529260851
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2015 12:36:19 +0100 (CET)
In-Reply-To: <871tbbsu27.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3854036465923552002==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PNftq4k6NuHCGvy8"
Content-Disposition: inline


--PNftq4k6NuHCGvy8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 27, 2015 at 08:55:01AM +0000, Kuninori Morimoto wrote:

> If my understanding was correct, tdm_slots is not enough for me.
> Because my CPU/Codec needs to know 6ch by (6ch) or (2ch + 2ch + 2ch)
> (My CPU can output both style)
> How to select this ?

I think we'd currently expect the three two channel interfaces to appear
as separate DAIs with their own TDM slots, though with routing within
the CPU you could just always configure them as a single DAI and then
let the choice of connection to the front end DAIs select what gets
routed out.

--PNftq4k6NuHCGvy8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWWEArAAoJECTWi3JdVIfQWjsH/0NKSEvPD1ei2M+EMFjbHX2L
/evQtTtK6TdkEzfnZgVM/4O2m6B4QhHmxqfvybGQTV/o++9yYBmI+FBWaANrtvGb
nXE1TE281JErDG8QGPiOSR8Iyatwi9cZVKKipJeTAJes1mF/U9I4G1pHhcHf90Wd
s2sbYpfwLXr1Z0K4Hn9uQ2uFfOzZOpe45BL1faPRINzaG0DRVkwC/i3pMBt+xcg/
u9VcB1U/v1go0dFGe71WXtw0uryL5KewlxpLxHUsHcTqBxTQdByFJxA8Jo/cm6jP
VsAdFM5Wd+7X+UHvdIoJ3PN//oLr2kIw3O8XS3ZiFpk0OOOpOhatMy8LtZXMT4Q=
=Aonz
-----END PGP SIGNATURE-----

--PNftq4k6NuHCGvy8--

--===============3854036465923552002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3854036465923552002==--
