From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bells: Specify REFCLK for FLLs
Date: Sat, 21 Sep 2013 14:28:33 +0100
Message-ID: <20130921132833.GU21013@sirena.org.uk>
References: <1379758218-28580-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9180471395289653293=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 94E11261717
 for <alsa-devel@alsa-project.org>; Sat, 21 Sep 2013 15:28:53 +0200 (CEST)
In-Reply-To: <1379758218-28580-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, sbkim73@samsung.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org


--===============9180471395289653293==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aHs8h1LsWZz+2jQe"
Content-Disposition: inline


--aHs8h1LsWZz+2jQe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 21, 2013 at 11:10:18AM +0100, Charles Keepax wrote:
> Wolfson recommends using a higher frequency REFCLK for best performance
> rather than the default 32kHz reference clock source. We should set a
> good example and do so.

The trick here is of course that MCLK1 is not guaranteed to be
physically present on the board and there are a range of possible
frequencies it could be set to...  I'm not sure I actually have any
crystals.

--aHs8h1LsWZz+2jQe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSPZ7+AAoJELSic+t+oim9QhoP/22eX/CUqZcqpQ5YX6JOkIXp
r9+PQtasoPBlz1m+8TEsrsmvTfXfX4hodTY/2T0WoZUfoZDJI3s0xdY4YD7zbjyT
7cNC440pINjczNkfhcMZ7PXojQA/QNMiad4tT0QlymqRXpWZX5dOhmN+iNIm71u0
XiThMseSvxmPQdjLZ3xjZnIHX6ftzrEGDqFLME+YMAoQMfHgfB4qeyIKPoYCFk/Q
ZSD9M2ALeFt0A3kwHIOH884qw0vrwgovS5+HdJsVyJGAvbSzeLry3rT+KObWwDOk
5R5dw1LuGeLEXC2RUrcNNf1iejV1/jGhoWp2YlaJAEzb+oyo+wIaEuGZOhTQpJod
dllkBr1NUR1P//pTfIk7Nvw8ND08fGlN+WJCDt7HHwF2+6eQd+cAkFX7BtUJzqcw
VWDnQWjba5E9RbTa/OYBreptSB09oQ72TU+XTrqhdNYyjgvEMtevRXOCqMBQrr4g
WDN3n8yA+DDOosZyKUiiC/WiUY6mduv+R94SqSViv68YuugulEI2NUgEjlgiqiFT
JouaRCz4D6ces0KYeakjP61AaE93ptvEw/jp9QbdeXV2DCbyaS0VyHIiDIpHgCsn
aot0ZRuHDzUigE2d7tvZ/fyHvsQFqYPx/FC8XXkF7QiOLEsYh02AhH2f74B1xxtN
HoGYMJoKd6Qhf5d0UMIT
=5f1b
-----END PGP SIGNATURE-----

--aHs8h1LsWZz+2jQe--

--===============9180471395289653293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9180471395289653293==--
