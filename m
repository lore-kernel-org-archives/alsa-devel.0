From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: rt5670: Add dsp support
Date: Fri, 3 Oct 2014 17:32:24 +0100
Message-ID: <20141003163224.GC3594@sirena.org.uk>
References: <1411957901-12156-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1175427654290643883=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5F27260492
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 18:32:46 +0200 (CEST)
In-Reply-To: <1411957901-12156-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1175427654290643883==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2014 at 10:31:41AM +0800, Bard Liao wrote:

> +static const struct firmware *rt5670_dsp_fw;

This should be part of the driver data not a global static.

> +/* DSP Mode */
> +static const char * const rt5670_dsp_mode[] = {
> +	"Mode 1", "Mode 2", "Mode 3", "Mode 4", "Mode 5"
> +};

What exactly are these modes?

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULs+XAAoJECTWi3JdVIfQ2GMH/iJwPF7dD90We3qPH0vSd+Br
MpL++1/r4esi7ycG3xhjydZawMDCiRCdnw52qLgoTxNFMLcilD++yHepqMz7j2sX
TQxNvVf/Nbzz7jisF4ZvCPUigGvl/MlOFKpK+TOfmxIqcngaaD4Z1Lf+1dstof69
YDcMsbu2R32Gc6YJWI7yrhpI8xpR/j+pcH/jNPCl2qDz1/JXUyKQehf9sukfmnIQ
vNKL2y9/xtbj5SF1GVUhIdxpIYeLsGBLzd0M9e2pR3WG2CCApYoXQ1lPYKegpRA9
JjaY05mGDd/ra+qXqBmNQwjofp7CcrvcqjZViUsBy9ELfsBpYFa3lz93As+i4Z8=
=91cY
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--

--===============1175427654290643883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1175427654290643883==--
