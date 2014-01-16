From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC fixes for v3.13
Date: Thu, 16 Jan 2014 13:33:44 +0000
Message-ID: <20140116133344.GS15567@sirena.org.uk>
References: <20140116123440.GQ15567@sirena.org.uk>
 <s5hy52grt7s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1612931844093747566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 943202616C9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 14:33:55 +0100 (CET)
In-Reply-To: <s5hy52grt7s.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1612931844093747566==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCjW77bNSYaih4x3"
Content-Disposition: inline


--fCjW77bNSYaih4x3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 01:45:11PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Nicolin Chen (1):
> >       ASoC: imx-spdif: Use snd-soc-dummy CODEC driver to link card

> This commit is a bit too intrusive than I wished for rc8.
> Is this a regression fix of 3.13?  It's not mentioned there, so I'm
> not sure about it.

I can't remember when exactly the problems were introduced but given
that the driver itself only came in with v3.12...

--fCjW77bNSYaih4x3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS19+1AAoJELSic+t+oim9YHEQAIp0GCaccN16qDfoEthCglsh
qSqL3RBPfXGK7LlSM0gKO7DXK7ZHaM1ZGngjq5lSrLDA74cEkFGzGtjGorR/rsUs
If8/pRJYUmILxX7e5tvQ3vSokUA9YUm/i7QTVSOKqLZAFDLF7xlsiKempb/Y2s0k
CPl9jyR/l7M+lU1pePf1Au0Rk/fje9ifgBV68jxY1wRMm9PNFkd9o1WitvS9oTwp
RV6KcUDeOld6aT5xROHvE0DhpPD7nFURP5EdLtJSombD/SIkGTI95sMpOlzhDImZ
PGKEek5W7bKuW7GWynczcDdG9Kjmyw0fmZdEE3P1zRvdL1lsmWGni7DvzjFLJnzu
amjGeDLTvynMiJE4jurZyQug52nkFv8ctpegDsY0cH7Xr0zv0XceRk8+DRP91xNr
mLRjjFnhCOrLiX2deqlt9l/qciHs/C0vQeBLfR5Vy71SRZPb+X0yJruQyEgQwwzj
w0B+RB8MuBRS5VFvAEvy7C/yMcg726IVx1cYEwXqvPw38IUMIJ/zK/lFQaqb+Nge
bDYq12neRad+aPEGxhCu3/XKrPMTULtkvGeKb8XX/Ej0xPg9vL9/4U8Nt6UeYGlL
BK7ZRF+sPPoLTx4qeikiUnay3x7S0xdJhHh+kDIlAgH+9wyR91f6WGIp6v3zA9aE
hWDhDQeiEGtlWIrnWULc
=uSd3
-----END PGP SIGNATURE-----

--fCjW77bNSYaih4x3--

--===============1612931844093747566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1612931844093747566==--
