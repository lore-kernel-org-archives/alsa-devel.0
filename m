From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rsnd: enable SRC setting via DT
Date: Wed, 6 Aug 2014 21:24:32 +0100
Message-ID: <20140806202432.GP17528@sirena.org.uk>
References: <87oawzum8z.wl%kuninori.morimoto.gx@gmail.com>
 <20140711123026.GK30458@sirena.org.uk>
 <87oaws1rhm.wl%kuninori.morimoto.gx@renesas.com>
 <877g32gpgu.wl%kuninori.morimoto.gx@gmail.com>
 <20140729182816.GC17528@sirena.org.uk>
 <87oavz1gb3.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6955025607061131608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4276A261A50
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 22:24:44 +0200 (CEST)
In-Reply-To: <87oavz1gb3.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6955025607061131608==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QM2s2stmEMx7KYVZ"
Content-Disposition: inline


--QM2s2stmEMx7KYVZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2014 at 01:39:13AM -0700, Kuninori Morimoto wrote:

> Q1
> About DPCM, if my understanding was correct,
> the FE/BE for above feature will be like below.
> Here, CPU (=3D FE) can covert rate for codec (=3D BE).
> But, is it correct ? if not, what is the correct connection ?
>=20
>      FE:  CPU   <-> dummy
>      BE:  dummy <-> codec

That's right.

> Q2
> This is extra question, but,
> if my understanding was correct,
> DPCM can use "single source (=3D CPU), multi sink (=3D codec)" playback ?

It should be able to do any combination of sources and sinks.

> Q3.
> I know Lars-Peter pointed DT idea for DPCM via
>      http://lxr.free-electrons.com/source/Documentation/devicetree/bindin=
gs/media/video-interfaces.txt
>=20
> and, you and Jean-Francois discussed about it in
>      Subject: Re: [alsa-devel] [PATCH] ASoC: generic: add generic compoun=
d card with DT support
>      Date: Thu, 2 Jan 2014 13:44:37 +0100
>=20
> But, it seems that there is no final agreement in ML ?

Right.

> In my understanding, FE/BE connection is controlled by amixer,
> this means connection is not statically, but dynamically selected.
> (Or can we use statically linked FE/BE ?)
> I think, we can use above video-interfaces.txt idea for DT,
> but, not 100% good match for us ?
> Can you show me your DT binding idea for DPCM ?
> I can study it, and try to implement it.

This depends a bit on the hardware.  If the audio block is one single IP
to the rest of the system then DPCM probably ought to be totally
transparent to DT and just look like a couple of DAIs attached to the IP
or something.  If the blocks are separate blocks that can be connected
up any old way then it gets a lot more complicated.  How does your
system look?

--QM2s2stmEMx7KYVZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4o79AAoJELSic+t+oim9du4P/iOk685JfBhQfduzGNKCEKdF
8+wb04nu/tgmZKMFdyEo3ScwSJVWa9GcRJpmYUdJNWtypcWuC+2oGRfQolp4j3l+
b6BEvtYQndtf9gSXU8NS/ZGbj6FmEWfb2O80qILTIx1Ij1f/uJUKM8Oq9KExRiSd
RjTCCdxSttYApe7+myDrqs3F5UGWhaO2idlBOD9j1vYOd+M3mxh7dy4kBBiPfY0z
pLxsIIjyGnlkpRCMF5mcQudE+6GWHs6EnZ7XeLidmHDvH4yHfLPnD1vPklqBB+OJ
cTFkukHvTShACh2u332auMTplO39byPZi4J7El0apxH8iGojIf2y4yuHjcpOdAOb
qW2m06z8oJmwvAqAfAR38Y5Z8T3MxtRL1xcpyduBk1HPWlM4t8w84i+nusHImTJS
1N0QEu6w+j9RdfUSJ1st46BfmPmgaIyypHZHkH8/LKeZBcID8Lw8jgcREbLyHgtR
1lHJl9nXEoL6kY8jxp1/PG3nHQwdtMhgci1jtrzt81s/mXHgHz3Wq2p3R2BdeDNv
chYY4mXlBLzDgZOaVw5BqTyG0gOHNt0Gl2WhSVNUHVVIRSgPGIGRmwm2+tmPP3xx
a2i1Ju5MY2Q9f5Va774hmqE1SxXnjq3YaqGSyCLnWe5K6ymw7M0lCOFd+sC9ouTr
pFrAH0cQaU2tnhOhJ9NK
=Gf2G
-----END PGP SIGNATURE-----

--QM2s2stmEMx7KYVZ--

--===============6955025607061131608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6955025607061131608==--
