From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: DPCM: make some DPCM API calls
 non static for compressed usage
Date: Thu, 16 Jan 2014 20:10:42 +0530
Message-ID: <20140116144042.GG25466@intel.com>
References: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140116123153.GP15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2208684881448049713=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 563EB261723
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 16:42:56 +0100 (CET)
In-Reply-To: <20140116123153.GP15567@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.jf.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2208684881448049713==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 12:31:53PM +0000, Mark Brown wrote:
> On Wed, Jan 15, 2014 at 04:51:56PM +0000, Liam Girdwood wrote:
> > The ASoC compressed code needs to call the internal DPCM APIs in order =
to
> > dynamically route compressed data to different DAIs.
>=20
> Applied, thanks.  I'm holding off on the second patch for a little so
> Vinod has a chance to say something since it's compressed stuff.
Both look good to me, so

Acked-by: Vinod Koul <vinod.koul@intel.com>

The second patch still needs an update for properly copying the hw_params. =
This
was one of issue reported by qcom folks, but I don't want to hold these now=
=2E We
can fix that as it will impact systems not have fixup function for BEs.

--
~Vinod

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJS1+9qAAoJEHwUBw8lI4NHrBMP/2GFIaC4riWn2Dq2JrKwihbh
FEXIR70RzRTdbdQuEmTWvhEqpJSzQH4LxdyDJeyeT1JWlrdhV9XdQPQzoy48Xa+6
pRHdymYGU6Bz/cVBlAfX4nLZUibZX3y7DBHmTkoAeY0hKUDvmbl0FIqAattGpYCM
jLyOvOWmxPndVtNkMAekqxS73EAeVsiCTGAStbhHhgGQ7E1+KKtxNwe35sbdDkIK
bGJs3JcrD4sOaAZ6Tn641WWoFAJsV56DrdV9QD0bvB7/6isZozJULwIbE3Vvnv5s
Qx3CfVv6EA7RUGB/fZFuF8ThEKhfgRnYtvpkcl7XqixBljUA22ECaOBvuQt0rlKH
VUjU7F6dnu/rE04m0VgSbVj4Zr4gRH3MgmK9260/PosT57SqardqwPbOzZTHN3Go
CUgkC8X2oCLDwF4E5VdPQQrFU//YIPqzG2k3KQtROa6sJQXL5J4JSIcrAzBRDpEg
wWKCpcyCkFHQnWesRSKHe8YRa5RMUGE0QU7yPLgZUizSckTTJjeifHEpNkvAFNoG
Jw8Grnu8FAn7mzfGDY0A3UNX2iEvkTc4vsnJ3OjpGUD2VoQ6Ib80B7iBSLFukUau
Vjhf73296Hmkc7XWty0QuXpz7rcLmBXZ2ZURsmiBB4dz5d9OAgjLOW/6XONeLkjM
bCBOT8ql8/pxRJwOJnwX
=AxgX
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

--===============2208684881448049713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2208684881448049713==--
