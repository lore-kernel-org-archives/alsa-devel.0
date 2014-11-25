From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix stream volume set no
 effect issue on Broadwell
Date: Tue, 25 Nov 2014 13:08:53 +0000
Message-ID: <20141125130853.GB7712@sirena.org.uk>
References: <1416920453-21342-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6258029684548789464=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 36D4D2605F6
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 14:11:01 +0100 (CET)
In-Reply-To: <1416920453-21342-1-git-send-email-yang.jie@intel.com>
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


--===============6258029684548789464==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="er3ccdgDRx8g9EQQ"
Content-Disposition: inline


--er3ccdgDRx8g9EQQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 09:00:53PM +0800, Jie Yang wrote:
> The volume setting control for capture stream doesn't take effect on intel
> Broadwell platform. Root cause it at 2 points:
> 1. set stream volume with channel=2 is wrongly bapassed;
> 2. the saved stream volume should be restored after stream is commit.

Applied, thanks.

--er3ccdgDRx8g9EQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdH9kAAoJECTWi3JdVIfQbMIH/AxB+oWGZP8aKQGNOY5HTZs2
jDZ+LgXnc1ki6glTA3iUwQVdMsPFTjLBBHgCKBxPCDQLIM/vj/QRz+RUdOLX0oTa
C6xzjmrxO6BHCSnkRlt6zhc7bgBo46QTthiKdRHVM/hulFvBix3+r5YePxHASiVB
v9M6m0oeW7/0GkXgi0HPXUfcFLZN0ZtgKkbeIxxCaJHqMFY1IvZC+X2pGc9BlSVw
Xg7JkbOkDLeNed7dSxc9VKXtEM+20CCHxcpC8o3N8CaAFrdnbLGKbpUWGzFmLsV6
ZQ3n0jqLrMv4E/eeqj6h3QUncfLB/WKHrnKVxxTEt2G6Ap4Xo2tQ/BL+taQ2uIs=
=2CXH
-----END PGP SIGNATURE-----

--er3ccdgDRx8g9EQQ--

--===============6258029684548789464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6258029684548789464==--
