From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/2] ASoC: Change the PCM runtime array
	to a list
Date: Wed, 18 Nov 2015 18:30:21 +0000
Message-ID: <20151118183021.GK31303@sirena.org.uk>
References: <cover.1446692512.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5142739984449678346=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D72A265BA3
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:30:30 +0100 (CET)
In-Reply-To: <cover.1446692512.git.mengdong.lin@linux.intel.com>
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


--===============5142739984449678346==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ef8eQmdvO1j1gFMO"
Content-Disposition: inline


--ef8eQmdvO1j1gFMO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2015 at 02:31:26AM -0500, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> The 2 patches are a preparation to allow the topology core to create
> PCM devices dynamically. Probing a component may load its topology and
> come up with new DAI links and thus new runtimes. So implementing the
> PCM runtimes in a list makes it easier to add new runtimes.

I've got two apparently identical copies of this series that have
threaded together into one thread.  I'm going to look at what looks like
the newer copy but I might get it wrong, please check.

--ef8eQmdvO1j1gFMO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTMO8AAoJECTWi3JdVIfQxXkH/3g5tEAmgmMeLdLKqz9si5CT
8vdgBhuJpzyBQTeaiauBlxtU6fHqgdQQzs8J/aJX2L2qK7QxLiWGZkI1aROf43kE
tmHdE9UpDWnO8jJf0zyI3exh4RebaH4DYZGlphW/+QWlXxl/nnoePnkAt7X+oDWE
7W21+d59QxISD7yA+9AbvtTVCgjm0fL5Mk3IeuTYqpMTJJy1Roa9Phn5F/mQ+Kzy
Ty3q4QChlQwA0VjdRzqrwtjs6l0rnoM01bkNr/fGFpXGUoETFnusvnWpmXOWCYy5
LlKhd2KhI+2WuROPsHdwtj3SylbE4ouFsBQ68QsBjMBr4JYUyT9WJgjKTuULmVE=
=sdsh
-----END PGP SIGNATURE-----

--ef8eQmdvO1j1gFMO--

--===============5142739984449678346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5142739984449678346==--
