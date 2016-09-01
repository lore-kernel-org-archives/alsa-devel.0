From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip: use SPI dependency for
	rt5514
Date: Thu, 1 Sep 2016 21:00:57 +0100
Message-ID: <20160901200057.GO5967@sirena.org.uk>
References: <20160826155120.1162512-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8753745510214397603=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 635F02671F9
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2016 22:01:14 +0200 (CEST)
In-Reply-To: <20160826155120.1162512-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Xing Zheng <zhengxing@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8753745510214397603==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Content-Disposition: inline


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2016 at 05:50:55PM +0200, Arnd Bergmann wrote:

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c6eac8a36a84 ("ASoC: rockchip: Add machine driver for RK3399 GRU Boards")

The Fixes is usually sorted before everything else, looks a bit odd like
that especially as more signoffs get added.  It's also a bit redundant
to use both () and "" not that it makes a huge difference.

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXyIj4AAoJECTWi3JdVIfQHRYIAIUo69FR1hodOUeGxzZV4cjU
ZUjlAEeNyM8W83QiVYplgWTXrtumO2k+YI0NZep6GMh5iYT3ukX8E4UgvCsQWD8m
EBL1uOPR/qp1v7em6kYGq8SYv23yanFUhoo1SlLbmIFyXfbjQ2XmIGUPmzWjTGcz
woif4+SMbuYzFOsjswtv2jBy88QnCAfCaB3gUXwL5KjTzig6K1eeoIiQdLTyGQKQ
E5m+wyCnJUQAgJUiaoS5zfPB8hgiX9brKzhIjjflFsMHMJ/T28rMP+tm1KkMPSvx
wHst1cozyD5lAuxBhCjw0VuO23uQN9Nf/CcU7+N+v9D/EQEptemv5TAqsxw1u5M=
=WhfM
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--

--===============8753745510214397603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8753745510214397603==--
