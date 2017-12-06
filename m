From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/3] ASoC: Add platforms directory
Date: Wed, 6 Dec 2017 12:39:08 +0000
Message-ID: <20171206123908.GB1827@finisterre>
References: <20171205181448.18513-1-afd@ti.com>
 <20171205181448.18513-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0482955053472067449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 843C4266AE1
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 13:39:10 +0100 (CET)
In-Reply-To: <20171205181448.18513-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0482955053472067449==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 12:14:46PM -0600, Andrew F. Davis wrote:
> Platform ASoC drivers are a lot like ASoC CODEC drivers in that they
> both are independent pieces of a sound device, or "machine". Platform
> drivers should be free of CODEC specifics and visa-versa. Both are then
> used by the the "machine" driver to form the complete sound device.
> This forms a hierarchy that makes it natural to group platform drivers
> into their own directory, much like we group CODEC drivers already.

This seems like a step backwards, and your current patch set only does
this for the TI drivers anyway.  Currently we have things split up by IP
holder, with machine drivers that have some platform specifics grouped
together with the matching IP drivers that may also share some platform
specific considerations.  This would group all the IP drivers together
and separate them from the machine drivers they work in concert with for
no obvious benefit.

If you want to make a common directory for TI stuff do that, there's no
need to mess up all the other platforms to do that though.

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlon5OsACgkQJNaLcl1U
h9Du4Qf/U9Z7wmDbxh1f9EubLW5EbAh8qO7TfGNB5+0N2F8rhr9JDQMyV91Q2liF
y4vcHtWvLMpwJafkeIotN8TrjvSfII38YIwK1V++YnuQWON4RelCqpZ4jU33BqRO
GnjJmcA3reSGNK1OIFUm2AucFZNhP1vU+Olh7hHjYYW5zEOLh6WxdaBEH8NWtwMh
QcGziZvBA78QpHtrz8O1a79bQlGRMLKBdvT9zM7qXYZwYSUGMwJe9j64LviOXGUJ
6zLNeb5KyrSHPftlAXcZ/Sub5faOvp3K55Eh7GMnVqHSu/MnYelys11I5fh5CQnG
walA80BEtAk9u70EJcWGOScjBwtXWA==
=tthK
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

--===============0482955053472067449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0482955053472067449==--
