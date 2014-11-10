From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 5/6] ASoC: Intel: add BYTCR machine
 driver with RT5640
Date: Mon, 10 Nov 2014 11:50:56 +0530
Message-ID: <20141110062056.GC18555@intel.com>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-6-git-send-email-vinod.koul@intel.com>
 <20141106124854.GC8509@sirena.org.uk>
 <20141106131141.GD1870@intel.com>
 <20141106134559.GJ8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3939074973408772415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id ECC4F2605D6
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 07:20:06 +0100 (CET)
In-Reply-To: <20141106134559.GJ8509@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3939074973408772415==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 01:46:00PM +0000, Mark Brown wrote:
> On Thu, Nov 06, 2014 at 06:41:42PM +0530, Vinod Koul wrote:
> > On Thu, Nov 06, 2014 at 12:48:54PM +0000, Mark Brown wrote:
>=20
> > > Don't bother with the wrapper functions, they're not adding anything.
> > > Why are we using prepare() and complete() here - other machine drivers
> > > don't need to do that?  Comments might be helpful...
>=20
> > due to I2C. We have seen that codec is resumed but I2C is still
> > not ready causing i2c failures, so moving to complete and prepare helps=
=2E I
> > will add this comment. Will remove wrappers.
>=20
> That doesn't sound right - this would affect almost all systems.
> Deferred probe should ensure that the machine driver can't load until
> after all the component devices (including the CODEC driver) are
> instantiated and we should be suspending in the reverse order that we
> probe the devices.
Yes defer probe is the right solution here. But in machine driver loading
how does it ensure that codec and platform are already loaded, should the
sound card registration be treated as failure and deferred?

Thanks
--=20
~Vinod

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUYFlIAAoJEHwUBw8lI4NHAG4P/R6oXu4onceJ2rYBMN92vVOn
6bPlfFXxsbUEemJh4Uwtpsj43+M5cEabYVG94wESkDVHkzNn29S4Oh+K4kaMkacQ
dzKazHbYGx5GU+YIhGe5SU7us6zBxRGPWeR5RYNCVRV/11V2D2lHtvI8FxxjQPr5
3RRqAv2rOdEzo1FifcZClQIJMzNK4M4/VXNdpKmcJgBoCczZi1oWUtOqavJTFqOM
XGLszIoWOcaL1fomHl2zhmqDtCKxecYV8SBsiW0gq8qJOG2j/xG5tHERh5qo8zpU
rpQjLQmP4rPXwwCPiEiSfQaNTmyTyxykjHdBCEy1wN919yi96ZAS6QVVHBL0fJwh
/20dwx7/Lzjk4ZL3ONj2IIZPdHN/11T6UE/oQy8MzCwXaKhYa1In4DvLs5J9h9Ti
lFNbb0Q+jtNZ++f8SqRbSU2f82+CVPtV0ZAkVD0drgRSh7V6jt9DD9gJcvTCS/T6
fdB799qVWKYQ0OST5GIKSnMmosxX0vCyhOiPdiFrUnHiw5oCf81wzqCKPHcrxKwn
q0aDP7b87W6lSxkkf4Qr4n9/1eYHVzx3x6mdBX5gxp5txI1x1KwzNTJG96uba8Ds
j6qzVYADRsUPtYiaBqxQuYDVhOR+wlMQVvlzdl+YBUpeEnz7As6txeMxjibRcJ/v
sYPqrNKMWGwY4VV9m+tK
=vEsa
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--

--===============3939074973408772415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3939074973408772415==--
