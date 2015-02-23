From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 10/13] ASoC: Intel: add pm support in sst
	ipc driver
Date: Mon, 23 Feb 2015 22:24:06 +0530
Message-ID: <20150223165406.GD5208@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
 <1423715405-4562-11-git-send-email-vinod.koul@intel.com>
 <20150223154516.GG6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3910685976734929487=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A34AA260600
 for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2015 17:57:01 +0100 (CET)
In-Reply-To: <20150223154516.GG6236@finisterre.sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3910685976734929487==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 12:45:16AM +0900, Mark Brown wrote:
> On Thu, Feb 12, 2015 at 10:00:02AM +0530, Vinod Koul wrote:
> > This adds support for system pm support. We need to save the dsp memory
> > which gets lost on suspend and restore that on resume
>=20
> This doesn't seem to apply against current code, not entirely sure
> what's going on there, can you take a look please?  I've applied
> everything up to here, thanks!
Sure, I will resend the remaining 4 patches. I am not sure why they are con=
flicting.
Btw where did you apply the 9 patches. I fetched your tree and see 3 in
mark/fix/intel and not rest

Thanks
--=20
~Vinod

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJU61suAAoJEHwUBw8lI4NHqPIQAM2CgbkzR3kNCsjHKimJ1Bl5
/bmjs/rg5YR0FDJ4WU3W4BuBOz7VaVvySUSZRlYuAxsrRwVL+sZfZuRBh1Ek1Iid
IGu/uZ0VPGIBaK4CIhMPzqkjEcDXD1K768CuUqlAPyXeGolf3hLVqxoQ+elaYon9
0ZEP03Vz2ziUwpLJ6ncqVEvNzGmwVITGRyD5QboL+8WJU1u49Q4sScJZ5TG80xn/
NFC1OYtjUBHK4G33cszO9uR2CHJtY24TnOsZ+B9xm0py4uVrjjI705C8euDxhYut
zpOwOUImzEjgDwTMKe3qWZM/48RxLdUhImlTVz0LSkV2mzHZPsYE/ac32WYm37zw
zFhr84SJXBiCRqO8/2xYa5doOmdehNNWWm0YzeieQJDpkPtA7x3LA8myNKaBnCJV
qAnHZifAOiHOPet1WgtIE4N9Iqd4ppl7biXkd9Bt5iWn0V4TLohuBQAGfXDc1iqn
IW4iLzE6Z+11TJ3wI+m1XPwPs/E3TMN7JdJB4ef3yp7vGiqqZiTlhtYPBCLFNwdk
vniN1ltDQaiNu9o2nDLNAGOWErw0s9SMTKeAoFJGGnQAK76ZP4OfYXlRXVFZT1MC
b0ZBUlw7geg+Ser9yFZhVLMU8bt1EdymDeQSuPImf4cJ/tFhq6Lz319dTBpe8Cad
GskpH85YmKEBYq8HLgqH
=i0BB
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

--===============3910685976734929487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3910685976734929487==--
