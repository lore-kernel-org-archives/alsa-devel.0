From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 7/9] ASoC: Intel: move PCI probe to a
 seprate	file
Date: Fri, 31 Oct 2014 11:25:02 +0530
Message-ID: <20141031055502.GI28745@intel.com>
References: <s5hmw8d4n1c.wl-tiwai@suse.de> <20141030143444.GA28745@intel.com>
 <s5hh9yl4lyq.wl-tiwai@suse.de> <20141030153719.GE28745@intel.com>
 <s5h7fzh4j3n.wl-tiwai@suse.de> <20141030155947.GF28745@intel.com>
 <s5h1tpp4i58.wl-tiwai@suse.de> <20141030161428.GG28745@intel.com>
 <s5hwq7h32rv.wl-tiwai@suse.de>
 <20141030173112.GF18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8093341690912421267=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 92C6326068C
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 07:35:58 +0100 (CET)
In-Reply-To: <20141030173112.GF18557@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8093341690912421267==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 05:31:12PM +0000, Mark Brown wrote:
> On Thu, Oct 30, 2014 at 06:07:00PM +0100, Takashi Iwai wrote:
> > Vinod Koul wrote:
>=20
> > > snd-intel-sst-pci-y +=3D sst-intel-core.o sst_pci.o
> > > snd-intel-sst-acpi-y +=3D st-intel-core.o sst_acpi.o
>=20
> > Kbuild doesn't allow this syntax, AFAIK.
>=20
> I've not followed the whole discussion but why not just have the core
> code as a separate module, this seems like an awful lot of trouble for
> something that's normally straightforward...
Hmm seems like my attempt to have just two module is fraught with risks. I
will convert core to module which can be linked either by PCI or ACPI.

Thats should clean this out :)
Thanks for all the points

Mark, please drop this patch, the ones before will still be required for
module so pls do review them

Thanks
--=20
~Vinod

>=20
> > > well both can be compile tested and we will put in symbols about limi=
tation
> > > of having bpth apci and pci as built-in or module.
>=20
> > No, the point is that the exclusiveness in Kconfig level gives more
> > demerits.  This makes impossible to build the both codes in a single
> > shot, which makes also impossible to cover wider build tests, etc.
> > My concern isn't about the actual operation but about testing.
>=20
> > That is: don't try to side step such a build issue.  I bet it'll
> > strike back later.  Better to keep rather the simple and common
> > approach other drivers take.
>=20
> Right.



--=20

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUUyQ2AAoJEHwUBw8lI4NHkkAP/jrE+rZn9Olc61YrxNILdmhd
jwhct9lz2ZDU/B3fybyuF9MQeBqhVurAw7/9+V9IABs01ZEkW1B3uZHHqrR2J0qB
oyT+MKndr7UsHPTVg5cDGFIzNkxbXugOAjCZzIviEcH3dyQ273HZrrs4G1NiNA/U
4QLBrPlO3LHIxzYRCKYVU7fgXygGO5KRM4aVsi+xZurqoNO/d+q+Ke1SWCcQvFSy
FU92hrkDPW7s00IEHU18T4Xc23Ou8L9c23hXOKcpxHOEIhuwpOFiqTsz81gHI7Fw
9FIzumA07k1ZcMRxwFPrUsCMkFB5ZBniYGCZ7aaBwbsDJrrfF25B70HaGOW0U0bP
MRB7AuUGsHwiGzDHLR8gdyKepDYJhJmDrds7HJRvd+skShwjb/G61DaVndTRtSc1
4bSzg7OJdkhBeLHBnJ03pMBNyz+hjE1KBplNIXCp5RkROPwMNdkVbnNT81Fv/kN8
onzT5mTuFyUbE0jPlcBxim4a7nyQqv1xQ9Lq7visrQd3zBJuDHFpzB4t0nUc1Oy6
wv2w2cUigw3qRbzlAvyfHmWX2N3Jy4W2BcWOnuaXzKvG3kRdm6o+LHoxuCxP3hYR
d3MMn0L4oIYiLFaoDufL3XQyZ+xTxoRGNoScjfAA32+OHl/HoQYyCgZzmOJiaN3c
LQKBzqvw1QvPtz1WtfKX
=7e/O
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--

--===============8093341690912421267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8093341690912421267==--
