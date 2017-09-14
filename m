From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: max98927: Added support for
 DSP_A and DSP_B format
Date: Thu, 14 Sep 2017 11:49:49 -0700
Message-ID: <20170914184949.enuziddz27polfyf@sirena.org.uk>
References: <1505146339-19380-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7119844539229270594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7221626721E
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 20:49:54 +0200 (CEST)
In-Reply-To: <1505146339-19380-1-git-send-email-ryans.lee@maximintegrated.com>
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


--===============7119844539229270594==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ll5fravr77dlkf4d"
Content-Disposition: inline


--ll5fravr77dlkf4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 09:12:18AM -0700, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---

Please make an effort to write changelogs that clearly describe the
change you're making.  This is doing way more than just implementing DSP
mode, it's also adding a fairly complicated set_tdm_slot() implementation=
=20
which isn't mentioned at all.  It probably needs splitting into multiple
patches as well.

> @@ -414,6 +504,9 @@ static int max98927_dac_event(struct snd_soc_dapm_wid=
get *w,
>  	struct max98927_priv *max98927 =3D snd_soc_codec_get_drvdata(codec);
> =20
>  	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		max98927->tdm_mode =3D 0;
> +		break;
>  	case SND_SOC_DAPM_POST_PMU:
>  		regmap_update_bits(max98927->regmap,
>  			MAX98927_R003A_AMP_EN,

Why is an event associated with the DAC changing something related to
the DAI format?  These things should be unrelated.

--ll5fravr77dlkf4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm6z0wACgkQJNaLcl1U
h9CNXggAhDxw3LIUGFaO4y03If63k62ypFtQb7Ys61U1kJuYYqlMfhsi50+q5c2r
seoJTWoUNLebuqnZw+mTHvRgyumcGSEnaMjrMzEN4xamfpqfRqC2QRmh4uX52wdX
fMMo2RLvSW17ZVEbJvXOfOCEVh2otlaSShI1wiLCZsbnDz+OTztBcwtSSfGJDK3h
o58GokqtlZQWOUD2qEnvviZRYsV2AJBLyt4Z9euwgPBvCf2Ipc5geSWv6UDl1zHX
3oSxW7pygjVpD7YGgexMcpDOLz1L0QTebvlPxJpSC/QKSv/YxikgjmDTmIl/JQXK
jpVu17r5jwLTkC9Rm5u9vFfh/jVnJg==
=j+9Q
-----END PGP SIGNATURE-----

--ll5fravr77dlkf4d--

--===============7119844539229270594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7119844539229270594==--
