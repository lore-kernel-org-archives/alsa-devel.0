From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] Intel: ASoC: remove duplicated code on
	merge
Date: Mon, 16 Mar 2015 11:00:49 +0000
Message-ID: <20150316110049.GJ28806@sirena.org.uk>
References: <1426481189-9898-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6872923554192876615=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 668CA260629
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 12:00:56 +0100 (CET)
In-Reply-To: <1426481189-9898-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6872923554192876615==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OEp3pE+VUYV0MT2S"
Content-Disposition: inline


--OEp3pE+VUYV0MT2S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2015 at 12:46:29PM +0800, han.lu@intel.com wrote:
> From: "Lu, Han" <han.lu@intel.com>
>=20
> Signed-off-by: Lu, Han <han.lu@intel.com>

Please include a commit description explaining what the problem you're
trying to fix is (like where the two different copies came from).  I've
tweaked the way the merges are being done which I think has stopped this
happening, can you check please?

--OEp3pE+VUYV0MT2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVBrfhAAoJECTWi3JdVIfQgyoH/0MYmzBCEVRIul9s2A5SqiSq
xYwEJdDx/k1qH4I3byIn6Fp3Obv3XnWr8tD+7AhK7BRorOYSQ/2eokQmxvdTu1ul
sevHdClDgt+DTg0UOhvrtGLgo6mPUCw8raeywgbKLqyorSUbOashRdf6U9MLiaKm
MTi+L5VhAIEPRzhgVY5ET9YYRKkZMVzf5iWHODW+md3SvAn2l9O/Vza7nEeNDQFC
ROwnoQ2mzKsdBboq01y/gYCNoKcyNhc6rYtDtseHLXMk1VivzHtN2PdexrQIRkxk
/yKuo0gCY83bwCVejQxJnBi6I8H8mZaYeEP6unvedzZwjND+pn/xqCNNZRJAhGs=
=yXqG
-----END PGP SIGNATURE-----

--OEp3pE+VUYV0MT2S--

--===============6872923554192876615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6872923554192876615==--
