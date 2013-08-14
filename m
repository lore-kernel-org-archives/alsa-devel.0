From: Mark Brown <broonie@kernel.org>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Wed, 14 Aug 2013 13:06:24 +0100
Message-ID: <20130814120624.GQ6427@sirena.org.uk>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
 <520B07FE.6060006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8471702504642973587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 37905265493
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 14:06:30 +0200 (CEST)
In-Reply-To: <520B07FE.6060006@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joel Fernandes <joelf@ti.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============8471702504642973587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JOUqYYSeXsqzCnuM"
Content-Disposition: inline


--JOUqYYSeXsqzCnuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2013 at 11:30:54PM -0500, Joel Fernandes wrote:

> Replying to this thread after a long time but just wondering, how do you
> guarantee in your implementation that DMA will not empty the buffer
> faster than it is filled?

Userspace is ultimately responsible for supplying data - if the
application can't keep up then the application should get an underrun
reported and restart.

--JOUqYYSeXsqzCnuM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSC3K9AAoJELSic+t+oim9NHwP/1kK9scKXmxQOQb/HOTCVcWu
/r0hV4vLELCm9dbzhQ1ScbsDZ+rFX7Z84N0ugoSwV2cBf8McpsqJysKlhCs381oZ
21znzriePnj1/EJ3qZd6hfYaFGsLaM0rewaPQ/mpJH2wM8RhFvOQmZCNy8aIhpD2
8R8ac8/9gnkZ1PnmpuUEnd4f7HYxK5WU43yM33esu9OtvxgeI7yrQjck1Et9YBjp
gDhnporz2pCgAAGIlgJZgifi4ek6sIOlN2BSYxk2tuExeDn+f4BV0j6MPTVzVKqf
e1QjPYAP6Xjk5ynvUAEYBL3yLHVvG/ukgyzJTQ28QVlRRGvePCR/ndtERvw4LJBY
f+J8paFYUU3qivnr4rwmzxzXarg0MAEnNle/TmEFPYaSNTpOoNQcsNrryyENccug
Ewm/DS5zK7J7UH/4OWTGYfwlKWNu2PiRoFDhYed1nlLHTaQqkD1d6ZaUJq5gXo4x
QzZowlVxZHrl5bPLNrmj0gPSf6YUnOaRBctHHSeh7sz9xMXiGg68HdwG/wivOhHn
9uuyR03Uh7B8fPNkpdiieUfVAgIJUrltC1IBxqIKzj0CMcOJB1+X8JCmM3eYqeWs
yA5HiZozcXD1LufPUADLIYWZoBVRAR/HMapeVkNh7Mk7cL3rSY+9QdfSB3GogNOe
m/HmKDJNVwUCjdFOKoHv
=gkPq
-----END PGP SIGNATURE-----

--JOUqYYSeXsqzCnuM--

--===============8471702504642973587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8471702504642973587==--
