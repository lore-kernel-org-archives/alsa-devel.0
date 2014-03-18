From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/7] sound: ASoC: add S/PDIF support to
 Armada 370 DB ASoC driver
Date: Tue, 18 Mar 2014 18:38:50 +0000
Message-ID: <20140318183850.GN11706@sirena.org.uk>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392225662-20431-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3990589903134725084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 336CA26165C
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 19:39:11 +0100 (CET)
In-Reply-To: <1392225662-20431-3-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3990589903134725084==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2RPQY0WN3yNjQaZ"
Content-Disposition: inline


--p2RPQY0WN3yNjQaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2014 at 06:20:57PM +0100, Thomas Petazzoni wrote:
> The Armada 370 DB board not only has analog audio input/output, but
> also S/PDIF input/output. This commit adds support for S/PDIF in the
> ASoC machine driver of the Armada 370 DB platform, and adjusts the
> Device Tree bindings documentation accordingly.

Applied, thanks.

--p2RPQY0WN3yNjQaZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKJK3AAoJELSic+t+oim9RRsP/2aR4qttimrPboOq8pQfg7kg
HO0xGmvnbN0EM9d4HNzIV5TD94K+9vWiMhJJOefFF/K2/vpU2vzLNF8gW5CRcS0O
01BRjpHNWY9fjyl3G+rvpRaemKSnRzCWPWPG0NEi0g361Yw0l2D1TQKX3K1YEkE6
TdbXruV1NlBRywJbDOK3idKy1Tjnsx+d7LQQ2weUX467gGnDoN8h5/PoXSafB+VP
MKfVRm/xf0eLi1Q4yUEV80Paa8/ZFNI45p/+oMyu5GZ7KU7OivPlh5JremvhgJLP
5z3KVrwHnZhsVMaEL40l6EJnffl7NYfw4J9C7/sf9F3GqaiUDU3Twam/OO2xqvPs
89vRRS2863A6qEdONs/3iE46cumBGyipacr/79G3LWJsnOTyMn7Gldn1F+aAydsB
T1JghW4XLdhuxxQ3pa8IqJ571xftYtIHmzzssZgvdK7WZDY2Wvi2nBUuVd2ctONK
8EKQfGzvLag44QZh5eMXLUNc8QDlLOBjwyaQfz8wwcSlAf6zB2gAaesuehFySqeb
9+bzE0QDpZ11xP9E3NOrppGLDaDGEaLMEt7kIl/Lpgoxypy4wBwBcDQQpmJIrHUf
wKhf/70grFZx1uMXnecT0fnQSbYHlCI4wEihTxvF+2QtrB1qw7OQ2RVVCFl3YDuX
bmzrVfG2dAZQ5KEd0PxL
=/HVz
-----END PGP SIGNATURE-----

--p2RPQY0WN3yNjQaZ--

--===============3990589903134725084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3990589903134725084==--
