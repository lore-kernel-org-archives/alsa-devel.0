Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1458EB64DA
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Jul 2023 16:18:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64BA97F1;
	Wed,  5 Jul 2023 18:17:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64BA97F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688573883;
	bh=GeYO4hEs6xDOK/p1n1fFk3HqkeUFQ9DVjoLNHuXTWGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KYX/jN4cD9f2d6WiR//m9GrY2bARpjl43hgHtD8tuWkQAllN1C/6iyQ3HKJU+HUpI
	 rrey+gIyaSyU9YZ9bel/OHaOZfTyomTFkFCB52qAj/pUaIliFIbbk52xBiq3Az+sl3
	 09l9igcTU8Zfok1rjZ+jwJeGKtRhu0iF2IrvCwgU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1583F80125; Wed,  5 Jul 2023 18:16:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45DB7F80125;
	Wed,  5 Jul 2023 18:16:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9743BF80125; Wed,  5 Jul 2023 18:16:45 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0226EF80104
	for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2023 18:16:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0226EF80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AwgiDq76
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EE6C661342;
	Wed,  5 Jul 2023 16:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08AEC433C8;
	Wed,  5 Jul 2023 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688573799;
	bh=GeYO4hEs6xDOK/p1n1fFk3HqkeUFQ9DVjoLNHuXTWGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwgiDq7611IvY8AjeW2W+C4dKuQWb1y8pGtbXxWXJgopfGLg4YXY6wy/wZZN9q/xu
	 hCI+qDM+72j4PzE4r8kjFyybE96Yek5lzGw5EcXvhEtATVEIAAmrgdzGhYV+jyA9DW
	 48qPHw/xXbaYsHEfZNhjnNaJ8jCJzPHFxhhNKjf6/UV1tUTx0QR4jddZoWbG8WvtCD
	 EPx0TvXxq20B8Z4wBNzgyW4fpAawzi5fI9yHxmDpIkgSywRWs+hEJNVnrntmxLX+j5
	 RmVrOmfnv38XBoQtxH+jcBO7Z/n20H33fCMlzy8d8PFeCjHVs/JLnJoJJ/o1yxNj8b
	 sXEpg/g/6hiBA==
Date: Wed, 5 Jul 2023 17:16:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v2 3/3] ASoC: amd: vangogh: Add support for
 NAU8821/MAX98388 variant
Message-ID: <a414b971-381b-4695-9ba4-d2c777bff330@sirena.org.uk>
References: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
 <20230705134341.175889-4-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ov8aIt3YF8eAYNFc"
Content-Disposition: inline
In-Reply-To: <20230705134341.175889-4-cristian.ciocaltea@collabora.com>
X-Cookie: Don't feed the bats tonight.
Message-ID-Hash: BRWIUWBGL77JTGFEJYGZH3O5JECFAV6V
X-Message-ID-Hash: BRWIUWBGL77JTGFEJYGZH3O5JECFAV6V
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BRWIUWBGL77JTGFEJYGZH3O5JECFAV6V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ov8aIt3YF8eAYNFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2023 at 04:43:41PM +0300, Cristian Ciocaltea wrote:

> +static int acp5x_max98388_hw_params(struct snd_pcm_substream *substream,
> +				    struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(rtd->card,
> +							     ACP5X_MAX98388_DAI_NAME);
> +	int ret;
> +
> +	ret = snd_soc_dai_set_fmt(dai,
> +				  SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_I2S |
> +				  SND_SOC_DAIFMT_NB_NF);
> +	if (ret < 0)
> +		dev_err(dai->dev, "Failed to set format: %d\n", ret);
> +
> +	return ret;
> +}

This never varies, why not just set it up statically in the dai_link?

--ov8aIt3YF8eAYNFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSll2EACgkQJNaLcl1U
h9BLLQf5AXp0pzyXPku8zlANe/5Bg+G+xI8VK0dpRTbhe2rDvtHwHsmTBIcTmLfZ
XNv2UEuQwYYaegA6aXufWlK43fbE2GR6TyA3APAsPSRaUf6rzGCmxC8tp4fPsvxA
9UIEY0VlAZAo/nTTfIdChqLiN1lUnZblGX6dLiZTsO52Ab734FEXf4ULlsR9b6bk
uVErEGnYAh9vbgRb87ztzp0IOlMumX9mgfLojCx8srQkETvrzS2N5yzmBlEJDa7s
wdtw7152EEwJiR3wIUiZULcfbLDIRiuc/k8BKRt05Ja8gZCxi2TwZ9OvVIJtmLHP
SwqXo1B1+3QraZpAIYQfdDUwFsV/og==
=WIYi
-----END PGP SIGNATURE-----

--ov8aIt3YF8eAYNFc--
