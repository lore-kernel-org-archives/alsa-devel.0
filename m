From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: Remove unused control_data
	field
Date: Fri, 14 Mar 2014 19:28:04 +0000
Message-ID: <20140314192804.GD366@sirena.org.uk>
References: <1394786016-29311-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1757698698255970481=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9019926550C
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 20:28:12 +0100 (CET)
In-Reply-To: <1394786016-29311-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1757698698255970481==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/ke75lzkNdJ8e8mR"
Content-Disposition: inline


--/ke75lzkNdJ8e8mR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 09:33:36AM +0100, Lars-Peter Clausen wrote:
> The driver assigns a value to the control_data field of the driver's state
> struct, but never reads it again. Which means it is unused and can be removed.

Applied, thanks.

--/ke75lzkNdJ8e8mR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTI1hBAAoJELSic+t+oim9BPAP/AhvcQzEwWdMuYML/vDARBEm
8NImE+hF5LgrnO2yAgAXYwnL2n/czVm004MoxeUmcMt8Eh9MM/Py90VGQsH7Ip4d
WsqHJmzNAOC1QgSsqLRiIdxVBYS+x8NH3hCafGXk6jaCqKqIKvNQJnOmnN2KELaP
zZ5ovuFNpCVuJvboEZpn4GctIwnhKoK4tJ2QKyPjHlru0lj1TWYKnpM2yIz1gnuw
TOm0xLubIe/mh7t2hdv7vBU93zUL4JFcecfX9lGOR179MdBySCrV1Ec6W8EWV7lL
75zNvF0SsckxSr93A4eaRem31cWlN7fK4s2R6JoNOjQhVxYD79p7lKFyT/8XaSSo
BbDiIrVEwc3LDmNE23JKY+thoQbDR7mlzFX7Nb7nSN7dr1ZjVSixvK+SpuXYSq8f
9Sa312v1ETHCBQScxyOG5YkQ2d/+Za0W5+14tkOHD+3c6SZ8YWuXFQwA/e9zp1Fg
y2MugraEJwhklKz6O8ZIyAJRfsY3vzZF0j0XSbE+TZbaDbLaZXoM9J6SAkmO33lR
7BYYmyRHhMP3DgDAhisn0CQlZhSrgtDvyeWAlyVP4PdGRfZmQPgW8HfliKhHXNzL
DFnXPCFWmYHSD88fHu9aHz6idNhBS8TRuLJPwXU5QoelIc/vt0DwE//gdekFIIeB
qVSK5QTNll9PmV+E5Ayl
=Y4fQ
-----END PGP SIGNATURE-----

--/ke75lzkNdJ8e8mR--

--===============1757698698255970481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1757698698255970481==--
