From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fsi: add master clock control
	functions
Date: Thu, 1 Nov 2012 14:47:29 +0000
Message-ID: <20121101144729.GN4413@opensource.wolfsonmicro.com>
References: <87mwz3mjou.wl%kuninori.morimoto.gx@renesas.com>
 <87k3u7mjmp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1183759826359036214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA45E2625D3
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 15:47:30 +0100 (CET)
In-Reply-To: <87k3u7mjmp.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1183759826359036214==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eGLW8NzjjVmDHwQh"
Content-Disposition: inline


--eGLW8NzjjVmDHwQh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 30, 2012 at 07:59:45PM -0700, Kuninori Morimoto wrote:

> +	own = clk_get(dev, NULL);
> +	if (IS_ERR(own))
> +		return -EINVAL;

Any reason not to use devm_clk_get()?

> +	if (xck) {
> +		*xck = clk_get(NULL, fsi_is_port_a(fsi) ? "fsiack" : "fsibck");
> +		if (IS_ERR(*xck)) {
> +			dev_err(dev, "can't get fsixck clock\n");
> +			return -EINVAL;
> +		}
> +	}

This looks wrong - I would expect the driver to be requesting the clock
with some fixed name and the struct device.  The platform should remap
this onto the appropriate underlying clock using clkdev or something.

> +static int fsi_clk_set_rate_external(struct device *dev,
> +				     struct fsi_priv *fsi,
> +				     int enable)
> +{
> +	struct clk *xck, *ick;
> +	int ret = 0;
> +
> +	ret = fsi_clk_gets(dev, fsi, &xck, &ick, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "clk gets failed\n");
> +		return ret;
> +	}
> +
> +	if (enable) {
> +		clk_disable(ick);

Are we sure that calls to this function are always balanced so that
calls to clk_enable() and clk_disable() are balanced?

--eGLW8NzjjVmDHwQh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkot6AAoJELSic+t+oim9zIMQAJZeqUvX83UK02tyZMG3SIaD
MtnSku9ipdOjW3vveWP6fhPnpY9LoR0k8/AZ/wVoYzkrpvQdcxayCBmgy/Se9ATg
wsheXbD63ILP4s+1Hc8ZmTuvWeuZFZpscNXhUOW83juonJMCAHMcO8w7l2TLYrzp
kDr5NZBV/dnDQkDxaqay5J4gCD0sP4gbVRcw6xgOVM0QPIodKOTUl06tD1zoMqpi
GVIBjQ07Tjy8pWL4WqMrAaFGesQwdm96ZlinUhP/5tPVnFVV6PFl2bqU8oxptp2W
9IfTVQskeownkqLNVp492MzRTjkytP81YzeO2zdgNGkjUCG/g0VU0FoI4USFt4+f
LrRxyL30l/JfHVQ6YCmhbrvSFhyDDnj3dGO31mf+sNSoPWQpR7p6LvJQR0v4njmV
xtUOe1A4gmrKt40Km+ijPwYJUdysyO4P4DXId/tbfrAmLX/YrWSguZdZM5oSJzPK
4XvvcQ+QWCyuC+8MpCJ8tu6PVzfT3Ebn0ZjgPIsyRXLTHacesj+yCFu9FWHW8ArN
DkOP/qLvJt64LRuwQdbMpigKcccdsxhw3vPxI/tX2izPMpokicCkNGOV74YJVznh
3jo3DKVCluZnEXXz9OkkwAwqSX83TqkKRueKVGpJQqssVDgGFQYpVmWsN1kwcHxd
7Z24r0tR5hRM1lU+UiYv
=xoFF
-----END PGP SIGNATURE-----

--eGLW8NzjjVmDHwQh--

--===============1183759826359036214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1183759826359036214==--
