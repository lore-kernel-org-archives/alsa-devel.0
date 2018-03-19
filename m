From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Fix kcontrol name string
	handling.
Date: Mon, 19 Mar 2018 15:06:43 +0800
Message-ID: <20180319070643.GD2186@sirena.org.uk>
References: <20180314204319.13919-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3172830624424066132=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C806267294
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 08:06:47 +0100 (CET)
In-Reply-To: <20180314204319.13919-1-liam.r.girdwood@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3172830624424066132==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5FDBdOf8+srCecG/"
Content-Disposition: inline


--5FDBdOf8+srCecG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2018 at 08:43:19PM +0000, Liam Girdwood wrote:
> Fix the topology kcontrol string handling so that string pointer
> references are strdup()ed instead of being copied. This fixes issues
> with kcontrol templates on the stack or ones that are freed. Remember
> and free the strings too when topology is unloaded.

This doesn't seem to apply against current code (I was going to apply it
as a fix but it doesn't seem to apply against -next either).

--5FDBdOf8+srCecG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqvYYIACgkQJNaLcl1U
h9B6iwf/f2SEvRc/L6f+RRQzObEws67fX+HVO3uElTXMjdmnJS+I8SYwbf9KXpE0
W8dS7HUH4qNgC8KJGu7iqZziBKQoBCd7p62gmexQNtd+LeAmFZRCkAthrXCwnu9X
QybJimCNkgx6U3S3i9UQJAjvDn17bida5AxFr4PLE5N7lUy2rK9+CvI7qWI6bXZ5
+rYay3BTPAyubvQOtR0kpHKHbpLZoTSOx6VpAoa8wqap0ojv0e75qoQHQ9G0bfSk
8cAlhhjbC+eVHaQ94omGp0vghExDrObQROmScCOGkTSYGh4tKt/lCFj8RKQydkqf
AhFtoCNrUdDUy3JMcwWEGyAa86ogkQ==
=b03M
-----END PGP SIGNATURE-----

--5FDBdOf8+srCecG/--

--===============3172830624424066132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3172830624424066132==--
