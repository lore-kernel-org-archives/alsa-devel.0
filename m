From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/7] ASoC: hda: add helper to configure
	module params
Date: Fri, 24 Apr 2015 18:38:30 +0100
Message-ID: <20150424173830.GB22845@sirena.org.uk>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9105900780962146017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 92AFE2605FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:38:35 +0200 (CEST)
In-Reply-To: <1429390653-8194-3-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9105900780962146017==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="49h+WPqFrDmC32aS"
Content-Disposition: inline


--49h+WPqFrDmC32aS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2015 at 02:27:28AM +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> This add helper functions to create module
> parameter for module IPC msg

This feels like it's abstracting between two different driver internal
formats but it's not entirely clear to me.  I'm lacking some big picture
stuff here.

--49h+WPqFrDmC32aS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOn+VAAoJECTWi3JdVIfQqaYH/2GDnS8DqC3YEvH5JECMD5p8
znAJ+1O90zbZJuJ8De1Y93+BzPgqGZQjrgkOEw7uUphGNNKu3NrEbWHGzfCHxe4J
mV07p5ggJWu0xM8Oy0OAutxLBasx4zLum8zz96UVuCUhPOqFV36hrTHcZrGZkM9m
/PPXaHsgn18Isa+ZEBKsaTJEHtJ36grE1v8aTDS6CUCLc4PPWClqiXQ0yyoTI4pc
plxj2/aCKH1/19jqDZk030uM1xbo5+4le+Vr2qMXZYVZhYbfQKBeYNVD4ug5PET5
GLWFj9NRp5jt7xScAdKUP5j9Vy2wLsZLfVqj5YCCznO2TjwwoDEDDoXUF19qgUc=
=9Q4e
-----END PGP SIGNATURE-----

--49h+WPqFrDmC32aS--

--===============9105900780962146017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9105900780962146017==--
