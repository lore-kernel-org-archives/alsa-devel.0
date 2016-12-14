From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: fallback
 mechanism if MCLK is not enabled
Date: Wed, 14 Dec 2016 13:19:48 +0000
Message-ID: <20161214131948.e3gqnbauv7762jrf@sirena.org.uk>
References: <1481654490-31846-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6167489910887712996=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B00B7265142
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2016 14:19:57 +0100 (CET)
In-Reply-To: <1481654490-31846-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6167489910887712996==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7kabx6lrffsobgf6"
Content-Disposition: inline


--7kabx6lrffsobgf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 13, 2016 at 12:41:30PM -0600, Pierre-Louis Bossart wrote:
> Commit df1a2776a795 ("ASoC: Intel: bytcr_rt5640: add MCLK support")
> was merged but the corresponding clock framework patches have not,
> after being bumped from audio to clock to x86 domains. The missing
> clock-related patches result in a regression starting with 4.9 with
> the audio card not being created.

When I asked about this previously you said that this only affected new
boards?

>  			dev_err(&pdev->dev,
>  				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
>  				PTR_ERR(priv->mclk));
> -			return PTR_ERR(priv->mclk);
> +
> +			/* Fall back to bitclock only */
> +			byt_rt5640_quirk &= ~BYT_RT5640_MCLK_EN;

This is broken for probe deferral, I'd expect this to be explicitly
checking for a no clock mapped error code (probably -ENOENT) rather than
just ignoring all errors.

--7kabx6lrffsobgf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRRvQACgkQJNaLcl1U
h9Dlawf/ZaQX2HT75ONgI6RL6v895syAjC2hLK4c0SgTTHSug4+OE5ly+xLiP4yw
I7yrljGmIq8YOP8pkrBgeQlZLR9xTL9T+hruZn3z6hcKXPAT523EFQPDqRtDyjUS
2n2YmW2Jj3+6bFVkXViRQv0cSSbul7de8aKy2PR3idmEJdfyOxH5xMsulD1DlJ9S
YQKE6xmbC79hYwW73YRBT1WTtwdqs56E7to6HPUPtXbNaNQvovLGb30jHsNtBZWZ
9mQQpN5rIVPYh1MGW4XIOcpv35Ke7GT9do4sqloecnE55+jaLu9vv28OhES35O4Q
CqL1CVJWRgkpw5Iz1pq6ymQDHciLkw==
=5V46
-----END PGP SIGNATURE-----

--7kabx6lrffsobgf6--

--===============6167489910887712996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6167489910887712996==--
