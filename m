From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add Merrifield machine driver
Date: Fri, 31 Oct 2014 17:11:27 +0000
Message-ID: <20141031171127.GG18557@sirena.org.uk>
References: <1414750298-23287-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6628234825977703961=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D8682606DE
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 18:11:53 +0100 (CET)
In-Reply-To: <1414750298-23287-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6628234825977703961==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ei+t7D26B1iiG0bY"
Content-Disposition: inline


--ei+t7D26B1iiG0bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 31, 2014 at 03:41:38PM +0530, Vinod Koul wrote:

> @@ -26,6 +26,7 @@ snd-soc-sst-haswell-objs := haswell.o
>  snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
>  snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
>  snd-soc-sst-broadwell-objs := broadwell.o
> +snd-merr-dpcm-wm8958-objs := merr_dpcm_wm8958.o

Notice the difference in naming style for the module here...

> +	switch (level) {
> +	case SND_SOC_BIAS_STANDBY:
> +		/*
> +		 * We are in standby down so */
> +		/* Switch to 32KHz MCLK2 input clock for codec
> +		 */

Interesting coding style!

> +static const struct wm8958_micd_rate micdet_rates[] = {
> +	{ 32768,       true,  1, 4 },
> +	{ 32768,       false, 1, 1 },
> +	{ 44100 * 256, true,  7, 10 },
> +	{ 44100 * 256, false, 7, 10 },
> +};

This isn't referenced anywhere.

> +static int mrfld_8958_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	int ret;
> +	struct snd_soc_card *card = runtime->card;
> +	struct mrfld_8958_mc_private *ctx = snd_soc_card_get_drvdata(card);
> +	struct snd_soc_dai *aif1_dai = card->rtd[CODEC_BE].codec_dai;
> +	struct snd_soc_codec *codec = aif1_dai->codec;
> +
> +	if (!aif1_dai)
> +		return -ENODEV;
> +
> +	ret = snd_soc_dai_set_tdm_slot(aif1_dai, 0xf0, 0xf0, 4, 24);
> +	if (ret < 0) {
> +		dev_err(card->dev, "can't set codec pcm format %d\n", ret);
> +		return ret;
> +	}
> +
> +	card->dapm.idle_bias_off = true;
> +
> +	if (!codec) {
> +		dev_err(card->dev, "%s: we didnt find the codec pointer!\n", __func__);
> +		return 0;
> +	}

This should be an error if it's even worth checking for (which it
shouldn't be).

> +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_1, KEY_MEDIA);
> +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);

Two buttons both reporting the same key?  Might be worth a comment.

> +	ret_val = snd_soc_register_card(&snd_soc_card_mrfld);

devm_snd_soc_register_card() and you can loose the remove function.

--ei+t7D26B1iiG0bY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU8K+AAoJECTWi3JdVIfQDscH/jZZssPt/QUmeg9A8B6CnwGw
5xnSt++vGOyCM/3BfFreZviws3ZecYXE0ae4SPGsKDV2AfuE/wgTLSM7XBQ7Q7Lf
CtkEPea0jPMmnfsuhJ2LGGyl7+wcRO9LO80G+T3tlTkLMmfNzb246/DJY7Un/SaC
s+qiZpxtcmGui/KHRE4tGlXq5t899198TcGdJhpAtfTthm/EsgE/c7+f2lv3kb3y
1sm9zf3Lgo8B5Iv5YbLfGWBowt3bzBuBq/dzqZKcUDNnMZCjI8c3mA0NOvS+czpn
sDvkTiVLg8xnbetZnZxYKX9Fmn166NiFrlDEHPkFyLxx9PxJoT2bYWdZ2jTBp+8=
=d4kX
-----END PGP SIGNATURE-----

--ei+t7D26B1iiG0bY--

--===============6628234825977703961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6628234825977703961==--
