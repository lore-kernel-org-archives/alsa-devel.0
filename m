From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: mediatek: mt6358: add codec
	driver
Date: Fri, 25 Jan 2019 18:10:22 +0000
Message-ID: <20190125181022.GB6939@sirena.org.uk>
References: <1548139153-18783-1-git-send-email-shunli.wang@mediatek.com>
 <1548139153-18783-4-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2829330112210760200=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 60EF42666B3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 19:10:26 +0100 (CET)
In-Reply-To: <1548139153-18783-4-git-send-email-shunli.wang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shunli Wang <shunli.wang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============2829330112210760200==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 02:39:10PM +0800, Shunli Wang wrote:
> add the mt6358 codec driver.
>=20
> Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> ---
>  sound/soc/codecs/Kconfig  |    7 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/mt6358.c | 2336 +++++++++++++++++++++++++++++++++++++++=
++++++
>  sound/soc/codecs/mt6358.h | 2314 +++++++++++++++++++++++++++++++++++++++=
+++++

This looks fine but it breaks the build for me:

Applying patch #10781741 using 'git am -3 -s'
Description: [3/6] ASoC: mediatek: mt6358: add codec driver
Applying: ASoC: mediatek: mt6358: add codec driver
scripts/kconfig/conf  --oldconfig Kconfig
sound/soc/codecs/Kconfig:1348: syntax error
sound/soc/codecs/Kconfig:1347:warning: ignoring unsupported character '.'
sound/soc/codecs/Kconfig:1347: unknown statement "external"
make[1]: *** [scripts/kconfig/Makefile:69: oldconfig] Error 1

It's the indentation of the help text.  I've fixed it up but please take
care!

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxLUQ0ACgkQJNaLcl1U
h9C8sAf8DNAEyEGWgfO4Ek/wE5oPraZ4UbbRr9tYhZaJ39ZJ38J/S/7ExNCrZbS2
KRswBDNvsR0ZP7PDbh8BiXT6Z8iJrW17tLXHlZyR7BHX5nPmxbAH5I/BWgpPsNMv
qWPgimQFYw7KkXY8RdYycxQgJPowudsc0AZs5pFomtKKpVq9z6Mj8X6bhD/ufrp4
L/gJ/Ce3R3f2xahJR69Yd/f4mB7xcVjqZRZvvgKLWAk4Km5siDkoHJ0T89K0rfur
xlOKGpc3Q0+8tdN/5Gv2IVJvIxb9Dkxh+5wmHgKBpEPFv4q6RZkF1x6iJHJbm13w
jG/HTKSja5F6fycZJI3ltp6MvkbZ5g==
=s5Uu
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

--===============2829330112210760200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2829330112210760200==--
