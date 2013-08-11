From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: cs4271: Add DAPM support
Date: Sun, 11 Aug 2013 18:41:09 +0100
Message-ID: <20130811174109.GD6427@sirena.org.uk>
References: <1376223377-23047-1-git-send-email-broonie@kernel.org>
 <1376223377-23047-2-git-send-email-broonie@kernel.org>
 <5207B5A2.2060203@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8305953440939697173=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4823E260896
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 19:41:13 +0200 (CEST)
In-Reply-To: <5207B5A2.2060203@gmail.com>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8305953440939697173==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g1HBHRjGshK0+67+"
Content-Disposition: inline


--g1HBHRjGshK0+67+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 11, 2013 at 06:02:42PM +0200, Daniel Mack wrote:

> Here you call the widgets "AINL"/"AINR", while above it's "AINA"/"AINB".
>  According to the datasheet, the latter is
> correct.

Fixed, thanks.

--g1HBHRjGshK0+67+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSB8yyAAoJELSic+t+oim9Fu4P/i7O5BkQpgh02VMNncVj+u6A
qwCTu97/EnfQ7mBpHFusTyxbD+YKUiB0byDExAskXgpF8PcNBFcHEAP7XaEmsnF5
cKE8oH2LW2GWRWeKRgVM0ZDvBkVGpGMu6+8P3nuf9+TDxJqN+5AzLWtaPhSbNuUY
DrOYL8v4L8GUbb33xsMsKhNCzvR7hYWuu0+Jfu8FLtigInYNr+BFUfPGHwzq/PXA
CZ92UbHUrPrA7Te2FBYIaXcMa72zT9h3Ydd6F/gYGp2J87FPtfVMmHuMf+cM3hIN
jNyUF2oGwLNxXErSo2fF5rAakPHDRi+ZCI5Tk6L3z2MKBAamW+/EELxPwjongk6o
1Ee/RLj+7Oe5QUymVqF/UrMMXnoE5Lq9u350T5Y0jIknF4/MPvLrxaQGsvRjGQlR
i/GdgB6l0gznywerGaHiPLWdK97FPz3QnS63VansbMSFmcttbFnSobSqsOazSkrH
pyWjt8NMR9WooNIo0d/i9yz+6ZRPIUKEkJ+41y8P2ADq4lTJFe3GQoJRLNrTpoX6
cXr3UfrtJczgMY67bD2xsVu+ZLfPDZm06Zj2/152nRlWrZZ7IbLcuo7qnvQMblfl
sHk6FvPzzNqtean3zLcv0T4kzeDQHtJ7i6Ikq78gqI2llOxr+N3jRM7srI6sYA5p
9ax7WuGD33PVV3u2825Z
=8n1N
-----END PGP SIGNATURE-----

--g1HBHRjGshK0+67+--

--===============8305953440939697173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8305953440939697173==--
