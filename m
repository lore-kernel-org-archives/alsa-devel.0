From: Mark Brown <broonie@kernel.org>
Subject: Re: BUG: double free of PCM structure upon module
	removal
Date: Tue, 23 May 2017 18:14:05 +0100
Message-ID: <20170523171405.iyahe4zfxerd7rn7@sirena.org.uk>
References: <87k2571px9.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0264834695197220206=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF61E267111
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 19:14:14 +0200 (CEST)
In-Reply-To: <87k2571px9.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0264834695197220206==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qr5bfslqsm3vo42l"
Content-Disposition: inline


--qr5bfslqsm3vo42l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2017 at 06:46:58PM +0200, Robert Jarzmik wrote:

> Did you notice the same behavior on other platforms, and if not would you have a
> hint why it happens to me ?

This is the only report I've seen, sorry.  It's not ringing any bells
immediately either - I'll have a think.

--qr5bfslqsm3vo42l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkkbdkACgkQJNaLcl1U
h9DRUAf9Hd6YnPGHHEeZXwUI9qrYtveSqt4bW8lDM9HYPfrpKeq1WXMtbktkozMS
jLTrmwUJw6+3IywLfqfInga/CiPgWwLUPWSeeHIymH1WsLtS0YhOPiVQ/9M5S6Ng
enN5GUqxocFsuQD8CwUa5ehW2UlyGcSpfYxo08M5XP6TynnN70lct9jkXxfd/WAi
VVJkQT6NnVlzc10oNEbQpaiHsh+U2N7X5ar4sQWEkLiZPPp4Ca6Z0m94kYyrF4ON
vGnrih8rYihqBnvfJ4hxnGFcR/L/iBF3Ef79a+NHn5kvnIAFYqOabFYYLqL4cP0F
vPl/Q07T+1iAAw9wPiunQvExDrTKhg==
=ptjw
-----END PGP SIGNATURE-----

--qr5bfslqsm3vo42l--

--===============0264834695197220206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0264834695197220206==--
