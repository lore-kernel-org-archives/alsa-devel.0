From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Add the chip type to
 distinguish the setting of the clock source
Date: Wed, 11 Feb 2015 13:41:19 +0800
Message-ID: <20150211054119.GQ2593@finisterre.sirena.org.uk>
References: <1423563274-20812-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6476935566367734164=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F7A726056D
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 06:41:53 +0100 (CET)
In-Reply-To: <1423563274-20812-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6476935566367734164==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vIXBmblrD40XNCy4"
Content-Disposition: inline


--vIXBmblrD40XNCy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2015 at 06:14:34PM +0800, Oder Chiou wrote:

> +		if (rt5677->type == RT5677) {
> +			regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK1,
> +				RT5677_MCLK_SRC_MASK, RT5677_MCLK2_SRC);
> +			regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK2,
> +				RT5677_PLL2_PR_SRC_MASK |
> +				RT5677_DSP_CLK_SRC_MASK,
> +				RT5677_PLL2_PR_SRC_MCLK2 |
> +				RT5677_DSP_CLK_SRC_BYPASS);
> +		} else {
> +			regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK2,
> +				RT5677_DSP_CLK_SRC_MASK,
> +				RT5677_DSP_CLK_SRC_BYPASS);
> +		}

This change looks good except for the above which is better written as a
switch statement - it's best to write choices between chip types like
that so that if a new variant comes up then it's easy to slot in.

--vIXBmblrD40XNCy4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2ut+AAoJECTWi3JdVIfQCIcH/1eLKI/uYvRDeYwBCgEjlz68
0/vrydNwIjETeYr5qM0hKiMgi6VP6n1FSvkNSXxkDvauBghylvDBzZwigd1rl5xr
kYbRlBdw1U2X38aUSPbQSzoqrutdB4KI5CHZTffW31XKLE1kNOhBVCMMfAnxUxIH
c60521X7Z6g7h+oAuVkC8kyO6T4nzf3qdgA2e8EIbdTrr+Sem8c6TnZXCk+J1KtF
EWlngOQ5zF5569UFboV4KDSWEEwAx1q5vihCrZzPkV9b4kgN54NFoQD7IGnH/JAP
OSsFqXho91luCZBT8TAicL2J6PQH0R23r+pcMMbmOs3U4ImH7PIeSvRM9+TES2s=
=ymLs
-----END PGP SIGNATURE-----

--vIXBmblrD40XNCy4--

--===============6476935566367734164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6476935566367734164==--
