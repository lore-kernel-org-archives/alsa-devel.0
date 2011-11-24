From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 3/8] firmware: Sigma: Fix endianess issues
Date: Thu, 24 Nov 2011 12:20:51 -0500
Message-ID: <201111241220.53832.vapier@gentoo.org>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
	<1322138908-32127-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0594916895440946325=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id A172F103DCF
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:20:43 +0100 (CET)
In-Reply-To: <1322138908-32127-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============0594916895440946325==
Content-Type: multipart/signed;
  boundary="nextPart4641843.cmqMq6Ze1z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4641843.cmqMq6Ze1z
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday 24 November 2011 07:48:22 Lars-Peter Clausen wrote:
> Currently the SigmaDSP firmware loader only works correctly on
> little-endian systems. Fix this by using the proper endianess conversion
> functions.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart4641843.cmqMq6Ze1z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOznz1AAoJEEFjO5/oN/WBtPMQAI+/gQ/lAUBwV5ga+H5s4EWa
PIQSJhH2G9wLZTs1ajVQYSRd8mYTDEqZ0DpOavX/WCwFV6aUbHQS1RLIcjsB0y61
kzH4IRMhGOAoy2nCUmtH7feADiRfdLUHZr6OPsZ2T6rdKF7QBRXgft19p9tfol8p
XXo7jwH2D5PtYSKQzOW+Cn4g+Zb0oWD6OeB9MPea55VC/4Wfn40Rf6UZ9U9vpXsG
ELgpWiuTtDHvgvKWuPIXBOIQfY8UmCqUpyqUgclHUfnCX8FbHBqP1ut+CLV9/dGg
SsNnkKg25bInzBtCWzIhBsmPuP0iFTbqHkZOyDtd8qrhwFpYx0dqgju+YXnRidZo
oU3CP8RPSrWmgT6DecSYMgOk2n5m3uPkr/3G0lEkdw4kLcPfjXyjfEMrYpxp7Agn
vr2EgCHu4izVGnylw5TX4SbbMDHbIbZLSGTkrJDtDshpntQym/lTg3+3mZHT5nqc
Fu6VL1MRANcVgTKXJ7u21c0nXtPDSTO1hx7XzQbzVlVwINbLvXdMgZ6rcP4w/AFp
ysAFewzRW7gGmCAbXuQeBeJxsQL3A4AScIlaQsezgv5alTHQyx4t+Pv6aQ9cXsd4
XoWvFc50OVHouyqeUErBLjohMka778FxzOHN7L/ZzuXcN037owevlSJH7SI6I+1z
QswGf4PmJLME3r+YaAC/
=1VEp
-----END PGP SIGNATURE-----

--nextPart4641843.cmqMq6Ze1z--

--===============0594916895440946325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0594916895440946325==--
