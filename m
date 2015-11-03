From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Tue, 3 Nov 2015 11:24:58 +0000
Message-ID: <20151103112458.GO20228@sirena.org.uk>
References: <20151102153229.GP21326@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6912485853118850203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 514E2260622
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 12:25:05 +0100 (CET)
In-Reply-To: <20151102153229.GP21326@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6912485853118850203==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OAiy6VLsECigG9dy"
Content-Disposition: inline


--OAiy6VLsECigG9dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 09:02:29PM +0530, Vinod Koul wrote:
> On Mon, Nov 02, 2015 at 12:07:27PM +0000, Mark Brown wrote:
> > On Mon, Nov 02, 2015 at 03:41:08PM +0530, Vinod Koul wrote:

> > > It is similar but sst_machines structure is entirely different. In Sk=
ylake
> > > case we only need machine entry name and rest of the information is c=
oming

> > So what exactly is the "machine entry name" supposed to be here and why
> > don't we use any board specific information?

> For this case the machine entry name is "skl_alc286s_i2s", which is the RT
> ALC 286 codec combination on Skylake.
> The SKL machine driver needs this as platform device and we create it here

> > +static struct sst_machines sst_skl_devdata[] =3D {
> > +	{ "INT343A", "skl_alc286s_i2s" },
> > +};
>=20
> This says for SKL, with codec ID "INT343A" create "skl_alc286s_i2s" machi=
ne
> platform device
> For different codec combination we can use codec ACPI names to match

I'm having a hard time seeing the difference between this and what's
going on in sst-acpi.  They seem to be doing the same thing in slightly
different ways, they both match tables of CODEC IDs to machine driver
names with the distinction being that this doesn't provide a firmware
filename whereas sst-acpi does but the mechanics of mapping a CODEC to a
machine driver seem otherwise the same.

> > > I am not sure I follow the comment on user, the SKL driver here is us=
er in
> > > this

> > There are no machines defined for this.

> sound/soc/intel/boards/skl_rt286.c

Ugh, the machines table is *really* buried at the bottom of the file
here :(

--OAiy6VLsECigG9dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOJmJAAoJECTWi3JdVIfQ4acH/RIFiBPKFLrCR6I79TWRr0Er
2OzMhOqtS6gtSzc5DQA5M7H/ad7lGqiso0Xgdb0p2fDxKLzmDVVQlimwS+KCDSvy
X0xh02hLF2/tRDMJOK6jPHgD7EYebgvJmuqLJi83nAONBNTM7Nj/IMgg+RVQJoUP
IjGzVsoSDufGTTydE9tAGo1EoWrv8T4iNDykvg7ny8elfRDOnlGTFIKcSQFe/8nk
nKfLdu91HX4IMlWAyoFfdbVL81b293he8kHklYAkCCdbARJdsThRwJDcFNqsG4MO
MOAs+7hQghe9RyhPCQcp0mneRey/899rn8cwEVLUEWhlxbcoUz2VCKjBxXGFhh8=
=Iu2V
-----END PGP SIGNATURE-----

--OAiy6VLsECigG9dy--

--===============6912485853118850203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6912485853118850203==--
