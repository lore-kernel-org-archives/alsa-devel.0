From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rsrc-card: rename rsrc-card to
 simple-dpcm-card phase2
Date: Wed, 17 Aug 2016 11:56:03 +0100
Message-ID: <20160817105603.GK9347@sirena.org.uk>
References: <87vaz8t4bu.wl%kuninori.morimoto.gx@renesas.com>
 <87shuct48p.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5004149912248014021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99C09266A8A
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 12:56:11 +0200 (CEST)
In-Reply-To: <87shuct48p.wl%kuninori.morimoto.gx@renesas.com>
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


--===============5004149912248014021==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0w7jVmmX7yCvRA1u"
Content-Disposition: inline


--0w7jVmmX7yCvRA1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 11, 2016 at 11:43:18AM +0900, Kuninori Morimoto wrote:

> -- compatible				: "renesas,rsrc-card{,<board>}"
> -					  Examples with boards are:
> -					    - "renesas,rsrc-card"
> -					    - "renesas,rsrc-card,lager"
> -					    - "renesas,rsrc-card,koelsch"
> +- compatible				: "simple-dpcm-audio-card"
> +

Since the card is already in released kernels we can't just remove the
old compatible strings, we should continue to support them.  I'm also a
bit unsure about adding a generic DPCM compatible string - it really is
a Linux specific thing.  While code reuse in the implementation is good
so factoring out the card is good I'm not sure we want to bake in the
idea that this is a strong abstraction so keeping a list of specific
compatible strings might be better.

--0w7jVmmX7yCvRA1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtELCAAoJECTWi3JdVIfQ8IcH/0/vbon/XgbIRsv8R+rZyLnr
rGTXcGxni9cB7IpObtFAcqFa6zS3cL9EuMekI30dMpVLlK2UfdCECjU2eVRs5gzL
hIYUHJZp6/Jpk8vQKS86jr7sgSmSnh5PxoB6nwfJV8J9XBYoZ0jyRFhEDHopUJ0y
DfgBtT4EQOFch9W359+5K3Ol+rqssaUnQkte8CTFRMR5DvrDQSa3OMOZuz/Xh0Bi
IUAHZEN+syFGpBj109HbGd+lHYi42nhSocRqToigpe0Op2tGnsTgIzgSDlVUQSGC
BZy8C1m2lXRPPBwoXWj1PG5AIH4vFkjq5rSD36pUhIzbwj9v//pradbUFr4KKvw=
=7IcD
-----END PGP SIGNATURE-----

--0w7jVmmX7yCvRA1u--

--===============5004149912248014021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5004149912248014021==--
