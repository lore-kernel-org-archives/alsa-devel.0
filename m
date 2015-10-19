From: Mark Brown <broonie@kernel.org>
Subject: Re: Implementing sub-stream multiplexing in DAI
Date: Mon, 19 Oct 2015 20:44:45 +0100
Message-ID: <20151019194445.GU32054@sirena.org.uk>
References: <85DFEED57DC57344B2483EF7BF8CB60552A848D9@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1355842076671873209=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 364C22660EA
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 21:44:50 +0200 (CEST)
In-Reply-To: <85DFEED57DC57344B2483EF7BF8CB60552A848D9@BGSMSX104.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "Shah,
 Hardik T" <hardik.t.shah@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============1355842076671873209==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nZJAkgcjPzQrJB+u"
Content-Disposition: inline


--nZJAkgcjPzQrJB+u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 10:11:12AM +0000, Ughreja, Rakesh A wrote:

> In order to implement sub-stream multiplexing as a part of single BE DAI =
I=20
> have following observations.

I'm not quite sure what you mean here?  Do you mean mixing or something
else?

> 1. All BE DAI ops gets called only once even if two different FE DAIs are=
=20
> connected to a BE DAI.
> 2. BE DAI ops are always called with sub-stream 0.

> are these expected ?

> What is the best way to allow calling of BE DAI ops with different=20
> sub-stream ID so that I can do link configuration based on sub-stream=20
> parameters ? can you give some pointers ?

I think that's all what is supposed to happen with DPCM - it really only
understands one stream with one configuration per DAI, it's expecting
everything to get combined with mixers rather than TDM.

--nZJAkgcjPzQrJB+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJUgsAAoJECTWi3JdVIfQtkYH/jZHzbEr9gtqfJ5cSE4XwXFB
4vfV0YXS2Z7lxyUHyneb2iEksd3PrU9oFD9YaNWIL40gF9RaXZFsOcSGnQphUfmj
Ws/gZDqYAekmQQcWI6rM7tDRh25388JuccR1IxTApsufF+1bvCkVf/Yyjp0QL9iu
49GaMIUvUQ0jOJh22JAv1iOIh0dYJZwnJBgsrsYg1evxVteBP1JGshpimVuj2adN
Vv3vpgeW3yjs5Y+s9aLQbLBI3UtxjmDsI9Q+c7xlfTAFf0lqTPSpkdrdxiiem/Xg
vjLkzumUxZRcDT0aPAvR70rJqnMedTd3iPhoNrlSOlgP4t1tyifiH7y2ZnoS3X0=
=QBJE
-----END PGP SIGNATURE-----

--nZJAkgcjPzQrJB+u--

--===============1355842076671873209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1355842076671873209==--
