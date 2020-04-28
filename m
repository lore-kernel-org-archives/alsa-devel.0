Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84339C83008
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:14:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1135B206A5
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="agniEQtT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Ow9QCQxH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QILMzCzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1135B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D1E91682;
	Tue, 28 Apr 2020 10:13:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D1E91682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588061687;
	bh=tHPWYD5NKX8gVZvLw67gLKlMuitCO/zrqdKCrZibUNY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=agniEQtTi28Yx8dQlkz3XEEjE6LKgE5aVLXxnMglpYiltUFZLuglOZMAlwn+qhi7i
	 Gbj+pQbw2+WQeWAmIDxvj/6s+eimarDT7fuB6SLsGekUTm7L9nXsLR8BO31VjofMet
	 izhTWJzQXou7ygbtnTZ9CUsFXDIUL2pkjX2Fy7fc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8DF3F801F7;
	Tue, 28 Apr 2020 10:13:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35662F8021C; Tue, 28 Apr 2020 10:13:29 +0200 (CEST)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CE14F801EB
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 10:13:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CE14F801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="Ow9QCQxH"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="QILMzCzy"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id A17D25800D6;
 Tue, 28 Apr 2020 04:13:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 28 Apr 2020 04:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=aNL6gNiksq4r4UbKFxC+u35ZMwz
 PjR4FLCxhPYO1ZHQ=; b=Ow9QCQxHMFqXBKP/9h6hzsznq8rDy5fQ9VO1YndVbr2
 a2Wm5YZ1aD4n8/JWVtd6i9LOavWI2m0lzfAPVQehZBo9TdQ1JbyWPb/wke5DIWCw
 k4RngA6/Wet2p7sMEfz5Ubwh96s4UuTXcolqQsqCUeSr/d1lWzYBd8FQtyxZwrbN
 CP8SOiJjdkP0xUs7zWO4iDG0X7bqRFJQR3ujI6P3298oywHmT5XLg6x3iYXMWezf
 5HAG/8drt6KTqjuqofDo0BZAaGf5whP2XHKJ2o+BYz6eZETWsuJz7BFOfy07Ey/C
 P2JjxdBHPrtglVT2hDcV1aWNjtXtP8754ANHLDV6kSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=aNL6gN
 iksq4r4UbKFxC+u35ZMwzPjR4FLCxhPYO1ZHQ=; b=QILMzCzyEaCrJJhYtR1Zps
 H/3ckqluppkUdd/xt9zDocbPx7ZFeUa0AWxWGSet25a3HWuuHvFnVjVTeNfMx4FS
 XcFP/6b1JeBk2AYVPiMiDHMCxcM/z/3pbWZ6pLFpCnUXzeyQ2KqDj1S2pS8KdN1r
 mfLa7g+CXY9pA5mIbbo/+TzpAOi3aoDbM8d42qX3tJl3YjNTKKIHQ9fLByPf7llQ
 M0tO59Qc6fzFSbgIoYvGheDzZp+f469p+7/bvSnOZcst1Qy2n7v8h4KVQQh2QTe4
 W+PSYNiAcOPF/C/FupRh/RtCp5ex4o5NaS8SO0eHPH2k26IlkfXQwbY0bVxdjLog
 ==
X-ME-Sender: <xms:o-WnXloq0ZC0sxFTMmAjuGzZHSppskXtXJGzTpYnNhIA_LxoTSKTig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedugddtudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
 ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:o-WnXj_Rvm0CbMeCkMsaC4ldOE2sJQTnHXqhLW6uEL94k6TMeHE68w>
 <xmx:o-WnXk-7UMGZwzPs2zSwi-YSGziaoWNibn7ZWWHYEx2M1zPq7Oew7A>
 <xmx:o-WnXitaEN9iqXogA8et9-gamTdv22Fg51U40qpYXV3sGXMFiZnreg>
 <xmx:pOWnXlxbTY2BlSQh_Rqc6-znSdCS9T2adHEgLupYOgqxTXUcxi0jWw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id C214D3280068;
 Tue, 28 Apr 2020 04:13:22 -0400 (EDT)
Date: Tue, 28 Apr 2020 10:13:21 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
Message-ID: <20200428081321.ht3el26yqhsnyfm4@gilmour.lan>
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7bvfzopuk76upvmv"
Content-Disposition: inline
In-Reply-To: <20200426104115.22630-4-peron.clem@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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


--7bvfzopuk76upvmv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 26, 2020 at 12:41:11PM +0200, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> H6 I2S is very similar to that in H3, except it supports up to 16
> channels.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 227 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 227 insertions(+)
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 4198a5410bf9..a23c9f2a3f8c 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -124,6 +124,21 @@
>  #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
>  #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
> =20
> +/* Defines required for sun50i-h6 support */
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK	GENMASK(21, 20)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)	((offset) << 20)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK		GENMASK(19, 16)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)		((chan - 1) << 16)
> +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK		GENMASK(15, 0)
> +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)	(((1 << num_chan) - 1))
> +
> +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG	0x44
> +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG	0x48
> +
> +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG	0x64
> +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG	0x68
> +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG	0x6C
> +
>  struct sun4i_i2s;
> =20
>  /**
> @@ -469,6 +484,65 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i=
_i2s *i2s,
>  	return 0;
>  }
> =20
> +static int sun50i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> +				   const struct snd_pcm_hw_params *params)
> +{
> +	unsigned int channels =3D params_channels(params);
> +	unsigned int slots =3D channels;
> +	unsigned int lrck_period;
> +
> +	if (i2s->slots)
> +		slots =3D i2s->slots;
> +
> +	/* Map the channels for playback and capture */
> +	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
> +	regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);
> +
> +	/* Configure the channels */
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL(channels));
> +	regmap_update_bits(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL(channels));
> +
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> +			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> +			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> +			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
> +			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
> +
> +	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		lrck_period =3D params_physical_width(params) * slots;
> +		break;
> +
> +	case SND_SOC_DAIFMT_I2S:
> +		lrck_period =3D params_physical_width(params);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (i2s->slot_width)
> +		lrck_period =3D i2s->slot_width;
> +
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> +			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> +			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
> +
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_EN(channels));
> +
> +	return 0;
> +}
> +
>  static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  			       struct snd_pcm_hw_params *params,
>  			       struct snd_soc_dai *dai)
> @@ -694,6 +768,108 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i=
_i2s *i2s,
>  	return 0;
>  }
> =20
> +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> +				 unsigned int fmt)

The alignment is off here

> +{
> +	u32 mode, val;
> +	u8 offset;
> +
> +	/*
> +	 * DAI clock polarity
> +	 *
> +	 * The setup for LRCK contradicts the datasheet, but under a
> +	 * scope it's clear that the LRCK polarity is reversed
> +	 * compared to the expected polarity on the bus.
> +	 */

Did you check this or has it been copy-pasted?

Thanks!
Maxime

--7bvfzopuk76upvmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfloQAKCRDj7w1vZxhR
xbV7AQCtzcyuXWod6ueBp9bCOgBmzvi9IbRXyMUpg8mupkFJzQD/YCKUuoTYmeh+
WHfw3z1Sgn4sv5c7EKyNffkPSqGpeQA=
=uH8m
-----END PGP SIGNATURE-----

--7bvfzopuk76upvmv--
