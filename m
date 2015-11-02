From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Mon, 2 Nov 2015 15:41:08 +0530
Message-ID: <20151102101108.GL21326@localhost>
References: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
 <1446217461-2106-2-git-send-email-vinod.koul@intel.com>
 <20151101025438.GH28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0282892474599776350=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E6872607C8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 11:07:40 +0100 (CET)
In-Reply-To: <20151101025438.GH28319@sirena.org.uk>
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


--===============0282892474599776350==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2015 at 11:54:38AM +0900, Mark Brown wrote:
> On Fri, Oct 30, 2015 at 08:34:18PM +0530, Vinod Koul wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> >=20
> > The UEFI BIOS does not create a machine entry for Linux devices
> > so add a table style machine registration to fix this missing
> > entry
>=20
> How does this relate to the existing sst_acpi code?  This might be
> clearer with a user...

It is similar but sst_machines structure is entirely different. In Skylake
case we only need machine entry name and rest of the information is coming
=66rom topology manifest data. I will try to move this as well to topology
data later, but for now on upstream to get audio out from boards I need this
patch :)

I am not sure I follow the comment on user, the SKL driver here is user in
this

> > +static struct sst_machines *sst_acpi_find_machine(
> > +	struct sst_machines *machines)
> > +{
> > +	struct sst_machines *mach;
> > +	bool found =3D false;
> > +
> > +	for (mach =3D machines; mach->codec_id; mach++)
> > +		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
> > +						  sst_acpi_mach_match,
> > +						  &found, NULL)) && found)
> > +			return mach;
> > +
> > +	return NULL;
> > +}
>=20
> ...but the code looks extremely similar.

as explained above code is similar but everyone uses different sst_machines
strcuture.

--=20
~Vinod

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWNza8AAoJEHwUBw8lI4NHGHcP/iA5WZRbOQ5xMRukR9YMnyGB
yrkDa7j4TPd2g9v3Fq0MuS1iXISiEG7UeIj1qXDLPJrGBm6WAOXalQHXzQa7sMtk
21NLdW4ZUtXcoEjEVxs3z8D5sjN4DikX6SiEyLrl1L+Z/olXVYl4GJojCs2J2cW4
XEaHS+bHYVGM8AQOV7PDISgC5/UTnk+dEwX0hOfaqQk48Q7O8s45uM+vE0WsNkOu
NHusaqoZhlwdnN54Qj6s2v/N7b9wtPB+h/unq/yOpm7UAFgCsnWdoQC3fAi4YQvr
j2veQl8X2URUH8RR2jg1sLAaf1xUGopBBtfl2bvKem7aPv+kXyTtjHWdvj0A9ToX
FHtghiY+y6NVDW0w4VxJNBOo7sC6GO7OIAra0oT3w6xqY+30iZyj3g04tpygb+/y
lJFywlfg0m5jWwuck2omR53zAnEyEiUVFITbn6lLVqRvRmqD9fxMi8D0mUWdb3+d
TiP7RYi/CLOR0O6II0ifG6S/mNxb/0AnxKetR0pW63yGad6hW8+901oBGapUtFqS
niBMiZtTKX9adDw5zredfD5LFmRVaISgIPA/7IyBPYJoAZ+WSzacKU4aeFWPL2Tq
ZcOwwtaQeZ/IMohk3dBSTHO0zesX7TFGatHfK2NRRO1Mm/88X3sLFu2IoIWo8j/y
sIp4l27ioFtPwZt0yKMV
=PVuV
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--

--===============0282892474599776350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0282892474599776350==--
