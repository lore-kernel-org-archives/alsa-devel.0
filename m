From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 0/4] ASoC: intel - add skylake PCM driver
Date: Fri, 19 Jun 2015 17:30:46 +0100
Message-ID: <20150619163046.GL14071@sirena.org.uk>
References: <1434546055-28866-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9000276765859810733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6DA02606F8
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 18:30:53 +0200 (CEST)
In-Reply-To: <1434546055-28866-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9000276765859810733==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VFtJ6YJpdOijWzIn"
Content-Disposition: inline


--VFtJ6YJpdOijWzIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2015 at 06:30:51PM +0530, Vinod Koul wrote:
> This patch series adds the SKL PCM driver in first two patches and then adds
> decoupling of the controller for splitting the links in last patch

This seems broadly fine but I guess there is some interdependency with
the HDA updates that have been going via Takashi so probably best to
wait until after the merge window.  There were a few minor coding style
things - I noticed some if/else statements with braces on only one side
for example - but nothing major.

--VFtJ6YJpdOijWzIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVhEO2AAoJECTWi3JdVIfQfA4H/RfEbJM6O2y3l/gJYGvI0MwB
VHeJ5qOw4VThFav4ZTJObvaxWibwU6COcdw0EpZghUu524W4UDFaNKutc8R1NqMW
6Bt23K9M1y/MdZbg1iMROmPSu0MRink90Qxfq/E3WWNVw+j0yXwtaSauG6wQDC+I
9cMZ6ldBbqbj9EtBY8I70YvEGVAEe9PYzbTlUcWQs/0tIhJ5q48T9b16I/UWhowJ
mKB6dVeWgG72a4SrBa0zRp5br/D1Q3WVId6grf0EhApB9+DWyp9Ej2G4F8STr84W
SB6Uod9QYpZ+NsstFrn3QxWy7VR/P53ip0umwz4mRwP05sKf9wvVglN6rvbYrvs=
=Qs1j
-----END PGP SIGNATURE-----

--VFtJ6YJpdOijWzIn--

--===============9000276765859810733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9000276765859810733==--
