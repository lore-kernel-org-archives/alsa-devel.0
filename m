From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5 v3] ASoC: add generic simple-card
	support
Date: Mon, 16 Apr 2012 09:22:40 +0100
Message-ID: <20120416082239.GB3238@opensource.wolfsonmicro.com>
References: <874nt2aphw.wl%kuninori.morimoto.gx@renesas.com>
	<87zkashytm.wl%kuninori.morimoto.gx@renesas.com>
	<87y5qchyqj.wl%kuninori.morimoto.gx@renesas.com>
	<20120406175848.GN19424@opensource.wolfsonmicro.com>
	<87sjgd7ozb.wl%kuninori.morimoto.gx@renesas.com>
	<87pqbh7dbt.wl%kuninori.morimoto.gx@renesas.com>
	<87obr17d3o.wl%kuninori.morimoto.gx@renesas.com>
	<20120413103529.GQ3168@opensource.wolfsonmicro.com>
	<87r4vo5exv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2478878535017486295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C30B4244BF
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 10:22:42 +0200 (CEST)
In-Reply-To: <87r4vo5exv.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2478878535017486295==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2012 at 12:11:28AM -0700, Kuninori Morimoto wrote:

> In our (= SuperH) case,
> "generic" detected 1st, SuperH is next.
> So, it get "Driver asoc-simple-card requests probe deferral" when boot.

> If "obj-$(CONFIG_SND_SOC) += generic/" is in last line on Makefile,
> this issue doesn't happen.
> How to solve this issue ?

> this is the kernel boot log (with #define DEBUG)

This isn't an issue, it is totally normal behaviour and nothing to be
concerned about.  As your log shows the card does get registered.

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAEBAgAGBQJPi9bGAAoJEBus8iNuMP3dwxQP+NT8rA23xVS/uFp/XuV0SmPf
wyfUJtbhCrQ+KFQV0oOUv/usEpW1bAxjA8A+ciG0AyGwZulXqxoT+PJkX67E8v4v
4HpkUX66b9EWZ46xZqHLhZ4YAdxT0dQolMxRhTBlwzI+uac00UtzLZWv0KXr8mqp
rgTud9Bm1sUb47Oa1LtzZ4BwvPv1RmviHDKY/ciGpr7uvvhkx9a0eYwSFEXmreOs
m1M7ead+gtG/R/6M7YyHOKgUo+nsFgUuomS9mOc0e7/jIofVfm5Qj3an+ZJcWzdI
5oohig62qUTsY2lV+28fjGym8CvBNYkIEnqlYzlxJiGQNogVKhv5rRuO7DivFV0U
0BmT5x7gTx8RRJZnkihOLkS7IfGPvS74lGb729h1oCI0JYhQd4+omsDUMSfbwzdd
SWe1HqLt/6rpatQogF/oO6/m6GsKk0zohwRDbT/qmyuWeQ6MfM1fBzC/ajYMjLS+
WnN4ICbW820bhXoBnSgOOb7WdYxx4eJKkJR47KXOUJIBXQoxtX0yrwhlNQ0rNAbb
eL8MsqeqClvX5FXaN5M0PEwWiFoL4NY8TAhB2Vhhq0gv6XyGcJ0JxC5dN5K2N/xY
XP7/AklyhbmSYs9AkmJjs/xxhbrZXsye8fsdwUWIm8DEOD0sEnbOG+qCD6MJ0dyX
U6Xc1/ThnhKlC4tuziU=
=91Xy
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

--===============2478878535017486295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2478878535017486295==--
