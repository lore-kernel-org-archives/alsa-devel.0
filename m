From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 384/493] sound: remove use of __devinitconst
Date: Tue, 20 Nov 2012 11:00:31 +0900
Message-ID: <20121120020029.GW4483@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-384-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7987059626489594174=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 229DB264F6A
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 03:00:41 +0100 (CET)
In-Reply-To: <1353349642-3677-384-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: Takashi Iwai <tiwai@suse.de>, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7987059626489594174==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bOC9TN0n4iVUZoxs"
Content-Disposition: inline


--bOC9TN0n4iVUZoxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 01:25:33PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinitconst is no
> longer needed.

Applied but *ALWAYS*:

 - CC maintainers on patches
 - Use subject lines appropriate to the subsystem you're patching

--bOC9TN0n4iVUZoxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQquQOAAoJELSic+t+oim9MaAQAJrqhLqw3aBoGRgWceDXort5
wvvIM1qnf6rDVDIqhywcYoInn1vckAtxs2eRndtyRuhp7FjvW6hYJJx6ada3IAGz
+3eoutkpW+sJxIyE9WY4kztZhdnpfRLBjpCIazC8dz0bKaVz2U9BetCRZ2WPkFFT
4z34ANmW245hP4rduyWnrbdwvEgC5mmAX5N8HFbSI7QCuRxSnbx8ARrQFiuE/91t
gro9HmxlzUqPjMi60ka0DEhXm/UFtPQaJuCglbn3Mo3r6Kh1To7tDinU8vP1Gamz
ovmBV4nojbY1cmO981OX90CSzMtB8pCLOR9m//6WFhE4fh/YNszhOahgOEvkGKcS
8rfrQ3qIOsDkGRNcLqA7QpL9uRpmZ/JFNRhXlpnKCAWR8NmZqsAE5x4lkE0yktf4
ugsWQJ1QxMVIna+NO6ABVk6/eWhhl4I1q54OPWqvuV8bDXaVZqAiRU0YzV1q1UmF
GFFkRw++9B7zp0bApnWmejxsxnyRtMUC8hkkbIdtvn1xKA4DxOZaK6AdL3j9LCtp
kSc+OlBlOK1Kg4NGSYQvSCk077+Y5t4BVenCnfuohyoe6iAOpvMW45Wvpd1aS/oE
Q0r2ZWm6DcCM4pCPEkJ3p8TUf1Rfc8vRCc3G7FMfaAd+bUrAHGQfyWc4/1Hh2Te2
5qZa7hObSjeHNjv/bGYo
=vF+I
-----END PGP SIGNATURE-----

--bOC9TN0n4iVUZoxs--

--===============7987059626489594174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7987059626489594174==--
