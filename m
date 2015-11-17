From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about TDM "slot"
Date: Tue, 17 Nov 2015 10:52:33 +0000
Message-ID: <20151117105233.GM31303@sirena.org.uk>
References: <87fv05hv7b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1548015907215251936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ABA93265086
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 11:52:39 +0100 (CET)
In-Reply-To: <87fv05hv7b.wl%kuninori.morimoto.gx@renesas.com>
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


--===============1548015907215251936==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
Content-Disposition: inline


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2015 at 08:49:20AM +0000, Kuninori Morimoto wrote:

> I would like to ask you about what does TDM "slot" mean on
> snd_soc_of_parse_tdm_slot() / snd_soc_dai_set_tdm_slot().
> Is slot = 3 in this case ?

>   |     |--- 2ch --> |       |
>   | CPU |--- 2ch --> | Codec |
>   |     |--- 2ch --> |       |  total 6ch

No, 6 - it's expected to be one slot per channel.

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSwbwAAoJECTWi3JdVIfQ1lIH/A/q9lpNeZG+nrT1Z75tQT9X
s2I4IQkGtajAzqX/V+EfY1PMLNuOT/E+K5EtgU1fGgaw5uEHMDx2pY96yX0YCszW
243xdQOZrq8uawikk/6rnhC7L/+A58WRdPXgDWWqs2BlrnMqYdAQ9dvXFCQuBwkw
laOcPza4GB9Gcp50Ef5MuvV4PnT/DSjYv8chGgHgFv31NCRTk/92oxLeShUn6k9b
pLgYsJxc6KEFTmnfTAamJp6zO8oLJgVnyRh9ps/XLxWONqYmTCZxo7jYJh+RYyNS
JojxvRqpjNRW/waS85GaJ23zNcCoviinjrqZnRfQi5iXCMuHZ2sJ3iojk5fNbw8=
=4FPb
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--

--===============1548015907215251936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1548015907215251936==--
