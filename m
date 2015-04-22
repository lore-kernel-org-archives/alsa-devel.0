From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] File format for topology data
Date: Wed, 22 Apr 2015 19:44:03 +0100
Message-ID: <20150422184403.GA22845@sirena.org.uk>
References: <1429621606.3793.37.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3680145146354862976=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83C712617C1
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 20:44:15 +0200 (CEST)
In-Reply-To: <1429621606.3793.37.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Koul, Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3680145146354862976==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="azskX66S5GHWoEK7"
Content-Disposition: inline


--azskX66S5GHWoEK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2015 at 02:06:46PM +0100, Liam Girdwood wrote:
> I've pasted below the topology data for the broadwell firmware using the
> text file format being used by UCM. Using the UCM format allows to to
> share parser code and allows us to also have UCM define topology data.
>=20
> I've not yet completed the byte or enum controls but the rest of the
> data is there for comments. I've also included the recent channel
> changes suggested in the UAPI header comments.

Just to check, this is the input format which will be compiled into the
topology files loaded by the kernel?

--azskX66S5GHWoEK7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN+vzAAoJECTWi3JdVIfQjzgIAIGx2b/mUPT49nwdevQfUlZE
E4wVLNg+IZCOxnMC9rgVFX/I50FQ9viyG9PSOkFfAkre1AlL6wZZ5bxTZEYMVMId
BpJw1kIPZkOoLAuIqi9aqRXcn9jg2EE0f5XV3ohiM+4tOhQZXv5lve8BPnvTM8FM
EMzLpwlH4WGQtopkJK+7s2QDOOVM2vcJr9AD0omFkXathOPDuSg70ytUgS5L3L6D
1zA+Bch5AUVxYmk0Lga5FjfEoBJzAWKakoKWPMuCqO4jYVA/7gA9YsfPkpi9cTHZ
OMq6Dl2SGTZ4EO51NFG/EzWGm/aLxRAlEpaXzwlUQSX8lSgASTKYM7fBMdpnfbg=
=dUSZ
-----END PGP SIGNATURE-----

--azskX66S5GHWoEK7--

--===============3680145146354862976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3680145146354862976==--
