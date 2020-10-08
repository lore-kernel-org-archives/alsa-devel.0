Return-Path: <SRS0=AlSY=DP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4DDC4363A
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:03:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FA32083B
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OhZmTSec";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="NYylp3Sc";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLW1XWUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FA32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 697621680;
	Thu,  8 Oct 2020 15:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 697621680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602162228;
	bh=RHHry27RhC9YEmcvKxC+zh6XM8RIvjBdmA3ZegT41MM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhZmTSecxaKCavPlH+OavJEiNuvHDBmd5XKPLL6D1DuAazAfqsnOJFYbNSmlVSvoT
	 H3t6KuznqLzlVnrRupgHJbxTWknEjXn/Ua/u81z0+NgVRjr6HyINkYA905QFoAMlB/
	 TgjK5a+tK+4wunMXowI5HKHUm9WM9EQwQPDodfXA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 949AEF80167;
	Thu,  8 Oct 2020 15:02:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 210ACF80168; Thu,  8 Oct 2020 15:02:56 +0200 (CEST)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C4BDF8015B
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2020 15:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C4BDF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="NYylp3Sc"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="nLW1XWUE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 8CE38B69;
 Thu,  8 Oct 2020 09:02:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 08 Oct 2020 09:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=OnX2OclxUMbS2YHgH9OBLagClcV
 8/eB+1eHYfJZoPcc=; b=NYylp3Scv0U41vEA323yHi1GV10gD9r94Ble+fzQ8i9
 T8ucGY05g80hQQ2imFXkgNsxD/BmBcKujiUa/tTzQjGwozaUxUROuXzWH1c7RxqU
 9OFCURdinvVZMKvV7Oei8O2pkz27cPlbS4CJhP85KCDv5OnpffVL10QxpR4OTIBd
 gKzH/mBwgNVdqm4wmwstK17+oXTAEwx5qt4VWtLg8YsZsgcGv03havdobuGV9Vuw
 orT7meEOiQqXSurhSy26W47Cvuo+Ir311jOC2F4s+0ffIN3DPkvkQSDzD4eTV1oo
 ui9frIXBP2hmidE3K2Te1Z4wZT1i517SNbm0dC4MY0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OnX2Oc
 lxUMbS2YHgH9OBLagClcV8/eB+1eHYfJZoPcc=; b=nLW1XWUE6LKvGPKt8xvmFf
 QrpCp6NfagO2jJzkOKRqygxf4hc5mH9h772F/ZEuM++AR20Hti62BQoHooIhhKgf
 Q9o3aquCVbzwCFJ/ky7aU6TYrZjLwN3KAQKmDbJsuZ3Rv8STBGrR75GTpreeg02d
 78+YHgveFdhnfqzPPuuommOpmgQWM6c5lGiPUJK+pxdJwdilq3TvAhhPFs3ftwQF
 deDsMKBSu+jTiniZv5Hz6ExPHKmy3IF22ukM+Zoxx5FrvVXTbKF4mrQ92ApmJeOC
 87Lw5EXvADItHrVNDZzuEsJRumjMmXE35gKd6/phEKtvgcZDORa0+xz8tIpPOdfw
 ==
X-ME-Sender: <xms:8g1_X-yl7bJuy72MxbNMxpYknqhqf8SGdbN0FqU7jrENP1sJ7cEtTA>
 <xme:8g1_X6TJx5eX2E0L1WiBLyMJxpq3OrstKjDmc8Jp3TWEzmksHnL98iEahF2h45HrV
 YEqAGtx3iN-XaV43aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeelgdefvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:8g1_XwWLyjFDfA1biphbMHrlJwXQhUrlXFd9c9EEtMrqXn9JqclZRA>
 <xmx:8g1_X0gbo-9Z0t7LsTXd6qeAr-oe1G1_j0wrjPXm5QpByHwvPILQIA>
 <xmx:8g1_XwASmWX8mjoLYOmmQv7seBIC-ruocKes4iad-xJr5801BBei5Q>
 <xmx:9Q1_X-AEB-rszeT-_GsGS4GBke2mZB7jm0b0NDZpkzAjsTfBuPz1ww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 466093064674;
 Thu,  8 Oct 2020 09:02:42 -0400 (EDT)
Date: Thu, 8 Oct 2020 15:02:41 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 20/25] ASoC: sun8i-codec: Protect the clock rate while
 streams are open
Message-ID: <20201008130241.uigiys7iv72hca7r@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-21-samuel@sholland.org>
 <20201005120101.igzzwosnq6bzbua6@gilmour.lan>
 <5ef4351f-e9ed-1a38-b79e-53e62a70437e@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="os5ttu6dxe7xjvcl"
