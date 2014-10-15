From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 4/6] ASoC: core: Call mute for cpu dais
	as well
Date: Wed, 15 Oct 2014 11:46:50 +0200
Message-ID: <20141015094649.GY27755@sirena.org.uk>
References: <1413356701-8535-1-git-send-email-vinod.koul@intel.com>
 <1413356701-8535-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2102625358786132647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ADA52604C6
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 11:47:09 +0200 (CEST)
In-Reply-To: <1413356701-8535-5-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2102625358786132647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/MgqJpI0ZKqTFycX"
Content-Disposition: inline


--/MgqJpI0ZKqTFycX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 12:34:59PM +0530, Vinod Koul wrote:
> From: Ramesh Babu <ramesh.babu@intel.com>
>=20
> We call mute for codec dai only, we should call this for cpu dai as well =
to
> allow cpu dais (FEs) in DSPs to be muted/unmuted on shutdown/startup

Applied, thanks.

--/MgqJpI0ZKqTFycX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPkKJAAoJECTWi3JdVIfQNtMH/RhXisxj0QkzLK6Uw29niItE
cp6zBm9bWHqq6LHGu2d3mygx0Y1MQmPeVKaFeekCvALEcphhdlUinILXYoYqRXl4
6nwql1t2KEgQ/mFHmNxIshGTWfqtldm3ZoZYa/RjFiWXSfbhkXqlV8G4xZcXJW7f
dg93PpqxntXZk0tMJI4t27AuvtqHydX8hjSXZsdphWzxTD+/bDapUX3p0a7epDGY
ZuIQD/ZjEnH/4q62MSWjr4XatTA3tEstXf37osyseuhjcrMw9Zjzphaxhz72Nydz
vkjjs2iErI+or8jwiAGCOP7Gr1Sl5RkX8cWBARnWCq4MZyHHldMdO51nK3+3qco=
=/pha
-----END PGP SIGNATURE-----

--/MgqJpI0ZKqTFycX--

--===============2102625358786132647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2102625358786132647==--
