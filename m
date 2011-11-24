From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 7/8] ASoC: SigmaDSP: Move private structs
	and functions to c file
Date: Thu, 24 Nov 2011 12:31:27 -0500
Message-ID: <201111241231.29800.vapier@gentoo.org>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
	<1322138908-32127-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5772848915706002281=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id A37E4103E4C
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:31:19 +0100 (CET)
In-Reply-To: <1322138908-32127-7-git-send-email-lars@metafoo.de>
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
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============5772848915706002281==
Content-Type: multipart/signed;
  boundary="nextPart6197221.puaH7Dkltp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6197221.puaH7Dkltp
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday 24 November 2011 07:48:26 Lars-Peter Clausen wrote:
> Move the structs and functions only used by SigmaDSP firmware loader itself
> from the header to the c file.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart6197221.puaH7Dkltp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOzn9xAAoJEEFjO5/oN/WBtucP/1CjzBC8InjNcwTq+H9SheO6
yY4ohc7/PmE0XeG3nxrgeMJVU9e5QCx2vyg31gul7YKQPqGjzaXDVtLFHq5vDVFX
9zJJek/gtHcXty/EY2y4ZwQZhNBF8JUlGonNK7ACc5jRlrIhXDHIcLcjsT51RRjD
WBnM+/HgRklaYDVanLkBN7BI/mxUI9IhhQZI+AHvq7+wOSEhBr6pjRGDF8dG1vQX
ucsVv+gX4p2DiiNZ+UhASgyobgefVo6AXRw93/SMj8+6ITXGVRDB04V4o8cPKKZ5
D3iM3Py/UKzoHc6gyXH/rGKWi4MiwJ7byX+Uml7W2vlRn3p1AI4R1NLb5E+iUPME
nzQDeRC3/1P7YtZIQqAfQ33TYdUd7mhSs+RRXKWrxURFbxTAumQUm5Wimd5t3vY2
SrdPt8iWiZiaz302horYc7KCz0d1IugtOEcMjQoyCeE2XZAHANnOEINZhb9Z/rpe
9GD71o7RwKx62AE8i3QcRSTdzMKv0BLTmPD/sPqBGk5pT7YVP8m6t0yXPBl/QGFR
+etxQEKIn/3duOEFK28U+IXr5f9tA18DnVt6I37bg+fKovtsPg2eEYy36H02huzK
fkeAa+W07tAu8/fWBsZmkGkojb6+1rKnc7ch/06+DJuniNlgLrNKgup2N7UFKFpX
9xFxgQkpEchckvN5EieY
=uc5Y
-----END PGP SIGNATURE-----

--nextPart6197221.puaH7Dkltp--

--===============5772848915706002281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5772848915706002281==--
