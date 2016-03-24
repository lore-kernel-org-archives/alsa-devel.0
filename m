From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] topology: Add support for vendor tuples
Date: Thu, 24 Mar 2016 11:20:51 +0000
Message-ID: <20160324112051.GW2566@sirena.org.uk>
References: <cover.1458788076.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8021739873139989093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC5DA266B4C
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 12:21:01 +0100 (CET)
In-Reply-To: <cover.1458788076.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8021739873139989093==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oU1dbz5gi9IL2UGH"
Content-Disposition: inline


--oU1dbz5gi9IL2UGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2016 at 11:05:29AM +0800, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> This series addes support for vendor tuples to topology, to avoid=20
> importing binary data blob from other files.
>=20
> Backward compatibility of ABI is not impacted. A kernel patch is also
> submitted "ASoC: topology: ABI - Define types for vendor tuples".

It's now been three kernel releases since the original code was merged
and we've still not seen any effort to make the ABI actually available.
Where are we with that?  I've mentioned it a few times previously but
don't really recall any response.

--oU1dbz5gi9IL2UGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW882SAAoJECTWi3JdVIfQa84IAIWHexL1ZNujOSuUpF6qCjSy
o/x+yAj7TqlYaa3N3NuKe4z1AcYt8HUHnT+HqM757mFlTUj+aGP1tVNuNxBGsS/7
TjpoyjDXxoxYSeRntUopArKVv9THYQNQWmTLFOL+wJ4U7pP5RhL0iZLEC8lW4RcT
uV1Y/RsVJtqZLvaaz/vSG7mDxPdmRUoOMuNqgoCWRldK/3C1e/PzbK995dbexEvt
FQ/UoltYwjXcqLddPapT+r2p9Ka434SZk7EUg06TMEGlg39fRA+cOtXKYKdohXRB
1vm6bR/MX62ZVzlx15+TbqYj8FPrMgB9BbzcGmf+/fk4gtUQ2gldBaWaovqEQwc=
=XUyA
-----END PGP SIGNATURE-----

--oU1dbz5gi9IL2UGH--

--===============8021739873139989093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8021739873139989093==--
