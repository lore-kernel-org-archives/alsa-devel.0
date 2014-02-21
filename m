From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Intel: Add support for
	Haswell/Broadwell DSP
Date: Fri, 21 Feb 2014 14:01:21 +0900
Message-ID: <20140221050121.GA25940@sirena.org.uk>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3934992505063412443=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE1322617B5
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 07:36:27 +0100 (CET)
In-Reply-To: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3934992505063412443==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 09:48:42PM +0000, Liam Girdwood wrote:
> Add support for low level differentiation functions for Haswell and Broadwell
> SST DSPs. This includes suppoprt for DSP boot and reset, DSP firmware module
> parsing and DSP memory block map initialisation.

Applied, thanks.  Some terribly minor things below:

> +u32 sst_shim32_read(void __iomem *addr, u32 offset)
> +{
> +	return readl(addr + offset);
> +}
> +EXPORT_SYMBOL_GPL(sst_shim32_read);

This lot all look like a regmap to me, though some extensions may be
needed for the 64 bit variants!

> +struct sst_ops haswell_ops = {
> +	.reset = hsw_reset,
> +        .boot = hsw_boot,
> +	.write = sst_shim32_write,

Something appears funky with the indentation for .boot - tab/space
confusion?

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBt2ZAAoJELSic+t+oim9UdAP/iz1L6bqTlWpvNo1RhyHO3xz
4GJMAQ8W4XgbL1DDH4N1hx/Btr6A2D00R7kjbPyMw5UiJzbZCbTxc79p7jMnFW0F
WltWXiHFqCNQkytOSC1qlQIIYTiHdejVZzMS9EBRmhNHR/rez8XFEMyGe6gFMQYC
T1BV5tn0xAhRt9+GuNtQiGr/bgdElK4jkCHX1rpbEEM+KZ5Rf+qFuPUryvYsBVBw
67/6WtNcnDVH5GOFqNQqU4DGP6WZzVXHbwJZIebtEoTIZesmVyOPmFJPc0qju40T
06FIsK00AS3qYzip3ZicWc32XuRFhGGzrwLfsIFJCCCEQ1Q/6x/OksHnjABnzHQh
WM+WQrfP53OV3Wbyoi2rTcLBdE2gdwslTky2yunVm4rs45Lpli/AQ1Gh0CDGeVYc
fi/7anxwjskWMvHSRys8VJKL+kMPZ/xlIoH3M9zEFgWhI+s+RemXKOyj8p+bThtJ
gRVgymdubhuRXJ6v3WXQlbTZggb0tKlcz+3EM6RDOUwpLh95B63eEQS0n444WBKm
vw4fpYV6crv1t7Sux615xCGljm+2UjAjajokwu0k4ucfxWlNM6o2E5B+CBbxojSl
8UBKMVFoYuMH47+OM3nGgn1RPEZ7avpl+/hYLECt5iaUgwQ7+HAhKI9qrrxceGcs
IMHUnma58ZqrncWEhh57
=7ziy
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

--===============3934992505063412443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3934992505063412443==--
