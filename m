From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4271: add optional soft
	reset workaround
Date: Mon, 24 Dec 2012 15:53:58 +0000
Message-ID: <20121224155358.GJ30837@opensource.wolfsonmicro.com>
References: <1355131804-22707-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0297431078828046331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ACC54261637
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 16:53:59 +0100 (CET)
In-Reply-To: <1355131804-22707-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============0297431078828046331==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RUqJLqMNe5u4kDWT"
Content-Disposition: inline


--RUqJLqMNe5u4kDWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2012 at 10:30:04AM +0100, Daniel Mack wrote:
> The CS4271 requires its LRCLK and MCLK to be stable before its RESET
> line is de-asserted. That also means that clocks cannot be changed
> without putting the chip back into hardware reset, which also requires
> a complete re-initialization of all registers.

Applied, thanks.

--RUqJLqMNe5u4kDWT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2HqPAAoJELSic+t+oim9ImoQAJrb33ZF+xd4vlSB1xlLT712
mqMo9tIL9AISic+Ry5HtHKH1B14ycJUt+VNLIeekBNb03pfO8FPHSl+Nofl1KnGF
qOz4SftVSbNHrclUgvrZS8ZCxH98lF+L3TFYm7JbHSavF8KUK9gz4J5TFfIX1RY7
o8MRVYG79C0uG094+XkiTRHqQABIpqADMCo5ijKW3D/yv8scnNWFlMftJOOtwFnQ
7NoGpInraz9ZeEIHS1S+bb1KVs00YYXd00MVyM6/+m6nRaf/b3hVFaXGRc5M3tYS
YptMJ/twP2gRG3aXbxmngAG0vc4czdO5YWgCX+E9M5b+vOlcRvU/kTnx0HlH9dz0
+outHy0VLI5kGzTLlsnjVHmKMfSDql8loYDMtTrNKjucbueaJCmMAAm+VTKrou+l
+FDUWyhSYqML+pH8DY+SxI4NiPnmGjGjnBzBxv9on6e6jLF2cPEokU5xSyUKH0Ii
pmAlNOz5o/4SxHvSu1uzjMM8MChkKQ5ny1nIec3YKXuQpZS6YfC8i/sD9sp5n3ss
P59hbIJug0fC4yE6nZPCogHioVK6tKtyYnDbgkljubHjNV0wIvW5TEOctdbEj6iR
t32KdcRaCAa4qDDU7zMMEkrPveHlGKI1H17WvXnVmLfbcEKJZaQiww7w/sp+6Twi
cWwr4JS2145asGz+4Z/n
=NcgC
-----END PGP SIGNATURE-----

--RUqJLqMNe5u4kDWT--

--===============0297431078828046331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0297431078828046331==--