Content-Disposition: inline
In-Reply-To: <5ef4351f-e9ed-1a38-b79e-53e62a70437e@sholland.org>
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--os5ttu6dxe7xjvcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 11:43:51PM -0500, Samuel Holland wrote:
> On 10/5/20 7:01 AM, Maxime Ripard wrote:
> > On Wed, Sep 30, 2020 at 09:11:43PM -0500, Samuel Holland wrote:
> >> The codec's clock input is shared among all AIFs, and shared with other
> >> audio-related hardware in the SoC, including I2S and SPDIF controllers.
> >> To ensure sample rates selected by userspace or by codec2codec DAI lin=
ks
> >> are maintained, the clock rate must be protected while it is in use.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  sound/soc/sunxi/sun8i-codec.c | 25 ++++++++++++++++++++++---
> >>  1 file changed, 22 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-cod=
ec.c
> >> index 501af64d43a0..86065bee7cd3 100644
> >> --- a/sound/soc/sunxi/sun8i-codec.c
> >> +++ b/sound/soc/sunxi/sun8i-codec.c
> >> @@ -416,27 +416,32 @@ static int sun8i_codec_get_lrck_div_order(unsign=
ed int slots,
> >>  	unsigned int div =3D slots * slot_width;
> >> =20
> >>  	if (div < 16 || div > 256)
> >>  		return -EINVAL;
> >> =20
> >>  	return order_base_2(div);
> >>  }
> >> =20
> >> +static unsigned int sun8i_codec_get_sysclk_rate(unsigned int sample_r=
ate)
> >> +{
> >> +	return sample_rate % 4000 ? 22579200 : 24576000;
> >> +}
> >> +
> >>  static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
> >>  				 struct snd_pcm_hw_params *params,
> >>  				 struct snd_soc_dai *dai)
> >>  {
> >>  	struct sun8i_codec *scodec =3D snd_soc_dai_get_drvdata(dai);
> >>  	struct sun8i_codec_aif *aif =3D &scodec->aifs[dai->id];
> >>  	unsigned int sample_rate =3D params_rate(params);
> >>  	unsigned int slots =3D aif->slots ?: params_channels(params);
> >>  	unsigned int slot_width =3D aif->slot_width ?: params_width(params);
> >> -	unsigned int sysclk_rate =3D clk_get_rate(scodec->clk_module);
> >> -	int lrck_div_order, word_size;
> >> +	unsigned int sysclk_rate =3D sun8i_codec_get_sysclk_rate(sample_rate=
);
> >> +	int lrck_div_order, ret, word_size;
> >>  	u8 bclk_div;
> >> =20
> >>  	/* word size */
> >>  	switch (params_width(params)) {
> >>  	case 8:
> >>  		word_size =3D 0x0;
> >>  		break;
> >>  	case 16:
> >> @@ -466,17 +471,30 @@ static int sun8i_codec_hw_params(struct snd_pcm_=
substream *substream,
> >>  			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
> >> =20
> >>  	/* BCLK divider (SYSCLK/BCLK ratio) */
> >>  	bclk_div =3D sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, s=
ample_rate);
> >>  	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> >>  			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
> >>  			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
> >> =20
> >> -	if (!aif->open_streams) {
> >> +	/* SYSCLK rate */
> >> +	if (aif->open_streams) {
> >> +		ret =3D clk_set_rate(scodec->clk_module, sysclk_rate);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +	} else {
> >> +		ret =3D clk_set_rate_exclusive(scodec->clk_module, sysclk_rate);
> >=20
> > It's not really clear to me why we wouldn't want to always protect the
> > clock rate here?
>=20
> From Documentation/sound/kernel-api/writing-an-alsa-driver.rst:
>=20
>     hw_params callback
>     ...
>     Note that this and ``prepare`` callbacks may be called multiple
>     times per initialization. For example, the OSS emulation may call
>     these callbacks at each change via its ioctl.
>=20
> Clock rate protection is reference counted, so we must only take one
> reference (or at least a known number of references) per stream.

Ah, right.

Can you add a comment to make that more obvious?

> >> +		if (ret =3D=3D -EBUSY)
> >> +			dev_err(dai->dev, "%s: clock is busy! Sample rate %u Hz "
> >> +				"conflicts with other audio streams.\n",
> >=20
> > This string creates a checkpatch warning.
>=20
> I will put it on one line, though >100 columns is also a checkpatch warni=
ng.

Yeah, but in general having an error on a single line is more important.
That way you can then grep for that error message

Maxime

--os5ttu6dxe7xjvcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX38N8QAKCRDj7w1vZxhR
xeeGAP0cFB8uWUUs+EZIcN6bxqGf/Bf/dWy9iwe3GhQXO0PhlgEA3YDzSc4+mvs5
7RfAvmCMM9CZpNlLZYle3uVbztf7Wwk=
=yu/i
-----END PGP SIGNATURE-----

--os5ttu6dxe7xjvcl--
