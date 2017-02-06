From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/3] ASoC: zx-i2s: support zx296718 SoC
 for ZTE's i2s controller driver
Date: Mon, 6 Feb 2017 16:28:39 +0000
Message-ID: <20170206162839.ymtwdvtlsj4rogyw@sirena.org.uk>
References: <1486389020-29432-1-git-send-email-baoyou.xie@linaro.org>
 <1486389020-29432-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8490517551710133048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A19D266DB0
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 17:29:17 +0100 (CET)
In-Reply-To: <1486389020-29432-3-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, xie.baoyou@zte.com.cn, vinod.koul@intel.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, jun.nie@linaro.org, shawn.guo@linaro.org, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8490517551710133048==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q34kbfph66mmt6tz"
Content-Disposition: inline


--q34kbfph66mmt6tz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2017 at 09:50:20PM +0800, Baoyou Xie wrote:

> +static void zx_i2s_set_clk(struct zx_i2s_info *i2s,
> +			   unsigned int ch_num, unsigned int sample_rate)
> +{
> +	unsigned long val = sample_rate * ch_num * CLK_RAT;
> +
> +	clk_set_rate(i2s->dai_wclk, val);
> +
> +	if (i2s->dai_pclk)
> +		clk_set_rate(i2s->dai_pclk, val);
> +}

There's no error checking here, if we don't care if these calls succeed
we could save some power and not enable the clocks.  This function is
also very small and has exactly one user so it's not clear why it's
split out.

>  static const struct of_device_id zx_i2s_dt_ids[] = {
>  	{ .compatible = "zte,zx296702-i2s", },
> +	{ .compatible = "zte,zx296718-i2s", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, zx_i2s_dt_ids);

This adds a new DT binding but does not update the binding document.

--q34kbfph66mmt6tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliYpDYACgkQJNaLcl1U
h9Chwgf/axpjVt1m2tfRyJRBHJZRURlloT1xFHn35OmvOKaskxOvTfENLeyy3Phc
CmcpfPA/B9CN+gzmgCaXWCLpkzTcOQ4nxb9zJhOMbbZaWqgC7cCrc6XHnnMd2m6W
6RoFH4/KVBZEl/XgGw/hT6FOg/oJZpaRYpu8p0NYMROgCbTLqsO2mpZ0XtYrDRwV
//bvBWTJkj35UYX8UeKDibAQq3Ao7/W+JvnrxZzYrGOrgXq/xgzU5kLYmmyvqZUe
3LOdnK87zyf6dbi0+MUnOzArIUZxci9ukUBKYg7ks2rl2KoNSr1xJUQqEtdvEeiC
+6MpheYkE8eibhok4wUV+gPpDHjmzQ==
=eKKt
-----END PGP SIGNATURE-----

--q34kbfph66mmt6tz--

--===============8490517551710133048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8490517551710133048==--
