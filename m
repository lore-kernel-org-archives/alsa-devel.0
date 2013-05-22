From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix early event callback list
	iteration
Date: Wed, 22 May 2013 17:34:25 -0500
Message-ID: <20130522223425.GG1627@sirena.org.uk>
References: <1369260773-4060-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0075173228317231526=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E6F4D261692
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 00:34:34 +0200 (CEST)
In-Reply-To: <1369260773-4060-1-git-send-email-lars@metafoo.de>
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


--===============0075173228317231526==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v+yx4Fq+rcVvnsQ8"
Content-Disposition: inline


--v+yx4Fq+rcVvnsQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2013 at 12:12:53AM +0200, Lars-Peter Clausen wrote:
> The power_list field is used when adding a widget to a power sequence list. Use
> the same field when iterating the list using list_for_each_entry, otherwise
> we'll see undefined behavior.

Gah, I had noticed occasional errors but hadn't seen them often enough
to reproduce reliably in my testing.  Thanks!

--v+yx4Fq+rcVvnsQ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnUfuAAoJELSic+t+oim9ickP/jV21vNspN5I0weq+9RPOwa1
NSbXANqg3y7GT5U6+QOwMKgBlcKyB/TUwjgacUFWOSF1C7I5LRh+nJ0jm7dY5o+4
XNJI5GNSvNMdboxaD7Uk5H1gKox2jKpjOdieiO1PYrnRTWNxxK5MiL5rAqeNo2iu
l2ucOgqKY9G0OmYYLOWgF9I156WyUTezKtZgygKuTIh1zpFfgdWNI76t5foVgg1o
lIZOdoiBmyq9XDPe9vDMFzcn5bC3dVy4U3Ke5qVBIQwlkoNSkSbjE/Hf97kHwv62
poEV0Cl4VPUcN3C02A7kp8EbHY8dh37HkVg22D7dR0U8C29AMM1sm9/yAtsf654u
IQ7CNCRxRgOWuT+JL9IA/+rgO/fV26Wn+QRz07qSWdp6cLL9x0l3fmNmsyqczDPn
gGB594UBC0E6biUrOPWhrOaxc4Y98Fuvr9d4vQ/03bko4zZoLl5ujkUkNcwM9ocX
yKkYH3nVsisIz1zmODIJ5H82a4MY/EMlHu/1attAVpKHuYAHiOEvCZ+jvJ6fewKd
+dxnLnCZf91skpBYIsWAzm4hdsTNZ2JlIJucT4U9TkHVYNlLkm7RvSYjCfFJFt7w
I4U9bCb75ZVGVktkyZyKzPFC4cITKYsa3H6KuOzBn4wen8utaDOVEl3kn01HpJv4
DUGOZquElaEVL2x6Fhro
=0QM8
-----END PGP SIGNATURE-----

--v+yx4Fq+rcVvnsQ8--

--===============0075173228317231526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0075173228317231526==--
