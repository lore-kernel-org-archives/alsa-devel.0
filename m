From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Store the entry_point read
	from FW file
Date: Wed, 24 Dec 2014 12:15:01 +0000
Message-ID: <20141224121501.GU17800@sirena.org.uk>
References: <1419297890-29290-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6164718157262753675=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2095D261490
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 13:15:21 +0100 (CET)
In-Reply-To: <1419297890-29290-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6164718157262753675==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MIuRhPDBHHz1F6y"
Content-Disposition: inline


--8MIuRhPDBHHz1F6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2014 at 09:24:50AM +0800, Jie Yang wrote:
> To enable some modules from other than base FW, according
> to FW interface spec, we need pass the correct entry point
> param to FW, so here store the entry_point read from FW
> file for later usage.

Applied, thanks.

--8MIuRhPDBHHz1F6y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmq5FAAoJECTWi3JdVIfQLPQH/2EDQQKWCpdW7/IbXlVZXRiw
Wi9NrUXoIeyuprrGc8RyCBMS2A+BXRdKzvDe/cdLEW+j38F9pQIQzSE11InTWDHJ
FJuf12lWY79LOw59HovsUs3yodZFtzjYc6VOPOwmwO9iMkoQMOj9DDekcZ+s3tCW
lnPm30VxXWBLbRiVWjz/XwQdXefcG7VgrM0C5tUaEl5sUYrccIxQuu83VBk7WRc8
QjkO3Whw3s+8bIpBVpZc0fP49Jx+D/Yo+o9sna2toIqPEhvCFG0c8qw8TQ6as0/f
+VpzOBOPUnCgcPPW1LQhK7ANWbCjqaIzTQ8gDIN0mE5D4HVj8CvcOqp+lRXvyZc=
=ZpCJ
-----END PGP SIGNATURE-----

--8MIuRhPDBHHz1F6y--

--===============6164718157262753675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6164718157262753675==--
