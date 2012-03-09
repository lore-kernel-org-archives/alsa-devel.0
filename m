From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 07/11] ASoC: fsl: check property
 'compatible' for the machine name
Date: Fri, 9 Mar 2012 11:51:41 +0000
Message-ID: <20120309115132.GC3273@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-8-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7350166057613077442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26F2B103AFD
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 12:51:58 +0100 (CET)
In-Reply-To: <1331225990-27308-8-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============7350166057613077442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 12:59:46AM +0800, Shawn Guo wrote:

> Check /compatible rather than /model to determine the machine name.
> The p1022ds older device trees get a different /model from the new
> ones, while /compatible is consistent there, so checking /compatible
> will save the bother of detecting older p1022ds device trees.

Applied, thanks.

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWe69AAoJEBus8iNuMP3doYoP/imBD5t+qofyaSWXaaVLHBzq
ihUNLEauU61K8lfWkRcXKvbmHODmUazjw8/F15g4Uy30j0bks3vFq+DCjCNW/e/a
xHrYs7GKfmh84eKymhfdxlmLafs1cqZKRkwS+WxdpCEu38N+enAvZ3owTjtomj+p
K1YekIVS37VCSU1aKBHO2jG8+3zfI49hTxI6JliUAxDDUHFFAZijdI74t8KT5r8C
ddx49rb5G5aAxSel991i9sW9ZurhQpYfEY0VwqyF1iGI8nQ3rthqAvPK0tebJ8Ru
ZsGrWFoI6vz3jnW4qDXsOXJ2zoVJKHSJ13reWm0L9HoeOxegC948dwclbO8MGaxq
zZKbBeJUU7Xm8b9EZwLYNgKZ9YTVvO0fdjFhhlGdj3IqbPlJWDE7PKHMT72y+Wu4
CA+Mx6oUI+Cgy9yefPONsdZ8YZNJ9TbbPc5SmP8QrolGv9594IxthhYMlHpFv9WH
gl9fYdOz0C8bgQB5OQ7h89nAYuhUzJ3C68wo7W/FVYj6d07cDuNCl5HAVt2PAQwl
BiOzGBue5RfN/QytQJTqgsKjJSFWOxbZcRYX6Z4gyCiTCOvrTvkfeDvm9gGKkGpf
fxvhDys//9YvdFgX+9WQcdz3t+0ciZcvKUXkEGgO1Ux8Yh07C4v3Hzqbrw2gBW4r
1mx74t7a5d4m6radLAzs
=tPh1
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--

--===============7350166057613077442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7350166057613077442==--
