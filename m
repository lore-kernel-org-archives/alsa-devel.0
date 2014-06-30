From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix S24_LE and U24_LE
	support
Date: Mon, 30 Jun 2014 15:53:59 +0100
Message-ID: <20140630145359.GB23300@sirena.org.uk>
References: <1403759364-14524-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5063464791971103988=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19EE0261A1A
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 16:54:14 +0200 (CEST)
In-Reply-To: <1403759364-14524-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5063464791971103988==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0/ML9vKcIGOIZr+"
Content-Disposition: inline


--m0/ML9vKcIGOIZr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2014 at 08:09:24AM +0300, Peter Ujfalusi wrote:
> In case of S24_LE/U24_LE modes we expect 24bits on the bus while the samples
> are stored and transferred in memory on 32bits (lower 3 bytes of the 4
> bytes).

Applied, thanks.

--m0/ML9vKcIGOIZr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsXoEAAoJELSic+t+oim9FmoP/0W7GiubZ3zWIzQ+yvMpCLgx
xhMCrbXLXpiE1if8nW6lNFW9xeXxTNDZuSOt0RLF3iyUPGmkt4ujhdU83n6vDQ5Q
ILUeUZcbRkVAvSnYmv4BG98Kbz+tRQbZVXOBTgNvWD/a1fwD9OEdk2kc8V5vxJ5r
REopkHI5fP5yd2KftK6n8SS43YRZqZyTy1fD75ypY+EY1zmNwa9JN9q9fvTOSmWV
SDenQJDVC/wh6dBBGF6QTBc6DIZgXbREB0q40DpZCxpX4rrv7/Cx7s+dnlw8DFkP
Q3Ljm6JkCmBLB1EJRw3eldvIPI/Kxq9865zWj4YGV9oLA/sDZThYTsgcbgv1eDBk
puqA3xTWMzqoQ9/Bd+ADQFesUPIHITQ0FeXox2CKMIMKR8eUkw60cAKS1iHP2rzH
7mLIi0XLK382KJv83NgabKh26hmpSsoM5PV31ZVs59aLb+VtOcAOZC5GmPK7OeGC
ipfTAuaiQ+nJln56Rw1gYa7APllqssvrq17hYfOzWXng2urUWnU/Hepypcb88T3D
n5aJ/YDhn4hozCMOhZR2sCb6QZ90xUlh39rJiMn/w9rdim38KTBvtUxxFaMeRgrX
VDBQlrPKOqDXK5C1Fat9CNii0l4BlYKc0pYMJvapITEbUe8QuPCfR8DmCxujLCGb
k6iYY5e6n3UscVqlr0dX
=ACHK
-----END PGP SIGNATURE-----

--m0/ML9vKcIGOIZr+--

--===============5063464791971103988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5063464791971103988==--
