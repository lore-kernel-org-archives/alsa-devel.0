From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] ASoC: max98927: Added TDM support
Date: Sun, 27 Aug 2017 15:02:38 +0100
Message-ID: <20170827140238.bqav6pkpxd2yogch@sirena.org.uk>
References: <1503708070-7906-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1918431481792019397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EA40C26684C
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 16:02:41 +0200 (CEST)
In-Reply-To: <1503708070-7906-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============1918431481792019397==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ozghonnujalcj4qi"
Content-Disposition: inline


--ozghonnujalcj4qi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 25, 2017 at 05:41:02PM -0700, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>

This says it's adding support for TDM mode but...

> +	case SND_SOC_DAIFMT_DSP_A:
> +		format = MAX98927_PCM_FORMAT_TDM_MODE1;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_B:
> +		format = MAX98927_PCM_FORMAT_TDM_MODE0;
> +		break;
>  	case SND_SOC_DAIFMT_PDM:
> -		max98927->iface |= SND_SOC_DAIFMT_PDM;
> +		use_pdm = true;
>  		break;

...it looks like it's adding support for two new DSP modes and generally
making a bunch of other changes.  This probably needs splitting up, or
at least a bit more of a changelog.

--ozghonnujalcj4qi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmi0PkACgkQJNaLcl1U
h9CmQQf+Mdba/LEwNXEp60e9gowmM0eWXqYV72DTD/LDevnesYy/JcgrAh0zZuE8
TaXfzw9wkccvgxu6Tf5VBxyngoidm2kl9NKg38S/WWGCdsRqygqBsvVmzWK/MjaF
Mfaz0yZ4hvEkmuHN6Dr++Fl69zfKsln/cDus1EJ4aigO4wDl6RQzRifvnLRjRI8w
ebfeg+f71Yjz8uJWD38ZP+tcxu/3lwbIyuri9xBJHcN12RTgv/OijmzYwl1s+CgD
gAgfmG7DLQIrCnU2xiieMXS1XYr7/VqU4+C1ZQTRV9ZKIzHLDmgusp28msY8Kqni
XjnSVJP0D+wB9xKpPl6L0fWxfc+r2A==
=9xtP
-----END PGP SIGNATURE-----

--ozghonnujalcj4qi--

--===============1918431481792019397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1918431481792019397==--
