From: Mark Brown <broonie@kernel.org>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Mon, 19 Sep 2016 12:12:47 +0100
Message-ID: <20160919111247.GL10189@sirena.org.uk>
References: <20160919105419.GK8719@lukather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7335245321622495247=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A2E226533B
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 13:12:57 +0200 (CEST)
In-Reply-To: <20160919105419.GK8719@lukather>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Mylene Josserand <mylene.josserand@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>
List-Id: alsa-devel@alsa-project.org


--===============7335245321622495247==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Content-Disposition: inline


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2016 at 12:54:19PM +0200, Maxime Ripard wrote:

> That codec is mapped in memory, however, we have a bunch of DAPM
> widgets that are mapped in a separate register space, that should
> probably be exposed through a syscon (but isn't yet).

Why not just represent those as a separate device?

> To make things worse, the register in the syscon behaves as a mailbox,
> where you actually have to set in that register the address you want
> to modify and the new value, in a single write. This also seem to
> deviate from the usual DAPM access pattern.

This is totally fine, just use events for the things that aren't simple
register updates - there are a large number of examples in the tree,
simple register access is totally optional.

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX38guAAoJECTWi3JdVIfQL4MH/09KEoaGj34Wcpfd6IUV6EnS
bbWbK8P/nW6QdsKDozsyB6VtfnG9+DHdwXDrEwOacZzF5lZApHssH5pqzXQxEE3+
TPw+BCMask6c+LJ3KRcwAdDWDUPRcAzy0rcQ/X615OlIJDu7g6TCDbMxSP9EEiZv
cG93XHI/RZoTuDDNL4DGObROhxnLp23+gYFUq9egtFF11hX6jF2a9ULCLCu5bFC6
0aiBTTiHoCoajr6HMRfX+veI+n1umv9k4UTi4+yjYsaVv2Bw0FUWYJsKqliGTMJE
fTkss6MgGDwRjr8N+rpPZefs2mPRmqlZZKWoz7ZFvgyx3ZYp1JrTytnB87hRLX0=
=bxZY
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--

--===============7335245321622495247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7335245321622495247==--
