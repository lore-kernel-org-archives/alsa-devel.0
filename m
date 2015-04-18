From: Mark Brown <broonie@kernel.org>
Subject: Re: How to correct params_format on DPCM ?
Date: Sat, 18 Apr 2015 13:32:22 +0100
Message-ID: <20150418123222.GP26185@sirena.org.uk>
References: <87twwsttp5.wl%kuninori.morimoto.gx@renesas.com>
 <20150408180118.GG6023@sirena.org.uk>
 <87a8yg8nko.wl%kuninori.morimoto.gx@renesas.com>
 <20150410154338.GL6023@sirena.org.uk>
 <87twwk7tz4.wl%kuninori.morimoto.gx@renesas.com>
 <87r3ro7hnu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8155346945523011405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B5AC2619BE
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 14:32:29 +0200 (CEST)
In-Reply-To: <87r3ro7hnu.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============8155346945523011405==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0UhZIN3Sa23/ILEd"
Content-Disposition: inline


--0UhZIN3Sa23/ILEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2015 at 04:54:39AM +0000, Kuninori Morimoto wrote:

> If my understanding is correct, the information which userland
> can get is setuped in .open

Yes.

> But, DPCM cases, it cares only cpu information. why it doesn't care codec ?

Like I said before for most systems that do DPCM (and certainly the ones
Liam's been working on) there's a DSP in place which rewrites all the
data between the front end and the back end so the constraints of the
CODEC aren't visible to the application layer.

> I guess DPCM should be...

>  FE.hw = fe_cpu & fe_codec
>  BE.hw = be_cpu & be_codec

Usually there's nothing "CODEC" visible at the front end for these
systems.

> And, if no FE constraint, final image will be

>  hw = FE.hw & BE.hw

Well, BE and CODEC but probably.

--0UhZIN3Sa23/ILEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMk7VAAoJECTWi3JdVIfQz20H/04ALMYAvPVFs0DAiW4MwZOp
dxplncuH5fH8RPOl9+0QoLALzjTAdkPAh+43vmIj+eLDowB6BoIHPLPXxSyxqvep
f2TZAx/ptnmLwJDOy4eMFu2HenOczh5NZhWZrj3b8lYuZCYZy2hayD2M+jU3oqYr
YjMB5aabQlFW2X1VJUcoLvriQGRiMmeO5s21k08g1jC/xs1iv2+qe/1mUBmBfGfc
G9M0A7D0tQ/bcE+DfNWqW0sDOnnob2v7kjDJbDLgLOUunIQs9tDGk2aibRTLRygX
GBVxJbLeEDpidsocsAZ+DXykuSTT57f70fHcaDHB0MYQ0I4MGo6WCgOU/s7PR1U=
=xn9X
-----END PGP SIGNATURE-----

--0UhZIN3Sa23/ILEd--

--===============8155346945523011405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8155346945523011405==--
