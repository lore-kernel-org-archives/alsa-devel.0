From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core utils: Dont set DMA params for
	BE substreams
Date: Fri, 13 Sep 2013 18:27:31 +0100
Message-ID: <20130913172731.GO29403@sirena.org.uk>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1379092188-7385-3-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2783954252322070155=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 79CEF2619DA
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:27:33 +0200 (CEST)
In-Reply-To: <1379092188-7385-3-git-send-email-liam.r.girdwood@linux.intel.com>
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


--===============2783954252322070155==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dB9btecPJHCmBhFt"
Content-Disposition: inline


--dB9btecPJHCmBhFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 06:09:47PM +0100, Liam Girdwood wrote:
> BE substreams dont require dummy DMA configs so dont set any.

Applied, thanks.

--dB9btecPJHCmBhFt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSM0sAAAoJELSic+t+oim96TUQAIZPxYfapE8+/xtHDkCQwF+Y
0vXVpu+MdJ7eIbK82/r1xLieuKpbc4AuakDNjztOwg7FjdoVj11pqKn8KqjGRjm+
aLbrW4DYxFDD25wvjBFW1Z7XfneKkzx0vkphg0aIcddNuS2hxzOv6yEOUSAdmzsZ
tgwBvYbjHOdYUh9RE6rSgP9SvD78WRXE6G+W8aAL6t4kEn/EZdaxwBwxWlqmCVcR
ujv9aY0nK+3em2KsQ4y32Rvlw3n6YHZwv2yB8tBDFPV0M3lR4ny5BHC4QLdsKQiq
hH2/DQ+gKC+v7KziERe9jlIW08ebBCEbjdrqRK7lIknHSI7Wl7iQY4U7LureehtF
/xsmrVedoMvoE6CgevFDL+yqjZQUmdEP0Iv1YxvOX+pYI7nccsUEJi2A7qXgm+4y
EKC9b1ZpfSrRbNKvo4GWBJ2QAWQhbqCvZ/IlDMRs68jnrTI05LKIwJSbQ7xiTTyN
QojtgdV6UzLV36ylrPXHT9g7qNQFbXn0UVfw5gHWPbXctAtX6KJx1xyNceymQBsU
S7iTHAuF5HAOqx2IHsOIxPxqMtiWhco9tjq/2h33WiTOKEPwMXZzHZC+5CYCC9Yc
fwCCHkBtTg9HKSeHmkbUxnpfB43821j7k9ZKlJwvhEIS3OyUjn514h9xhvvVHWyA
5cmeBLOvL6R0kkTIegnc
=KTGl
-----END PGP SIGNATURE-----

--dB9btecPJHCmBhFt--

--===============2783954252322070155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2783954252322070155==--
