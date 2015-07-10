From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/9] ASoC: sti: Add CPU DAI driver for
	playback
Date: Fri, 10 Jul 2015 18:00:46 +0100
Message-ID: <20150710170046.GU11162@sirena.org.uk>
References: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
 <1434983473-25092-4-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0552153752533245655=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B458266606
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 19:00:55 +0200 (CEST)
In-Reply-To: <1434983473-25092-4-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


--===============0552153752533245655==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YW2MF9I5J49Ey/EG"
Content-Disposition: inline


--YW2MF9I5J49Ey/EG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2015 at 04:31:07PM +0200, Arnaud Pouliquen wrote:

> +	if (clk_id != 0)
> +		return -EINVAL;
> +
> +	player->mclk = freq;
> +
> +	return clk_set_rate(player->clk, freq);

You should really only set the mclk after clk_set_rate() succeeds but
practically it probably doesn't matter.

> +	case SND_SOC_DAIFMT_IB_NF:
> +		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(player);
> +		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(player);
> +		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
> +	}

Missing break in that last case.

> +	player->clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(player->clk))
> +		ret = (int)PTR_ERR(player->clk);

You shouldn't need the cast here.

--YW2MF9I5J49Ey/EG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVn/o9AAoJECTWi3JdVIfQKs8H/RO92w+pOrOm7gmpykwcw1tw
Np4TulcZ74XwWWGBStric5JXlNyBJTDbZ4Drv4TxsG1YJ1h5Zb52NoeLwDDT9NhF
hPuj7TctOBiXyVFXMYeO5SfsTxap0menGwiLOKBmhpZLIOfd/U+WwARFsDA5Ubtw
8e+s1ickP53gD9iOzaA9R5A4j7Jd5hg661QCMenyLem8kRgfrw2yImHUuzECXUnI
PdgvMcgJEFPwZc1vuGWvJEKcH31EvevnAqFYbyuA6jGMe85tU6eK/zuNtDwBHWia
cxSykYbryxpQMkcIqi8eKEpYLYhuf3cdg3C3P2vkp3NEcI+icsGFnhXDim65Hqg=
=2Toy
-----END PGP SIGNATURE-----

--YW2MF9I5J49Ey/EG--

--===============0552153752533245655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0552153752533245655==--
