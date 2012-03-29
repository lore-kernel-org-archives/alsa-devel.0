From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: submiting an asoc-core patch with codec updates
Date: Thu, 29 Mar 2012 22:24:04 +0100
Message-ID: <20120329212403.GA4153@opensource.wolfsonmicro.com>
References: <alpine.DEB.2.02.1203291421530.21413@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9053242168298213166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B839104547
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 23:24:07 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1203291421530.21413@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9053242168298213166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2012 at 02:23:59PM -0500, Brian Austin wrote:
> I would like to submit a patch that adds some new macros for TLV in
> ASoC. this patch requires changes in 2 codecs (CS42L51,CS42L73).

> Should I submit just the asoc-core patch then follow up with the
> codec patches or just submit as a series?

If the core patch doesn't break the build of the CODECs (eg, it
introduces a new API) either way is fine, it doesn't matter much so long
as it's clear that the core patch needs to be applied first.  If the
core patch does break the build (eg, it changes an existing API) then
all the changes need to be part of a single patch.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdNLrAAoJEBus8iNuMP3dRqcP/3BjAMEEV41AV6UHvWvWme4i
MoguAM2XnJtCtp3eNmWeuFWqnXny3RH2QSZpV9L0wIf6acT2zSVj9eYGlYJjn7j/
5LcAWWWsKdlnPixDMIIDXdW6YWoNixmnr1Y9AqOn7zuurQCtN/MAcOm4a2ixqiHU
YUmCXF+mlbD4RkWg/we+aOK0cfY4ZIzqHWOrhrHM3oGDKnl7Bkk/NEMIhQkQqx39
J5D3YKS06I7Eilk9D41pJ/Hdc/M4qJrkmk06aSuuHQpzQsfa/Jhb95CJJqZZmMCU
LORKWSJe6oLMbI8RJDaNx7zgFJ4k0lPaxWgTnunEQCAvLjJE6edIsyxc4qg+d13c
TtL16YDOIBQu/VDrluR8R1f5t52g9qTNrUgj9s3STzkBYsmgc7tahSBLyLe2Gm5e
WTP++XwmzVq4/QHlXohfoMpNTiQ4LffY8SD5JQV+cj0nud+08JyBReAplGxIXvkE
F6OOPB0THP9e1XwobyVqIQfE7jR2Iumj7rQGBpbrW7A+mLrRtEqKi5VVV42arGAV
4KY7fQzaxftoGT/IVbFicxBQ+kn8F9QZ53K+JOj4IDqL5JZ19UtLSr8XSau/4uCf
Lzi0s+tHUNB9XCfs0K9lS2tjlQebM+KTrz5FCzbLwas/LuyvvO7hQKpTwgsKUnlC
/JP4A1xRnxIcVBvk9Uo/
=aybL
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

--===============9053242168298213166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9053242168298213166==--
