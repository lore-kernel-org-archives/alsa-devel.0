From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ALSA: pcm: Add
	snd_pcm_rate_range_to_bits()
Date: Sun, 10 Jan 2016 12:03:53 +0000
Message-ID: <20160110120353.GX6588@sirena.org.uk>
References: <cover.1451550513.git.mengdong.lin@linux.intel.com>
 <712e57698a4144889318549d3b20ba2eaaa9c36b.1451550513.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0167235953721995019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F61F2602F1
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:06:07 +0100 (CET)
In-Reply-To: <712e57698a4144889318549d3b20ba2eaaa9c36b.1451550513.git.mengdong.lin@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0167235953721995019==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O82bwzp7nMTZS6dV"
Content-Disposition: inline


--O82bwzp7nMTZS6dV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 31, 2015 at 04:40:50PM +0800, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> This helper function can convert a given sample rate range to
> SNDRV_PCM_RATE_xxx bits.

Please CC any core ALSA changes to Takashi and Jaroslav, I'll generally
want to see some review from them before I apply anything.

--O82bwzp7nMTZS6dV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWkkioAAoJECTWi3JdVIfQw6YIAIE7o0UN12Ccv8zFleKE39M6
VcgXb0iV+kjAG3NDSKXn01AfsiO1UoNHl8zeBTS+u6FJq+fARAumvCydjIcXT9rr
aS8TfL26D5sOmFBNizOZp1nZHHOT7gH3h1WPtSqmEJ1AVo+gzFBUkGZatr5Pd2GD
M9VxNk7tWIMFXDRDqosQCYbwxEjicSvJM7BILT9+d1HEqV3lJd9dQlZ1n31WWytf
iRfx7z+Nnd4zUtPDHGJAtqEymBfoOENDksvcWM+p1r8+oMkmvVMQ9M/okndh7rIh
RnRcUxutbpaIjU2QZFCYOoWVKy1yn8ar9Zv3g0JPh7sTt1AzgVTmcqukak/83FA=
=V9Cy
-----END PGP SIGNATURE-----

--O82bwzp7nMTZS6dV--

--===============0167235953721995019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0167235953721995019==--
