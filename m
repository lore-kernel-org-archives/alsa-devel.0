From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: extend FLL function
Date: Tue, 1 Mar 2016 12:23:16 +0900
Message-ID: <20160301032316.GG18327@sirena.org.uk>
References: <1456683827-6597-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8175116340434603808=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA255265B51
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:23:26 +0100 (CET)
In-Reply-To: <1456683827-6597-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8175116340434603808==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EDqNRv/wdIsIOPQx"
Content-Disposition: inline


--EDqNRv/wdIsIOPQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 29, 2016 at 02:23:47AM +0800, John Hsu wrote:
> Extend FLL clock source from MCLK/BCLK/FS.
> Modify FLL calculation and parameter setting.

I'm sorry but this really doesn't tell me very much about what this is
supposed to do so it's very hard to tell if the change does it or not.
It also sounds like there's multiple different changes going on here, if
nothing else it sounds like there's the addition of some new sources for
the FLL and also some unspecified changes to the calculations.  Separate
changes should be in separate patches.

> +	/* We selected MCLK source but the clock itself managed externally */
> +	if (!nau8825->mclk)
> +		return 0;
> +

That comment sounds *very* suspicous, if we are using MCLK we should
manage it via the clock API.  If the platform doesn't have good clock
support we should fix the platform.

> +	if (nau8825->mclk_freq != freq) {
> +		nau8825->mclk_freq = freq;
> +
> +		freq = clk_round_rate(nau8825->mclk, freq);
> +		ret = clk_set_rate(nau8825->mclk, freq);
> +		if (ret) {
> +			dev_err(nau8825->dev, "Unable to set mclk rate\n");
> +			return ret;
> +		}

We store the frequency even if we failed to set it.  This means that if
we retry we'll skip over setting which is buggy.

--EDqNRv/wdIsIOPQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1QsjAAoJECTWi3JdVIfQtyAH/iS05XLCJAkUPeS2RRkcJ5qi
MqoOUhjBcLJQra321nlKLO5niFrIwoOcb+5Hek+FnL6K811+pcboorHKInTnXztC
PVxWmisEmVqWDKy+apFMLtPcav80th2VjfCDb0OMrz5gAB507EfzLR/N11yCvEtt
XEzBYSwpQWhJ7Nvw8JtaiU2t0f6jeMzMJFTg2N9pggwTREN+lmZVPncB+yA+9SbV
HyiFW9oAy2vgzRE6U2mHRY7Qx9GXObsc2o+0uNHDR/4fw5Rse4oHVEQY46TNZJ0y
ZrEneMzMN9WToucytSzE5R6tpTZBmcrpArHHLOIMcXWpOEqz/b1UxM/LeFuGDjI=
=DH2l
-----END PGP SIGNATURE-----

--EDqNRv/wdIsIOPQx--

--===============8175116340434603808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8175116340434603808==--
