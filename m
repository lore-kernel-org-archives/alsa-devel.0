From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Allow the codec to work in
	slave mode
Date: Mon, 22 Sep 2014 18:54:48 -0700
Message-ID: <20140923015448.GF27755@sirena.org.uk>
References: <1411082245-25679-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2178112869143586779=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9712E261600
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 03:55:10 +0200 (CEST)
In-Reply-To: <1411082245-25679-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, jean-michel.hautbois@vodalys.com, alsa-devel@alsa-project.org, Fabio Estevam <fabio.estevam@freescale.com>, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============2178112869143586779==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2014 at 08:17:25PM -0300, Fabio Estevam wrote:

>  	default:
> -		/* if mclk not satisify the divider, use pll */
> +		/* if mclk not satisfy the divider, use pll */
>  		if (sgtl5000->master) {
>  			clk_ctl |= SGTL5000_MCLK_FREQ_PLL <<
>  				SGTL5000_MCLK_FREQ_SHIFT;
> -		} else {
> -			dev_err(codec->dev,
> -				"PLL not supported in slave mode\n");
> -			return -EINVAL;
>  		}
>  	}

Are you sure that the configuration that results is valid?  Typically
the requirements for MCLK to other clock ratios are very similar for
master and slave modes, it's just that it tends to be a lot more obvious
when things go wrong in master mode since directly visible clocks tend
to go wrong as opposed to performance problems.  Are the dividers that
we can't get configuration for purely for generating BCLK/LRCLK in
master mode or are they for other things?

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUINLnAAoJECTWi3JdVIfQl5MH/AoxXkbcDusTvBIb2sJo4I0W
tJE0qE26X7gP7eSuTd06Z8/RbHKNS4BF+g9b02nKN1b96pzlsJVp//uYICNxuggC
iNL0qcTlbHfKm5ziYHJ18NohNYr0h9iJwmXLOVJO6YOqCYWnu7A8UhiQ+k42M5fn
1b0KwSWtD1x7SXmmC7iYa6ufLxug/pVypI+/+RD5qQiP1crQrjqie3ix/dOdct/G
1wiugpuXrlgR6Q0tR8ZnWmvxvHZJs3XJy0f4aQlTmydCYGTu61zyPHWi2F4Kbrzy
Hv3vaI+YMjWtJJyLwGjA2YvSWuJ76/4PvDJjv27y5DO3HhZFAuKzdnKvlcA5uVU=
=SNKO
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--

--===============2178112869143586779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2178112869143586779==--
