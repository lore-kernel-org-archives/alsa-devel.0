From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASOC: dapm: add code to configure dai
	link parameters
Date: Mon, 18 Aug 2014 13:53:00 -0500
Message-ID: <20140818185300.GK14537@sirena.org.uk>
References: <1407341786-14990-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2811431650195225033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 405BA261ADA
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 20:53:59 +0200 (CEST)
In-Reply-To: <1407341786-14990-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2811431650195225033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wv56KCa6/aA7yLgk"
Content-Disposition: inline


--wv56KCa6/aA7yLgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 05:16:26PM +0100, Nikesh Oswal wrote:

> +/* create new dapm dai link control */
> +static int dapm_new_dai_link(struct snd_soc_dapm_widget *w)
> +{
> +	int i, ret;
> +	struct snd_kcontrol *kcontrol;
> +	struct snd_soc_dapm_context *dapm = w->dapm;
> +	struct snd_card *card = dapm->card->snd_card;
> +
> +
> +	/* add kcontrol */
> +	for (i = 0; i < w->num_kcontrols; i++) {
> +		kcontrol = snd_soc_cnew(&w->kcontrol_news[i], w,
> +		w->name, NULL);

We appear to be creating the control unconditionally so even a link
which has only one configuration will have a control created which
doesn't seem right.  Suppressing the control creation for links that
only have one configuration seems better.

Throughout this you've got coding style problems, you're not indenting
the continuations of multi-line statements.  Please try to follow the
kernel coding style, if your code is visibly different to the rest of
the codebase that's not good.

> +	for (count = 0 ; count < num_params; count++) {
> +		w_param_text[count] =  kzalloc(sizeof(char) * 100, GFP_KERNEL);

Random number!

> +		if (!w_param_text) {
> +			ret = -ENOMEM;
> +			goto  outfree_w_param;
> +		}
> +
> +		sprintf(w_param_text[count], "SampleRate=%d:Channels=%d:BitsPerSample=%d",
> +			config->rate_min, config->channels_min,
> +			snd_pcm_format_width(ffs(config->formats) - 1));
> +		config++;

The configurations have user speciable names in them which are being
ignored here - this means that users can't specify names that are
meaningful for their systems.

--wv56KCa6/aA7yLgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8kuCAAoJELSic+t+oim9J1sP/R5A4x8U1Y8SzDRhB13r3S2X
ojK64pEqUvwwoxYGAllMA2FUexwLlP5V2BjJkFhz89ZI1CmE+LVNwHlWB3ejbpnC
h+DrRK2U9/GhQAG2B61izoh29XKCKFcdDx4aIDdRN4ArwncYPwyhBZQ3RMvaz3+c
OMYUZ1N+A7CFDhnvRVK+GwgbgCVD7wFEwjhVYXzux6sM6ELBdSSBxgiLe4+QaOWx
iIkQJT6yUux0vIW3xt8d/4nWj77o/L9lDfzbYuwGJA568LVCIxXtRd6XG5iSN37B
EijI5gGtNyUN7veNoh5zxy8OcTNIKX9WkLno3Al0VqYAT01AOUug/msJYbAGm0tQ
ksYGs92CzH/pXysX2e4EaR12qVwKwtfRC/mmTVDd51NTzRgVBb6MDwgc0eGXdhhp
Vb75c/L1dl59Dt7uhrKc1/QFmZW5jWKd8IzbLC+kOaxv3jNLKLKheDedg7kZPFaO
s2Nl9fjAugkbKR7sGIY7R9AyCCzYRuuNSms8Wv9pmsRYJbDjTYqTwlDLMl+AqCeZ
c3G+ZyfmV8s+surEWxQgnSli9zYHx69yV6ZgwYddd+aX+1ykIbTbWlB4fhpT661T
rl1ZIni2ZtU0DUI9QQsqH2+dC68Fm8CG9cg3eKNY0k0ghyM4b+paFGxJqv98o0f3
2JqIaKMQ/x4xMnzklOno
=ri3I
-----END PGP SIGNATURE-----

--wv56KCa6/aA7yLgk--

--===============2811431650195225033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2811431650195225033==--
