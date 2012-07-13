From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] sound:soc:soc-dmap: Fix compilation
	warning.
Date: Fri, 13 Jul 2012 15:45:24 +0100
Message-ID: <20120713144524.GO4215@opensource.wolfsonmicro.com>
References: <1342126816-22308-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1072522730509120516=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F1892479E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2012 16:45:26 +0200 (CEST)
In-Reply-To: <1342126816-22308-1-git-send-email-marek.belisko@open-nandra.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1072522730509120516==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RD6GsZsdEJvsf78O"
Content-Disposition: inline


--RD6GsZsdEJvsf78O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2012 at 11:00:16PM +0200, Marek Belisko wrote:
> Fix following:
> sound/soc/soc-dapm.c: In function =E2=80=98dapm_clock_event=E2=80=99:
> sound/soc/soc-dapm.c:1021:1: warning: control reaches end of non-void fun=
ction [-Wreturn-type]

Applied,:but:please:do:make:an:effort:to:use:subject:lines:appropriate:to
the:subsystem.  As well as using a totally different style there's a
spelling issue, I very nearly deleted the patch unread because of these
things.

--RD6GsZsdEJvsf78O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQADR3AAoJEBus8iNuMP3df14QAJi+1R1niDq/r1HEb/mReIg4
AGfbc5gFn0XkmCPMAIC4g/OFSMcGpDrs9ItgtgHqkaMkjUIpOZxu9cOiUgIxnpaw
mtMJxr1wBCuFHvRnKRdpXzTPpAVogO+dKMkBjoN5G2WJ6PGMbuPnbhWBfK8U64R2
UVeg8ISJxgnehuh6fta8JUBYneZS3E9vwSwBayDQL4mbWnGjVMC/aHL1Te5DKu29
chp+rjPRn7LGImFShsiGMgaUr/R93t75ze1cdWuk4654fQVG9mFZA91ZiTIXFHNg
qiWj0XStLknMbQpRpTNGL9keAzMXQBPU1LPxIcBHn/WL7vebT79H5Bpnqsme3SPS
LbgLsmjay6vKVkshG6nlnz9aNYbMwPc1Ur2AFlenlNVdvjvBiHpyxw855s+aYkue
xX6h+HHqRLYo4re8dx5m7cLO2WAciL4lRjm7QUKAnPLn6Nrg7wfoFceo0cKoHskI
mdma9lg9nw4afZv/D2vrxtqOsN3cBhVfGm7PmQjbjnU31jVG7CtjAgUuxYnVmF/N
vldwn8KIJsy+PesH4FexboeFeZm1lqOtW8nWsCMfr+P93W4oo2Qx84Vw9383rtTI
8s6IlSH57ABWaUGnSS5vPVMWIwxWvq9EYOF4o6CRzJcwLBLkgxCt+TFvwW+qUub1
k+V6IL6aojjdTXHmIdjU
=bV68
-----END PGP SIGNATURE-----

--RD6GsZsdEJvsf78O--

--===============1072522730509120516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1072522730509120516==--
