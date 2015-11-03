From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Tue, 3 Nov 2015 23:27:08 +0530
Message-ID: <20151103175708.GH12910@localhost>
References: <20151102153229.GP21326@localhost>
 <20151103112458.GO20228@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3308605234133978130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D4542604D1
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 18:53:47 +0100 (CET)
In-Reply-To: <20151103112458.GO20228@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3308605234133978130==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2015 at 11:24:58AM +0000, Mark Brown wrote:
> > For this case the machine entry name is "skl_alc286s_i2s", which is the=
 RT
> > ALC 286 codec combination on Skylake.
> > The SKL machine driver needs this as platform device and we create it h=
ere
>=20
> > > +static struct sst_machines sst_skl_devdata[] =3D {
> > > +	{ "INT343A", "skl_alc286s_i2s" },
> > > +};
> >=20
> > This says for SKL, with codec ID "INT343A" create "skl_alc286s_i2s" mac=
hine
> > platform device
> > For different codec combination we can use codec ACPI names to match
>=20
> I'm having a hard time seeing the difference between this and what's
> going on in sst-acpi.  They seem to be doing the same thing in slightly
> different ways, they both match tables of CODEC IDs to machine driver
> names with the distinction being that this doesn't provide a firmware
> filename whereas sst-acpi does but the mechanics of mapping a CODEC to a
> machine driver seem otherwise the same.

I don't disagree with your observation, the code does same stuff and only
difference is the data we require here, so commonizing becomes tricky

> > > > I am not sure I follow the comment on user, the SKL driver here is =
user in
> > > > this
>=20
> > > There are no machines defined for this.
>=20
> > sound/soc/intel/boards/skl_rt286.c
>=20
> Ugh, the machines table is *really* buried at the bottom of the file
> here :(

Ah sorry for that, I can add a comment here and send an update

--=20
~Vinod

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWOPV0AAoJEHwUBw8lI4NHncwQALg9Bjh9y7q7aqgUHdtvnUyo
omp+2moNIPoGA4f3NfB1c3oQftZ65zNKpC3VJ72DTVqecPujaKWJ+vpodu0dBdGW
V1iktflKnvaVjPpRD00j+T5n2+rqNwxhAJFZCz9xVUwjv1RoLTrA44RgfEyQNEky
ipzFlT9qWFHOU764ZaYekMK2MfbQXa4vhkajTpJP8xNX/NaCBTVlwQG9xq2n3bRp
c+MpEKs1fjMBl6iolJImOMAL9q6/RXpOjU81gX2qYsSJpgr77D+/VALmJuJKDPf2
wgFkLSrwa7PpOMRoZZIpNXhuXdk9JxDlt4LCULaBqQ9UX25YPl/983co2NX52BPJ
kKgAXub4F1SCzFpe3fJkHZdM83+4qODkG9PBzQmskqDRN6Te2d/Qfu63d2qEjMiI
3MEJyLks58kSaDGrkn3O77kdUOcfM/4wFuRFGBVW4a8Ps5/6Tx4S/n1xUEASSbMj
jiLWp6kh/pQMhu9HL2Wd/fqfCVkXo4qxbdP2X8+8tWSRLKIjNQPbN2goAoIoa2eZ
Rka6ePID7ONAgxUnrdZdKhTHv18lcPq6uniIjbQC9D12liqo2N7//3e9tKzw2m1N
0LjeOyGrttxmrjcJyXXJi3JzAWMd9aPfQFAImThCZgEH4ZJHZjqkL9omuiKwuZDI
MZHCgRBSQknlHqsHuvmb
=YNLD
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--

--===============3308605234133978130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3308605234133978130==--
