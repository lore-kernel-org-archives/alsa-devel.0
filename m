From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake - Add Skylake RT286
 I2S machine driver
Date: Mon, 12 Oct 2015 22:02:25 +0530
Message-ID: <20151012163225.GH27370@localhost>
References: <201510101650.2oGqByd9%fengguang.wu@intel.com>
 <1444619526.3544.6.camel@intel.com>
 <20151012161736.GG4238@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3677544438713891173=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A386264F3F
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 18:29:42 +0200 (CEST)
In-Reply-To: <20151012161736.GG4238@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lkp <lkp@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Abdullah,
 Omair M" <omair.m.abdullah@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "Kp, Jeeja" <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3677544438713891173==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2015 at 05:17:36PM +0100, Mark Brown wrote:
> On Mon, Oct 12, 2015 at 03:12:07AM +0000, Koul, Vinod wrote:
> > On Sat, 2015-10-10 at 16:42 +0800, kbuild test robot wrote:
>=20
> > > [auto build test ERROR on next-20151009 -- if it's inappropriate base=
, please
> > > ignore]
>=20
> > > config: arm-allmodconfig (attached as .config)
> > > reproduce:
>=20
> > That's nice, thanks. We should add a depends on X86 for this to not com=
pile on non
> > X86 code
>=20
> > Will send updated patch
>=20
> It looks like the missing functions are just readl() and writel() which
> means that they're probably only working on x86 through implicit
> inclusion rather than intentionally - if that's the case adding (IIRC)
> linux/io.h is a better fix.
Yes relooking at this, I do agree that seems to be doable.
Let me try that and see if we can get this to build :)

--=20
~Vinod

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWG+CZAAoJEHwUBw8lI4NH1mIQAMhpUcvQpXXraqNfgXnChNjM
hOXunokrYSM2gRlg3mzGjnRw5sa46TLKTwf4S9k/TL3imlIwknmMvPTfdia+xvNe
0ZiOTkrQLNsheOw0jl97G3lFdwKOzsMWEx6tUMY0kcE37pUHvkmSxe1YceEDo9Rx
rmIR+SEaD2UvXF56A3KWAhLH1mtHZW9GNCY11n7wfgzg1dVTNQ+bAy0tbA/2saJB
IusfhkCiSZa9v4rqFhFzZUKCH//HCfX0wzJ5Ze4gZVs9OcpOe+SOEg8db/D+e2kt
itxHScLzlIIx6+t5L/tbA4LdkIrGfct/AFWVhQYQ/yJ2en/wvdH5+ch1JLKEtdZd
E9iTEzBJq6Cy7+bkvi46h0QtcG3yKxavRpAmVH337AsSYyO87MArqmDPj1LzF478
57IXywro4KB+tuf9F6i5Wwda7SP3KSWLD3JgiD3GmbsTDBdOGiyvi1qkDAB2os2D
U6mzQlbmnqowDsmoS6BNMnKrhglNNKGa4Ous0kLWVwSob9OlKe+8z9EbFxHOyUBH
w/cJ7izDxNjlAIqRptIKTt3yts7NK1mAKL06vxCP8t2/erErpX2sj6IVCD0+zyWQ
IPCAVxhqcQuUADnoNSlhfRD+nlV2Z8gB/dH97fBm5vgxP1ZOPY0ovY0D4O63rsEv
1iqVmrE/kkzm2CcghMkZ
=Gc/v
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--===============3677544438713891173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3677544438713891173==--
